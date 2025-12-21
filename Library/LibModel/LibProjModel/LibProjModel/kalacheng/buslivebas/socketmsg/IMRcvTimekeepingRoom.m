//此代码由 http://code.siwaha.com/ 生成，服务器修改后可重新生成
#import <Foundation/Foundation.h>

#import <LibTools/NSDictionary+Json.h>
#import "IMRcvTimekeepingRoom.h"


/**
计时房间消息
 */
@implementation IMRcvTimekeepingRoom

-(NSString*) getMsgType
{
    return @"TimekeepingRoom";
}
-(void) onMsg:(NSString*)subType content:(NSDictionary*)content
{
   if([subType isEqualToString:@"insufficientUserBalancePrompt"])
{
        [self insufficientUserBalancePrompt:[content getInt64:@"times"] ];
}else    if([subType isEqualToString:@"remindToRecharge"])
{
        [self remindToRecharge:[content getStr:@"msg"] ];
}
}
-(void) onOtherMsg:(NSDictionary*)content
{
}
/**
 余额不足提示
 @param times 60费用仅够1分钟；180费用仅够3分钟；返回的是180秒倒计时
 */
-(void) insufficientUserBalancePrompt:(int64_t)times {  }
/**
 提醒充值
 @param msg null
 */
-(void) remindToRecharge:(NSString *)msg {  }

@end


