//
//  ApplePushManager.h
//  PushKit
//
//  Created by shao on 2020/9/1.
//  Copyright © 2019 klc. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>


NS_ASSUME_NONNULL_BEGIN

typedef void(^PushDataHandle)(BOOL active,NSDictionary *info);

@interface ApplePushManager : NSObject

///使用推送震动
@property (nonatomic, assign)BOOL enableNotifyShake;


///app启动就注册
+ (void)registeNotification:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions;


///注册koken
+ (void)registerDeviceToken:(NSData *)deviceToken;


///处理iOS10一下低版本的通知信息
+ (void)handleLowVersionNotificationInfo:(NSDictionary *)info;


///获得的推送数据 ----- 获得推送数据  ----- 
+ (void)receiveDataHandle:(PushDataHandle)param;



@end

NS_ASSUME_NONNULL_END
