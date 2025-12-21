//此代码由 http://code.siwaha.com/ 生成，服务器修改后可重新生成

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN




/**
app端消息通知开关VO
 */
@interface MsgNotifySwitchVOModel : NSObject 


	/**
提示音开关 0：关闭 1：开启
 */
@property (nonatomic, assign) int toneSwitch;

	/**
用户id
 */
@property (nonatomic, assign) int64_t userId;

 +(NSMutableArray<MsgNotifySwitchVOModel*>*)getFromArr:(NSArray*)list;

 -(NSDictionary*)modelToJSONObject;

 +(NSMutableArray*)modelToJSONArray:(NSMutableArray<MsgNotifySwitchVOModel*>*)list;

 +(MsgNotifySwitchVOModel*)getFromDict:(NSDictionary*)dict;

 +(void)cloneObj:(MsgNotifySwitchVOModel*) source target:(MsgNotifySwitchVOModel*)target;

@end

NS_ASSUME_NONNULL_END
