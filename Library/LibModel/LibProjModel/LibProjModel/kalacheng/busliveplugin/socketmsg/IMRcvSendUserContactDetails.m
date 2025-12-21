//此代码由 http://code.siwaha.com/ 生成，服务器修改后可重新生成
#import <Foundation/Foundation.h>

#import <LibTools/NSDictionary+Json.h>
#import "IMRcvSendUserContactDetails.h"


/**
直播间发送联系方式（和一对一无关）
 */
@implementation IMRcvSendUserContactDetails

-(NSString*) getMsgType
{
    return @"SendUserContactDetails";
}
-(void) onMsg:(NSString*)subType content:(NSDictionary*)content
{
   if([subType isEqualToString:@"onSendUsreContactDetails"])
{
        [self onSendUsreContactDetails:[content getInt:@"sendContactType"] contactDetails:[content getStr:@"contactDetails"] ];
}
}
-(void) onOtherMsg:(NSDictionary*)content
{
}
/**
 发送联系方式
 @param sendContactType 1：qq 2：微信 3：手机号
 @param contactDetails 对应类型的联系方式
 */
-(void) onSendUsreContactDetails:(int)sendContactType contactDetails:(NSString *)contactDetails {  }

@end


