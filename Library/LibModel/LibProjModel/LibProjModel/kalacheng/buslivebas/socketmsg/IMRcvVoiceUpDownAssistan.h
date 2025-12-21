//此代码由 http://code.siwaha.com/ 生成，服务器修改后可重新生成
#import <Foundation/Foundation.h>

#import <TXImKit/TXImKit.h>
#import "ApiUsersVoiceAssistanModel.h"
#import "RoomAssistantPromptVOModel.h"
NS_ASSUME_NONNULL_BEGIN



/**
多人语音上下麦相关
 */
@interface IMRcvVoiceUpDownAssistan: NSObject<IMReceiver>


-(NSString*)getMsgType;

-(void) onMsg:(NSString*)subType content:(NSDictionary*)content;

-(void) onOtherMsg:(NSDictionary*)content;


/**
 直播间内游客申请上麦，给主播发送申请通知信息
 @param apiUsersVoiceAssistans null
 */
-(void) onVoiceLineRequset:(ApiUsersVoiceAssistanModel* )apiUsersVoiceAssistans ;


/**
 直播间内申请上麦的游客数量
 @param roomId null
 @param num null
 */
-(void) onVoiceLineNumber:(int64_t)roomId num:(int)num ;


/**
 直播间邀请用户上麦
 @param roomId null
 @param roomAssistantPromptVO null
 */
-(void) onVoiceAssistantPrompt:(int64_t)roomId roomAssistantPromptVO:(RoomAssistantPromptVOModel* )roomAssistantPromptVO ;


/**
 回复邀请上麦申请
 @param roomId null
 @param status 1：同意 2:拒绝 3：超时
 */
-(void) replyInviteAssistant:(int64_t)roomId status:(int)status ;


/**
 房主拒绝游客的上麦申请
 @param roomID null
 */
-(void) refuseUpAstApply:(int64_t)roomID ;


/**
 撤销上麦申请
 @param authId 撤销方ID
 */
-(void) cancelApplyUp:(int64_t)authId ;


/**
 申请上麦超时 两边都发
 @param applyUid 申请人ID
 */
-(void) applyUpTimeOut:(int64_t)applyUid ;


/**
 房主同意游客的上麦申请
 @param roomID null
 */
-(void) agreeUpAstApply:(int64_t)roomID ;

@end

NS_ASSUME_NONNULL_END
