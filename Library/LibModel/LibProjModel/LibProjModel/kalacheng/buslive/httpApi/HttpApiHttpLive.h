//此代码由 http://code.siwaha.com/ 生成，服务器修改后可重新生成
#import <Foundation/Foundation.h>

#import <LibProjBase/PageInfo.h>


#import "ApiLeaveRoomModel.h"

#import "ApiUsableAnchorRespModel.h"

#import "ApiCloseLiveModel.h"

#import "AppJoinRoomVOModel.h"

#import "HttpLive_openLive.h"
#import "HttpNoneModel.h"

typedef void (^CallBackHttpLive_ApiLeaveRoom)(int code,NSString *strMsg,ApiLeaveRoomModel* model);
typedef void (^CallBackHttpLive_ApiUsableAnchorRespArr)(int code,NSString *strMsg,NSArray<ApiUsableAnchorRespModel*>* arr);
typedef void (^CallBackHttpLive_ApiCloseLive)(int code,NSString *strMsg,ApiCloseLiveModel* model);
typedef void (^CallBackHttpLive_AppJoinRoomVO)(int code,NSString *strMsg,AppJoinRoomVOModel* model);
typedef void (^CallBackHttpLive_HttpNone)(int code,NSString *strMsg,HttpNoneModel* model);
NS_ASSUME_NONNULL_BEGIN



/**
视频直播间相关创建房间及加入房间接口
 */
@interface HttpApiHttpLive: NSObject



/**
 http方式离开房间
 @param roomId 房间id
 */
+(void) leaveRoomOpt:(int64_t)roomId  callback:(CallBackHttpLive_ApiLeaveRoom)callback;


/**
 主播在直播间点击PK选择可连麦的主播前端需要取的字段头像,性别,名称,等级,id
 @param keyWord 搜索主播id/名称
 */
+(void) getUsableAnchor:(NSString *)keyWord  callback:(CallBackHttpLive_ApiUsableAnchorRespArr)callback;


/**
 http方式关播
 @param roomId 房间id
 */
+(void) closeLive:(int64_t)roomId  callback:(CallBackHttpLive_ApiCloseLive)callback;


/**
 http方式加入房间
 @param roomId 房间id
 @param roomType 房间类型 0:是一般直播 1:是私密直播 2:是收费直播 3:是计时直播 4:贵族房间
 @param roomTypeVal 房间类型对应的值
 */
+(void) joinRoom:(int64_t)roomId roomType:(int)roomType roomTypeVal:(NSString *)roomTypeVal  callback:(CallBackHttpLive_AppJoinRoomVO)callback;




/**
 http方式创建房间code为3时请先认证
 @param address 开播地址
 @param channelId 频道id
 @param city 市
 @param lat 经度
 @param liveFunction 是否有直播购 0:没有直播购 1:有直播购
 @param lng 纬度
 @param province 省
 @param pull 播流地址
 @param roomType 房间类型 0:是一般直播 1:是私密直播 2:是收费直播 3:是计时直播 4:贵族房间
 @param roomTypeVal 房间类型对应的值
 @param shopRoomLabel 直播购房间标签
 @param title 开播标题
 */
+(void) openLive:(HttpLive_openLive*)_mdl callback:(CallBackHttpLive_AppJoinRoomVO)callback;
/**
 http方式创建房间code为3时请先认证
 @param address 开播地址
 @param channelId 频道id
 @param city 市
 @param lat 经度
 @param liveFunction 是否有直播购 0:没有直播购 1:有直播购
 @param lng 纬度
 @param province 省
 @param pull 播流地址
 @param roomType 房间类型 0:是一般直播 1:是私密直播 2:是收费直播 3:是计时直播 4:贵族房间
 @param roomTypeVal 房间类型对应的值
 @param shopRoomLabel 直播购房间标签
 @param title 开播标题
 */
+(void) openLive:(NSString *)address channelId:(int)channelId city:(NSString *)city lat:(double)lat liveFunction:(int)liveFunction lng:(double)lng province:(NSString *)province pull:(NSString *)pull roomType:(int)roomType roomTypeVal:(NSString *)roomTypeVal shopRoomLabel:(NSString *)shopRoomLabel title:(NSString *)title  callback:(CallBackHttpLive_AppJoinRoomVO)callback;


/**
 设置直播横幅
 @param roomId 房间号
 @param shopLiveBanner 横幅地址
 */
+(void) setShopLiveBanner:(int64_t)roomId shopLiveBanner:(NSString *)shopLiveBanner  callback:(CallBackHttpLive_HttpNone)callback;


/**
 app合流
 @param appOptType app操作类型 1：合流成功 2：合流失败 3：合流回调成功 4：合流回调失败 5：退出合流
 @param otherDescription 其他描述
 @param otherRoomId 对方房间号
 @param otherUserId 对方用户id
 @param roomId 操作方房间号
 */
+(void) appLiveLog:(int)appOptType otherDescription:(NSString *)otherDescription otherRoomId:(int64_t)otherRoomId otherUserId:(int64_t)otherUserId roomId:(int64_t)roomId  callback:(CallBackHttpLive_HttpNone)callback;

@end

NS_ASSUME_NONNULL_END
