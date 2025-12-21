//
//  OTOMessageBannerView.m
//  LibProjView
//
//  Created by klc_sl on 2020/7/17.
//  Copyright © 2020 . All rights reserved.
//

#import "OTOMessageBannerView.h"
#import <LibTools/LibTools.h>
#import <LibProjBase/LibProjBase.h>
#import <SDWebImage.h>
#import <LibProjModel/KLCAppConfig.h>
#import <LibProjModel/KLCUserInfo.h>
#import <Masonry/Masonry.h>
#import <LibProjModel/ApiPushChatModel.h>
#import "ForceAlertController.h"

@interface OTOMessageBannerView ()

@property(nonatomic,weak)UIImageView *headImageV;
@property(nonatomic,weak)UILabel *userNameL;
@property(nonatomic,weak)UIImageView *typeImageV;
@property(nonatomic,weak)UILabel *coinLable;

@property (nonatomic, strong)ApiPushChatModel *userInfoModel;

@end

@implementation OTOMessageBannerView

+ (void)showInView:(UIView *)superView userInfo:(ApiPushChatModel *)model{
    OTOMessageBannerView *bannerV = [[OTOMessageBannerView alloc] initWithFrame:CGRectMake(0, -100, kScreenWidth, 80)];
    [superView addSubview:bannerV];
    [bannerV createSubView];
    [bannerV setUserInfoModel:model];
}

-(void)createSubView{
    
    self.backgroundColor = [UIColor clearColor];
    ///边框阴影
    UIView *shadowView = [[UIView alloc] initWithFrame:CGRectMake(12, 5, self.width-24, 70)];
    shadowView.layer.cornerRadius = 5.0;
    shadowView.layer.borderWidth = 1.5f;
    shadowView.layer.borderColor = [UIColor whiteColor].CGColor;
    shadowView.layer.shadowColor = [UIColor blackColor].CGColor;
    shadowView.layer.shadowOffset = CGSizeMake(0.0, 0.0);
    shadowView.layer.shadowRadius = 4.0;
    shadowView.layer.shadowOpacity = 0.5f;
    
    [self addSubview:shadowView];
    
    ///背景图
    UIView *bgV = [[UIView alloc] initWithFrame:shadowView.frame];
    bgV.backgroundColor = [UIColor whiteColor];
    bgV.layer.masksToBounds = YES;
    bgV.layer.cornerRadius = 4.0;
    [self addSubview:bgV];

    //头像
    UIImageView *headImageV = [[UIImageView alloc]initWithFrame:CGRectMake(12, (70-46)/2.0, 46, 46)];
    headImageV.layer.cornerRadius = 22;
    headImageV.clipsToBounds = YES;
    headImageV.contentMode = UIViewContentModeScaleAspectFill;
    [bgV addSubview:headImageV];
    _headImageV = headImageV;
    
    //昵称
    UILabel *userNameL = [[UILabel alloc]init];
    userNameL.textAlignment = NSTextAlignmentLeft;
    userNameL.textColor = kRGB_COLOR(@"#333333");
    userNameL.font = [UIFont systemFontOfSize:14];
    [bgV addSubview:userNameL];
    _userNameL = userNameL;
    
    ///类型图标
    UIImageView *typeImageV = [[UIImageView alloc] init];
    typeImageV.image = nil;
    typeImageV.contentMode = UIViewContentModeScaleAspectFit;
    [bgV addSubview:typeImageV];
    _typeImageV = typeImageV;
    
    ///具体文字
    UILabel *coinLable = [[UILabel alloc]init];
    coinLable.textAlignment = NSTextAlignmentLeft;
    coinLable.textColor = kRGB_COLOR(@"#333333");
    coinLable.font = [UIFont systemFontOfSize:14];
    [bgV addSubview:coinLable];
    _coinLable = coinLable;
    
    [self.userNameL mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.headImageV.mas_right).mas_offset(10);
        make.top.equalTo(self.headImageV).mas_offset(5);
        make.height.mas_equalTo(15);
        make.right.equalTo(self.typeImageV.mas_left).mas_equalTo(-7);
    }];
    
    [self.typeImageV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(22, 22));
        make.centerY.equalTo(self.userNameL);
    }];
    
    [self.coinLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.headImageV).mas_offset(-5);
        make.left.equalTo(self.userNameL);
    }];
    
    UIButton *grabOrderBtn = [[UIButton alloc] initWithFrame:CGRectMake(bgV.width-50, 0, 50, bgV.height)];
    [grabOrderBtn setTitle:kLocalizationMsg(@"抢单") forState:UIControlStateNormal];
    grabOrderBtn.titleLabel.font = [UIFont systemFontOfSize:14];
    [grabOrderBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [bgV addSubview:grabOrderBtn];
    [grabOrderBtn setBackgroundImage:[UIImage imageNamed:@"color1"] forState:UIControlStateNormal];
    [grabOrderBtn addTarget:self action:@selector(clickGrabOrderBtn:) forControlEvents:UIControlEventTouchUpInside];
    
    UISwipeGestureRecognizer *swipe = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(dismissView)];
    swipe.direction = UISwipeGestureRecognizerDirectionUp;
    swipe.numberOfTouchesRequired = 1;
    [bgV addGestureRecognizer:swipe];
}

- (void)dismissView{
    [self removeSelf];
}


- (void)clickGrabOrderBtn:(UIButton *)btn{

    if (_userInfoModel) {
        if ([KLCUserInfo getRole] == 1) {
            [self removeFromSuperview];
           // NSLog(@"过滤文字抢聊%lld"),_userInfoModel.userId);
            [RouteManager routeForName:RN_live_launchScrambleChat currentC:[ProjConfig currentVC] parameters:@{@"userId":@(_userInfoModel.userId),@"sessionId":@(_userInfoModel.sessionID),@"isVideo":@((_userInfoModel.chatType == 1)?1:0)}];
        }else{
            [self removeSelf];
            ForceAlertController *alert = [ForceAlertController alertTitle:kLocalizationMsg(@"提示") message:kLocalizationMsg(@"你还没有认证,无法抢单!\n快去认证，开始赚钱吧!")];
            [alert addOptions:kLocalizationMsg(@"取消") textColor:(ForceAlert_BlackColor) clickHandle:nil];
            [alert addOptions:kLocalizationMsg(@"确定") textColor:(ForceAlert_NormalColor) clickHandle:^{
                 [RouteManager routeForName:RN_center_anchorAuthAC currentC:[ProjConfig currentVC]];
            }];
            [[ProjConfig currentVC] presentViewController:alert animated:YES completion:nil];
        }
    }
}


- (void)showBanner{
    kWeakSelf(self);
    [UIView animateWithDuration:0.3 animations:^{
        weakself.y = kStatusBarHeight;
    } completion:^(BOOL finished) {
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [weakself removeSelf];
        });
    }];
}

- (void)removeSelf{
    kWeakSelf(self);
    [UIView animateWithDuration:0.3 animations:^{
        weakself.y = -100;
    } completion:^(BOOL finished) {
        [weakself removeFromSuperview];
    }];
}


- (void)setUserInfoModel:(ApiPushChatModel *)userInfoModel{
    _userInfoModel = userInfoModel;
    
    [self.headImageV sd_setImageWithURL:[NSURL URLWithString:userInfoModel.avatar] placeholderImage:[ProjConfig getDefaultImage]];
    self.userNameL.text = userInfoModel.username;
    CGFloat userNameLW = [userInfoModel.username widthWithFont:[UIFont systemFontOfSize:14] constrainedToHeight:22];
    self.userNameL.frame = CGRectMake(self.headImageV.maxX + 10, 15, userNameLW, 22);
    self.typeImageV.frame = CGRectMake(self.userNameL.maxX + 10, 15, 22, 22);
    //1视频聊天2语音聊天
    if (userInfoModel.chatType == 1) {
        self.typeImageV.image = [UIImage imageNamed:@"message_shipin"];
    }else{
        self.typeImageV.image = [UIImage imageNamed:@"message_yuying"];
    }
    
    if ([KLCAppConfig showOtmCoin]) {
        self.coinLable.text = [NSString stringWithFormat:kLocalizationMsg(@"%d%@/分钟"),userInfoModel.coin,[KLCAppConfig unitStr]];
    }else{
        self.coinLable.text = userInfoModel.chatType == 1?kLocalizationMsg(@"视频通话"):kLocalizationMsg(@"语音通话");
    }
    
    [self showBanner];
}




@end
