//此代码由 http://code.siwaha.com/ 生成，服务器修改后可重新生成

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN




/**
APP语音直播背景图
 */
@interface AppVoiceThumbModel : NSObject 


	/**
描述
 */
@property (nonatomic, copy) NSString * des;

	/**
排序
 */
@property (nonatomic, assign) int orderno;

	/**
图片地址
 */
@property (nonatomic, copy) NSString * thumb;

	/**
null
 */
@property (nonatomic, assign) int64_t id_field;

	/**
类型 0:多人语音 1:一对一语音
 */
@property (nonatomic, assign) int type;

 +(NSMutableArray<AppVoiceThumbModel*>*)getFromArr:(NSArray*)list;

 -(NSDictionary*)modelToJSONObject;

 +(NSMutableArray*)modelToJSONArray:(NSMutableArray<AppVoiceThumbModel*>*)list;

 +(AppVoiceThumbModel*)getFromDict:(NSDictionary*)dict;

 +(void)cloneObj:(AppVoiceThumbModel*) source target:(AppVoiceThumbModel*)target;

@end

NS_ASSUME_NONNULL_END
