//
//  UserInfoRoute.m
//  UserInfo
//
//  Created by klc_sl on 2021/7/30.
//  Copyright © 2021 KLC. All rights reserved.
//

#import "UserInfoRoute.h"
#import "FansGroupVC.h"
#import <LibProjBase/RouteManager.h>
#import <LibProjBase/AppRouteName.h>
#import "buyGuardVc.h"
#import "MineLookeMeVc.h"
#import "AnchorReportController.h"
#import "UserBlackListVC.h"
#import "UserGuardListVc.h"
#import "MedalListViewController.h"
#import "SetUserMarkVC.h"
#import "UserInfoMainVC.h"
#import "CAuthorityManageVc.h"
#import "MineFansGroupListVC.h"
#import "UserInfoEditVc.h"
#import "UserInfoEditeInputVc.h"

@implementation UserInfoRoute

+ (void)registeRoute{
    
    ///粉丝团
    [RouteManager addRouteForName:RN_activity_fansGroupAC handle:^UIViewController * _Nonnull(NSDictionary<NSString *,id> * _Nullable parameters) {
        FansGroupVC *fans = [[FansGroupVC alloc] init];
        fans.idStr = parameters[@"id"];
        return fans;
    }];
    
    ///我的粉丝团列表
    [RouteManager addRouteForName:RN_activity_MineFansGroupList  handle:^UIViewController * _Nonnull(NSDictionary<NSString *,id> * _Nullable parameters) {
        MineFansGroupListVC *lookVC = [[MineFansGroupListVC alloc] init];
        lookVC.navTitle = parameters[@"navTitle"];
        return lookVC;
    }];
    
    ///购买守护
    [RouteManager addRouteForName:RN_center_buyGuard handle:^UIViewController * _Nonnull(NSDictionary<NSString *,id> * _Nullable parameters) {
        buyGuardVc *guardVC = [[buyGuardVc alloc] init];
        guardVC.userId = parameters[@"userId"];
        return guardVC;
    }];
    
    
    ///谁看过我
    [RouteManager addRouteForName:RN_center_lookMeMore  handle:^UIViewController * _Nonnull(NSDictionary<NSString *,id> * _Nullable parameters) {
        MineLookeMeVc *lookVC = [[MineLookeMeVc alloc] init];
        lookVC.navTitle = parameters[@"title"];
        return lookVC;
    }];
     
    
    ///守护列表
    [RouteManager addRouteForName:RN_center_userGuard handle:^UIViewController * _Nonnull(NSDictionary<NSString *,id> * _Nullable parameters) {
        UserGuardListVc *guardVC = [[UserGuardListVc alloc] init];
        guardVC.userId = [parameters[@"userId"] longLongValue];
        return guardVC;
    }];
    
    ///勋章墙
    [RouteManager addRouteForName:RN_center_allMedalWall handle:^UIViewController * _Nonnull(NSDictionary<NSString *,id> * _Nullable parameters) {
        MedalListViewController *medalVC = [[MedalListViewController alloc] init];
        medalVC.userId = parameters[@"userId"];
        return medalVC;
    }];
    
    
    [RouteManager addRouteForName:RN_center_editProfile vcClass:NSClassFromString(@"UserInfoEditVc")];
    
    
    ///设置用户备注
    [RouteManager addRouteForName:RN_user_setUserRemark handle:^UIViewController * _Nonnull(NSDictionary<NSString *,id> * _Nullable parameters) {
        SetUserMarkVC *userMark = [[SetUserMarkVC alloc] init];
        userMark.userId = parameters[@"id"];
        userMark.remark = parameters[@"remark"];
        return userMark;
    }];
    
    ///搜索
    [RouteManager addRouteForName:RN_base_searchAnchorVC vcClass:NSClassFromString(@"SearchAnchorVC")];

    
    ///举报用户
    [RouteManager addRouteForName:RN_base_userReportVC handle:^UIViewController * _Nonnull(NSDictionary<NSString *,id> * _Nullable parameters) {
        AnchorReportController *reportVC = [[AnchorReportController alloc] init];
        reportVC.userId = [parameters[@"id"] longLongValue];
        return reportVC;
    }];
    
    
    ///用户详细信息
    [RouteManager addRouteForName:RN_user_userInfoVC handle:^UIViewController * _Nonnull(NSDictionary<NSString *,id> * _Nullable parameters) {
        UserInfoMainVC *userInfo = [[UserInfoMainVC alloc] init];
        userInfo.userId = [parameters[@"id"] longLongValue];
        return userInfo;
    }];
    
    ///用户拉黑列表
    [RouteManager addRouteForName:RN_User_MineBlackList vcClass:UserBlackListVC.class];
    
    
    ///主播认证 ：
    [RouteManager addRouteForName:RN_center_anchorAuthAC vcClass:CAuthorityManageVc.class];
    
}

@end
