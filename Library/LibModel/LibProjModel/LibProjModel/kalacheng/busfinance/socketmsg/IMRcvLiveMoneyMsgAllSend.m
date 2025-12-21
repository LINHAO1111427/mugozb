//此代码由 http://code.siwaha.com/ 生成，服务器修改后可重新生成
#import <Foundation/Foundation.h>

#import <LibTools/NSDictionary+Json.h>
#import "IMRcvLiveMoneyMsgAllSend.h"


/**
发送消息给所有人
 */
@implementation IMRcvLiveMoneyMsgAllSend

-(NSString*) getMsgType
{
    return @"LiveMoneyMsgAllSend";
}
-(void) onMsg:(NSString*)subType content:(NSDictionary*)content
{
   if([subType isEqualToString:@"onUserRechargeCallbackMsg"])
{
        [self onUserRechargeCallbackMsg:[content getDouble:@"coin"] user:[ApiUserInfoModel getFromDict:content[@"user"]] ];
}else    if([subType isEqualToString:@"onElasticFrameMember"])
{
        [self onElasticFrameMember:[ApiElasticFrameModel getFromDict:content[@"elasticFrame"]] ];
}
}
-(void) onOtherMsg:(NSDictionary*)content
{
}
/**
 充值金币成功后通知前端
 @param coin 充值的金币数
 @param user null
 */
-(void) onUserRechargeCallbackMsg:(double)coin user:(ApiUserInfoModel* )user {  }
/**
 开通会员提示飘窗
 @param elasticFrame null
 */
-(void) onElasticFrameMember:(ApiElasticFrameModel* )elasticFrame {  }

@end


