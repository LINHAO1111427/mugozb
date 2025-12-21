//此代码由 http://code.siwaha.com/ 生成，服务器修改后可重新生成

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN




/**
连续登录奖励
 */
@interface AdminLoginAwardVOModel : NSObject 


	/**
null
 */
@property (nonatomic, assign) int64_t id_field;

	/**
连续登录天数
 */
@property (nonatomic, assign) int day;

	/**
上次登录时间
 */
@property (nonatomic,copy) NSDate * lastLoginDay;

	/**
奖励金币
 */
@property (nonatomic, assign) int coin;

 +(NSMutableArray<AdminLoginAwardVOModel*>*)getFromArr:(NSArray*)list;

 -(NSDictionary*)modelToJSONObject;

 +(NSMutableArray*)modelToJSONArray:(NSMutableArray<AdminLoginAwardVOModel*>*)list;

 +(AdminLoginAwardVOModel*)getFromDict:(NSDictionary*)dict;

 +(void)cloneObj:(AdminLoginAwardVOModel*) source target:(AdminLoginAwardVOModel*)target;

@end

NS_ASSUME_NONNULL_END
