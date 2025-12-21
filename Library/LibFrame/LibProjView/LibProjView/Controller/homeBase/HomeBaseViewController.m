//
//  HomeBaseViewController.m
//  LibProjController
//
//  Created by ssssssssssss on 2020/9/16.
//  Copyright © 2020 KLC. All rights reserved.
//

#import "HomeBaseViewController.h"

#import <LibProjModel/HttpApiUserController.h>

#import <LibProjModel/APPConfigModel.h>

#import <LibProjModel/AdminLoginSwitchModel.h>

#import <LibProjView/ZQAlterField.h>
#import <LibProjView/SignToastView.h>
#import <LibProjView/VersionTipView.h>
#import <LibProjView/FreeCallTipView.h>
#import <LibProjView/LoginRewardView.h>
#import <LibProjView/UserGiftPackView.h>
#import <LibProjView/SystemNoticeView.h>
#import <LibProjView/MyBirthdaySplashView.h>
#import <LibProjView/PlatformBanTreatyView.h>
#import <LibProjView/FirstRechargeRewardView.h>

static dispatch_once_t onceToken;

@interface HomeBaseViewController ()

@property(nonatomic,strong)ZQAlterField *codeAlertView;
@property (nonatomic,assign) dispatch_queue_t myQueue;//队列

@property (nonatomic, copy)NSArray *systemAlertArray;

@end

@implementation HomeBaseViewController


- (dispatch_queue_t)myQueue{
    static dispatch_queue_t queue;
    dispatch_once(&onceToken, ^{
        queue = dispatch_queue_create("alerSystemtView", DISPATCH_QUEUE_SERIAL);
    });
    return queue;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    if (self.showAlert) {
        
        self.systemAlertArray = [[ProjConfig shareInstence].businessConfig getAppSystemAlertArray];
        
        BOOL hasShow = [[NSUserDefaults standardUserDefaults] boolForKey:@"systemAlertHasShow"];
        if (!hasShow) {
            [self showSystemAlert];
        }
        
    }
}


//******************开始弹窗******************
- (void)showSystemAlert{
    [self.view endEditing:YES];
    onceToken = 0;
    self.myQueue = nil;
    [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"systemAlertHasShow"];
    [self showSerialQueueAlertViewCompletion:^(BOOL finished) {
       // NSLog(@"过滤文字系统弹窗 执行完毕"));
        [[NSUserDefaults standardUserDefaults] setBool:NO forKey:@"systemAlertHasShow"];
        [KLCUserInfo updateUserInfo:nil];//更新用户信息
    }];
}


#pragma mark - 启动后的弹窗
////*****************邀请码****************
- (void)showInvitationCode:(void (^)(BOOL isNeed))callBack{
    
    APPConfigModel *config = KLCAppConfig.appConfig;
    ///邀请码弹窗显示 1：只显示一次 2：未填邀请码，每次打开app均显示
    NSInteger display = config.loginSwitch.invitationPopDisplay;
    
    /// isPid 该人是否填写过邀请码 1没有填写过 2:已经绑定
    /// 该判断为没有填写过邀请码并且 是邀请码绑定
    if (config.loginSwitch.invitationBindingMethod == 1 && [KLCUserInfo isNeedBind]) { ///邀请码
        NSString *inviteShowStanderStr = [NSString stringWithFormat:@"isShowInviteV_%lld",[ProjConfig userId]];
        BOOL isShowInviteV = [[[NSUserDefaults standardUserDefaults] objectForKey:inviteShowStanderStr] boolValue];
        ///如果没有显示过邀请码页面 或者 未绑定每次打开均显示
        if (!isShowInviteV || display == 2) {
            [[NSUserDefaults standardUserDefaults] setObject:@(YES) forKey:inviteShowStanderStr];
            [self.view endEditing:YES];
            [self showCodeEditView:^(BOOL success) {
                callBack(success);
            }];
        }else{
            callBack(YES);
        }
    }else{
        callBack(YES);
    }
}


- (void)showCodeEditView:(void (^)(BOOL success))callBack{
    APPConfigModel *config = KLCAppConfig.appConfig;
    ///邀请码是必填 1.必填 2.非必填
    NSInteger isRegCode = config.loginSwitch.isRegCode;
    for(UIView * view in [[UIApplication sharedApplication].keyWindow subviews]){
        if([view isKindOfClass:[ZQAlterField class]]){
            [[[UIApplication sharedApplication].keyWindow viewWithTag:10500] removeFromSuperview];
        }
    }
    self.codeAlertView = [ZQAlterField alertView];
    self.codeAlertView.tag = 10500;
    self.codeAlertView.title = kLocalizationMsg(@"请输入邀请码");
    self.codeAlertView.Maxlength = 20;
    self.codeAlertView.styleType = ((isRegCode == 1)?regCodeStyle:noRegCodeStyle);
    
    [self.codeAlertView ensureClickBlock:^(NSString *inputString) {
        if (inputString.length == 0) {
            [SVProgressHUD showInfoWithStatus:kLocalizationMsg(@"请输入邀请码")];
        }else{
            [HttpApiUserController binding:inputString fromSource:1 callback:^(int code, NSString *strMsg, HttpNoneModel *model) {
                if (code == 1) {
                    [SVProgressHUD showSuccessWithStatus:kLocalizationMsg(@"绑定成功")];
                    [KLCUserInfo saveBind];
                    [self.codeAlertView dismiss];
                    callBack(YES);
                }else{
                    [SVProgressHUD showInfoWithStatus:strMsg];
                }
            }];
        }
    }];
    [self.codeAlertView cancelClickBlock:^{
        callBack(YES);
    }];
    [self.codeAlertView show];
}


//*****************检查版本****************
-  (void)checkVersion:(void (^)(BOOL isCancel, NSString * url))callBack{
    [VersionTipView showVersionTip:^(BOOL isCancel, NSString * _Nonnull openUrl) {
        if (callBack) {
            callBack(isCancel,openUrl);
        }
    }];
}

//*****************一对一免费通话提示****************
-  (void)freeCallTipShow:(void (^)(BOOL close))callBack{
    if ([KLCUserInfo getRole] == 0) {
        [FreeCallTipView showFreeCallTipWithComplete:^(BOOL close) {
            if (callBack) {
                callBack(close);
            }
        }];
    }else{
        callBack(YES);
    }
}

//*****************是否签到****************
-  (void)signToastShow:(void (^)(BOOL isTip))callBack{
    [SignToastView launchAutoShowSign:^(BOOL isSignIn) {
        callBack(isSignIn);
    }];
}

//新手大礼包
- (void)showGiftPack:(void (^)(BOOL success))callBack{
    [UserGiftPackView showGiftPackCallBack:^(BOOL isSucess) {
        callBack(isSucess);
    }];
}

//连续登录奖励
- (void)showLoginRewardCallBack:(void (^)(BOOL success))callBack{
    [LoginRewardView showLoginReward:^(BOOL isSucess) {
        callBack(isSucess);
    }];
}

//系统公告
- (void)showSystemNoticeWithCallBack:(void (^)(BOOL isShowDetail, NSString * _Nonnull url))callBack{
    [SystemNoticeView showSystemNoticeCallBack:^(BOOL isShowDetail, NSString * _Nonnull url) {
        callBack(isShowDetail,url);
    }];
}

//平台严令禁止条约
- (void)banTreatyCallBack:(void(^)(void))callback{
    [PlatformBanTreatyView showTreaty:^{
        callback();
    }];
}

///首充奖励
- (void)firstRecharge:(void(^)(BOOL isSucess))callback{
    [FirstRechargeRewardView launchShowFirstRechargeReward:^(BOOL isSucess) {
        callback(isSucess);
    }];
}

- (void)showSerialQueueAlertViewCompletion:(void(^)(BOOL finished))completion{
    //异步 开启新线程
    //同一个线程 同一个队列
    dispatch_async(self.myQueue, ^{
        dispatch_semaphore_t sema = dispatch_semaphore_create(0);//信号量
        for (NSDictionary *dic in self.systemAlertArray) {
            int type = [dic[@"type"] intValue];
            if (type) {
                dispatch_async(dispatch_get_main_queue(), ^{
                    switch (type) {
                        case 100:{//生日闪屏
                            [self.view endEditing:YES];
                            [MyBirthdaySplashView showBirthdaySplashComplete:^(BOOL isSucess) {
                                dispatch_semaphore_signal(sema);
                            }];
                        }
                            break;
                        case 101:{//邀请码
                            [self.view endEditing:YES];
                            [self showInvitationCode:^(BOOL isNeed) {
                                dispatch_semaphore_signal(sema);
                            }];
                        }
                            break;
                        case 102:{//新手大礼包
                            [self.view endEditing:YES];
                            [self showGiftPack:^(BOOL success) {
                                dispatch_semaphore_signal(sema);
                            }];
                        }
                            break;
                        case 103:{//连续登录奖励
                            [self.view endEditing:YES];
                            [self showLoginRewardCallBack:^(BOOL success) {
                                dispatch_semaphore_signal(sema);
                            }];
                        }
                            break;
                        case 104:{//系统公告
                            [self.view endEditing:YES];
                            [self showSystemNoticeWithCallBack:^(BOOL isShowDetail, NSString * _Nonnull url) {
                                if (isShowDetail) {
                                    [RouteManager routeForName:RN_general_webView currentC:self parameters:@{@"url":url}];
                                }
                                dispatch_semaphore_signal(sema);
                            }];
                        }
                            break;
                        case 105:{//版本升级
                            [self.view endEditing:YES];
                            [self checkVersion:^(BOOL isCancel, NSString *url) {
                                if (isCancel) {
                                    dispatch_semaphore_signal(sema);
                                }else{
                                    dispatch_semaphore_signal(sema);
                                }
                            }];
                        }
                            break;
                        case 106:{//免费通话提示
                            [self.view endEditing:YES];
                            [self freeCallTipShow:^(BOOL isTip) {
                                dispatch_semaphore_signal(sema);
                            }];
                        }
                            break;
                            
                        case 107:{//签到
                            [self.view endEditing:YES];
                            [self signToastShow:^(BOOL isTip) {
                                dispatch_semaphore_signal(sema);
                            }];
                        }
                            break;
                        case 108:{//禁止条约
                            [self.view endEditing:YES];
                            [self banTreatyCallBack:^{
                                dispatch_semaphore_signal(sema);
                            }];
                        }
                            break;
                        case 109:{//首充奖励
                            [self.view endEditing:YES];
                            [self firstRecharge:^(BOOL isSucess) {
                                dispatch_semaphore_signal(sema);
                            }];
                        }
                            break;
                        default:{
                            dispatch_semaphore_signal(sema);
                        }
                            break;
                    }
                });
                dispatch_semaphore_wait(sema, DISPATCH_TIME_FOREVER);
            }
        }
        
        dispatch_async(dispatch_get_main_queue(), ^{
            dispatch_semaphore_signal(sema);
            if (completion) {
                completion(YES);
            }
        });
    });
}

@end
