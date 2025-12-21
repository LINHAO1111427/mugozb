//此代码由 http://code.siwaha.com/ 生成，服务器修改后可重新生成

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN




/**
APP守护功能
 */
@interface GuardEffectModel : NSObject 


	/**
标识logo
 */
@property (nonatomic, copy) NSString * img;

	/**
描述
 */
@property (nonatomic, copy) NSString * des;

	/**
是否可用1可用0不可用
 */
@property (nonatomic, assign) int isAble;

	/**
标题
 */
@property (nonatomic, copy) NSString * title;

 +(NSMutableArray<GuardEffectModel*>*)getFromArr:(NSArray*)list;

 -(NSDictionary*)modelToJSONObject;

 +(NSMutableArray*)modelToJSONArray:(NSMutableArray<GuardEffectModel*>*)list;

 +(GuardEffectModel*)getFromDict:(NSDictionary*)dict;

 +(void)cloneObj:(GuardEffectModel*) source target:(GuardEffectModel*)target;

@end

NS_ASSUME_NONNULL_END
