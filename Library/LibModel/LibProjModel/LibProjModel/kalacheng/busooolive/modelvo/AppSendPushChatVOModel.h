//此代码由 http://code.siwaha.com/ 生成，服务器修改后可重新生成

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN




/**
APP求聊页面数据
 */
@interface AppSendPushChatVOModel : NSObject 


	/**
求聊显示文字
 */
@property (nonatomic, copy) NSString * pushShowContent;

	/**
求聊音乐
 */
@property (nonatomic, copy) NSString * pushMusic;

	/**
一对一求聊等待背景图
 */
@property (nonatomic, copy) NSString * oooAskWait;

	/**
会话id
 */
@property (nonatomic, assign) int64_t sessionId;

 +(NSMutableArray<AppSendPushChatVOModel*>*)getFromArr:(NSArray*)list;

 -(NSDictionary*)modelToJSONObject;

 +(NSMutableArray*)modelToJSONArray:(NSMutableArray<AppSendPushChatVOModel*>*)list;

 +(AppSendPushChatVOModel*)getFromDict:(NSDictionary*)dict;

 +(void)cloneObj:(AppSendPushChatVOModel*) source target:(AppSendPushChatVOModel*)target;

@end

NS_ASSUME_NONNULL_END
