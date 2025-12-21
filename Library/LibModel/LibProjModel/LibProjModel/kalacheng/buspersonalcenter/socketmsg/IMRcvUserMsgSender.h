//此代码由 http://code.siwaha.com/ 生成，服务器修改后可重新生成
#import <Foundation/Foundation.h>

#import <TXImKit/TXImKit.h>
#import "ApiBeautifulNumberModel.h"
NS_ASSUME_NONNULL_BEGIN



/**
用户推送公告内容
 */
@interface IMRcvUserMsgSender: NSObject<IMReceiver>


-(NSString*)getMsgType;

-(void) onMsg:(NSString*)subType content:(NSDictionary*)content;

-(void) onOtherMsg:(NSDictionary*)content;


/**
 赠送靓号推送公告内容
 @param user null
 */
-(void) onUsersBeautifulNumber:(ApiBeautifulNumberModel* )user ;

@end

NS_ASSUME_NONNULL_END
