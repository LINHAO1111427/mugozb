//此代码由 http://code.siwaha.com/ 生成，服务器修改后可重新生成
#import <Foundation/Foundation.h>

#import <LibProjBase/PageInfo.h>


#import "HttpNoneModel.h"

typedef void (^CallBackMonitoringController_HttpNone)(int code,NSString *strMsg,HttpNoneModel* model);
NS_ASSUME_NONNULL_BEGIN



/**
用户鉴黄
 */
@interface HttpApiMonitoringController: NSObject



/**
 图片鉴黄
 @param imageUrls 图片地址(多张逗号隔开)
 @param monitoringType 1:视频 2:语音 3:1v1 4:电台 5:派对 6:短视频 7:动态 10:头像
 @param roomId 房间号
 @param showId 直播标识
 */
+(void) imageMonitoring:(NSString *)imageUrls monitoringType:(int)monitoringType roomId:(int64_t)roomId showId:(NSString *)showId  callback:(CallBackMonitoringController_HttpNone)callback;

@end

NS_ASSUME_NONNULL_END
