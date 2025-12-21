//此代码由 http://code.siwaha.com/ 生成，服务器修改后可重新生成
#import <Foundation/Foundation.h>

#import <TXImKit/TXImKit.h>
#import "ApiSimpleMsgRoomModel.h"
#import "ApiGiftSenderModel.h"
NS_ASSUME_NONNULL_BEGIN



/**
赠送礼物发送消息
 */
@interface IMRcvLiveGiftSend: NSObject<IMReceiver>


-(NSString*)getMsgType;

-(void) onMsg:(NSString*)subType content:(NSDictionary*)content;

-(void) onOtherMsg:(NSDictionary*)content;


/**
 简单消息
 @param apiSimpleMsgRoom null
 */
-(void) onSimpleGiftMsgRoom:(ApiSimpleMsgRoomModel* )apiSimpleMsgRoom ;


/**
 全直播间飘屏信息
 @param apiGiftSender null
 */
-(void) onGiftMsgAll:(ApiGiftSenderModel* )apiGiftSender ;


/**
 赠送礼物后给用户发送消息
 @param apiGiftSender null
 */
-(void) onGiveGiftUser:(ApiGiftSenderModel* )apiGiftSender ;


/**
 群聊送礼物发送socket
 @param apiGiftSender null
 */
-(void) onGroupGiveGift:(ApiGiftSenderModel* )apiGiftSender ;


/**
 赠送礼物后给房间发送消息
 @param apiGiftSender null
 */
-(void) onGiveGift:(ApiGiftSenderModel* )apiGiftSender ;

@end

NS_ASSUME_NONNULL_END
