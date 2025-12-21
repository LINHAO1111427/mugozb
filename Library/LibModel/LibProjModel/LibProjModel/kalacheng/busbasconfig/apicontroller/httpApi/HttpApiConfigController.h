//此代码由 http://code.siwaha.com/ 生成，服务器修改后可重新生成
#import <Foundation/Foundation.h>

#import <LibProjBase/PageInfo.h>


#import "LiveRtcTokenModel.h"

typedef void (^CallBackConfigController_LiveRtcToken)(int code,NSString *strMsg,LiveRtcTokenModel* model);
typedef void (^CallBackpushaction)(int code,NSString *strMsg,NSDictionary* responDic);

NS_ASSUME_NONNULL_BEGIN



/**
配置相关
 */
@interface HttpApiConfigController: NSObject



/**
 获取互动直播Token，code=333表示欠费
 @param channelName channelName
 @param uid uid
 */
+(void) getRtcToken:(NSString *)channelName uid:(int64_t)uid  callback:(CallBackConfigController_LiveRtcToken)callback;

+(void) sendpushUrl:(NSString *)pushUrl uid:(int64_t)uid roomId:(NSString *)roomId callback:(CallBackpushaction)callback;
@end

NS_ASSUME_NONNULL_END
