//
//  OneLiveCheckContactView.m
//  OTMLive
//
//  Created by ssssssss on 2020/9/8.
//  Copyright © 2020 萌鑫达. All rights reserved.
//

#import "OneLiveCheckContactView.h"

#import <LibProjBase/PopupTool.h>
#import <LibProjBase/ProjConfig.h>
#import <LibProjBase/AppRouteName.h>
#import <LibProjBase/RouteManager.h>

#import <LibProjModel/KLCAppConfig.h>
#import <LibProjModel/HttpApiOOOLive.h>
#import <LibProjModel/SingleStringModel.h>
#import <LibProjModel/ApiUserInfoModel.h>
#import <LibProjModel/HttpApiOOOLive.h>
#import <LibProjModel/HttpApiUserController.h>

#import <LibProjView/CustomPopUpAlert.h>
#import <LibProjView/ForceAlertController.h>

#import <LibTools/LibTools.h>


@interface OneLiveCheckContactView()

@property (nonatomic, weak)UILabel *wechatNumL;
@property (nonatomic, weak)UILabel *wechatBtnTextL;
@property (nonatomic, strong)OooShowAnchorContactVOModel *wechatModel;
@property (nonatomic, assign)int64_t userId;

@end

@implementation OneLiveCheckContactView

#pragma mark - 直播间按钮

+ (void)showContact:(int64_t)anchorId hasBgColor:(BOOL)has{
    [HttpApiUserController getShowAnchorContact:anchorId callback:^(int code, NSString *strMsg, OooShowAnchorContactVOModel *model) {
        if (code == 1 && model) {
            dispatch_async(dispatch_get_main_queue(), ^{
                dispatch_async(dispatch_get_main_queue(), ^{
                    UIView *tipV = [PopupTool getPopupViewForClass:self];
                    if (!tipV) {
                        OneLiveCheckContactView *showView = [[OneLiveCheckContactView alloc] initWithFrame:CGRectMake(0, 0, 275, 260)];
                        showView.wechatModel = model;
                        showView.userId = anchorId;
                        [showView showViewNow:has];
                    }
                });
            });
        }else{
            [SVProgressHUD showInfoWithStatus:strMsg];
        }
    }];
}

- (void)showViewNow:(BOOL)hasBgColor{
    [self contentViewSubviewsLayout];
    [[PopupTool share] createPopupViewWithLinkView:self allowTapOutside:NO cover:hasBgColor];
    self.center = CGPointMake(self.superview.width/2.0, self.superview.height/2.0);
}

#pragma mark - 弹窗
- (void)contentViewSubviewsLayout{
    
    self.backgroundColor = [UIColor whiteColor];
    self.layer.masksToBounds = YES;
    self.layer.cornerRadius = 25;
    
    UIImageView *bgV = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, self.width, 120)];
    bgV.image = [UIImage imageNamed:@"otm_user_contact"];
    [self addSubview:bgV];
    
    UILabel *contactTitleL = [[UILabel alloc]initWithFrame:CGRectMake(0, 43, self.width, 20)];
    contactTitleL.textAlignment = NSTextAlignmentCenter;
    contactTitleL.font = [UIFont boldSystemFontOfSize:15];
    contactTitleL.textColor = kRGB_COLOR(@"#FFFFFF");
    contactTitleL.text = kLocalizationMsg(@"查看TA的联系方式");
    [bgV addSubview:contactTitleL];
    
    UIButton *closeBtn = [[UIButton alloc]initWithFrame:CGRectMake(self.width-30, 10, 30, 30)];
    [closeBtn setImage:[UIImage imageNamed:@"live_guanbi_gray"] forState:UIControlStateNormal];
    closeBtn.imageEdgeInsets = UIEdgeInsetsMake(10, 10, 10, 10);
    [closeBtn addTarget:self action:@selector(closeBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:closeBtn];
    
    
    UIView *centerV = [[UIView alloc] initWithFrame:CGRectMake(23, 92, 230, 150)];
    // Radius Code
    centerV.layer.cornerRadius = 5;
    centerV.backgroundColor = [UIColor whiteColor];
    // Shadow Code
    centerV.layer.shadowColor = [UIColor colorWithRed:255/255.0 green:94/255.0 blue:198/255.0 alpha:0.1].CGColor;
    centerV.layer.shadowOffset = CGSizeMake(0,2);
    centerV.layer.shadowRadius = 8;
    centerV.layer.shadowOpacity = 1;
    [self addSubview:centerV];
    
    UILabel *wechatTitleL = [[UILabel alloc]initWithFrame:CGRectMake(0, 30, centerV.width, 20)];
    wechatTitleL.textAlignment = NSTextAlignmentCenter;
    wechatTitleL.font = [UIFont systemFontOfSize:14];
    wechatTitleL.textColor  = kRGB_COLOR(@"#333333");
    wechatTitleL.attributedText = [kLocalizationMsg(@"微信号") attachmentForImage:[UIImage imageNamed:@"1v1_contact_check_wechat"] bounds:CGRectMake(0, -3, 18, 18) before:YES];
    [centerV addSubview:wechatTitleL];
    
    UILabel *wechartNumL = [[UILabel alloc]initWithFrame:CGRectMake(0, wechatTitleL.maxY+10, wechatTitleL.width, 20)];
    wechartNumL.textAlignment = NSTextAlignmentCenter;
    wechartNumL.font = [UIFont systemFontOfSize:14];
    wechartNumL.textColor  = kRGB_COLOR(@"#333333");
    if ([self.wechatModel.wechatNo isEqualToString:@"-2"]) {//无权限
        wechartNumL.text = @"**********";
    }else if ([self.wechatModel.wechatNo isEqualToString:@"-1"]){  ///没填写
        wechartNumL.text = kLocalizationMsg(@"未设置");
    }else{
        wechartNumL.text = self.wechatModel.wechatNo.length>0?self.wechatModel.wechatNo:kLocalizationMsg(@"暂无");
    }
    self.wechatNumL = wechartNumL;
    [centerV addSubview:wechartNumL];
    
    UIButton *wechatBtn = [[UIButton alloc]initWithFrame:CGRectMake(0, wechartNumL.maxY+18, 100, 32)];
    wechatBtn.centerX = wechatTitleL.centerX;
    wechatBtn.layer.cornerRadius = 16;
    wechatBtn.layer.masksToBounds = YES;
    [wechatBtn addTarget:self action:@selector(wechatBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [centerV addSubview:wechatBtn];
    CAGradientLayer *gl = [CAGradientLayer layer];
    gl.frame = wechatBtn.bounds;
    gl.startPoint = CGPointMake(1.00, 0.50);
    gl.endPoint = CGPointMake(0.00, 0.50);
    gl.colors = @[
        (__bridge id)[UIColor colorWithRed:252/255.0 green:103/255.0 blue:169/255.0 alpha:1.0].CGColor,
        (__bridge id)[UIColor colorWithRed:252/255.0 green:120/255.0 blue:198/255.0 alpha:1.0].CGColor,
    ];
    gl.locations = @[@(0),@(1.0f)];
    [wechatBtn.layer addSublayer:gl];
    
    UILabel *btnTitleL = [[UILabel alloc] init];
    btnTitleL.textColor = [UIColor whiteColor];
    btnTitleL.font = [UIFont boldSystemFontOfSize:14];
    _wechatBtnTextL = btnTitleL;
    [wechatBtn addSubview:btnTitleL];
    [btnTitleL mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(wechatBtn);
    }];
    if ([self.wechatModel.wechatNo isEqualToString:@"-2"]) {//无权限
        NSString *title = [NSString stringWithFormat:kLocalizationMsg(@"%.0f 获取"),self.wechatModel.wechatCoin];
        NSMutableAttributedString *muAttrStr = [[NSMutableAttributedString alloc] initWithAttributedString:[title attachmentForImage:[ProjConfig getCoinImage] bounds:CGRectMake(0, -1, 10, 10) before:YES]];
        [muAttrStr addAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:13]} range:NSMakeRange(muAttrStr.length-2, 2)];
        btnTitleL.attributedText = muAttrStr;
    }else if ([self.wechatModel.wechatNo isEqualToString:@"-1"]){  ///没填写
        btnTitleL.text = kLocalizationMsg(@"确定");
    }else{
        btnTitleL.text = kLocalizationMsg(@"点击复制");
    }
}


- (void)wechatBtnClick:(UIButton *)btn{
    
    if ([self.wechatModel.wechatNo isEqualToString:@"-2"]) {//无权限
        ForceAlertController *forceVC = [ForceAlertController alertTitle:kLocalizationMsg(@"提示") message:[NSString stringWithFormat:kLocalizationMsg(@"获取TA的微信号需要支付%.0f%@\n是否继续支付"),self.wechatModel.wechatCoin,[KLCAppConfig unitStr]]];
        [forceVC addOptions:kLocalizationMsg(@"否") textColor:ForceAlert_BlackColor clickHandle:nil];
        [forceVC addOptions:kLocalizationMsg(@"是") textColor:ForceAlert_NormalColor clickHandle:^{
            [self lookAndPayViewContact];
        }];
        [[ProjConfig currentVC] presentViewController:forceVC animated:YES completion:nil];
    }else if ([self.wechatModel.wechatNo isEqualToString:@"-1"]){  ///没填写
        [self dismisssNow];
    }else{
        if (self.wechatModel.wechatNo > 0) {
            UIPasteboard *paste = [UIPasteboard generalPasteboard];
            paste.string = self.wechatModel.wechatNo;
            [SVProgressHUD showSuccessWithStatus:kLocalizationMsg(@"微信号复制成功")];
        }
    }
}

- (void)closeBtnClick:(UIButton *)btn{
    [self dismisssNow];
}

- (void)dismisssNow{
    [[PopupTool share] closePopupView:self];
    [self removeAllSubViews];
    [self removeFromSuperview];
}

#pragma mark - 查看联系方式

-(void)lookAndPayViewContact{
    kWeakSelf(self);
    [HttpApiOOOLive payViewContact:2 userId:self.userId callback:^(int code, NSString *strMsg, SingleStringModel *model) {
        if (code == 1) {
            weakself.wechatModel.wechatNo = model.value;
            weakself.wechatNumL.text = self.wechatModel.wechatNo;
            weakself.wechatBtnTextL.text = kLocalizationMsg(@"点击复制");
        }else if(code == -1){
            [weakself BalanceInsufficientPopView];
        }else if(code == 7300){ ///svip
            [RouteManager routeForName:RN_center_svip currentC:[ProjConfig currentVC]];
        }else{
            [SVProgressHUD showInfoWithStatus:strMsg];
        }
        
    }];
    
}

//余额不足
-(void)BalanceInsufficientPopView{
    CustomPopUpAlert *customAlert = [CustomPopUpAlert alertTitle:@"" message:kLocalizationMsg(@"您的余额不足，先去充值吧！") liveType:LiveTypeForBalanceInsufficient];
    customAlert.clickCancelBlock = ^{
        
    };
    customAlert.clickSureBlock = ^(NSString * _Nonnull passwordStr) {
        [RouteManager routeForName:RN_center_myAccountAC currentC:[ProjConfig currentVC]];
    };
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [[ProjConfig currentVC] presentViewController:customAlert animated:YES completion:nil];
    });
}

#pragma mark - lazy load

- (void)dealloc{
    _wechatModel = nil;
}
@end


