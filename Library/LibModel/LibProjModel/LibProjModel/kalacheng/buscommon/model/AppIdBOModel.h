//此代码由 http://code.siwaha.com/ 生成，服务器修改后可重新生成

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN




/**
null
 */
@interface AppIdBOModel : NSObject 


	/**
表的主键
 */
@property (nonatomic, assign) int64_t id_field;

 +(NSMutableArray<AppIdBOModel*>*)getFromArr:(NSArray*)list;

 -(NSDictionary*)modelToJSONObject;

 +(NSMutableArray*)modelToJSONArray:(NSMutableArray<AppIdBOModel*>*)list;

 +(AppIdBOModel*)getFromDict:(NSDictionary*)dict;

 +(void)cloneObj:(AppIdBOModel*) source target:(AppIdBOModel*)target;

@end

NS_ASSUME_NONNULL_END
