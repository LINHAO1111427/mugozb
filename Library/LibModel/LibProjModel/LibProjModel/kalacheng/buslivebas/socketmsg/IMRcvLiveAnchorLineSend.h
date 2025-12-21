//此代码由 http://code.siwaha.com/ 生成，服务器修改后可重新生成
#import <Foundation/Foundation.h>

#import <TXImKit/TXImKit.h>
#import "ApiCloseLineModel.h"
#import "ApiSendMsgUserModel.h"
#import "ApiSendLineMsgRoomModel.h"
NS_ASSUME_NONNULL_BEGIN



/**
主播互动发送消息
 */
@interface IMRcvLiveAnchorLineSend: NSObject<IMReceiver>


-(NSString*)getMsgType;

-(void) onMsg:(NSString*)subType content:(NSDictionary*)content;

-(void) onOtherMsg:(NSDictionary*)content;


/**
 主播关闭互动
 @param apiCloseLine null
 */
-(void) onAnchorCloseLine:(ApiCloseLineModel* )apiCloseLine ;


/**
 主播发送连麦请求
 @param apiSendMsgUser null
 */
-(void) onAnchorLineReq:(ApiSendMsgUserModel* )apiSendMsgUser ;


/**
 主播在直播间发送是否同意连麦消息
 @param apiSendLineMsgRoom null
 */
-(void) onAnchorLineResp:(ApiSendLineMsgRoomModel* )apiSendLineMsgRoom ;

@end

NS_ASSUME_NONNULL_END
