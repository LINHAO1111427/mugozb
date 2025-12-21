//
//  LiveInfomation.h
//  TCDemo
//
//  Created by SL on 2019/10/31.
//  Copyright © 2019 CH. All rights reserved.
//
//  当前直播房间 主播信息，房间信息，当前状态，身份

#import <Foundation/Foundation.h>

#import "OneLiveInterface.h"
#import "MPLiveInterface.h"
#import <CoreGraphics/CoreGraphics.h>
#import <LibProjModel/AppJoinRoomVOModel.h>
#import <LibProjModel/OOOReturnModel.h>

@class OpenAuthDataVOModel;


///房间类型
typedef NS_ENUM(NSUInteger, LiveInfo_LiveType) {
    ///多人直播
    LiveTypeForMPVideoLive      =0,
    ///多人语音
    LiveTypeForMPAudioLive      =1,
    ///1v1直播(语音+视频)
    LiveTypeForOneToOne         =2,
    ///商城
    LiveTypeForShoppingLive     =3,
};

///当前房间的状态
typedef NS_ENUM(NSUInteger, LiveInfo_CurrentState) {
    ///普通
    CurrentStateForDefault      =0,
    ///互动
    CurrentStateForInteraction  =1,
    ///pk
    CurrentStateForPK           =2,
    ///连麦
    CurrentStateForConnect      =3,
};

///房间内的PK模式
typedef NS_ENUM(NSUInteger, LiveInfo_PKType) {
    ///普通模式
    LivePKTypeForNormal         =0,
    ///房间内
    LivePKTypeForRoom           =1,
    ///单人PK
    LivePKTypeForSingle         =2,
    ///激情团战
    LivePKTypeForTeam           =3,
};


///房间内的角色
typedef NS_ENUM(NSUInteger, LiveInfo_roomRole) {
    ///普通无角色
    RoomRoleForNormal           =0,
    ///主播
    RoomRoleForAnchor           =1,
    ///副播
    RoomRoleForBroadcaster      =2,
    ///观众
    RoomRoleForAudience         =3,
};



NS_ASSUME_NONNULL_BEGIN

@interface LiveInfomation : NSObject

/// 前端判断的房间类型
@property (nonatomic, assign) LiveInfo_LiveType liveType;

/// 当前直播间的状态
@property (nonatomic, assign) LiveInfo_CurrentState currentState;

/// 当前直播间的PK类型
@property (nonatomic, assign) LiveInfo_PKType pkType;

/// 直播间内的身份    主播  - 1 / 副播  - 2 /  观众 - 3
@property (nonatomic, assign) LiveInfo_roomRole roomRole;

/// 房间唯一的房主id
@property (nonatomic, assign)int64_t anchorId;

/// 房间唯一的主播用户名
@property (nonatomic, copy)NSString *anchorName;

/// 房间唯一的主播头像
@property (nonatomic, copy)NSString *anchorIcon;

/// 房间唯一的主播贵族等级
@property (nonatomic, copy)NSString *anchorVIPLevel;

/// 房间唯一的主播名称
@property (nonatomic, assign)int64_t roomId;


///是否为最小化
@property (nonatomic, assign)BOOL isMini;

 ///是否关闭麦克风
@property (nonatomic, assign)BOOL offMic;
 ///是否关闭声音
@property (nonatomic, assign)BOOL offAudio;
 ///是否关闭摄像机
@property (nonatomic, assign)BOOL offCamera;



/// 直播间类型1视频直播间2语音直播间
/// 服务器需要的liveType  (需要从roomModel或者o2oModel中提取)
@property (nonatomic, assign) int serviceLiveType;
 ///服务器需要showId  (需要从roomModel或者o2oModel中提取)
@property (nonatomic, copy) NSString *serviceShowId;





/// 直播房间信息
@property (nonatomic, strong) AppJoinRoomVOModel *roomModel;
///一对一直播间信息
@property (nonatomic, strong) OOOReturnModel *o2oModel;
///开播基本信息
@property (nonatomic, strong) OpenAuthDataVOModel *openData;





#pragma mark - 所有视图配置 -

/** 获取O2O视频配置 */
@property (nonatomic, copy) Class<OneLiveInterface> _Nullable oneViewConfig;

/** 获取多人配置 */
@property (nonatomic, copy) Class<MPLiveInterface> _Nullable mpViewConfig;





#pragma mark - 直播间内统一数据 -

///获得语音视图尺寸（在当前屏幕）
- (CGRect)getAudioSeatFrame;







@end

NS_ASSUME_NONNULL_END
