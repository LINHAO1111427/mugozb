//此代码由 http://code.siwaha.com/ 生成，服务器修改后可重新生成

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN




/**
房间邀请或申请上麦提示VO
 */
@interface RoomAssistantPromptVOModel : NSObject 


	/**
null
 */
@property (nonatomic, assign) int64_t serialVersionUID;

	/**
主持人id
 */
@property (nonatomic, assign) int64_t presenterUid;

	/**
邀请人id
 */
@property (nonatomic, assign) int64_t invitePeopleId;

	/**
用户ID
 */
@property (nonatomic, assign) int64_t userId;

	/**
用户名称
 */
@property (nonatomic, copy) NSString * userName;

	/**
用户头像
 */
@property (nonatomic, copy) NSString * userAvatar;

	/**
推送内容
 */
@property (nonatomic, copy) NSString * content;

	/**
连麦倒计时
 */
@property (nonatomic, assign) int lineTime;

 +(NSMutableArray<RoomAssistantPromptVOModel*>*)getFromArr:(NSArray*)list;

 -(NSDictionary*)modelToJSONObject;

 +(NSMutableArray*)modelToJSONArray:(NSMutableArray<RoomAssistantPromptVOModel*>*)list;

 +(RoomAssistantPromptVOModel*)getFromDict:(NSDictionary*)dict;

 +(void)cloneObj:(RoomAssistantPromptVOModel*) source target:(RoomAssistantPromptVOModel*)target;

@end

NS_ASSUME_NONNULL_END
