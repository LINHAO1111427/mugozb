//此代码由 http://code.siwaha.com/ 生成，服务器修改后可重新生成

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN




/**
token-userid 返回封装类
 */
@interface UserTokenModel : NSObject 


	/**
null
 */
@property (nonatomic, assign) int64_t userAvatarId;

	/**
null
 */
@property (nonatomic, assign) int64_t userid;

	/**
null
 */
@property (nonatomic, copy) NSString * UserToken;

 +(NSMutableArray<UserTokenModel*>*)getFromArr:(NSArray*)list;

 -(NSDictionary*)modelToJSONObject;

 +(NSMutableArray*)modelToJSONArray:(NSMutableArray<UserTokenModel*>*)list;

 +(UserTokenModel*)getFromDict:(NSDictionary*)dict;

 +(void)cloneObj:(UserTokenModel*) source target:(UserTokenModel*)target;

@end

NS_ASSUME_NONNULL_END
