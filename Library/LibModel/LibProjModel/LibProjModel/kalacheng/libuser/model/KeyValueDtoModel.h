//此代码由 http://code.siwaha.com/ 生成，服务器修改后可重新生成

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN




/**
键值对数据
 */
@interface KeyValueDtoModel : NSObject 


	/**
默认是否进入到此选项页面 0： 否  1：是
 */
@property (nonatomic, assign) int isDefault;

	/**
补充值2
 */
@property (nonatomic, copy) NSString * value2;

	/**
补充值1
 */
@property (nonatomic, copy) NSString * value1;

	/**
值
 */
@property (nonatomic, copy) NSString * value;

	/**
键
 */
@property (nonatomic, copy) NSString * key;

 +(NSMutableArray<KeyValueDtoModel*>*)getFromArr:(NSArray*)list;

 -(NSDictionary*)modelToJSONObject;

 +(NSMutableArray*)modelToJSONArray:(NSMutableArray<KeyValueDtoModel*>*)list;

 +(KeyValueDtoModel*)getFromDict:(NSDictionary*)dict;

 +(void)cloneObj:(KeyValueDtoModel*) source target:(KeyValueDtoModel*)target;

@end

NS_ASSUME_NONNULL_END
