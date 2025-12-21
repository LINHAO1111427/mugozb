//
//  AppDelegate.m
//  emo
//
//  Created by admin on 2019/12/4.
//  Copyright © 2019 . All rights reserved.
//

#import "AppDelegate.h"

#import "AppKeyConfig.h"
#import "SystemBaseConfig.h"
#import "RootMainViewController.h"
#import <TXImKit/IMSocketIns.h>
#import <XTMediaKit/XTUploadFile.h>
#import <LibProjBase/MobManager.h>
#import <LibProjBase/TXMapManager.h>
#import <LibProjBase/LibProjBase.h>


#import <LibProjBase/KLCNavgationContoller.h>

#import <LibProjModel/HttpApiAppLogin.h>
#import <LibProjModel/KLCAppConfig.h>
#import <Login/UserInfoFillVc.h>

#import <Login/LanuchAdViewController.h>
#import <Bugly/Bugly.h>
#import <UserNotifications/UserNotifications.h>

#import "ProjBusinessConfig.h"
#import <LibProjBase/ApplePushManager.h>
#import <OpenInstallSDK.h>
#import <ThirdPay/ThirdPay.h>
#import <ALVideoRecord/ALVideoRecord.h>

@interface AppDelegate ()<OpenInstallDelegate>
@property (nonatomic, strong)UITextField *urlTextF;
@end

@implementation AppDelegate

+ (id)app{
    return [UIApplication sharedApplication].delegate;
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    [self klcApp:application didFinishLaunchingWithOptions:launchOptions];
    return YES;
}

- (void)klcApp:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions{
    ///配置系统基本信息
    [ProjConfig shareInstence].baseConfig = SystemBaseConfig.class;
    [ProjConfig shareInstence].businessConfig = ProjBusinessConfig.class;
    [ProjConfig shareInstence].keyConfig = AppKeyConfig.class;
    
    //设置主窗口，并设置根控制器
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    [Bugly startWithAppId:BuglyId];
    //腾讯地图
    [[TXMapManager shareInstance] initWithApiKey:tencentMapKey];//地图
    [KLCAppConfig updateAppConfig:nil];
    
    //注册阿里短视频
    [[ALVideoRecordManager share] registerAliRecordSdk];
    
    //广告图
    LanuchAdViewController *adView = [[LanuchAdViewController alloc]initWithCallBack:^(BOOL isClick, NSString * _Nonnull openUrl) {
        [self isLoginRoot:![ProjConfig isUserLogin]];
        if (isClick) {
            [LanuchAdViewController showAdInfo:openUrl];
        }
    }];
    [ApplePushManager registeNotification:application didFinishLaunchingWithOptions:launchOptions];
    //SVProgressHUD配置
    [self setPageParameter];
    
    //mob注册平台
    [MobManager registPlatforms];
    self.window.rootViewController = adView;
    [self.window makeKeyAndVisible];
    
    [OpenInstallSDK initWithDelegate:self];
    
    //登录否
    if ([ProjConfig isUserLogin]) {
        [ProjConfig userlogined];
    }
}

- (void)applicationWillTerminate:(UIApplication *)application{
}


- (void)applicationDidBecomeActive:(UIApplication *)application{
    
}

- (void)applicationWillResignActive:(UIApplication *)application{
    [UIApplication sharedApplication].applicationIconBadgeNumber = 0;
}


- (void)applicationDidEnterBackground:(UIApplication *)application{
    [UIApplication sharedApplication].applicationIconBadgeNumber = 0;
}


- (void)applicationWillEnterForeground:(UIApplication *)application{
}

- (void)isLoginRoot:(BOOL)isLogin{
    RootMainViewController *rootViewController = [[RootMainViewController alloc] init];
    __block UIViewController *rootVC;
    if (isLogin || [[ProjConfig shareInstence].baseConfig whetherSetUserProfile]) {
        rootVC = [rootViewController rootLogin];
    }else{
        rootVC = [rootViewController createNewTabBar];
        [ProjConfig connectSocket];
    }
    [self.window setRootViewController:rootVC];
}


- (void)setPageParameter{
    [SVProgressHUD setMinimumDismissTimeInterval:2.0];
    [SVProgressHUD setMaximumDismissTimeInterval:3.0];
    [SVProgressHUD setHapticsEnabled:YES];
}


- (void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken {
    [ApplePushManager registerDeviceToken:deviceToken];
}

- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo fetchCompletionHandler:(nonnull void (^)(UIBackgroundFetchResult))completionHandler{
    [ApplePushManager handleLowVersionNotificationInfo:userInfo];
    completionHandler(UIBackgroundFetchResultNewData);
}

- (BOOL)application:(UIApplication *)app openURL:(NSURL *)url options:(NSDictionary<UIApplicationOpenURLOptionsKey,id> *)options{
   // NSLog(@"过滤文字=====调取数据返回的url=====%@"),url);
    [[ThirdPay pay] payResultToOpenURL:url];
    [OpenInstallSDK handLinkURL:url];
    return YES;
}

- (BOOL)application:(UIApplication *)application continueUserActivity:(NSUserActivity *)userActivity restorationHandler:(nonnull void (^)(NSArray<id<UIUserActivityRestoring>> * _Nullable))restorationHandler{
    //处理通过openinstall一键唤起App时传递的数据
    [OpenInstallSDK continueUserActivity:userActivity];
    [[ThirdPay pay] handleUniversalLink:userActivity];
    //其他第三方回调；
     return YES;
}

@end
