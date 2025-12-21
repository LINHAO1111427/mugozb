//此代码由 http://code.siwaha.com/ 生成，服务器修改后可重新生成

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN




/**
APP获取管理员列表
 */
@interface ApiUsersLiveManagerModel : NSObject 


	/**
用户id
 */
@property (nonatomic, assign) int64_t uid;

	/**
会员等级
 */
@property (nonatomic, copy) NSString * userLevel;

	/**
个性签名
 */
@property (nonatomic, copy) NSString * signature;

	/**
性别；0：保密，1：男；2：女
 */
@property (nonatomic, assign) int sex;

	/**
用户头像
 */
@property (nonatomic, copy) NSString * avatar;

	/**
id
 */
@property (nonatomic, assign) int64_t id_field;

	/**
主播等级
 */
@property (nonatomic, copy) NSString * anchorLevel;

	/**
用户名
 */
@property (nonatomic, copy) NSString * username;

 +(NSMutableArray<ApiUsersLiveManagerModel*>*)getFromArr:(NSArray*)list;

 -(NSDictionary*)modelToJSONObject;

 +(NSMutableArray*)modelToJSONArray:(NSMutableArray<ApiUsersLiveManagerModel*>*)list;

 +(ApiUsersLiveManagerModel*)getFromDict:(NSDictionary*)dict;

 +(void)cloneObj:(ApiUsersLiveManagerModel*) source target:(ApiUsersLiveManagerModel*)target;

@end

NS_ASSUME_NONNULL_END
