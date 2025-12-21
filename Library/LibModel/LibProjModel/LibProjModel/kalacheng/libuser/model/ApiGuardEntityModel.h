//此代码由 http://code.siwaha.com/ 生成，服务器修改后可重新生成

#import <Foundation/Foundation.h>

 @class ApiGuardModel;
NS_ASSUME_NONNULL_BEGIN




/**
APP守护类目
 */
@interface ApiGuardEntityModel : NSObject 


	/**
守护类目
 */
@property (nonatomic, strong) NSMutableArray<ApiGuardModel*>* apiGuardList;

	/**
守护天数
 */
@property (nonatomic, assign) int64_t dayNumber;

	/**
用户总金额
 */
@property (nonatomic, assign) int totalCoin;

 +(NSMutableArray<ApiGuardEntityModel*>*)getFromArr:(NSArray*)list;

 -(NSDictionary*)modelToJSONObject;

 +(NSMutableArray*)modelToJSONArray:(NSMutableArray<ApiGuardEntityModel*>*)list;

 +(ApiGuardEntityModel*)getFromDict:(NSDictionary*)dict;

 +(void)cloneObj:(ApiGuardEntityModel*) source target:(ApiGuardEntityModel*)target;

@end

NS_ASSUME_NONNULL_END
