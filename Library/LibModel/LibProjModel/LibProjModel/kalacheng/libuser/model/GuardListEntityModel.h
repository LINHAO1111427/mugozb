//此代码由 http://code.siwaha.com/ 生成，服务器修改后可重新生成

#import <Foundation/Foundation.h>

 @class ApiGuardEntityChildModel;
NS_ASSUME_NONNULL_BEGIN




/**
APP守护列表
 */
@interface GuardListEntityModel : NSObject 


	/**
守护人数
 */
@property (nonatomic, assign) int number;

	/**
时长类型，0天，1月，2年
 */
@property (nonatomic, assign) int lengthType;

	/**
守护用户列表
 */
@property (nonatomic, strong) NSMutableArray<ApiGuardEntityChildModel*>* getguardEntityChildList;

	/**
到期时间
 */
@property (nonatomic, copy) NSString * endTime;

 +(NSMutableArray<GuardListEntityModel*>*)getFromArr:(NSArray*)list;

 -(NSDictionary*)modelToJSONObject;

 +(NSMutableArray*)modelToJSONArray:(NSMutableArray<GuardListEntityModel*>*)list;

 +(GuardListEntityModel*)getFromDict:(NSDictionary*)dict;

 +(void)cloneObj:(GuardListEntityModel*) source target:(GuardListEntityModel*)target;

@end

NS_ASSUME_NONNULL_END
