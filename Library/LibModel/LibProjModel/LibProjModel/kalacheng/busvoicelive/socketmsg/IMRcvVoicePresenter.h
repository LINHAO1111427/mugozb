//此代码由 http://code.siwaha.com/ 生成，服务器修改后可重新生成
#import <Foundation/Foundation.h>

#import <TXImKit/TXImKit.h>
#import "ApiUsersVoiceAssistanModel.h"
#import "RoomAssistantPromptVOModel.h"
NS_ASSUME_NONNULL_BEGIN



/**
多人语音主持人相关
 */
@interface IMRcvVoicePresenter: NSObject<IMReceiver>


-(NSString*)getMsgType;

-(void) onMsg:(NSString*)subType content:(NSDictionary*)content;

-(void) onOtherMsg:(NSDictionary*)content;


/**
 刷新主持麦位数据 
 @param assistantPresenter null
 */
-(void) refreshPresenterAssistant:(ApiUsersVoiceAssistanModel* )assistantPresenter ;


/**
 发送上主持位申请 
 @param roomId null
 @param roomAssistantPromptVO null
 */
-(void) applyPresenterAssistant:(int64_t)roomId roomAssistantPromptVO:(RoomAssistantPromptVOModel* )roomAssistantPromptVO ;


/**
 回复主持位申请
 @param roomId null
 @param status 1：同意 2:拒绝 3：超时
 */
-(void) replyApplyPresenterAssistant:(int64_t)roomId status:(int)status ;


/**
 房间主持人变化 
 @param upUserId null
 @param downUserId null
 @param assistantPresenter null
 */
-(void) presenterChange:(int64_t)upUserId downUserId:(int64_t)downUserId assistantPresenter:(ApiUsersVoiceAssistanModel* )assistantPresenter ;

@end

NS_ASSUME_NONNULL_END
