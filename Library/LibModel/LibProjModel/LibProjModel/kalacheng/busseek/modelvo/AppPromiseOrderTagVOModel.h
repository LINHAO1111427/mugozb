//此代码由 http://code.siwaha.com/ 生成，服务器修改后可重新生成

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN




/**
邀约订单标签VO
 */
@interface AppPromiseOrderTagVOModel : NSObject 


	/**
邀约订单标签名
 */
@property (nonatomic, copy) NSString * promiseTagName;

	/**
null
 */
@property (nonatomic, assign) int64_t id_field;

 +(NSMutableArray<AppPromiseOrderTagVOModel*>*)getFromArr:(NSArray*)list;

 -(NSDictionary*)modelToJSONObject;

 +(NSMutableArray*)modelToJSONArray:(NSMutableArray<AppPromiseOrderTagVOModel*>*)list;

 +(AppPromiseOrderTagVOModel*)getFromDict:(NSDictionary*)dict;

 +(void)cloneObj:(AppPromiseOrderTagVOModel*) source target:(AppPromiseOrderTagVOModel*)target;

@end

NS_ASSUME_NONNULL_END
