//
//  LiveTimekeeping.h
//  LiveCommon
//
//  Created by klc_sl on 2020/4/1.
//  Copyright © 2020 . All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface LiveTimekeeping : NSObject


- (instancetype)init NS_UNAVAILABLE;
+ (instancetype)alloc NS_UNAVAILABLE;


+ (instancetype)share;


///直播时长
@property (nonatomic, assign)int64_t showTime;

/// 开播时间计时⌛️
/// @param baseTime 基础创建房间的时间戳
- (void)startLiveTime:(int64_t)baseTime;

- (void)stopLiveTime;

///显示时长弹窗
- (void)showTimeAlert;




/// 添加时间监听回调
/// @param observer 监听者类
/// @param timeBlock 数据毁回调
- (void)addTimerObserver:(id)observer timeBlock:(void(^)(int64_t currentTime))timeBlock;

- (void)removeTimerObserver:(id)observer;

- (void)removeAllTimerObserver;


@end

NS_ASSUME_NONNULL_END
