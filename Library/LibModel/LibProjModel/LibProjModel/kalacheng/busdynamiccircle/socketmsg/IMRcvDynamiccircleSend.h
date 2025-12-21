//此代码由 http://code.siwaha.com/ 生成，服务器修改后可重新生成
#import <Foundation/Foundation.h>

#import <TXImKit/TXImKit.h>
#import "ApiSendVideoUnReadNumberModel.h"
NS_ASSUME_NONNULL_BEGIN



/**
动态消息发送socket
 */
@interface IMRcvDynamiccircleSend: NSObject<IMReceiver>


-(NSString*)getMsgType;

-(void) onMsg:(NSString*)subType content:(NSDictionary*)content;

-(void) onOtherMsg:(NSDictionary*)content;


/**
 动态评论或回复发送消息显示个数
 @param apiSendVideoUnReadNumber null
 */
-(void) onUserVideoCommentCount:(ApiSendVideoUnReadNumberModel* )apiSendVideoUnReadNumber ;

@end

NS_ASSUME_NONNULL_END
