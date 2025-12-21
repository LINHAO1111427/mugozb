//
//  VoipRingObj.m
//  PushKit
//
//  Created by klc_sl on 2020/12/3.
//  Copyright © 2020 KLC. All rights reserved.
//

#import "VoipRingObj.h"
#import <PushKit/PushKit.h>
#import <UserNotifications/UserNotifications.h>
#import <AudioToolbox/AudioToolbox.h>
#define kLocalizationMsg(key) NSLocalizedString(key, nil)
@implementation VoipRingObj


- (instancetype)init
{
    self = [super init];
    if (self) {
    }
    return self;
}

- (void)addNotification{
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(onCancelRing) name:UIApplicationWillTerminateNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(onCancelRing) name:UIApplicationDidBecomeActiveNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(onCancelRing) name:UIApplicationWillEnterForegroundNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(onCancelRing) name:UIApplicationDidFinishLaunchingNotification object:nil];
}

- (void)removeNotification{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIApplicationWillTerminateNotification object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIApplicationDidBecomeActiveNotification object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIApplicationWillEnterForegroundNotification object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIApplicationDidFinishLaunchingNotification object:nil];
}


- (void)registerPushKit{
    ///注册VOIP
    PKPushRegistry *pushRegistry = [[PKPushRegistry alloc] initWithQueue:dispatch_get_main_queue()];
    pushRegistry.delegate = self;
    pushRegistry.desiredPushTypes = [NSSet setWithObject:PKPushTypeVoIP];
}

- (void)onStartRing:(NSDictionary *)param{
    
    switch ([UIApplication sharedApplication].applicationState) {
        case UIApplicationStateActive:
        {
            ///在前台不接
            return;
        }
            break;
        case UIApplicationStateInactive:
        {
        }
            break;
        case UIApplicationStateBackground:
        {
        }
            break;
        default:
            break;
    }
    
    [[NSNotificationCenter defaultCenter] postNotificationName:@"PKPushIncomingCallReportedNotification" object:nil];
    
    __weak typeof(self) weakself = self;
    _bgTask = [[UIApplication sharedApplication] beginBackgroundTaskWithName:@"MyTask" expirationHandler:^{
        
        // Clean up any unfinished task business by marking where you
        // stopped or ending the task outright.
        
        [weakself onCancelRing];
        
        [[UIApplication sharedApplication] endBackgroundTask: weakself.bgTask];
        weakself.bgTask = UIBackgroundTaskInvalid;
    }];
    
    [self addNotification];
    
    NSDictionary *apnDic = param[@"aps"];
    NSDictionary *alertDic = apnDic[@"alert"];
    
    if ([[UIDevice currentDevice].systemVersion floatValue] >= 10.0) {
        
        UNUserNotificationCenter* center = [UNUserNotificationCenter currentNotificationCenter];
        center.delegate = _notificationDelegate;
        
        UNMutableNotificationContent* content = [[UNMutableNotificationContent alloc] init];
        content.title = alertDic[@"title"];
        content.body = alertDic[@"subtitle"];
        
        //        UNNotificationSound *customSound = [UNNotificationSound soundNamed:apnDic[@"sound"]];
        ///call.wav
        UNNotificationSound *customSound = [UNNotificationSound soundNamed:@"call.wav"];
        content.sound = customSound;
        
        content.userInfo = param;
        
        UNTimeIntervalNotificationTrigger* trigger = [UNTimeIntervalNotificationTrigger
                                                      triggerWithTimeInterval:1 repeats:NO];
        UNNotificationRequest *request = [UNNotificationRequest requestWithIdentifier:@"Voip_Push"
                                                                              content:content trigger:trigger];
        [center addNotificationRequest:request withCompletionHandler:^(NSError * _Nullable error) {
        }];
        
    }else {
        _callNotification = [[UILocalNotification alloc] init];
        // 发出推送的日期
        _callNotification.fireDate = [NSDate dateWithTimeIntervalSinceNow:0.1];
        // 推送的内容
        _callNotification.alertTitle = alertDic[@"title"];
        _callNotification.alertBody = alertDic[@"subtitle"];
        // 可以添加特定信息
        _callNotification.userInfo = param;
        // 角标
        _callNotification.applicationIconBadgeNumber = 1;
        [[UIApplication sharedApplication] scheduleLocalNotification:_callNotification];
        
    }
    [self startPlaySystemSound];
    
    //    [self test:kLocalizationMsg(@"开始") pointY:200];
}

- (void)onCancelRing{
    //    //取消通知栏
    //    if ([[UIDevice currentDevice].systemVersion floatValue] >= 10.0) {
    //        NSMutableArray *arraylist = [[NSMutableArray alloc] init];
    //        [arraylist addObject:@"Voip_Push"];
    //        [[UNUserNotificationCenter currentNotificationCenter] removeDeliveredNotificationsWithIdentifiers:arraylist];
    //    }else {
    //        [[UIApplication sharedApplication] cancelLocalNotification:_callNotification];
    //    }
    //
    //    AudioServicesPlaySystemSound(1007);
    
    [self stopPlaySystemSound];
    [self removeNotification];
    [[UIApplication sharedApplication] endBackgroundTask:_bgTask];
}



///开始震动
- (void)startPlaySystemSound
{
    if (!_timer) {
        dispatch_queue_t  queue = dispatch_get_global_queue(0, 0);
        
        // 创建一个 timer 类型定时器 （ DISPATCH_SOURCE_TYPE_TIMER）
        _timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, queue);
        
        //设置定时器的各种属性（何时开始，间隔多久执行）
        // GCD 的时间参数一般为纳秒 （1 秒 = 10 的 9 次方 纳秒）
        // 指定定时器开始的时间和间隔的时间
        dispatch_source_set_timer(_timer, DISPATCH_TIME_NOW, 1.0 * NSEC_PER_SEC, 0);
        
        __block int param = 50;
        __weak typeof(self) weakself = self;
        // 任务回调
        dispatch_source_set_event_handler(_timer, ^{
            --param;
            AudioServicesPlaySystemSound(kSystemSoundID_Vibrate);
            if (param == 0) {
                [weakself onCancelRing];
            }
        });
        // 开始定时器任务（定时器默认开始是暂停的，需要复位开启）
        dispatch_resume(_timer);
    }
}


#pragma mark ---- 结束震动
-(void)stopPlaySystemSound{
    if (_timer) {
        dispatch_source_cancel(_timer);
        _timer = nil;
    }
}





#pragma mark -PKPushRegistryDelegatev-

- (void)pushRegistry:(PKPushRegistry *)registry didUpdatePushCredentials:(PKPushCredentials *)pushCredentials forType:(PKPushType)type {
    if([pushCredentials.token length] == 0) {
       // NSLog(@"过滤文字ApplePush推送voip token NULL"));
        return;
    }
    if (self.delegate) {
        [self.delegate voipServerToken:pushCredentials.token];
    }
}

- (void)pushRegistry:(PKPushRegistry *)registry didReceiveIncomingPushWithPayload:(PKPushPayload *)payload forType:(PKPushType)type {
    
   // NSLog(@"过滤文字ApplePush推送收到---voip推送 ----实现客户端逻辑~~~%@~~~%@"),payload.dictionaryPayload, type);
    ///通话
    NSData *data = [payload.dictionaryPayload[@"extraMap"] dataUsingEncoding:NSUTF8StringEncoding];
    NSDictionary *param = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
    if ([param[@"pushType"] intValue] == 10) {
        if (_timer) {
        }else{
            [self onStartRing:payload.dictionaryPayload];
        }
    }
    if ([param[@"pushType"] intValue] == 11) {
        
        //        [self test:kLocalizationMsg(@"结束") pointY:250];
        [self onCancelRing];
    }
}

- (void)pushRegistry:(PKPushRegistry *)registry didInvalidatePushTokenForType:(PKPushType)type{
    //    [self onCancelRing];
}


///调试用
- (void)test:(NSString *)show pointY:(CGFloat)pointY{
    NSString *param = @"sdssfsfdsdfsdfdsf";
    switch ([UIApplication sharedApplication].applicationState) {
        case UIApplicationStateActive:
        {
            param = kLocalizationMsg(@"在前台活跃");
            return;
        }
            break;
        case UIApplicationStateInactive:
        {
            param = kLocalizationMsg(@"在不活跃");
        }
            break;
        case UIApplicationStateBackground:
        {
            param = kLocalizationMsg(@"在后台");
        }
            break;
        default:
            break;
    }
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"hh:mm:ss"];
    NSString *DateTime = [formatter stringFromDate:[NSDate date]];
    
    UILabel *lab = [[UILabel alloc] initWithFrame:CGRectMake(0, pointY, 400, 50)];
    lab.text = [NSString stringWithFormat:@"%@-%@:%@",param,show,DateTime];
    lab.textColor = [UIColor redColor];
    lab.font = [UIFont systemFontOfSize:34];
    lab.textAlignment = NSTextAlignmentCenter;
    [[UIApplication sharedApplication].keyWindow addSubview:lab];
    
}



@end
