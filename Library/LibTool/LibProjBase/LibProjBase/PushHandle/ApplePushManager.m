//
//  ApplePushManager.m
//  PushKit
//
//  Created by shao on 2020/9/1.
//  Copyright © 2019 klc. All rights reserved.
//

#import "ApplePushManager.h"
#import <objc/runtime.h>

#import <UserNotifications/UserNotifications.h>
#import <LibProjBase/ProjConfig.h>
#import "PushSessionObj.h"
#import "VoipRingObj.h"
#import "PushInfoHandle.h"

const void *_launchedByNotification;

@interface ApplePushManager ()<UNUserNotificationCenterDelegate,VoipRingObjDelegate>

@property (nonatomic, copy)NSString *pushTokenStr;  ///苹果推送注册Token字符串

@property (nonatomic, copy)NSString *voipTokenStr;  ///苹果Voip注册token字符串

@property (nonatomic, copy)PushDataHandle notificationInfo;

@property (nonatomic, copy)VoipRingObj *voipRing; ///视频通话

@property (nonatomic, copy)PushInfoHandle *pushHandle;

@end

@implementation ApplePushManager

+ (instancetype)share{
    static ApplePushManager *_dlNotice = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        if (!_dlNotice) {
            _dlNotice = [[ApplePushManager alloc] init];
        }
    });
    return _dlNotice;
}



#pragma mark - push handle -

+ (void)registeNotification:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    [[ApplePushManager share] registerNotify:application options:launchOptions];
}

+ (void)registerDeviceToken:(NSData *)deviceToken {
    [[ApplePushManager share] setPushKitDeviceToken:deviceToken];
    [[ApplePushManager share] registerUserIdentifier];
}

+ (void)handleLowVersionNotificationInfo:(NSDictionary *)info {
   // NSLog(@"过滤文字ApplePush推送iOS8-10 收到通知"));
    [[ApplePushManager share] handleUserInfo:info];
}

+ (void)receiveDataHandle:(PushDataHandle)param {
    [ApplePushManager share].notificationInfo = param;
}

- (void)setPushKitDeviceToken:(NSData *)deviceToken{
    _pushTokenStr = [self setUserNotificationRegisterId:deviceToken];
}

- (NSString *)setUserNotificationRegisterId:(NSData *)deviceToken{
    NSMutableString *deviceTokenString = [NSMutableString string];
    const char *bytes = deviceToken.bytes;
    NSUInteger iCount = deviceToken.length;
    for (int i = 0; i < iCount; i++) {
        [deviceTokenString appendFormat:@"%02x", bytes[i]&0x000000FF];
    }
    return deviceTokenString;
}

///注册app
- (void)registerNotify:(UIApplication *)application options:(nonnull NSDictionary *)launchOptions{
   // NSLog(@"过滤文字[PushKit]%@"),launchOptions);
    ///是否有远程推送消息
    NSDictionary *remoteNotification = [launchOptions objectForKey:UIApplicationLaunchOptionsRemoteNotificationKey];
    self.launchedByNotification = (remoteNotification == nil ? NO : YES);
    
    if ([[ProjConfig shareInstence].baseConfig hasVoipNotification]) {
        [self.voipRing registerPushKit];
    }
    ///注册推送
    if (@available(iOS 10.0, *)) {
        //iOS 10 later
        UNUserNotificationCenter *notificationCenter = [UNUserNotificationCenter currentNotificationCenter];
        //必须写代理，不然无法监听通知的接收与点击事件
        notificationCenter.delegate = self;
        [notificationCenter requestAuthorizationWithOptions:(UNAuthorizationOptionBadge | UNAuthorizationOptionSound | UNAuthorizationOptionAlert) completionHandler:^(BOOL granted, NSError * _Nullable error) {
            if (!error && granted) {
                //用户点击允许
               // NSLog(@"过滤文字ApplePush推送注册成功"));
            }else{
                //用户点击不允许
               // NSLog(@"过滤文字ApplePush推送注册失败"));
            }
        }];
        // 可以通过 getNotificationSettingsWithCompletionHandler 获取权限设置
        //之前注册推送服务，用户点击了同意还是不同意，以及用户之后又做了怎样的更改我们都无从得知，现在 apple 开放了这个 API，我们可以直接获取到用户的设定信息了。注意UNNotificationSettings是只读对象哦，不能直接修改！
        [notificationCenter getNotificationSettingsWithCompletionHandler:^(UNNotificationSettings * _Nonnull settings) {
            //打印结果 ========<UNNotificationSettings: 0x1740887f0; authorizationStatus: Authorized, notificationCenterSetting: Enabled, soundSetting: Enabled, badgeSetting: Enabled, lockScreenSetting: Enabled, alertSetting: NotSupported, carPlaySetting: Enabled, alertStyle: Banner>
        }];
    }else if (@available(iOS 8.0, *)){
        //iOS 8 - iOS 10系统
        UIUserNotificationSettings *settings = [UIUserNotificationSettings settingsForTypes:UIUserNotificationTypeAlert | UIUserNotificationTypeBadge | UIUserNotificationTypeSound categories:nil];
        [application registerUserNotificationSettings:settings];
    }else{
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wdeprecated-declarations"
        //iOS 8.0系统以下
        [application registerForRemoteNotificationTypes:UIRemoteNotificationTypeBadge | UIRemoteNotificationTypeAlert | UIRemoteNotificationTypeSound];
#pragma clang diagnostic pop
    }
    
    [application registerForRemoteNotifications];
}


///向服务器注册Id(苹果自己的推送没有registerId)
- (void)registerUserIdentifier{
    int pushPlatform = 5;
    if ([ProjConfig isUserLogin]) {
        NSString *requestUrl = [NSString stringWithFormat:@"%@%@",[ProjConfig baseUrl],@"/api/user/upUserPushInfo"];
        NSDictionary *param = @{@"pushPlatform":@(pushPlatform) ,@"pushRegisterId":_pushTokenStr.length>0?_pushTokenStr:@"", @"voipToken":_voipTokenStr.length>0?_voipTokenStr:@""};
        [PushSessionObj requestSession:requestUrl param:param complete:^(BOOL success, id  _Nonnull info) {
            if (success) {
               // NSLog(@"过滤文字ApplePush推送后台注册成功"));
            }
        }];
    }
}


- (BOOL)launchedByNotification {
    NSNumber *boolNum = objc_getAssociatedObject(self, _launchedByNotification);
    return [boolNum boolValue];
}

- (void)setLaunchedByNotification:(BOOL)launchedByNotification {
    objc_setAssociatedObject(self, _launchedByNotification, @(launchedByNotification), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (void)handleUserInfo:(NSDictionary *)userInfo{
   // NSLog(@"过滤文字ApplePush推送系统，收到通知:%@"), userInfo);
    if (userInfo && userInfo[@"extraMap"]) {
        if (self.launchedByNotification) {
           // NSLog(@"过滤文字ApplePush推送程序关闭(杀死)状态点击推送消息打开应用"));
            
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(5.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [self blockPushData:userInfo[@"extraMap"] active:NO];
            });
        } else {
            if ([UIApplication sharedApplication].applicationState == UIApplicationStateActive) {
               // NSLog(@"过滤文字ApplePush推送程序前台运行"));
                [self blockPushData:userInfo[@"extraMap"] active:YES];
            } else {
               // NSLog(@"过滤文字ApplePush推送程序挂起但未被杀死"));
                [self blockPushData:userInfo[@"extraMap"] active:NO];
            }
        }
        
    }

    [UIApplication sharedApplication].applicationIconBadgeNumber = 0;
    [self.voipRing onCancelRing];
    
}

- (void)blockPushData:(NSString *)extraMap active:(BOOL)active{
    if (_notificationInfo) {
        NSData *data = [extraMap dataUsingEncoding:NSUTF8StringEncoding];
        NSDictionary *param = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
        
        NSString *pushIdStr = param[@"pushId"];
        
        if (![self.pushHandle existsPushId:pushIdStr]) {
            [self.pushHandle savePushId:pushIdStr];
            _notificationInfo(active, param);
        }
        
    }
}


#pragma mark - UNUserNotificationCenterDelegate -

//- (void)userNotificationCenter:(UNUserNotificationCenter *)center willPresentNotification:(UNNotification *)notification withCompletionHandler:(void (^)(UNNotificationPresentationOptions options))completionHandler {
//
//    UNNotificationContent *content = notification.request.content;
//    NSDictionary *userInfo = content.userInfo;
//    completionHandler(UNNotificationPresentationOptionAlert|UNNotificationPresentationOptionSound);
//}


// The method will be called on the delegate when the user responded to the notification by opening the application, dismissing the notification or choosing a UNNotificationAction. The delegate must be set before the application returns from application:didFinishLaunchingWithOptions:.
- (void)userNotificationCenter:(UNUserNotificationCenter *)center didReceiveNotificationResponse:(UNNotificationResponse *)response withCompletionHandler:(void(^)(void))completionHandler{
    
    UNNotificationContent *content = response.notification.request.content;
    NSDictionary *userInfo = content.userInfo;
    if([response.notification.request.trigger isKindOfClass:[UNPushNotificationTrigger class]]) {
       // NSLog(@"过滤文字ApplePush推送iOS10 收到远程通知"));
    } else {
       // NSLog(@"过滤文字ApplePush推送iOS10 收到本地通知"));
    }
    
    [self.voipRing onCancelRing];
    
    [self handleUserInfo:userInfo];
    
    // 此处必须要执行下行代码，不然会报错
    completionHandler();
    
}

- (void)userNotificationCenter:(UNUserNotificationCenter *)center openSettingsForNotification:(nullable UNNotification *)notification {
    
}


#pragma mark - VoipRingObjDelegate -
- (void)voipServerToken:(NSData *)data{
    //应用启动获取token，并上传服务器
    _voipTokenStr = [self setUserNotificationRegisterId:data];
    //token上传自己的服务器
    [self registerUserIdentifier];
    
   // NSLog(@"过滤文字ApplePush推送拿到token~~~%@~~~~\n~~~%@"),data,_voipTokenStr);
}


- (VoipRingObj *)voipRing{
    if (!_voipRing && [[ProjConfig shareInstence].baseConfig hasVoipNotification]) {
        _voipRing = [[VoipRingObj alloc] init];
        _voipRing.delegate = self;
        _voipRing.notificationDelegate = self;
    }
    return _voipRing;
}

- (PushInfoHandle *)pushHandle{
    if (!_pushHandle) {
        _pushHandle = [[PushInfoHandle alloc] init];
    }
    return _pushHandle;
}


@end
