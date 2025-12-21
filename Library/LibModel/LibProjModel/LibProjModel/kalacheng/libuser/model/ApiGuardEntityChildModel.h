//此代码由 http://code.siwaha.com/ 生成，服务器修改后可重新生成

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN




/**
APP守护列表用户信息
 */
@interface ApiGuardEntityChildModel : NSObject 


	/**
用户id
 */
@property (nonatomic, assign) int64_t uid;

	/**
时长类型，0天，1月，2年
 */
@property (nonatomic, assign) int lengthType;

	/**
用户等级
 */
@property (nonatomic, copy) NSString * userLevel;

	/**
性别1男2女
 */
@property (nonatomic, assign) int sex;

	/**
用户头像
 */
@property (nonatomic, copy) NSString * avatar;

	/**
用户名称
 */
@property (nonatomic, copy) NSString * userName;

	/**
周贡献魅力值
 */
@property (nonatomic, assign) int coin;

 +(NSMutableArray<ApiGuardEntityChildModel*>*)getFromArr:(NSArray*)list;

 -(NSDictionary*)modelToJSONObject;

 +(NSMutableArray*)modelToJSONArray:(NSMutableArray<ApiGuardEntityChildModel*>*)list;

 +(ApiGuardEntityChildModel*)getFromDict:(NSDictionary*)dict;

 +(void)cloneObj:(ApiGuardEntityChildModel*) source target:(ApiGuardEntityChildModel*)target;

@end

NS_ASSUME_NONNULL_END
