//
//  VipSeatBuyView.m
//  LiveCommon
//
//  Created by klc on 2020/6/9.
//  Copyright © 2020 . All rights reserved.
//

#import "VipSeatBuyView.h"
#import "LibTools/LibTools.h"
#import <LibProjBase/LibProjBase.h>
#import <LibProjView/FunctionSheetBaseView.h>
#import <Masonry/Masonry.h>
#import <LiveCommon/LiveManager.h>
#import <SDWebImage/SDWebImage.h>
#import <LiveCommon/LiveComponentMsgListener.h>
#import <LiveCommon/LiveComponentMsgMgr.h>
#import <LibProjModel/KLCAppConfig.h>
#import <LibProjModel/APPConfigModel.h>
#import <LibProjModel/AdminLiveConfigModel.h>
#import <LibProjModel/HttpApiPublicLive.h>
#import <LibProjView/KlcAvatarView.h>
#import <LibProjView/SWHTapImageView.h>

@implementation VipSeatBuyView


+ (void)showVIPSeat{
    VipSeatBuyView *vipSeat = [[VipSeatBuyView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 200)];
    [vipSeat createView];
    [FunctionSheetBaseView showTitle:kLocalizationMsg(@"豪华贵宾席") detailView:vipSeat cover:NO];
}

///创建页面显示
- (void)createView{
    
    AppJoinRoomVOModel *joinModel = [LiveManager liveInfo].roomModel;
    
    ///主播信息
    UIView *centerView = [[UIView alloc] init];
    [self addSubview:centerView];
    
    ///主播头像
    KlcAvatarView *userIconV = [[KlcAvatarView alloc] init];
    [userIconV showUserIconUrl:joinModel.anchorAvatar vipBorderUrl:joinModel.anchorNobleAvatarFrame];
    [centerView addSubview:userIconV];
    
    ///名称
    UILabel *titleL = [[UILabel alloc] init];
    titleL.textColor = [UIColor blackColor];
    titleL.textAlignment = NSTextAlignmentLeft;
    titleL.text = [NSString stringWithFormat:kLocalizationMsg(@"%@ 邀请你上座贵宾席"),[LiveManager liveInfo].anchorName];
    titleL.font = [UIFont systemFontOfSize:14];
    [centerView addSubview:titleL];
    
    //文本内容
    UIView *contentV = [[UIView alloc] init];
    contentV.backgroundColor = [UIColor yellowColor];
    [centerView addSubview:contentV];
    
    ///购买贵宾席
    UIButton *buyBtn = [UIButton buttonWithType:0];
    buyBtn.layer.masksToBounds = YES;
    [buyBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [buyBtn setTitle:kLocalizationMsg(@"成为直播间大卡司") forState:UIControlStateNormal];
    buyBtn.titleLabel.font = [UIFont systemFontOfSize:15];
    buyBtn.backgroundColor = kRGB_COLOR(@"#362F4F");
    [buyBtn addTarget:self action:@selector(buyVIPSeat) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:buyBtn];
    NSString *showStr = [NSString stringWithFormat:kLocalizationMsg(@"%0.0lf%@ 成为直播间大卡司"),[KLCAppConfig appConfig].adminLiveConfig.VIPStatesFee,[KLCAppConfig unitStr]];
    NSAttributedString *attrStr = [showStr attachmentForImage:[ProjConfig getCoinImage] bounds:CGRectMake(0, -6, 22, 22) before:YES textFont:[UIFont systemFontOfSize:15] textColor:[UIColor whiteColor]];
    [buyBtn setAttributedTitle:attrStr forState:UIControlStateNormal];
    
    
    ///开通贵族按钮
    UIButton *becomeBtn = [UIButton buttonWithType:0];
    [becomeBtn setTitle:kLocalizationMsg(@"开通贵族，免费上位 >>") forState:UIControlStateNormal];
    becomeBtn.titleLabel.font = [UIFont systemFontOfSize:12];
    [becomeBtn setTitleColor:kRGB_COLOR(@"#F5A623") forState:UIControlStateNormal];
    [becomeBtn addTarget:self action:@selector(becomeVIP) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:becomeBtn];
    
    
    [centerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self);
        make.top.equalTo(self).mas_offset(20);
        make.bottom.equalTo(buyBtn.mas_top).mas_offset(-34);
    }];
    
    [userIconV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.bottom.equalTo(centerView);
        make.size.mas_equalTo(CGSizeMake(60, 60));
        make.right.equalTo(titleL.mas_left).mas_offset(-15);
    }];

    [titleL mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(centerView).mas_offset(9);
        make.right.equalTo(centerView);
    }];
    
    [contentV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(titleL);
        make.height.mas_offset(15);
        make.bottom.equalTo(centerView).mas_offset(-9);
    }];
    
    [buyBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(270, 38));
        make.centerX.equalTo(self);
        make.bottom.equalTo(buyBtn.mas_top).mas_offset(-5);
    }];
    
    [becomeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self);
        make.size.mas_equalTo(CGSizeMake(150, 20));
        make.bottom.equalTo(self).mas_offset(-20);
    }];
    
    [buyBtn layoutIfNeeded];
    buyBtn.layer.cornerRadius = buyBtn.height/2.0;

    [contentV layoutIfNeeded];
    {
        ///性别
        CGFloat max = 0;
        if (joinModel.anchorSex) {
            SWHTapImageView *genderV = [[SWHTapImageView alloc] initWithFrame:CGRectMake(max, 0, 30, 15)];
            genderV.layer.cornerRadius = 7.5;
            genderV.layer.masksToBounds = YES;
            ///性别与角色
            UIImage *image = [[ProjConfig shareInstence].baseConfig imageGender:joinModel.anchorSex age:joinModel.anchorAge role:joinModel.role];
            if (image) {
                genderV.image = image;
                max = genderV.maxX+4;
            }else{
                genderV.width = 0;
            }
            genderV.btnClick = ^(int type) {
                [[ProjConfig shareInstence].businessConfig showAuthAlertView:[ProjConfig currentVC].view role:joinModel.role];
            };
            
            [contentV addSubview:genderV];
            
             
        }

        if (joinModel.anchorWealthGradeImg.length > 0) {
            ///主播等级
            UIImageView *levelV = [[UIImageView alloc] initWithFrame:CGRectMake(max, 0, 30, 15)];
            [levelV sd_setImageWithURL:[NSURL URLWithString:joinModel.anchorWealthGradeImg]];
            levelV.contentMode = UIViewContentModeScaleAspectFit;
            [contentV addSubview:levelV];

            max = levelV.maxX+4;
        }
        
        if (joinModel.anchorNobleGradeImg.length > 0) {
            ///贵族等级
            UIImageView *vipV = [[UIImageView alloc] initWithFrame:CGRectMake(max, 0, 30, 15)];
            [vipV sd_setImageWithURL:[NSURL URLWithString:joinModel.anchorNobleGradeImg]];
            vipV.contentMode = UIViewContentModeScaleAspectFit;
            [contentV addSubview:vipV];
        }
    }
    
}


- (void)becomeVIP{
    [LiveComponentMsgMgr sendMsg:LM_BuyVIP msgDic:nil];
}

- (void)buyVIPSeat{
    [self buyVIPSeatForCoin:[KLCAppConfig appConfig].adminLiveConfig.VIPStatesFee];
}

- (void)buyVIPSeatForCoin:(double)coin{
    kWeakSelf(self);
    [HttpApiPublicLive purchaseVIPSeats:[LiveManager liveInfo].anchorId coin:coin liveType:[LiveManager liveInfo].serviceLiveType roomId:[LiveManager liveInfo].roomId callback:^(int code, NSString *strMsg, AppVIPSeatsModel *model) {
        if (code == 1) {
            [SVProgressHUD showSuccessWithStatus:strMsg];
            [FunctionSheetBaseView deletePopView:weakself];
        }else{
            [SVProgressHUD showInfoWithStatus:strMsg];
        }
    }];
}

@end
