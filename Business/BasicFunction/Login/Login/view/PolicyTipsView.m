//
//  PolicyTipsView.m
//  LibProjView
//
//  Created by klc on 2020/4/30.
//  Copyright © 2020 . All rights reserved.
//

#import "PolicyTipsView.h"
#import <LibTools/LibTools.h>
#import <LibProjModel/KLCAppConfig.h>
#import <LibProjModel/APPConfigModel.h>
#import <LibProjModel/AdminLiveConfigModel.h>
#import <LibProjModel/KLCAppConfig.h>
#import <LibProjBase/ProjBaseData.h>
#import <AFNetworking/AFNetworking.h>
#import <CoreTelephony/CTCellularData.h>
#import <LibProjBase/LibProjBase.h>
#import <LibTools/TimerBlock.h>
#import <CoreTelephony/CTCellularData.h>

@interface PolicyTipsView()<UITextViewDelegate,YBAttributeTapActionDelegate>

@property (nonatomic, strong)UITextView *contentLabel;

@property(nonatomic, copy) NSString *xieyiRule;

@property (nonatomic, weak)UIViewController *superVC;

@property (nonatomic, copy)void(^closeBlock)(void);

@property (nonatomic, copy)TimerBlock *timerBlock;

@property (nonatomic, assign)BOOL requestFinish; ///网络请求是否结束

@end



@implementation PolicyTipsView

+ (void)showInVC:(UIViewController *)vc closeBlock:(void (^)(void))closeBlock {
    BOOL isAgree = [[NSUserDefaults standardUserDefaults] boolForKey:@"policy_tips"];
    if (!isAgree) {
        PolicyTipsView *showView = [[PolicyTipsView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight)];
        showView.backgroundColor = [UIColor colorWithWhite:0 alpha:0.5];
        showView.superVC = vc;
        showView.closeBlock = closeBlock;
        [vc.view addSubview:showView];
        [showView createUI];
    }else{
        if(closeBlock){
            closeBlock();
        }
    }
}

- (TimerBlock *)timerBlock{
    if (!_timerBlock) {
        _timerBlock = [[TimerBlock alloc] init];
    }
    return _timerBlock;
}

- (void)createUI
{
    UIView *tipView = [[UIView alloc]initWithFrame:CGRectMake((kScreenWidth-280)/2.0, (kScreenHeight-400)/2.0, 280, 450)];
    tipView.backgroundColor = [UIColor whiteColor];
    tipView.layer.cornerRadius = 8;
    tipView.clipsToBounds = YES;
    [self addSubview:tipView];
    
    UILabel *titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(10, 40, 260, 20)];
    titleLabel.text = kLocalizationMsg(@"服务条款和隐私政策提示");
    titleLabel.textAlignment = NSTextAlignmentCenter;
    titleLabel.font = [UIFont boldSystemFontOfSize:16];
    titleLabel.textColor = kRGB_COLOR(@"#333333");
    [tipView addSubview:titleLabel];
    
    NSString *str = KLCAppConfig.appConfig.adminLiveConfig.xieyiRule;
    if (str.length == 0) {
        [self netStatus];
    }
    UITextView *contentLabel = [[UITextView alloc]initWithFrame:CGRectMake(30, 90, tipView.width-60, 180)];
    contentLabel.textColor =kRGB_COLOR(@"#666666");
    contentLabel.textAlignment = NSTextAlignmentLeft;
    contentLabel.selectable = NO;
    contentLabel.editable = NO;
    contentLabel.attributedText = [str HTMLTextWithTextColor:[UIColor blackColor]];;
    self.contentLabel = contentLabel;
    [tipView addSubview:contentLabel];
    
    NSString *tipStr = kLocalizationMsg(@"请在使用前查看并同意完整的《用户协议》及《隐私政策》");
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:tipStr];
    [attributedString setAttributes:@{NSForegroundColorAttributeName:[ProjConfig normalColors]} range:[[attributedString string] rangeOfString:kLocalizationMsg(@"《用户协议》")]];
    [attributedString setAttributes:@{NSForegroundColorAttributeName:[ProjConfig normalColors]} range:[[attributedString string] rangeOfString:kLocalizationMsg(@"《隐私政策》")]];
    
    UILabel *tipL = [[UILabel alloc] initWithFrame:CGRectMake(30, contentLabel.maxY+25, contentLabel.width, 40)];
    tipL.numberOfLines = 0;
    tipL.font = [UIFont systemFontOfSize:12];
    tipL.textColor = kRGB_COLOR(@"#666666");
    tipL.attributedText = attributedString;
    [tipView addSubview:tipL];
    
    tipL.enabledTapEffect = NO;
    [tipL yb_addAttributeTapActionWithStrings:@[kLocalizationMsg(@"《用户协议》"),kLocalizationMsg(@"《隐私政策》")] delegate:self];
    
    NSDictionary *infoDictionary = [[NSBundle mainBundle] infoDictionary];
    NSString *appName = [infoDictionary objectForKey:@"CFBundleDisplayName"];
    UIButton *noAgreeBtn = [[UIButton alloc]initWithFrame:CGRectMake(40, 390, 200, 40)];
    noAgreeBtn.backgroundColor = [UIColor clearColor];
    [noAgreeBtn setTitle:[NSString stringWithFormat:kLocalizationMsg(@"不同意并退出%@"),appName] forState:UIControlStateNormal];
    noAgreeBtn.titleLabel.font = [UIFont systemFontOfSize:12];
    [noAgreeBtn setTitleColor: kRGB_COLOR(@"#BBBBBB") forState:UIControlStateNormal];
    [noAgreeBtn addTarget:self action:@selector(noAgreeBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [tipView addSubview:noAgreeBtn];
    
    UIButton *agreeBtn = [[UIButton alloc]initWithFrame:CGRectMake(60, 350, 160, 34)];
    [agreeBtn addTarget:self action:@selector(agreeBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [agreeBtn setTitle:kLocalizationMsg(@"同意并继续") forState:UIControlStateNormal];
    [agreeBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    agreeBtn.clipsToBounds = YES;
    agreeBtn.layer.cornerRadius = 17;
    [tipView addSubview:agreeBtn];
    
    CAGradientLayer *gradientLayer = [CAGradientLayer layer];
    gradientLayer.colors     = @[(__bridge id) kRGB_COLOR(@"#FE73E1").CGColor, (__bridge id) kRGB_COLOR(@"#9A58FF").CGColor];
    gradientLayer.locations  = @[@0.3, @1.0];
    gradientLayer.startPoint = CGPointMake(0, 0);
    gradientLayer.endPoint   = CGPointMake(1.0, 0);
    gradientLayer.frame      = agreeBtn.bounds;
    gradientLayer.cornerRadius = 5;
    [agreeBtn.layer addSublayer:gradientLayer];
    
    kWeakSelf(self);
    [self.timerBlock startTimerForTotalTime:30 IntervalTime:0.1 progress:^(CGFloat progress) {
        [weakself netStatus];
    } finish:^{
        
    }];
}



- (void)netStatus{
    //获取用户app配置文件
    kWeakSelf(self);
    if (self.xieyiRule.length == 0) {
        [KLCAppConfig updateAppConfig:^(BOOL success) {
            if (success && KLCAppConfig.appConfig.currTime > 0) {
                weakself.requestFinish = YES;
                weakself.xieyiRule = KLCAppConfig.appConfig.adminLiveConfig.xieyiRule;
                [weakself.timerBlock stopTimer];
                weakself.timerBlock = nil;
                weakself.contentLabel.attributedText = [weakself.xieyiRule HTMLTextWithTextColor:[UIColor blackColor]];
            }
        }];
    }
}

- (void)noAgreeBtnClick:(UIButton *)btn{
    UIWindow *window =[UIApplication sharedApplication].delegate.window;
    [window removeAllSubViews];
    [UIView animateWithDuration:0.25f animations:^{
        window.alpha = 0;
        window.frame = CGRectMake(kScreenWidth/2.0, kScreenHeight/2.0, 0, 0);
    } completion:^(BOOL finished) {
        exit(0);
    }];
}

- (void)agreeBtnClick:(UIButton *)btn{
    
    if (self.contentLabel.attributedText.length > 0) {
        
        [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"policy_tips"];
        
        if(self.closeBlock){
            self.closeBlock();
        }
        
        [self removeAllSubViews];
        [self removeFromSuperview];
        
    }else{
        kWeakSelf(self);
        [self openEventServiceWithBlock:^(BOOL connState) {
            if (connState) {
                if (weakself.requestFinish) {
                    
                    dispatch_async(dispatch_get_main_queue(), ^{
                        weakself.closeBlock?weakself.closeBlock():nil;
                        
                        [weakself removeAllSubViews];
                        [weakself removeFromSuperview];
                    });
                    
                }else{
                    [weakself netStatus];
                }
            }else{
                [SVProgressHUD showInfoWithStatus:kLocalizationMsg(@"请先确认网络是否正常连接")];
            }
        }];
    }
    
}


///点击文字
- (void)yb_tapAttributeInLabel:(UILabel *)label string:(NSString *)string range:(NSRange)range index:(NSInteger)index{
    NSString *url = @"";
    if (index == 0) {
        url = @"/api/login/appSite?type=10";
    }else{
        url = @"/api/login/appSite?type=2";
    }
    [RouteManager routeForName:RN_general_webView currentC:self.superVC parameters:@{@"url":url}];
}


- (BOOL)textView:(UITextView *)textView shouldInteractWithURL:(NSURL *)URL inRange:(NSRange)characterRange {
    NSString *url = @"";
    if ([[URL scheme] isEqualToString:@"userdeal"]) {
        url = @"/api/login/appSite?type=10";
        [RouteManager routeForName:RN_general_webView currentC:self.superVC parameters:@{@"url":url}];
        return NO;
    } else if ([[URL scheme] isEqualToString:@"policy"]) {
        url = @"/api/login/appSite?type=2";
        [RouteManager routeForName:RN_general_webView currentC:self.superVC parameters:@{@"url":url}];
        return NO;
    }
    return YES;
}


///iOS开发检测是否开启联网
- (void)openEventServiceWithBlock:(void(^)(BOOL connState))callback
{
    
    CTCellularData *cellularData = [[CTCellularData alloc] init];
    cellularData.cellularDataRestrictionDidUpdateNotifier = ^(CTCellularDataRestrictedState state){
        if (state == kCTCellularDataRestrictedStateUnknown) {
            callback(NO);
        } else {
            callback(YES);
        }
    };
//    CTCellularDataRestrictedState state = cellularData.restrictedState;
//    if (state == kCTCellularDataRestrictedStateUnknown) {
//        callback(NO);
//    } else {
//        callback(YES);
//    }
}


@end
