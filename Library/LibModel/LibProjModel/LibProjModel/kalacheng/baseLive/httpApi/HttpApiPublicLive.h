//此代码由 http://code.siwaha.com/ 生成，服务器修改后可重新生成
#import <Foundation/Foundation.h>

#import <LibProjBase/PageInfo.h>


#import "HttpNoneModel.h"

#import "LiveRoomTypeDTOModel.h"

#import "ApiUsersLiveManagerModel.h"

#import "ApiKickModel.h"

#import "AppLiveEffectVOModel.h"

#import "ApiShutUpModel.h"

#import "LiveHomeAdsVOModel.h"

#import "LivePkConfigurationVOModel.h"

#import "ApiUserBasicInfoModel.h"

#import "LiveRoomAdsListVOModel.h"

#import "RanksDtoModel.h"

#import "AppVIPSeatsModel.h"

#import "AppUsersLiveDataVOModel.h"

typedef void (^CallBackPublicLive_HttpNone)(int code,NSString *strMsg,HttpNoneModel* model);
typedef void (^CallBackPublicLive_LiveRoomTypeDTOArr)(int code,NSString *strMsg,NSArray<LiveRoomTypeDTOModel*>* arr);
typedef void (^CallBackPublicLive_ApiUsersLiveManagerArr)(int code,NSString *strMsg,NSArray<ApiUsersLiveManagerModel*>* arr);
typedef void (^CallBackPublicLive_ApiKickArr)(int code,NSString *strMsg,NSArray<ApiKickModel*>* arr);
typedef void (^CallBackPublicLive_AppLiveEffectVOArr)(int code,NSString *strMsg,NSArray<AppLiveEffectVOModel*>* arr);
typedef void (^CallBackPublicLive_ApiShutUpArr)(int code,NSString *strMsg,NSArray<ApiShutUpModel*>* arr);
typedef void (^CallBackPublicLive_LiveHomeAdsVOArr)(int code,NSString *strMsg,NSArray<LiveHomeAdsVOModel*>* arr);
typedef void (^CallBackPublicLive_LivePkConfigurationVOArr)(int code,NSString *strMsg,NSArray<LivePkConfigurationVOModel*>* arr);
typedef void (^CallBackPublicLive_ApiUserBasicInfoArr)(int code,NSString *strMsg,NSArray<ApiUserBasicInfoModel*>* arr);
typedef void (^CallBackPublicLive_LiveRoomAdsListVO)(int code,NSString *strMsg,LiveRoomAdsListVOModel* model);
typedef void (^CallBackPublicLive_RanksDto)(int code,NSString *strMsg,RanksDtoModel* model);
typedef void (^CallBackPublicLive_AppVIPSeats)(int code,NSString *strMsg,AppVIPSeatsModel* model);
typedef void (^CallBackPublicLive_AppUsersLiveDataVOArr)(int code,NSString *strMsg,NSArray<AppUsersLiveDataVOModel*>* arr);
NS_ASSUME_NONNULL_BEGIN



/**
用户直播api
 */
@interface HttpApiPublicLive: NSObject



/**
 http方式修改房间模式
 @param roomId 房间id
 @param roomType 直播类型 0:一般直播 1:私密直播 2:收费直播 3:计时直播 4:贵族房间
 @param roomTypeVal 类型值
 */
+(void) updateLiveType:(int64_t)roomId roomType:(int)roomType roomTypeVal:(NSString *)roomTypeVal  callback:(CallBackPublicLive_HttpNone)callback;


/**
 获取房间模式
 @param liveType 直播类型  1:直播 2:语音 3:1v1 4:电台 5:派对 6:短视频 7:动态
 @param showId 直播标识(直播间内传,其他位置传-1)
 */
+(void) getLiveRoomType:(int)liveType showId:(NSString *)showId  callback:(CallBackPublicLive_LiveRoomTypeDTOArr)callback;


/**
 http方式修改房间标题
 @param liveType 直播类型 1:直播 2:语音 3:1v1 4:电台 5:派对 6:短视频 7:动态 
 @param roomId 房间id
 @param roomTitle 房间标题
 */
+(void) updateLiveTitle:(int)liveType roomId:(int64_t)roomId roomTitle:(NSString *)roomTitle  callback:(CallBackPublicLive_HttpNone)callback;


/**
 获取直播间管理员列表
 @param anchorId 主播用户id
 @param liveType 直播类型 1:视频 2:语音 3:1v1 4:电台 5:派对 6:短视频 7:动态
 */
+(void) getLiveManagerList:(int64_t)anchorId liveType:(int)liveType  callback:(CallBackPublicLive_ApiUsersLiveManagerArr)callback;


/**
 直播间踢人操作
 @param liveType 直播类型 1:视频 2:语音 3:1v1 4:电台 5:派对 6:短视频 7:动态
 @param roomId 房间号
 @param touid 被禁言人id
 */
+(void) addKick:(int)liveType roomId:(int64_t)roomId touid:(int64_t)touid  callback:(CallBackPublicLive_HttpNone)callback;


/**
 查看直播间公告
 @param anchorId 主播ID
 @param liveType 直播类型 1:视频 2:语音 3:1v1 4:电台 5:派对 6:短视频 7:动态
 */
+(void) getLiveNotice:(int64_t)anchorId liveType:(int)liveType  callback:(CallBackPublicLive_HttpNone)callback;


/**
 视频语音,门票/计时发起扣费
 @param anchorId 主播id 
 @param liveType 直播类型 1:直播 2:语音 3:1v1 4:电台 5:派对 6:短视频 7:动态 
 @param roomId 房间号
 @param roomType 房间模式(暂时弃用,使用主播的) 0:普通房间 1:私密房间 2:收费房间 3:计时房间 4:贵族房间
 @param roomTypeVal 类型值
 @param showId 直播标识 
 */
+(void) startDeduction:(int64_t)anchorId liveType:(int)liveType roomId:(int64_t)roomId roomType:(int)roomType roomTypeVal:(NSString *)roomTypeVal showId:(NSString *)showId  callback:(CallBackPublicLive_HttpNone)callback;


/**
 取消管理员
 @param liveType 直播类型 1:视频 2:语音 3:1v1 4:电台 5:派对 6:短视频 7:动态
 @param touid 对方用户id
 */
+(void) cancelLivemanager:(int)liveType touid:(int64_t)touid  callback:(CallBackPublicLive_HttpNone)callback;


/**
 直播间踢人列表
 @param liveType 直播类型 1:视频 2:语音 3:1v1 4:电台 5:派对 6:短视频 7:动态
 @param roomId 房间号
 */
+(void) getKickList:(int)liveType roomId:(int64_t)roomId  callback:(CallBackPublicLive_ApiKickArr)callback;


/**
 获取直播音效包
 */
+(void) getAppLiveEffectAll:(CallBackPublicLive_AppLiveEffectVOArr)callback;


/**
 主播离开房间(不是关闭直播)
 @param liveType 直播类型 1:直播 2:语音 3:1v1 4:电台 5:派对 6:短视频 7:动态 
 @param roomId 房间id
 */
+(void) leaveRoomTemporarily:(int)liveType roomId:(int64_t)roomId  callback:(CallBackPublicLive_HttpNone)callback;


/**
 清空房间火力值
 @param liveType 直播类型 1:直播 2:语音 3:1v1 4:电台 5:派对 6:短视频 7:动态 
 @param roomId 房间id
 */
+(void) clearRoomVotes:(int)liveType roomId:(int64_t)roomId  callback:(CallBackPublicLive_HttpNone)callback;


/**
 添加管理员
 @param liveType 直播类型 1:视频 2:语音 3:1v1 4:电台 5:派对 6:短视频 7:动态
 @param userId 用户id
 */
+(void) addLivemanager:(int)liveType userId:(int64_t)userId  callback:(CallBackPublicLive_HttpNone)callback;


/**
 直播间禁言列表
 @param liveType 直播间类型 1:视频直播间 2:语音直播间
 @param roomId 房间号
 */
+(void) shutupList:(int)liveType roomId:(int64_t)roomId  callback:(CallBackPublicLive_ApiShutUpArr)callback;


/**
 获取首页图标广告列表
 @param adsType 首页广告类型 1：图片广告 2:文字广告
 */
+(void) getLiveHomeAdsList:(int)adsType  callback:(CallBackPublicLive_LiveHomeAdsVOArr)callback;


/**
 查询pk时长配置
 @param liveType 直播类型 1:直播 2:语音 3:1v1 4:电台 5:派对 6:短视频 7:动态
 */
+(void) getLivePkConfiguration:(int)liveType  callback:(CallBackPublicLive_LivePkConfigurationVOArr)callback;


/**
 http方式给房间上锁/解锁
 @param liveLockStatus 房间锁的状态 1:上锁了 0:未上锁
 @param liveType 直播类型 1:直播 2:语音 3:1v1 4:电台 5:派对 6:短视频 7:动态 
 @param roomId 房间id
 */
+(void) liveRoomLock:(int)liveLockStatus liveType:(int)liveType roomId:(int64_t)roomId  callback:(CallBackPublicLive_HttpNone)callback;


/**
 http查看贵宾席列表
 @param anchorId 主播id
 @param liveType 直播类型 1:视频 2:语音 3:1v1 4:电台 5:派对 6:短视频 7:动态
 @param roomId 房间号
 */
+(void) userVIPSeatsList:(int64_t)anchorId liveType:(int)liveType roomId:(int64_t)roomId  callback:(CallBackPublicLive_ApiUserBasicInfoArr)callback;


/**
 获取直播间广告集合
 @param roomId 房间号
 */
+(void) getLiveRoomAdsList:(int64_t)roomId  callback:(CallBackPublicLive_LiveRoomAdsListVO)callback;


/**
 直播间禁言/取消禁言操作
 @param anchorId 主播id
 @param liveType 直播类型 1:视频 2:语音 3:1v1 4:电台 5:派对 6:短视频 7:动态
 @param roomId 房间号
 @param touid 被禁言人id
 */
+(void) addShutup:(int64_t)anchorId liveType:(int)liveType roomId:(int64_t)roomId touid:(int64_t)touid  callback:(CallBackPublicLive_HttpNone)callback;


/**
 移除踢人列表用户
 @param liveType 直播类型 1:视频 2:语音 3:1v1 4:电台 5:派对 6:短视频 7:动态
 @param roomId 房间号
 @param touid 被踢人id
 */
+(void) delKick:(int)liveType roomId:(int64_t)roomId touid:(int64_t)touid  callback:(CallBackPublicLive_HttpNone)callback;


/**
 观众席当前用户所在排行
 @param roomId 房间号
 @param userId 当前用户id
 */
+(void) getLiveUserRank:(int64_t)roomId userId:(int64_t)userId  callback:(CallBackPublicLive_RanksDto)callback;


/**
 修改直播间公告
 @param anchorId 主播ID
 @param content 公告内容
 @param liveType 直播类型 1:视频 2:语音 3:1v1 4:电台 5:派对 6:短视频 7:动态
 @param roomId 房间号
 */
+(void) updateLiveNotice:(int64_t)anchorId content:(NSString *)content liveType:(int)liveType roomId:(int64_t)roomId  callback:(CallBackPublicLive_HttpNone)callback;


/**
 http购买贵宾席
 @param anchorId 主播id
 @param coin 金币 
 @param liveType 直播类型 1:视频 2:语音 3:1v1 4:电台 5:派对 6:短视频 7:动态
 @param roomId 房间号 
 */
+(void) purchaseVIPSeats:(int64_t)anchorId coin:(double)coin liveType:(int)liveType roomId:(int64_t)roomId  callback:(CallBackPublicLive_AppVIPSeats)callback;


/**
 http方式获取加入房间数据
 @param liveType 直播类型 1:视频 2:语音 3:1v1 4:电台 5:派对 6:短视频 7:动态
 @param roomId 房间id
 */
+(void) joinRoomData:(int)liveType roomId:(int64_t)roomId  callback:(CallBackPublicLive_HttpNone)callback;


/**
 获取直播间观众列表
 @param roomId 房间号
 */
+(void) getLiveUser:(int64_t)roomId  callback:(CallBackPublicLive_ApiUserBasicInfoArr)callback;


/**
 获取主播的直播记录
 @param beforeDay 天数(如最近3天传3,5天传5即可,-1查所有)
 @param page 当前页
 @param pageSize 每页的条数
 */
+(void) getLiveData:(int)beforeDay page:(int)page pageSize:(int)pageSize  callback:(CallBackPublicLive_AppUsersLiveDataVOArr)callback;

@end

NS_ASSUME_NONNULL_END
