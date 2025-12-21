//此代码由 http://code.siwaha.com/ 生成，服务器修改后可重新生成

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN




/**
1vs1-求聊话费设置
 */
@interface AdminRushToTalkConfigModel : NSObject 


	/**
添加时间
 */
@property (nonatomic,copy) NSDate * createTime;

	/**
话费
 */
@property (nonatomic, assign) int telephoneMoney;

	/**
null
 */
@property (nonatomic, assign) int64_t id_field;

	/**
聊天类型 1:视频聊天 2:语音聊天
 */
@property (nonatomic, assign) int chatType;

 +(NSMutableArray<AdminRushToTalkConfigModel*>*)getFromArr:(NSArray*)list;

 -(NSDictionary*)modelToJSONObject;

 +(NSMutableArray*)modelToJSONArray:(NSMutableArray<AdminRushToTalkConfigModel*>*)list;

 +(AdminRushToTalkConfigModel*)getFromDict:(NSDictionary*)dict;

 +(void)cloneObj:(AdminRushToTalkConfigModel*) source target:(AdminRushToTalkConfigModel*)target;

@end

NS_ASSUME_NONNULL_END
