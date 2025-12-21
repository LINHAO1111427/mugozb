//此代码由 http://code.siwaha.com/ 生成，服务器修改后可重新生成
#import <Foundation/Foundation.h>

#import <TXImKit/TXImKit.h>
#import "ApiAnchorLineStatusModel.h"
#import "ApiSendMsgUserModel.h"
#import "ApiCloseLineModel.h"
#import "ApiUserLineRoomModel.h"
NS_ASSUME_NONNULL_BEGIN



/**
用户连麦发送消息
 */
@interface IMRcvLiveUserLineSend: NSObject<IMReceiver>


-(NSString*)getMsgType;

-(void) onMsg:(NSString*)subType content:(NSDictionary*)content;

-(void) onOtherMsg:(NSDictionary*)content;


/**
 设置连麦状态,1:开启连麦,2:关闭连麦
 @param apiAnchorLineStatus null
 */
-(void) onSetAnchorLineStatus:(ApiAnchorLineStatusModel* )apiAnchorLineStatus ;


/**
 用户发送连麦请求
 @param apiSendMsgUser null
 */
-(void) onUserLineReq:(ApiSendMsgUserModel* )apiSendMsgUser ;


/**
 用户/主播关闭连麦
 @param apiCloseLine null
 */
-(void) onUserCloseLine:(ApiCloseLineModel* )apiCloseLine ;


/**
 主播同意用户连麦,给房间发消息
 @param apiUserLineRoom null
 */
-(void) onUserLineResp:(ApiUserLineRoomModel* )apiUserLineRoom ;

@end

NS_ASSUME_NONNULL_END
