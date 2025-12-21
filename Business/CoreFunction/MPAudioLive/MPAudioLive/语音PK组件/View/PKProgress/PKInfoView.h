//
//  PKInfoView.h
//  MPAudioLive
//
//  Created by klc on 2020/6/15.
//  Copyright © 2020 klc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <LiveCommon/LiveManager.h>

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSUInteger, PKProgressStatus) {
     ///准备
    PKProgressForPreparing,
    ///倒计时
    PKProgressForLoading,
    ///开始
    PKProgressForStart,
    ///结果。 （胜负。平局）
    PKProgressForEnd,
    ///PK终止
    PKProgressForStop,
};


@class ApiPkResultRoomModel;

@interface PKInfoView : UIView

- (instancetype)initWithFrame:(CGRect)frame PKType:(LiveInfo_PKType)type;

///设置PK主题
- (void)showPKTitle:(NSString *)title;

///退出PK
- (void)quitPK:(void(^)(PKProgressStatus status, NSArray *_Nullable assistans))quit;

///更改我方和对方礼物数量
- (void)updateMyTotal:(double)myTotal enemyTotal:(double)enemyTotal;

///更新我方送礼人排行和对方送礼人排行
- (void)updateMyGiftRank:(NSArray *)myItems enemyGiftRank:(NSArray *)enemyItems;

///显示开始PK动画
- (void)showStartAmination;

///变更时间
- (void)changePKStatus:(PKProgressStatus)pkStatus time:(int64_t)time;


///显示PK结果
- (void)showPKResult:(ApiPkResultRoomModel *)pkResult assistans:(NSArray *)assistans;


@end

NS_ASSUME_NONNULL_END
