//此代码由 http://code.siwaha.com/ 生成，服务器修改后可重新生成
#import <Foundation/Foundation.h>

#import <LibTools/NSDictionary+Json.h>
#import "IMRcvLiveWishSend.h"


/**
心愿单 socket
 */
@implementation IMRcvLiveWishSend

-(NSString*) getMsgType
{
    return @"LiveWishSend";
}
-(void) onMsg:(NSString*)subType content:(NSDictionary*)content
{
   if([subType isEqualToString:@"onSendWish"])
{
        [self onSendWish:[ApiUsersLiveWishModel getFromArr:content[@"awList"]] ];
}else    if([subType isEqualToString:@"onSendWishUser"])
{
        [self onSendWishUser:[ApiUsersLiveWishModel getFromArr:content[@"awList"]] ];
}else    if([subType isEqualToString:@"onUserAddWishMsg"])
{
        [self onUserAddWishMsg:[ApiUsersLiveWishModel getFromArr:content[@"list"]] ];
}else    if([subType isEqualToString:@"onUserAddWishMsgUser"])
{
        [self onUserAddWishMsgUser:[ApiUsersLiveWishModel getFromArr:content[@"list"]] ];
}
}
-(void) onOtherMsg:(NSDictionary*)content
{
}
/**
 心愿单设置成功推给房间
 @param awList null
 */
-(void) onSendWish:(NSMutableArray<ApiUsersLiveWishModel*>* )awList {  }
/**
 心愿单设置成功推给用户
 @param awList null
 */
-(void) onSendWishUser:(NSMutableArray<ApiUsersLiveWishModel*>* )awList {  }
/**
 主播收到心愿单礼物后推送给直播间
 @param list null
 */
-(void) onUserAddWishMsg:(NSMutableArray<ApiUsersLiveWishModel*>* )list {  }
/**
 主播收到心愿单礼物后推送给直播间(用户)
 @param list null
 */
-(void) onUserAddWishMsgUser:(NSMutableArray<ApiUsersLiveWishModel*>* )list {  }

@end


