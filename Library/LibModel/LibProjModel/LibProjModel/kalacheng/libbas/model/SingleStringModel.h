//此代码由 http://code.siwaha.com/ 生成，服务器修改后可重新生成

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN




/**
单个字符串封装类
 */
@interface SingleStringModel : NSObject 


	/**
值
 */
@property (nonatomic, copy) NSString * value;

 +(NSMutableArray<SingleStringModel*>*)getFromArr:(NSArray*)list;

 -(NSDictionary*)modelToJSONObject;

 +(NSMutableArray*)modelToJSONArray:(NSMutableArray<SingleStringModel*>*)list;

 +(SingleStringModel*)getFromDict:(NSDictionary*)dict;

 +(void)cloneObj:(SingleStringModel*) source target:(SingleStringModel*)target;

@end

NS_ASSUME_NONNULL_END
