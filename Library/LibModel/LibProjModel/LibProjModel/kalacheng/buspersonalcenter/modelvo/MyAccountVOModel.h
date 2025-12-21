//此代码由 http://code.siwaha.com/ 生成，服务器修改后可重新生成

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN




/**
我的账户相关
 */
@interface MyAccountVOModel : NSObject 


	/**
金币/充值金额
 */
@property (nonatomic, assign) double coin;

 +(NSMutableArray<MyAccountVOModel*>*)getFromArr:(NSArray*)list;

 -(NSDictionary*)modelToJSONObject;

 +(NSMutableArray*)modelToJSONArray:(NSMutableArray<MyAccountVOModel*>*)list;

 +(MyAccountVOModel*)getFromDict:(NSDictionary*)dict;

 +(void)cloneObj:(MyAccountVOModel*) source target:(MyAccountVOModel*)target;

@end

NS_ASSUME_NONNULL_END
