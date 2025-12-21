//
//  MineCenterRoute.m
//  MineCenter
//
//  Created by klc_sl on 2021/7/30.
//  Copyright © 2021 KLC. All rights reserved.
//

#import "MineCenterRoute.h"
#import "MyAccountViewController.h"
#import <LibProjBase/RouteManager.h>
#import <LibProjBase/AppRouteName.h>
#import "PrivacyAndSafeVC.h"
#import "InviteRecordVc.h"
#import "guardPrivilegeVc.h"
#import <LibProjModel/KLCAppConfig.h>
#import <LibProjModel/AdminLiveConfigModel.h>

@implementation MineCenterRoute


+ (void)registeRoute{
        
    // 充值
    [RouteManager addRouteForName:RN_center_myAccountAC vcClass:MyAccountViewController.class];
    
    // 守护特权
    [RouteManager addRouteForName:RN_center_guardPrivilege vcClass:guardPrivilegeVc.class];

    //邀请记录
    [RouteManager addRouteForName:RN_center_InviteRecode vcClass:InviteRecordVc.class];
    
    //消息设置
    [RouteManager addRouteForName:RN_center_setting_messageSet vcClass:NSClassFromString(@"MessageSettingVC")];
    
    //青少年模式
    [RouteManager addRouteForName:RN_center_youthMethod vcClass:NSClassFromString(@"YouthProtectModeVC")];
    
    //设置 ：
    [RouteManager addRouteForName:RN_center_settingAC vcClass:NSClassFromString(@"MineSettingVC")];
    
    //主播中心
    [RouteManager addRouteForName:RN_center_hostCenter vcClass:NSClassFromString(@"AnchorCenterViewController")];
    
    //特权设置
    [RouteManager addRouteForName:RN_activity_privilegeSetting vcClass:NSClassFromString(@"PrivilegeSettingVC")];
    
    //隐私与安全
    [RouteManager addRouteForName:RN_center_SafeAndPrivacy vcClass:NSClassFromString(@"PrivacyAndSafeVC")];
    
    //等级特权
    [RouteManager addRouteForName:RN_center_privilegeLevel vcClass:NSClassFromString(@"PrivilegeLevelVC")];
    
    //我喜欢的
    [RouteManager addRouteForName:RN_center_mineLike vcClass:NSClassFromString(@"MineLikeInfoListVC")];
    
    // 我的邀请码
    [RouteManager addRouteForName:RN_center_inviteCode vcClass:NSClassFromString(@"MyInviteCodeVC")];
    
    //我的邀请码/收入排行榜
    [RouteManager addRouteForName:RN_center_incomeRank vcClass:NSClassFromString(@"MyInvteIncomeRankVC")];

    //用户注销
    [RouteManager addRouteForName:RN_center_setting_cancelAccount vcClass:NSClassFromString(@"AccountCancelVC")];
    
    //联系客服
    [RouteManager addRouteForName:RN_center_setting_contactService vcClass:NSClassFromString(@"ContactUsVC")];
    
    //任务中心
    [RouteManager addRouteForName:RN_center_taskCenter handle:^UIViewController * _Nonnull(NSDictionary<NSString *,id> * _Nullable parameters) {
        UIViewController *taskVC = [[NSClassFromString(@"myTaskCenterVc") alloc] init];
        if (parameters[@"isAnchor"]) {
            [taskVC setValue:parameters[@"isAnchor"] forKey:@"isAnchor"];
        }
        return taskVC;
    }];
    
    // 我的时间轴
    [RouteManager addRouteForName:RN_center_timeActivity handle:^UIViewController * _Nonnull(NSDictionary<NSString *,id> * _Nullable parameters) {
        UIViewController *myTimeVc = [[NSClassFromString(@"MyTimeActivityListViewController") alloc] init];
        [myTimeVc setValue:parameters[@"model"] forKey:@"userModel"];
        return myTimeVc;
    }];
    
    //账户验证
    [RouteManager addRouteForName:RN_center_setting_verifyAccount handle:^UIViewController * _Nonnull(NSDictionary<NSString *,id> * _Nullable parameters) {
        UIViewController *vc = [NSClassFromString(@"AccountVerifyVC") new];
        if (parameters[@"btnTitle"]) {  [vc setValue:parameters[@"btnTitle"] forKey:@"btnTitle"];}
        if (parameters[@"completeHandle"]) {[vc setValue:parameters[@"completeHandle"] forKey:@"completeHandle"]; };
        return vc;
    }];

    //在线客服
    [RouteManager addRouteForName:RN_center_setting_onLineService complete:^(NSDictionary<NSString *,id> * _Nullable parameters, UIViewController * _Nonnull lastVC) {
        NSString *url = [[KLCAppConfig appConfig].adminLiveConfig.onlineServiceUrl stringByTrimmingWhitespace];
        [RouteManager routeForName:RN_general_webView currentC:lastVC parameters:@{@"url":url.length?url:@""}];
    }];
     
    
    //手机号绑定与修改
    [RouteManager addRouteForName:RN_center_setting_bindOrModifyPhone handle:^UIViewController * _Nonnull(NSDictionary<NSString *,id> * _Nullable parameters) {
        UIViewController *bindVC = [[NSClassFromString(@"ModifyOrBindPhoneVC") alloc] init];
        [bindVC setValue:parameters[@"title"] forKey:@"navTitle"];
        [bindVC setValue:parameters[@"type"] forKey:@"type"];
        return bindVC;
    }];
    
    
    //在线商城
    [RouteManager addRouteForName:RN_center_marketAC handle:^UIViewController * _Nonnull(NSDictionary<NSString *,id> * _Nullable parameters) {
        UIViewController *marketVC = [[NSClassFromString(@"OnlineMarketViewController") alloc] init];
        [marketVC setValue:@"/pub/h5page/index.html#/byDress" forKey:@"makertUrl"];
        [marketVC setValue:@"/pub/h5page/index.html#/useDress" forKey:@"myPackUrl"];
        return marketVC;
    }];
    
    //认证提示
    [RouteManager addRouteForName:RN_center_anchorAuthStatusTipAC handle:^UIViewController * _Nonnull(NSDictionary<NSString *,id> * _Nullable parameters) {
        UIViewController *verifiedTipVC = [[NSClassFromString(@"AuthenticationTipVC") alloc] init];
        [verifiedTipVC setValue:parameters[@"model"] forKey:@"anchorModel"];
        return verifiedTipVC;
    }];
    
    //图片分享
    [RouteManager addRouteForName:RN_center_pictureSharingAC handle:^UIViewController * _Nonnull(NSDictionary<NSString *,id> * _Nullable parameters) {
        UIViewController *pictureSharingVC = [[NSClassFromString(@"PictureSharingVC") alloc] init];
        [pictureSharingVC setValue:parameters[@"model"] forKey:@"inviteModel"];
        return pictureSharingVC;
    }];
    //守护中心
    [RouteManager addRouteForName:RN_center_myGuardAC handle:^UIViewController * _Nonnull(NSDictionary<NSString *,id> * _Nullable parameters) {
        UIViewController *guardVC = [[NSClassFromString(@"myGuardCenterVc") alloc] init];
        if (parameters[@"type"] && parameters[@"userId"]) {
            [guardVC setValue:parameters[@"userId"] forKey:@"userId"];
            [guardVC setValue:parameters[@"type"] forKey:@"type"];
        }
        return guardVC;
    }];
     
    
}

@end
