//
//  LiveTimekeeping.m
//  LiveCommon
//
//  Created by klc_sl on 2020/4/1.
//  Copyright © 2020 . All rights reserved.
//

#import "LiveTimekeeping.h"
#import <LibTools/LibTools.h>
#import <LibProjView/TipAlertView.h>
#import <LiveCommon/LiveManager.h>
#import <LiveCommon/LiveComponentMsgListener.h>
#import <LiveCommon/LiveComponentMsgMgr.h>
#import <LibProjBase/LibProjBase.h>

@interface LiveTimekeeping ()

@property (nonatomic, copy)TimerBlock *timeBlock;

@property (nonatomic, copy)NSMutableDictionary<NSString *, void (^)(int64_t)> *timeBlockDic;

@property (nonatomic, weak)UILabel *showTimeL;

///基础秒数
@property (nonatomic, assign)int64_t baseSecond;

@property (nonatomic, assign)int attenTime;
@property (nonatomic, assign)int fansTime;

@end

@implementation LiveTimekeeping

- (void)dealloc
{
    [_timeBlock stopTimer];
    _timeBlock = nil;
}


+ (instancetype)share{
    static dispatch_once_t onceToken;
    static LiveTimekeeping *_timeKeeping = nil;
    dispatch_once(&onceToken, ^{
        _timeKeeping = [[LiveTimekeeping alloc] init];
    });
    return _timeKeeping;
}

- (void)startLiveTime:(int64_t)baseTime{
    kWeakSelf(self);
    [self setBaseTime:baseTime];
    
    [self.timeBlock startTimerForSecondBlock:^(CGFloat progress) {
        [weakself timeManager:(int64_t)progress];
    }];
}

- (void)setBaseTime:(int64_t)baseTime{
    _attenTime = [[ProjConfig shareInstence].baseConfig liveRoomAttenTipTime];
    _fansTime = [[ProjConfig shareInstence].baseConfig liveRoomFansTipTime];
    
    if (baseTime > 1000) {
        NSDate *dateNow = [NSDate date];
        int64_t timeSp = [[NSNumber numberWithDouble:[dateNow timeIntervalSince1970]] longLongValue];
        _baseSecond = timeSp-(baseTime/1000);
    }else{
        _baseSecond = 0;
    }

}

- (void)timeManager:(int64_t)progress{
    
    _showTime = progress+_baseSecond;
    
    _showTimeL.text = [NSString changeShowTimeForSecond:_showTime];
    
    switch ([LiveManager liveInfo].roomRole) {
        case RoomRoleForAnchor:  ///主播
        {

        }
            break;
        default:    ///其他用户
        {
            if (progress == _attenTime) {///弹出用户关注弹窗
                
                [LiveComponentMsgMgr sendMsg:(LM_TimeAttention) msgDic:nil];
                
            }else if (progress == _fansTime){//////弹出用户加入粉丝团弹窗
                
                [LiveComponentMsgMgr sendMsg:(LM_TimeJoinFans) msgDic:nil];
                
            }else{
                
            }
        }
            break;
    }
    kWeakSelf(self);
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        [weakself notificationBlock:weakself.showTime];
    });
}

- (void)notificationBlock:(int64_t)time{
    [_timeBlockDic enumerateKeysAndObjectsUsingBlock:^(NSString * _Nonnull key, void (^ _Nonnull obj)(int64_t), BOOL * _Nonnull stop) {
        if (obj) {
            dispatch_async(dispatch_get_main_queue(), ^{
                obj(time);
            });
        }
    }];
}


- (void)stopLiveTime{
    [self removeAllTimerObserver];
    [_timeBlock stopTimer];
    _timeBlock = nil;
}

- (TimerBlock *)timeBlock{
    if (!_timeBlock) {
        _timeBlock =  [[TimerBlock alloc] init];
    }
    return _timeBlock;
}


- (void)showTimeAlert{
    kWeakSelf(self);
    [TipAlertView showTitle:kLocalizationMsg(@"当前直播时长") subTitle:^(UILabel * _Nonnull subTitleL) {
        subTitleL.text = [NSString changeShowTimeForSecond:weakself.showTime];
        weakself.showTimeL = subTitleL;
    } sureBtnTitle:kLocalizationMsg(@"我知道了") btnClick:^{
        weakself.showTimeL = nil;
    } cancel:^{
        weakself.showTimeL = nil;
    }];
}




#pragma mark - 添加计时器监听 -

- (NSMutableDictionary *)timeBlockDic{
    if (!_timeBlockDic) {
        _timeBlockDic = [[NSMutableDictionary alloc] init];
    }
    return _timeBlockDic;
}

- (void)addTimerObserver:(id)observer timeBlock:(void (^)(int64_t))timeBlock{
    
    NSString *observerStr = @"";
    if ([observer isKindOfClass:[NSObject class]]) {
        NSObject *obj = (NSObject *)observer;
        observerStr = NSStringFromClass(obj.class);
    }
    
    if (timeBlock && observerStr.length > 0 && observerStr.length) {
        [self.timeBlockDic setObject:timeBlock forKey:observerStr];
    }
}


- (void)removeTimerObserver:(id)observer{
    
    NSString *observerStr = @"";
    if ([observer isKindOfClass:[NSObject class]]) {
        NSObject *obj = (NSObject *)observer;
        observerStr = NSStringFromClass(obj.class);
    }
    
    if (observerStr.length > 0) {
        [self.timeBlockDic removeObjectForKey:observerStr];
    }
}


- (void)removeAllTimerObserver{
    [_timeBlockDic removeAllObjects];
    _timeBlockDic = nil;
}



@end
