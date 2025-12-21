//此代码由 http://code.siwaha.com/ 生成，服务器修改后可重新生成
#import <Foundation/Foundation.h>

#import <TXImKit/TXImKit.h>
#import "ApiSimpleMsgRoomModel.h"
#import "ApiGiftSenderModel.h"
NS_ASSUME_NONNULL_BEGIN



/**
直播，一对一公共socket 直播间内
 */
@interface IMRcvPublicLiveSend: NSObject<IMReceiver>


-(NSString*)getMsgType;

-(void) onMsg:(NSString*)subType content:(NSDictionary*)content;

-(void) onOtherMsg:(NSDictionary*)content;


/**
 更新直播间贵宾席
 @param vipSeatsAvatar null
 @param needToBuy 0:不需要购买 1：需要购买
 */
-(void) onRoomVipSeats:(NSString *)vipSeatsAvatar needToBuy:(int)needToBuy ;


/**
 简单消息
 @param apiSimpleMsgRoom null
 */
-(void) onSimpleMsgRoom:(ApiSimpleMsgRoomModel* )apiSimpleMsgRoom ;


/**
 后台发送系统消息
 @param apiSimpleMsgRoom null
 */
-(void) onSimpleMsgAll:(ApiSimpleMsgRoomModel* )apiSimpleMsgRoom ;


/**
 全直播间飘屏信息
 @param apiGiftSender null
 */
-(void) onMsgAll:(ApiGiftSenderModel* )apiGiftSender ;


/**
 主播封禁后,向发送socket信息
 @param sessionID null
 @param banInfo null
 */
-(void) onRoomBan:(int64_t)sessionID banInfo:(NSString *)banInfo ;


/**
 鉴黄提示
 @param monitoringTipDuration null
 @param monitoringTipContent null
 */
-(void) onMonitoringTip:(int)monitoringTipDuration monitoringTipContent:(NSString *)monitoringTipContent ;


/**
 直播间发消息全站广播
 @param roomId null
 @param apiSimpleMsgRoom null
 */
-(void) onMsgAllForBroadCast:(int64_t)roomId apiSimpleMsgRoom:(ApiSimpleMsgRoomModel* )apiSimpleMsgRoom ;


/**
 用户封禁后,向发送socket信息
 @param sessionID null
 @param banInfo null
 */
-(void) onUserBan:(int64_t)sessionID banInfo:(NSString *)banInfo ;

@end

NS_ASSUME_NONNULL_END
