//此代码由 http://code.siwaha.com/ 生成，服务器修改后可重新生成
#import <Foundation/Foundation.h>

@class IMSocketIns;
@class ApiLightSenderModel;

typedef void (^CallBack_LiveGift_ApiLightSender)(int code,NSString *errMsg,ApiLightSenderModel* model);
NS_ASSUME_NONNULL_BEGIN



/**
直播间送礼物socket
 */
@interface IMApiLiveGift: NSObject


@property (nonatomic, strong)IMSocketIns*  socket;
-(instancetype) init:(IMSocketIns*)socket;

/**
 sendLight
 @param anchorId 主播id
 @param type 类型 1:视频直播 2:语音直播
 */
-(void) sendLight:(int)anchorId type:(int)type  callback:(CallBack_LiveGift_ApiLightSender)callback;

@end

NS_ASSUME_NONNULL_END
