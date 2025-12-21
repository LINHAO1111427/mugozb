//此代码由 http://code.siwaha.com/ 生成，服务器修改后可重新生成
#import <Foundation/Foundation.h>

#import <TXImKit/TXImKit.h>
#import "ApiPkResultModel.h"
#import "ApiSendMsgUserModel.h"
#import "ApiSendPKMsgRoomModel.h"
#import "ApiPkResultRoomModel.h"
NS_ASSUME_NONNULL_BEGIN



/**
主播PK发送消息
 */
@interface IMRcvLiveAnchorPkSend: NSObject<IMReceiver>


-(NSString*)getMsgType;

-(void) onMsg:(NSString*)subType content:(NSDictionary*)content;

-(void) onOtherMsg:(NSDictionary*)content;


/**
 赠送礼物后血条信息
 @param apiPKResult null
 */
-(void) onGiftPKResult:(ApiPkResultModel* )apiPKResult ;


/**
 主播发送PK请求
 @param apiSendMsgUser null
 */
-(void) onAnchorPKReq:(ApiSendMsgUserModel* )apiSendMsgUser ;


/**
 主播在直播间发送是否同意PK请求
 @param ApiSendPKMsgRoom null
 */
-(void) onAnchorPKResp:(ApiSendPKMsgRoomModel* )ApiSendPKMsgRoom ;


/**
 PK结果响应
 @param apiPkResultRoom null
 */
-(void) onPKResultResp:(ApiPkResultRoomModel* )apiPkResultRoom ;

@end

NS_ASSUME_NONNULL_END
