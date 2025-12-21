//此代码由 http://code.siwaha.com/ 生成，服务器修改后可重新生成
#import <Foundation/Foundation.h>

#import <LibTools/NSDictionary+Json.h>
#import "IMRcvCommonMsgSend.h"


/**
公共msg socket消息Send
 */
@implementation IMRcvCommonMsgSend

-(NSString*) getMsgType
{
    return @"CommonMsgSend";
}
-(void) onMsg:(NSString*)subType content:(NSDictionary*)content
{
   if([subType isEqualToString:@"onUserLoginRewards"])
{
        [self onUserLoginRewards:[content getInt:@"oneFlag"] ];
}else    if([subType isEqualToString:@"onUserSimpleInfo"])
{
        [self onUserSimpleInfo:[UserSimpleInfoModel getFromDict:content[@"userSimpleInfo"]] ];
}else    if([subType isEqualToString:@"onUserGetNoReadAll"])
{
        [self onUserGetNoReadAll:[content getInt64:@"count"] ];
}else    if([subType isEqualToString:@"onAdminSendText"])
{
        [self onAdminSendText:[AdminSendTextVOModel getFromDict:content[@"adminSendTextVO"]] ];
}
}
-(void) onOtherMsg:(NSDictionary*)content
{
}
/**
 通知用户领取连续登录奖励
 @param oneFlag null
 */
-(void) onUserLoginRewards:(int)oneFlag {  }
/**
 用户贵族/svip 信息
 @param userSimpleInfo null
 */
-(void) onUserSimpleInfo:(UserSimpleInfoModel* )userSimpleInfo {  }
/**
 总未读数
 @param count 总未读数
 */
-(void) onUserGetNoReadAll:(int64_t)count {  }
/**
 管理后台向用户发送文本消息
 @param adminSendTextVO null
 */
-(void) onAdminSendText:(AdminSendTextVOModel* )adminSendTextVO {  }

@end


