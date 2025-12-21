//此代码由 http://code.siwaha.com/ 生成，服务器修改后可重新生成
#import <Foundation/Foundation.h>

#import <TXImKit/TXImKit.h>
#import "ApiSendMsgRoomModel.h"
#import "ApiExitRoomModel.h"
#import "AppJoinRoomVOModel.h"
#import "ApiTimerExitRoomModel.h"
NS_ASSUME_NONNULL_BEGIN



/**
直播间发送消息
 */
@interface IMRcvLiveMsgSend: NSObject<IMReceiver>


-(NSString*)getMsgType;

-(void) onMsg:(NSString*)subType content:(NSDictionary*)content;

-(void) onOtherMsg:(NSDictionary*)content;


/**
 指定用户发消息
 @param apiSendMsgRoom null
 */
-(void) onAppointUserSend:(ApiSendMsgRoomModel* )apiSendMsgRoom ;


/**
 修改房间公告推送公告内容
 @param content null
 */
-(void) onUserNoticMsg:(NSString *)content ;


/**
 修改房间类型
 @param apiExitRoom null
 */
-(void) onUserUpLiveTypeExitRoom:(ApiExitRoomModel* )apiExitRoom ;


/**
 在直播间发送消息
 @param apiSendMsgRoom null
 */
-(void) onUserSendMsgRoom:(ApiSendMsgRoomModel* )apiSendMsgRoom ;


/**
 计时房间余额不足时发送提醒
 @param times 还能观看倒计时秒
 */
-(void) onUserTimmerRoomRemind:(int)times ;


/**
 在直播间发送消息
 @param appJoinRoomVO null
 */
-(void) onUserSendApiJoinRoom:(AppJoinRoomVOModel* )appJoinRoomVO ;


/**
 计时房间余额不足退出房间
 @param apiTimerExitRoom null
 */
-(void) onTimerExitRoom:(ApiTimerExitRoomModel* )apiTimerExitRoom ;


/**
 发送房间总的火力值
 @param roomVotes null
 */
-(void) onRoomTotalVotes:(double)roomVotes ;

@end

NS_ASSUME_NONNULL_END
