//
//  FirstRechargeRewardView.m
//  LibProjView
//
//  Created by ssssssss on 2020/12/7.
//  Copyright © 2020 KLC. All rights reserved.
//

#import "FirstRechargeRewardView.h"
#import <LibProjBase/PopupTool.h>
#import <LibProjModel/KLCAppConfig.h>
#import <LibProjModel/GiftPackVOModel.h>
#import <LibProjModel/HttpApiOperationController.h>
#import <LibProjModel/RechargeGiftVOModel.h>
#import <LibProjModel/KLCUserInfo.h>
#import <LibProjModel/ApiUserInfoLoginModel.h>

@interface FirstRechargeRewardView ()
@property (nonatomic, copy)FirstRechargeRewardCallback callBack;
@property (nonatomic, strong)NSArray *giftArr;
@property (nonatomic, assign)int selectedIndex;
@property (nonatomic, strong)UIView *rewardView;
@end

@implementation FirstRechargeRewardView

+ (void)launchShowFirstRechargeReward:(FirstRechargeRewardCallback)callBack {
    if ([KLCUserInfo isFirstRechange]) {
        [HttpApiOperationController firstRechargeGift:^(int code, NSString *strMsg, NSArray<RechargeGiftVOModel *> *arr) {
            if (code == 1 && arr.count > 0) {
                [FirstRechargeRewardView showRewardView:arr callback:callBack];
                [KLCUserInfo alreadyShowFirstRechange];
            }else{
                callBack(NO);
            }
        }];
    }else{
        callBack(NO);
    }
}


+ (void)mainPageShowRechargeReward:(NSArray *)rewardArr{
    [FirstRechargeRewardView showRewardView:rewardArr callback:nil];
}


+ (void)showRewardView:(NSArray *)arr callback:(FirstRechargeRewardCallback)callBack {
    dispatch_async(dispatch_get_main_queue(), ^{
        CGFloat width = kMaxWidth*305/375.0;
        CGFloat height = width *440/305.0;
        FirstRechargeRewardView *showView = [[FirstRechargeRewardView alloc]initWithFrame:CGRectMake((kScreenWidth-width)/2.0, (kScreenHeight-height)/2.0-30, width, height)];
        showView.backgroundColor = [UIColor colorWithWhite:0.01 alpha:0.001];
        showView.callBack = callBack;
        showView.giftArr = arr;
        [[PopupTool share] createPopupViewWithLinkView:showView allowTapOutside:NO cover:YES];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [PopupTool bringViewToFront:[FirstRechargeRewardView class]];
        });
        [showView creatSubviews];
    });
}


 
- (void)creatSubviews{
    UIButton *closeBtn = [[UIButton alloc]initWithFrame:CGRectMake(self.width-32, 0, 32, 32)];
    closeBtn.backgroundColor = [UIColor clearColor];
    [closeBtn setBackgroundImage:[UIImage imageNamed:@"tip_close"] forState:UIControlStateNormal];
    [closeBtn addTarget:self action:@selector(closeBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:closeBtn];
    
    UIImageView *bgImageV = [[UIImageView alloc]initWithFrame:CGRectMake(0, 30, self.width, self.height-30)];
    bgImageV.image = [UIImage imageNamed:@"first_recharge_reward_tip_bg"];
    bgImageV.contentMode = UIViewContentModeScaleAspectFill;
    bgImageV.userInteractionEnabled = YES;
    [self addSubview:bgImageV];
    
    CGFloat pt = kScreenWidth/375.0;
    UIButton *getRewardBtn = [[UIButton alloc]initWithFrame:CGRectMake(40*pt, bgImageV.height-30*pt-50, self.width-2*40*pt, 50)];
    [getRewardBtn setBackgroundImage:[UIImage imageNamed:@"first_recharge_reward_get"] forState:UIControlStateNormal];
    [getRewardBtn setTitle:kLocalizationMsg(@"立即领取") forState:UIControlStateNormal];
    getRewardBtn.titleLabel.font = [UIFont boldSystemFontOfSize:16];
    [getRewardBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [getRewardBtn addTarget:self action:@selector(getRewardBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [bgImageV addSubview:getRewardBtn];
    
    UIView *rewardView = [[UIView alloc]initWithFrame:CGRectMake(40*pt, 135*pt, getRewardBtn.width, getRewardBtn.y-135*pt-10)];
    rewardView.backgroundColor = [UIColor clearColor];
    self.rewardView  = rewardView;
    [bgImageV addSubview:rewardView];

    
    
    self.selectedIndex = 0;
    [self showRewardsWith];
}
- (void)btnClick:(UIButton *)btn{
    self.selectedIndex = (int)btn.tag;
    [self showRewardsWith];
}
- (void)showRewardsWith{
    [self.rewardView removeAllSubViews];
    
    UIView *btnBackV = [[UIView alloc]initWithFrame:CGRectMake(0, 5, self.rewardView.width, 52)];
    btnBackV.layer.cornerRadius = 12;
    btnBackV.clipsToBounds = YES;
    btnBackV.backgroundColor = kRGB_COLOR(@"#CC2323");
    [self.rewardView addSubview:btnBackV];
    
    UIView *contentV = [[UIView alloc]initWithFrame:CGRectMake(0, 33, self.rewardView.width, self.rewardView.height-33)];
    contentV.backgroundColor = [UIColor whiteColor];
    contentV.layer.cornerRadius = 12;
    contentV.clipsToBounds = YES;
    [self.rewardView addSubview:contentV];
    
    CGFloat btnW = self.rewardView.width/4.0;
    CGFloat btnH = 45;
    NSInteger num = self.giftArr.count;
    if (num > 4) {
        num = 4;
    }
    for (int i = 0; i < num; i++) {
        RechargeGiftVOModel *model = self.giftArr[i];
        UIButton *btn = [[UIButton alloc]initWithFrame:CGRectMake(i*btnW, 0, btnW, btnH)];
        UIBezierPath*maskPath = [UIBezierPath bezierPathWithRoundedRect:btn.bounds byRoundingCorners:(UIRectCornerTopRight | UIRectCornerTopLeft) cornerRadii:CGSizeMake(12,13)];//圆角大小
        CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
        maskLayer.frame = btn.bounds;
        maskLayer.path = maskPath.CGPath;
        btn.layer.mask = maskLayer;
        btn.backgroundColor = [UIColor clearColor];
        btn.tag = i;
        if (btn.tag == self.selectedIndex) {
            btn.selected = YES;
        }
        [btn setBackgroundImage:[UIImage imageWithColor:[UIColor whiteColor]] forState:UIControlStateSelected];
        [btn setBackgroundImage:[UIImage imageWithColor:[UIColor clearColor]] forState:UIControlStateNormal];
        btn.titleLabel.font = [UIFont systemFontOfSize:14];
        [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
        [btn setTitleColor:kRGB_COLOR(@"#B71918") forState:UIControlStateSelected];
        [btn setTitle:[NSString stringWithFormat:kLocalizationMsg(@"%.1f元"),model.money] forState:UIControlStateNormal];
        [self.rewardView addSubview:btn];
    }
   
    RechargeGiftVOModel *model = self.giftArr[self.selectedIndex];
    
    UIView *coinV = [[UIView alloc]initWithFrame:CGRectMake(12,17, self.rewardView.width-24, 45)];
    coinV.layer.cornerRadius = 22.5;
    coinV.clipsToBounds = YES;
    [contentV addSubview:coinV];
    
    if (model.coin > 0) {
        coinV.backgroundColor = kRGB_COLOR(@"#FFF9CF");
        
        UILabel *coinL = [[UILabel alloc]initWithFrame:CGRectMake(12, (coinV.height-25)/2.0, coinV.width-24, 25)];
        coinL.textAlignment = NSTextAlignmentCenter;
        NSString *coinStr = [NSString stringWithFormat:@"    %@ x %d",[KLCAppConfig unitStr],model.coin];
        coinL.attributedText = [coinStr attachmentForImage:[ProjConfig getCoinImage] bounds:CGRectMake(0, -8, 28, 28) before:YES];
        coinL.textColor = kRGB_COLOR(@"#984310");
        coinL.font = [UIFont systemFontOfSize:15];
        [coinV addSubview:coinL];
    }

    CGFloat giftW = self.rewardView.width/4.0;
    CGFloat y = (contentV.height-coinV.maxY-70)/2.0;
    CGFloat margin = (giftW-30)/2.0;
    
    NSInteger nn = 0;
    nn = model.giftList.count;
    if (nn > 4) {
        nn  =4;
    }
    
    if (model.giftList.count > 0) {
        for (int i = 0; i < nn; i++) {
            GiftPackVOModel *giftM = model.giftList[i];
            UIImageView *giftImageV = [[UIImageView alloc]initWithFrame:CGRectMake(margin+giftW*i, y+coinV.maxY, 30, 30)];
            giftImageV.contentMode = UIViewContentModeScaleAspectFit;   
            if ([giftM.action isEqualToString:@"video"]) {//短视频
                giftImageV.image = [UIImage imageNamed:@"icon_account_reward_shortV"];
            }else{
                [giftImageV sd_setImageWithURL:[NSURL URLWithString:giftM.gifticon] placeholderImage:[UIImage imageWithColor:[UIColor lightGrayColor]]];
            }
             
            [contentV addSubview:giftImageV];
            UILabel *nameL = [[UILabel alloc]initWithFrame:CGRectMake(0, giftImageV.maxY, giftW, 20)];
            nameL.centerX = giftImageV.centerX;
            nameL.textColor = kRGB_COLOR(@"#AE8537");
            nameL.font = [UIFont systemFontOfSize:10];
            nameL.textAlignment = NSTextAlignmentCenter;
            nameL.text = giftM.name;
            [contentV addSubview:nameL];
            
            UILabel *numL = [[UILabel alloc]initWithFrame:CGRectMake(0, nameL.maxY, giftW, 20)];
            numL.textColor = kRGB_COLOR(@"#B71918");
            numL.font = [UIFont systemFontOfSize:11];
            numL.centerX = giftImageV.centerX;
            numL.textAlignment = NSTextAlignmentCenter;
            if ([giftM.action isEqualToString:@"gift"]) {//礼物
                numL.text = [NSString stringWithFormat:@"x%d",giftM.typeVal];
            }else if([giftM.action isEqualToString:@"car"]){//坐骑
                numL.text = [NSString stringWithFormat:kLocalizationMsg(@"x%d天"),giftM.typeVal];
            }else if([giftM.action isEqualToString:@"noble"]){//贵族
                numL.text = [NSString stringWithFormat:kLocalizationMsg(@"x%d月"),giftM.typeVal];
            }else{//短视频
                numL.text = [NSString stringWithFormat:kLocalizationMsg(@"x%d次"),giftM.typeVal];
            }
            [contentV addSubview:numL];
        }
    }
}

- (void)getRewardBtnClick:(UIButton *)btn{
    [RouteManager routeForName:RN_center_myAccountAC currentC:[ProjConfig currentVC]];
    [[PopupTool share]closePopupView:self];
    if (self.callBack) {
        self.callBack(YES);
    }
}
- (void)closeBtnClick:(UIButton *)btn{
    [[PopupTool share]closePopupView:self];
    if (self.callBack) {
        self.callBack(NO);
    }
}
-(NSArray *)giftArr{
    if (!_giftArr) {
        _giftArr = [NSArray array];
    }
    return _giftArr;
}
@end
