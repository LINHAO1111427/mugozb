//
//  LiveLevelView.h
//  LiveCommon
//
//  Created by shirley on 2021/12/31.
//  Copyright © 2021 KLC. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LiveComponentProtocol.h"

@class AppHomeHallDTOModel,SlideLiveRoomInfoModel,LiveLevelView;

NS_ASSUME_NONNULL_BEGIN

@protocol LiveLevelViewDelegate <NSObject>

/// 左右滑动清屏
/// @param clear 是否清屏
/// @param start 开始或者结束
- (void)clearScreen:(BOOL)clear startOrEnd:(BOOL)start;
///离开没有加入的房间
- (void)leaveLiveRoomForNotJoin;
///刷新当前直播间的信息
- (void)reloadLiveRoomInfo:(LiveLevelView *)liveView;

@end

@interface LiveLevelView : UIView

///当前页面是否正在播放
@property (nonatomic, assign)BOOL isPlayInfo;
///当前播放的是第几个
@property (nonatomic, assign)NSInteger currIndex;
///直播房间ID
@property (nonatomic, assign)int64_t roomId;
///直播类型
@property (nonatomic, assign)int LiveType;

///代理
@property (nonatomic, weak)id<LiveLevelViewDelegate> viewDelegate;

///显示层级视图
@property (nonatomic, copy) NSArray *liveViews;

///是否可以清屏
@property (nonatomic, assign) BOOL canClear;


///视图清屏 是否有动画
- (void)clearView:(BOOL)clear animation:(BOOL)animation;

///加入房间 & 加入成功回调处理
- (void)joinRoomAllCompInfo:(Class<LiveComponentProtocol>)liveCompConfig successHandle:(void(^)(void))successHandle;

///显示关播页面
- (void)showCloseInfo:(AppHomeHallDTOModel *)dtoModel;

///显示没有具体信息时的遮盖页面
- (void)showCoverViewMakeBaseInfo:(SlideLiveRoomInfoModel *)dtoModel;


@end

NS_ASSUME_NONNULL_END
