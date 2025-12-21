//
//  LoginRewardView.m
//  LibProjView
//
//  Created by klc on 2020/5/16.
//  Copyright © 2020 . All rights reserved.
//

#import "LoginRewardView.h"
#import <LibTools/LibTools.h>
#import <SDWebImage.h>
#import <LibProjBase/LibProjBase.h>
#import <LibProjModel/KLCUserInfo.h>
#import <LibProjModel/ApiUserInfoModel.h>
#import <LibProjBase/PopupTool.h>
#import <LibProjModel/HttpApiOperationController.h>
#import <LibProjModel/AdminLoginAwardVOModel.h>

@interface LoginRewardView ()

@property (nonatomic, copy)LoginRewardCallback callBack;

@end

@implementation LoginRewardView

+ (void)showLoginReward:(LoginRewardCallback)block{
    [HttpApiOperationController getContinueLogin:^(int code, NSString *strMsg, AdminLoginAwardVOModel *model) {
        if (code == 1 && model) {
            dispatch_async(dispatch_get_main_queue(), ^{
                [LoginRewardView showLoginRewardNowWithReward:model callBack:block];
            });
        }else{
            if (block) {
                block(NO);
            }
        }
    }];
}


+ (void)showLoginRewardNowWithReward:(AdminLoginAwardVOModel *)reward callBack:(LoginRewardCallback)callBack{
    
    LoginRewardView *showView = [[LoginRewardView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight)];
    showView.layer.cornerRadius = 10;
    showView.clipsToBounds = YES;
    showView.backgroundColor = [UIColor colorWithWhite:0 alpha:0.5];
    showView.callBack = callBack;
    CGFloat width = 230.0*kScreenWidth/360;
    CGFloat height = width*260/230.0;
    UIImageView *tipView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, width, height)];
    tipView.userInteractionEnabled = YES;
    tipView.image = [UIImage imageNamed:@"system_login_reward_bg"];
    tipView.layer.cornerRadius = 8;
    tipView.center = showView.center;
    tipView.clipsToBounds = YES;
    [showView addSubview:tipView];
    [[PopupTool share] createPopupViewWithLinkView:showView allowTapOutside:NO];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [PopupTool bringViewToFront:[LoginRewardView class]];
    });
    
    UIButton *closeBtn = [[UIButton alloc]initWithFrame:CGRectMake(0, tipView.maxY+20, 40, 40)];
    closeBtn.centerX = tipView.centerX;
    [closeBtn setImage:[UIImage imageNamed:@"tip_close"] forState:UIControlStateNormal];
    [closeBtn addTarget:showView action:@selector(closeBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    closeBtn.backgroundColor = [UIColor clearColor];
    [showView addSubview:closeBtn];
    
    CGFloat scaleT = 204/96.0;
    CGFloat widthT = 204.0*kScreenWidth/360;
    CGFloat heightT = widthT/scaleT;
    UIImageView *tipTextipImageV = [[UIImageView alloc]initWithFrame:CGRectMake((width-widthT)/2.0, 20, widthT, heightT)];
    tipTextipImageV.image = [UIImage imageNamed:@"system_login_reward_head"];
    [tipView addSubview:tipTextipImageV];

    //奖励
    UILabel *loginDayLabel = [[UILabel alloc] initWithFrame:CGRectMake((width-widthT)/2.0, tipTextipImageV.maxY+5, widthT, 20)];
    loginDayLabel.textAlignment = NSTextAlignmentCenter;
    loginDayLabel.textColor = kRGB_COLOR(@"#FFFFFF");
    loginDayLabel.font = [UIFont boldSystemFontOfSize:15];
    loginDayLabel.text =  [NSString stringWithFormat:kLocalizationMsg(@"连续第%d天登录"),reward.day];
    [tipView addSubview:loginDayLabel];
    
    CGFloat y = (height-loginDayLabel.maxY-60-50)/2.0;
    UILabel *rewardLabel = [[UILabel alloc]initWithFrame:CGRectMake(10, loginDayLabel.maxY+y, width-20, 20)];
    rewardLabel.textAlignment = NSTextAlignmentCenter;
    NSTextAttachment *countImgAtt = [[NSTextAttachment alloc] init];
    countImgAtt.image = [ProjConfig getCoinImage];;
    countImgAtt.bounds = CGRectMake(0, -2, 15, 15);
    NSAttributedString *collegeStr = [NSAttributedString attributedStringWithAttachment:countImgAtt];
    NSAttributedString *collegeStr2 = [[NSAttributedString alloc] initWithString:[NSString stringWithFormat:@"+%d",reward.coin] attributes:@{NSFontAttributeName : [UIFont systemFontOfSize:14],NSForegroundColorAttributeName:[UIColor whiteColor]}];
    NSMutableAttributedString *countAttM = [[NSMutableAttributedString alloc] initWithAttributedString:collegeStr];
    [countAttM appendAttributedString:collegeStr2];
    rewardLabel.attributedText = countAttM;
    [tipView addSubview:rewardLabel];
    
    UILabel *tipLabel = [[UILabel alloc]initWithFrame:CGRectMake(10, rewardLabel.maxY+5, width-20, 20)];
    tipLabel.numberOfLines = 0;
    tipLabel.textColor = [UIColor whiteColor];
    tipLabel.textAlignment = NSTextAlignmentCenter;
    tipLabel.text = kLocalizationMsg(@"已放入你的账户，快去找主播玩耍吧");
    tipLabel.font = [UIFont systemFontOfSize:12];
    [tipView addSubview:tipLabel];
    
     
    //知道了按钮
    UIButton *kownBtn  = [[UIButton alloc]initWithFrame:CGRectMake((width-160)/2.0, height-60, 160, 40)];
    kownBtn.layer.cornerRadius = 20;
    kownBtn.clipsToBounds = YES;
    kownBtn.backgroundColor = kRGB_COLOR(@"#FFCD30");
    [kownBtn addTarget:showView action:@selector(closeBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [kownBtn setTitle:kLocalizationMsg(@"我知道了") forState:UIControlStateNormal];
    [kownBtn setTitleColor:kRGB_COLOR(@"#222222") forState:UIControlStateNormal];
    kownBtn.titleLabel.font = [UIFont systemFontOfSize:14];
    [tipView addSubview:kownBtn];
}

- (void)closeBtnClick:(UIButton *)btn{
    if (_callBack) {
        _callBack(YES);
    }
    [self removeAllSubViews];
    [self removeFromSuperview];
    [[PopupTool share] closePopupView:self];
}
@end
