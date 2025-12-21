//此代码由 http://code.siwaha.com/ 生成，服务器修改后可重新生成

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN




/**
全局获取用户免费通话时间和通话次数
 */
@interface OOORegisterCallVOModel : NSObject 


	/**
剩余的注册赠送通话次数
 */
@property (nonatomic, assign) int registerCallSecond;

	/**
注册赠送通话时间(单位为分钟)
 */
@property (nonatomic, assign) int registerCallTime;

 +(NSMutableArray<OOORegisterCallVOModel*>*)getFromArr:(NSArray*)list;

 -(NSDictionary*)modelToJSONObject;

 +(NSMutableArray*)modelToJSONArray:(NSMutableArray<OOORegisterCallVOModel*>*)list;

 +(OOORegisterCallVOModel*)getFromDict:(NSDictionary*)dict;

 +(void)cloneObj:(OOORegisterCallVOModel*) source target:(OOORegisterCallVOModel*)target;

@end

NS_ASSUME_NONNULL_END
