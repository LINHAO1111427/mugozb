//
//  VoipRingObj.h
//  PushKit
//
//  Created by klc_sl on 2020/12/3.
//  Copyright © 2020 KLC. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <PushKit/PushKit.h>

NS_ASSUME_NONNULL_BEGIN

@protocol VoipRingObjDelegate <NSObject>

- (void)voipServerToken:(NSData *)data;

@end

@interface VoipRingObj : NSObject <PKPushRegistryDelegate>

@property (nonatomic, copy)dispatch_source_t timer; ///定时器

@property (nonatomic, copy)UILocalNotification *callNotification; ///ios10以下推送

@property (nonatomic, assign)UIBackgroundTaskIdentifier bgTask;  ///申请任务

@property (nonatomic, weak)id<VoipRingObjDelegate> delegate;

@property (nonatomic, weak)id notificationDelegate;


- (void)registerPushKit;

- (void)onStartRing:(NSDictionary *)param;

- (void)onCancelRing;


@end

NS_ASSUME_NONNULL_END
