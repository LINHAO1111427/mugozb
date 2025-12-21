//
//  CheckRoomPermissions.h
//  TCDemo
//
//  Created by admin on 2019/10/28.
//  Copyright © 2019 CH. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <LibProjModel/AppJoinRoomVOModel.h>
#import <LibProjView/LiveRoomListReqParam.h>

@class AppHomeHallDTOModel;

NS_ASSUME_NONNULL_BEGIN

///与后台的liveType类型保持一致 1:直播 2:语音 3:1v1 4:电台 5:派对 6:短视频 7:动态
typedef NS_ENUM(int, CheckLiveDataType) {
    ///无
    LiveTypeForNone            =0,
    ///多人直播（+直播购）
    LiveTypeForMPVideo         =1,
    ///语音
    LiveTypeForMPAudio         =2,
    ///1v1用户信息
    LiveTypeForPersonCenter    =3,
    ///电台
    LiveTypeFoRadio            =4,
    ///派对
    LiveTypeForParty           =5,
    ///短视频
    LiveTypeForShortVideo      =6,
    ///动态
    LiveTypeForDynamic         =7,
};

///加入房间失败的原因 ---- 没有细分，其他失败原因暂没用上
typedef NS_ENUM(int, JoinRoomFailType) {
    ///其他错误
    JoinRoomFailTypeForOther            =0,
    ///贵族
    JoinRoomFailTypeForVIP              =1,
};

@interface CheckRoomPermissions : NSObject

///是否控制发通知（一次）
@property (nonatomic, assign)BOOL noNotifyForOnceAtChangeRoom;


+ (instancetype)share;


- (void)joinRoom:(int64_t)roomId liveDataType:(CheckLiveDataType)liveDataType joinRoom:(void(^_Nullable)(AppJoinRoomVOModel *joinModel))joinRoom closeRoom:(void(^_Nullable)(AppHomeHallDTOModel *dtoModel))closeRoom fail:(void(^_Nullable)(JoinRoomFailType failType))fail;


///显示除直播间外其他数据详情
- (void)showDetail:(AppHomeHallDTOModel *)dtoModel currentVC:(UIViewController *)currentVC;



///加入直播间
- (void)joinRoomForModel:(AppJoinRoomVOModel *)voModel currentVC:(UIViewController *)currentVC otherInfo:(LiveRoomListReqParam *_Nullable)otherInfo;


///加入自己开的房间
///liveType类型 1:直播 2:语音 3:1v1 4:电台 5:派对 6:短视频 7:动态
- (void)joinOwnRoom:(int64_t)roomId liveType:(int)liveType;


@end

NS_ASSUME_NONNULL_END
