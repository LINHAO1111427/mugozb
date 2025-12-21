//此代码由 http://code.siwaha.com/ 生成，服务器修改后可重新生成
#import <Foundation/Foundation.h>

#import <TXImKit/TXImKit.h>
#import "ApiUserInfoModel.h"
NS_ASSUME_NONNULL_BEGIN



/**
主播相关的socket
 */
@interface IMRcvAnchorMsgSender: NSObject<IMReceiver>


-(NSString*)getMsgType;

-(void) onMsg:(NSString*)subType content:(NSDictionary*)content;

-(void) onOtherMsg:(NSDictionary*)content;


/**
 主播认证成功推送socket
 @param user null
 */
-(void) onAnchorAuthUser:(ApiUserInfoModel* )user ;

@end

NS_ASSUME_NONNULL_END
