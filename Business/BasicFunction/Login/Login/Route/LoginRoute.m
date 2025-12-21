//
//  LoginRoute.m
//  Login
//
//  Created by klc_sl on 2021/7/31.
//  Copyright © 2021 KLC. All rights reserved.
//

#import "LoginRoute.h"
#import <LibProjBase/RouteManager.h>
#import <LibProjBase/AppRouteName.h>
#import "UserInfoFillVC.h"
#import "UserInterestSelectVC.h"
#import "ModiftPasswordVC.h"
#import "ChangePasswordController.h"
#import "LoginViewController.h"
#import <LibProjBase/KLCNavgationContoller.h>

@implementation LoginRoute


+ (void)registeRoute{
    
    ///用户形象设置
    [RouteManager addRouteForName:RN_login_setUserProfile vcClass:UserInfoFillVC.class];
    
    ///用户兴趣标签
    [RouteManager addRouteForName:RN_login_userInterestLabel vcClass:UserInterestSelectVC.class];
    
    //忘记密码
    [RouteManager addRouteForName:RN_login_losePassword handle:^UIViewController * _Nonnull(NSDictionary<NSString *,id> * _Nullable parameters) {
        ModiftPasswordVC *passwordVc = [[ModiftPasswordVC alloc] init];
        passwordVc.operationTypetype = @(1);
        return passwordVc;
    }];
    
    //注册
    [RouteManager addRouteForName:RN_login_userRegister handle:^UIViewController * _Nonnull(NSDictionary<NSString *,id> * _Nullable parameters) {
        ModiftPasswordVC *passwordVc = [[ModiftPasswordVC alloc] init];
        passwordVc.operationTypetype = @(0);
        return passwordVc;
    }];
    
    //绑定手机号
    [RouteManager addRouteForName:RN_login_userBindPhone handle:^UIViewController * _Nonnull(NSDictionary<NSString *,id> * _Nullable parameters) {
        ModiftPasswordVC *passwordVc = [[ModiftPasswordVC alloc] init];
        passwordVc.operationTypetype = @(2);
        return passwordVc;
    }];
    
    
    //    修改密码：
    [RouteManager addRouteForName:RN_center_setting_changePassword handle:^UIViewController * _Nonnull(NSDictionary<NSString *,id> * _Nullable parameters) {
        ChangePasswordController *passwordVC = [[ChangePasswordController alloc] init];
        passwordVC.navtitle = parameters[@"title"];
        return passwordVC;
    }];
    
    ///推出登录页面
    [RouteManager addRouteForName:RN_login_ShowLoginVC complete:^(NSDictionary<NSString *,id> * _Nullable parameters, UIViewController * _Nonnull lastVC) {
        LoginViewController *loginVC = [[LoginViewController alloc] init];
        loginVC.hasBack = YES;
        KLCNavgationContoller *loginNav = [[KLCNavgationContoller alloc] initWithRootViewController:loginVC];
        loginNav.modalPresentationStyle = UIModalPresentationFullScreen;
        [lastVC presentViewController:loginNav animated:YES completion:nil];
    }];
}


@end
