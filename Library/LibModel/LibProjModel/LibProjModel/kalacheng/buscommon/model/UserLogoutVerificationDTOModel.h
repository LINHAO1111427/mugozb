//此代码由 http://code.siwaha.com/ 生成，服务器修改后可重新生成

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN




/**
用户注销验证model
 */
@interface UserLogoutVerificationDTOModel : NSObject 


	/**
角色 0:普通用户 1:主播
 */
@property (nonatomic, assign) int role;

	/**
注销开关 0:开启 1:关闭
 */
@property (nonatomic, assign) int logOffSwitch;

	/**
映票余额/可提现金额
 */
@property (nonatomic, assign) double votes;

	/**
金币 /充值金额
 */
@property (nonatomic, assign) double coin;

 +(NSMutableArray<UserLogoutVerificationDTOModel*>*)getFromArr:(NSArray*)list;

 -(NSDictionary*)modelToJSONObject;

 +(NSMutableArray*)modelToJSONArray:(NSMutableArray<UserLogoutVerificationDTOModel*>*)list;

 +(UserLogoutVerificationDTOModel*)getFromDict:(NSDictionary*)dict;

 +(void)cloneObj:(UserLogoutVerificationDTOModel*) source target:(UserLogoutVerificationDTOModel*)target;

@end

NS_ASSUME_NONNULL_END
