//此代码由 http://code.siwaha.com/ 生成，服务器修改后可重新生成
#import <Foundation/Foundation.h>

#import <LibTools/NSDictionary+Json.h>
#import "IMRcvVoicePresenter.h"


/**
多人语音主持人相关
 */
@implementation IMRcvVoicePresenter

-(NSString*) getMsgType
{
    return @"VoicePresenter";
}
-(void) onMsg:(NSString*)subType content:(NSDictionary*)content
{
   if([subType isEqualToString:@"refreshPresenterAssistant"])
{
        [self refreshPresenterAssistant:[ApiUsersVoiceAssistanModel getFromDict:content[@"assistantPresenter"]] ];
}else    if([subType isEqualToString:@"applyPresenterAssistant"])
{
        [self applyPresenterAssistant:[content getInt64:@"roomId"] roomAssistantPromptVO:[RoomAssistantPromptVOModel getFromDict:content[@"roomAssistantPromptVO"]] ];
}else    if([subType isEqualToString:@"replyApplyPresenterAssistant"])
{
        [self replyApplyPresenterAssistant:[content getInt64:@"roomId"] status:[content getInt:@"status"] ];
}else    if([subType isEqualToString:@"presenterChange"])
{
        [self presenterChange:[content getInt64:@"upUserId"] downUserId:[content getInt64:@"downUserId"] assistantPresenter:[ApiUsersVoiceAssistanModel getFromDict:content[@"assistantPresenter"]] ];
}
}
-(void) onOtherMsg:(NSDictionary*)content
{
}
/**
 刷新主持麦位数据 
 @param assistantPresenter null
 */
-(void) refreshPresenterAssistant:(ApiUsersVoiceAssistanModel* )assistantPresenter {  }
/**
 发送上主持位申请 
 @param roomId null
 @param roomAssistantPromptVO null
 */
-(void) applyPresenterAssistant:(int64_t)roomId roomAssistantPromptVO:(RoomAssistantPromptVOModel* )roomAssistantPromptVO {  }
/**
 回复主持位申请
 @param roomId null
 @param status 1：同意 2:拒绝 3：超时
 */
-(void) replyApplyPresenterAssistant:(int64_t)roomId status:(int)status {  }
/**
 房间主持人变化 
 @param upUserId null
 @param downUserId null
 @param assistantPresenter null
 */
-(void) presenterChange:(int64_t)upUserId downUserId:(int64_t)downUserId assistantPresenter:(ApiUsersVoiceAssistanModel* )assistantPresenter {  }

@end


