//此代码由 http://code.siwaha.com/ 生成，服务器修改后可重新生成

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN




/**
直播pk配置VO
 */
@interface LivePkConfigurationVOModel : NSObject 


	/**
PK时长(秒)
 */
@property (nonatomic, assign) int pkTime;

	/**
null
 */
@property (nonatomic, assign) int id_field;

 +(NSMutableArray<LivePkConfigurationVOModel*>*)getFromArr:(NSArray*)list;

 -(NSDictionary*)modelToJSONObject;

 +(NSMutableArray*)modelToJSONArray:(NSMutableArray<LivePkConfigurationVOModel*>*)list;

 +(LivePkConfigurationVOModel*)getFromDict:(NSDictionary*)dict;

 +(void)cloneObj:(LivePkConfigurationVOModel*) source target:(LivePkConfigurationVOModel*)target;

@end

NS_ASSUME_NONNULL_END
