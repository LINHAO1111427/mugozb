//此代码由 http://code.siwaha.com/ 生成，服务器修改后可重新生成
#import <Foundation/Foundation.h>

#import <LibProjBase/PageInfo.h>


#import "HttpNoneModel.h"

typedef void (^CallBackRoomPublicController_HttpNone)(int code,NSString *strMsg,HttpNoneModel* model);
NS_ASSUME_NONNULL_BEGIN



/**
房间公共控制（包括一对一）
 */
@interface HttpApiRoomPublicController: NSObject



/**
 发送消息(视频语音一对一)
 @param anchorId 主播id,没有传0
 @param content 消息内容
 @param liveType 直播类型 1:视频 2:语音 3:1v1 4:电台 5:派对 6:短视频 7:动态
 @param roomId 房间id
 @param type 消息类型 0:系统消息(超管) 1:是普通消息 2:弹幕消息
 */
+(void) sendMsgRoom:(int64_t)anchorId content:(NSString *)content liveType:(int)liveType roomId:(int64_t)roomId type:(int)type  callback:(CallBackRoomPublicController_HttpNone)callback;

@end

NS_ASSUME_NONNULL_END
