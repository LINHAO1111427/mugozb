//此代码由 http://code.siwaha.com/ 生成，服务器修改后可重新生成
#import <Foundation/Foundation.h>

#import <TXImKit/TXImKit.h>
#import "ApiUsersVoiceAssistanModel.h"
NS_ASSUME_NONNULL_BEGIN



/**
多人语音操作的推送消息
 */
@interface IMRcvVoiceOperation: NSObject<IMReceiver>


-(NSString*)getMsgType;

-(void) onMsg:(NSString*)subType content:(NSDictionary*)content;

-(void) onOtherMsg:(NSDictionary*)content;


/**
 观众上麦操作
 @param apiVoiceAssistanEntity null
 @param upUid null
 */
-(void) onUpVoiceAssistan:(NSMutableArray<ApiUsersVoiceAssistanModel*>* )apiVoiceAssistanEntity upUid:(int64_t)upUid ;


/**
 单独发送主播的火力值
 @param anchorId null
 @param votes null
 */
-(void) sendAnchorVotes:(int64_t)anchorId votes:(double)votes ;


/**
 副播下麦操作
 @param apiVoiceAssistanEntity null
 @param downUid null
 */
-(void) downVoiceAssistan:(NSMutableArray<ApiUsersVoiceAssistanModel*>* )apiVoiceAssistanEntity downUid:(int64_t)downUid ;


/**
 语音房间非PK状态下的主播发送表情包
 @param presenterAssistant null
 */
-(void) sendAnchorSticker:(ApiUsersVoiceAssistanModel* )presenterAssistant ;


/**
 副播开关麦操作
 @param apiVoiceAssistanEntity null
 @param setUid null
 */
-(void) offVolumn:(NSMutableArray<ApiUsersVoiceAssistanModel*>* )apiVoiceAssistanEntity setUid:(int64_t)setUid ;


/**
 语音房间非PK状态下的副播发送表情包
 @param no null
 @param hGetAssistanList null
 */
-(void) sendStricker:(int)no hGetAssistanList:(NSMutableArray<ApiUsersVoiceAssistanModel*>* )hGetAssistanList ;


/**
 主播开关麦操作
 @param onOffState null
 */
-(void) hostOffVolumn:(int)onOffState ;


/**
 主播将指定麦序的麦位上副播踢出
 @param assisId 被踢出的副播id
 @param assitan null
 */
-(void) kickOutAssistan:(int64_t)assisId assitan:(NSMutableArray<ApiUsersVoiceAssistanModel*>* )assitan ;


/**
 封锁指定麦序的麦位
 @param assistanNo 指定麦序
 @param assitan null
 */
-(void) LockThisAssistan:(int)assistanNo assitan:(NSMutableArray<ApiUsersVoiceAssistanModel*>* )assitan ;


/**
 语音房间非PK状态下的送礼
 @param hGetAssistanList null
 */
-(void) sendGift:(NSMutableArray<ApiUsersVoiceAssistanModel*>* )hGetAssistanList ;

@end

NS_ASSUME_NONNULL_END
