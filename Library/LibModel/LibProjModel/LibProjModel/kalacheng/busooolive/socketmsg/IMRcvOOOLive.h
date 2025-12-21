//此代码由 http://code.siwaha.com/ 生成，服务器修改后可重新生成
#import <Foundation/Foundation.h>

#import <TXImKit/TXImKit.h>
#import "OOOInviteRetModel.h"
#import "ApiPushChatModel.h"
#import "OOOReturnModel.h"
#import "OOOHangupReturnModel.h"
#import "OooAskPopUpModel.h"
NS_ASSUME_NONNULL_BEGIN



/**
一对一获取消息
 */
@interface IMRcvOOOLive: NSObject<IMReceiver>


-(NSString*)getMsgType;

-(void) onMsg:(NSString*)subType content:(NSDictionary*)content;

-(void) onOtherMsg:(NSDictionary*)content;


/**
 别人邀请你聊天
 @param oooInviteRet null
 */
-(void) oooInviteYouToChat:(OOOInviteRetModel* )oooInviteRet ;


/**
 向用户推送某个求聊信息
 @param pushChat null
 */
-(void) onGirlUserToMaleUser:(ApiPushChatModel* )pushChat ;


/**
 邀请被发起方撤销
 @param sessionID null
 */
-(void) oooCancelInvite:(int64_t)sessionID ;


/**
 拒绝邀请
 @param sessionID null
 */
-(void) oooRefuseLive:(int64_t)sessionID ;


/**
 同意邀请
 @param info null
 */
-(void) oooAgreeLive:(OOOReturnModel* )info ;


/**
 用户选择的背景图(海报)
 @param portrait 用户选择的背景图(海报)
 */
-(void) oooUserPortrait:(NSString *)portrait ;


/**
 挂断电话，挂断聊天
 @param sessionID null
 @param hangupInfo null
 */
-(void) oooHangupCall:(int64_t)sessionID hangupInfo:(OOOHangupReturnModel* )hangupInfo ;


/**
 向某个用户推送某个求聊信息
 @param pushChat null
 */
-(void) onAskForAChatMsg:(ApiPushChatModel* )pushChat ;


/**
 推送求聊信息弹窗
 @param oooAskPopUp 推送求聊信息弹窗
 */
-(void) oooSendAskPopUp:(OooAskPopUpModel* )oooAskPopUp ;


/**
 邀请终止-双方都会收到
 @param sessionID null
 @param resion 原因：13等待超时；12：网络断开
 */
-(void) oooInviteEnd:(int64_t)sessionID resion:(int)resion ;

@end

NS_ASSUME_NONNULL_END
