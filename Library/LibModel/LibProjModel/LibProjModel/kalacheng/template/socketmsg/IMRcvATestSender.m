//此代码由 http://code.siwaha.com/ 生成，服务器修改后可重新生成
#import <Foundation/Foundation.h>

#import <LibTools/NSDictionary+Json.h>
#import "IMRcvATestSender.h"


/**
用于测试的SOCKET
 */
@implementation IMRcvATestSender

-(NSString*) getMsgType
{
    return @"aTestSender";
}
-(void) onMsg:(NSString*)subType content:(NSDictionary*)content
{
   if([subType isEqualToString:@"onGroupMsg"])
{
        [self onGroupMsg:[aTestModleModel getFromDict:content[@"mdl"]] ];
}else    if([subType isEqualToString:@"onRoomMsg"])
{
        [self onRoomMsg:[aTestModleModel getFromDict:content[@"mdl"]] ];
}else    if([subType isEqualToString:@"onAllMsg"])
{
        [self onAllMsg:[aTestModleModel getFromDict:content[@"mdl"]] ];
}else    if([subType isEqualToString:@"onMyMsg"])
{
        [self onMyMsg:[aTestModleModel getFromDict:content[@"mdl"]] ];
}
}
-(void) onOtherMsg:(NSDictionary*)content
{
}
/**
 
 @param mdl null
 */
-(void) onGroupMsg:(aTestModleModel* )mdl {  }
/**
 
 @param mdl null
 */
-(void) onRoomMsg:(aTestModleModel* )mdl {  }
/**
 
 @param mdl null
 */
-(void) onAllMsg:(aTestModleModel* )mdl {  }
/**
 
 @param mdl null
 */
-(void) onMyMsg:(aTestModleModel* )mdl {  }

@end


