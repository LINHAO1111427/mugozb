//此代码由 http://code.siwaha.com/ 生成，服务器修改后可重新生成
#import <Foundation/Foundation.h>

#import <TXImKit/TXImKit.h>
#import "OOOHangupReturnModel.h"
#import "OOOVolumeRetModel.h"
#import "OOOReturnModel.h"
#import "OOOInviteRetModel.h"
NS_ASSUME_NONNULL_BEGIN



/**
一对一对多获取消息
 */
@interface IMRcvOTMLive: NSObject<IMReceiver>


-(NSString*)getMsgType;

-(void) onMsg:(NSString*)subType content:(NSDictionary*)content;

-(void) onOtherMsg:(NSDictionary*)content;


/**
 副播发起挂断电话，挂断聊天
 @param sessionID null
 @param hangupInfo null
 */
-(void) hangupCall:(int64_t)sessionID hangupInfo:(OOOHangupReturnModel* )hangupInfo ;


/**
 1v1v7 付费方撤销了对指定副播的邀请
 @param sessionID null
 */
-(void) cancelInvite:(int64_t)sessionID ;


/**
 1v1v7 开关麦克风 或者 禁言操作
 @param sessionID null
 @param volumeRet null
 */
-(void) upVolumeOperation:(int64_t)sessionID volumeRet:(OOOVolumeRetModel* )volumeRet ;


/**
 同意邀请
 @param info null
 */
-(void) agreeLive:(OOOReturnModel* )info ;


/**
 别人邀请你聊天
 @param oooInviteRet null
 */
-(void) inviteYouToChat:(OOOInviteRetModel* )oooInviteRet ;


/**
 1v1v7 将指定id的副播踢出了房间
 @param assisId 被踢出的副播id
 @param sessionID null
 @param hangupInfo null
 */
-(void) kickOutRoom:(int64_t)assisId sessionID:(int64_t)sessionID hangupInfo:(OOOHangupReturnModel* )hangupInfo ;


/**
 金币不足，余额不足提醒，金币快用光了
 @param sessionID null
 @param times 60费用仅够1分钟；180费用仅够3分钟；返回的是180秒倒计时
 */
-(void) runningOutOfCoin:(int64_t)sessionID times:(int)times ;


/**
 邀请终止-双方都会收到
 @param sessionID null
 @param reason 原因：13等待超时；12：网络断开
 */
-(void) otmInviteEnd:(int64_t)sessionID reason:(int)reason ;


/**
 拒绝邀请
 @param sessionID null
 */
-(void) refuseLive:(int64_t)sessionID ;


/**
 消费者金币余额
 @param sessionID null
 @param coin 金币余额
 */
-(void) otmUptUserCoin:(int64_t)sessionID coin:(double)coin ;


/**
 主播/用户 挂断电话，挂断聊天
 @param sessionID null
 @param hangupInfo null
 */
-(void) hangupCallUser:(int64_t)sessionID hangupInfo:(OOOHangupReturnModel* )hangupInfo ;

@end

NS_ASSUME_NONNULL_END
