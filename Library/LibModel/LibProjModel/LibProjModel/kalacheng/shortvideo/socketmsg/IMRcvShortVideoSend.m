//此代码由 http://code.siwaha.com/ 生成，服务器修改后可重新生成
#import <Foundation/Foundation.h>

#import <LibTools/NSDictionary+Json.h>
#import "IMRcvShortVideoSend.h"


/**
短视频相关的socket发送
 */
@implementation IMRcvShortVideoSend

-(NSString*) getMsgType
{
    return @"ShortVideoSend";
}
-(void) onMsg:(NSString*)subType content:(NSDictionary*)content
{
   if([subType isEqualToString:@"onUserShortVideoCommentCount"])
{
        [self onUserShortVideoCommentCount:[ApiSendVideoUnReadNumberModel getFromDict:content[@"apiSendVideoUnReadNumber"]] ];
}
}
-(void) onOtherMsg:(NSDictionary*)content
{
}
/**
 短视频评论或回复发送消息显示个数
 @param apiSendVideoUnReadNumber null
 */
-(void) onUserShortVideoCommentCount:(ApiSendVideoUnReadNumberModel* )apiSendVideoUnReadNumber {  }

@end


