//此代码由 http://code.siwaha.com/ 生成，服务器修改后可重新生成

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN




/**
档期VO
 */
@interface AppScheduleVOModel : NSObject 


	/**
档期描述（都一样）
 */
@property (nonatomic, copy) NSString * scheduleDescription;

	/**
档期名称
 */
@property (nonatomic, copy) NSString * name;

	/**
null
 */
@property (nonatomic, assign) int64_t id_field;

 +(NSMutableArray<AppScheduleVOModel*>*)getFromArr:(NSArray*)list;

 -(NSDictionary*)modelToJSONObject;

 +(NSMutableArray*)modelToJSONArray:(NSMutableArray<AppScheduleVOModel*>*)list;

 +(AppScheduleVOModel*)getFromDict:(NSDictionary*)dict;

 +(void)cloneObj:(AppScheduleVOModel*) source target:(AppScheduleVOModel*)target;

@end

NS_ASSUME_NONNULL_END
