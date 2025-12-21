//此代码由 http://code.siwaha.com/ 生成，服务器修改后可重新生成

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN




/**
APP心愿单用户
 */
@interface ApiWishUserModel : NSObject 


	/**
数量
 */
@property (nonatomic, assign) int number;

	/**
用户id
 */
@property (nonatomic, assign) int64_t uid;

	/**
头像
 */
@property (nonatomic, copy) NSString * avatar;

	/**
姓名
 */
@property (nonatomic, copy) NSString * username;

 +(NSMutableArray<ApiWishUserModel*>*)getFromArr:(NSArray*)list;

 -(NSDictionary*)modelToJSONObject;

 +(NSMutableArray*)modelToJSONArray:(NSMutableArray<ApiWishUserModel*>*)list;

 +(ApiWishUserModel*)getFromDict:(NSDictionary*)dict;

 +(void)cloneObj:(ApiWishUserModel*) source target:(ApiWishUserModel*)target;

@end

NS_ASSUME_NONNULL_END
