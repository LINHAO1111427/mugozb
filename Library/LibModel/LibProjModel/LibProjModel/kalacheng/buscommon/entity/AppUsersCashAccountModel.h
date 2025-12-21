//此代码由 http://code.siwaha.com/ 生成，服务器修改后可重新生成

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN




/**
用户提现账户表
 */
@interface AppUsersCashAccountModel : NSObject 


	/**
银行名称
 */
@property (nonatomic, copy) NSString * accountBank;

	/**
用户ID
 */
@property (nonatomic, assign) int64_t uid;

	/**
是否默认 1:默认 0:非默认
 */
@property (nonatomic, assign) int isDefault;

	/**
添加时间
 */
@property (nonatomic,copy) NSDate * addtime;

	/**
姓名
 */
@property (nonatomic, copy) NSString * name;

	/**
null
 */
@property (nonatomic, assign) int64_t id_field;

	/**
账号类型 1:表示支付宝 2:表示微信 3:表示银行卡
 */
@property (nonatomic, assign) int type;

	/**
支行
 */
@property (nonatomic, copy) NSString * branch;

	/**
账号
 */
@property (nonatomic, copy) NSString * account;

 +(NSMutableArray<AppUsersCashAccountModel*>*)getFromArr:(NSArray*)list;

 -(NSDictionary*)modelToJSONObject;

 +(NSMutableArray*)modelToJSONArray:(NSMutableArray<AppUsersCashAccountModel*>*)list;

 +(AppUsersCashAccountModel*)getFromDict:(NSDictionary*)dict;

 +(void)cloneObj:(AppUsersCashAccountModel*) source target:(AppUsersCashAccountModel*)target;

@end

NS_ASSUME_NONNULL_END
