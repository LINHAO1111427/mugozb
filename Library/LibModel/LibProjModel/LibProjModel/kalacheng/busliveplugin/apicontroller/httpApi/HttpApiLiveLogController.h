//此代码由 http://code.siwaha.com/ 生成，服务器修改后可重新生成
#import <Foundation/Foundation.h>

#import <LibProjBase/PageInfo.h>


#import "HttpNoneModel.h"

typedef void (^CallBackLiveLogController_HttpNone)(int code,NSString *strMsg,HttpNoneModel* model);
NS_ASSUME_NONNULL_BEGIN



/**
直播相关的记录
 */
@interface HttpApiLiveLogController: NSObject



/**
 添加房间流程记录
 @param liveType 直播类型 1:视频 2:语音 3:1v1 4:电台 5:派对 6:短视频 7:动态
 @param optDescribe 操作描述
 @param optType 操作类型 1：加入房间 2：更新token 3：离开房间
 @param roomId 房间号
 @param showId 直播标识
 */
+(void) addRoomProcessLog:(int)liveType optDescribe:(NSString *)optDescribe optType:(int)optType roomId:(int64_t)roomId showId:(NSString *)showId  callback:(CallBackLiveLogController_HttpNone)callback;

@end

NS_ASSUME_NONNULL_END
