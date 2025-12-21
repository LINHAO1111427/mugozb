//此代码由 http://code.siwaha.com/ 生成，服务器修改后可重新生成

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN




/**
APP登录接口返回值
 */
@interface ApiUserInfoOOOReqModel : NSObject 


	/**
用户真实在线状态 0:离线 1:在线
 */
@property (nonatomic, assign) int onlineStatus;

	/**
头像
 */
@property (nonatomic, copy) NSString * avatar;

	/**
用户ID
 */
@property (nonatomic, assign) int64_t userId;

	/**
昵称
 */
@property (nonatomic, copy) NSString * username;

 +(NSMutableArray<ApiUserInfoOOOReqModel*>*)getFromArr:(NSArray*)list;

 -(NSDictionary*)modelToJSONObject;

 +(NSMutableArray*)modelToJSONArray:(NSMutableArray<ApiUserInfoOOOReqModel*>*)list;

 +(ApiUserInfoOOOReqModel*)getFromDict:(NSDictionary*)dict;

 +(void)cloneObj:(ApiUserInfoOOOReqModel*) source target:(ApiUserInfoOOOReqModel*)target;

@end

NS_ASSUME_NONNULL_END
