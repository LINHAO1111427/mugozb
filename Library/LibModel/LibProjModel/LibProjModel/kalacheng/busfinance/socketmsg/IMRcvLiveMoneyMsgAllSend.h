//此代码由 http://code.siwaha.com/ 生成，服务器修改后可重新生成
#import <Foundation/Foundation.h>

#import <TXImKit/TXImKit.h>
#import "ApiUserInfoModel.h"
#import "ApiElasticFrameModel.h"
NS_ASSUME_NONNULL_BEGIN



/**
发送消息给所有人
 */
@interface IMRcvLiveMoneyMsgAllSend: NSObject<IMReceiver>


-(NSString*)getMsgType;

-(void) onMsg:(NSString*)subType content:(NSDictionary*)content;

-(void) onOtherMsg:(NSDictionary*)content;


/**
 充值金币成功后通知前端
 @param coin 充值的金币数
 @param user null
 */
-(void) onUserRechargeCallbackMsg:(double)coin user:(ApiUserInfoModel* )user ;


/**
 开通会员提示飘窗
 @param elasticFrame null
 */
-(void) onElasticFrameMember:(ApiElasticFrameModel* )elasticFrame ;

@end

NS_ASSUME_NONNULL_END
