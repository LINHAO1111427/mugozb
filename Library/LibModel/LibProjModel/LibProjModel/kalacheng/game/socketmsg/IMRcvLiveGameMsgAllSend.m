//此代码由 http://code.siwaha.com/ 生成，服务器修改后可重新生成
#import <Foundation/Foundation.h>

#import <LibTools/NSDictionary+Json.h>
#import "IMRcvLiveGameMsgAllSend.h"


/**
发送游戏消息给所有人
 */
@implementation IMRcvLiveGameMsgAllSend

-(NSString*) getMsgType
{
    return @"LiveGameMsgAllSend";
}
-(void) onMsg:(NSString*)subType content:(NSDictionary*)content
{
   if([subType isEqualToString:@"onUserWinAPrize"])
{
        [self onUserWinAPrize:[GameUserWinAwardsDTOModel getFromDict:content[@"gameUserWinAwardsDTO"]] ];
}
}
-(void) onOtherMsg:(NSDictionary*)content
{
}
/**
 中奖之后发送socket信息
 @param gameUserWinAwardsDTO null
 */
-(void) onUserWinAPrize:(GameUserWinAwardsDTOModel* )gameUserWinAwardsDTO {  }

@end


