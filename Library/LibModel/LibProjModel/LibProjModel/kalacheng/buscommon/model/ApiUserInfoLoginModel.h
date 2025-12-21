//此代码由 http://code.siwaha.com/ 生成，服务器修改后可重新生成

#import <Foundation/Foundation.h>

 @class GiftPackVOModel;
 @class ApiUserInfoModel;
NS_ASSUME_NONNULL_BEGIN




/**
APP登录接口返回值
 */
@interface ApiUserInfoLoginModel : NSObject 


	/**
新手大礼包
 */
@property (nonatomic, strong) NSMutableArray<GiftPackVOModel*>* packList;

	/**
用户信息
 */
@property (strong, nonatomic) ApiUserInfoModel* userInfo;

	/**
是否能开播 1:否 0:是
 */
@property (nonatomic, assign) int isLive;

	/**
是否第一次登录 1:是 2:不是
 */
@property (nonatomic, assign) int isFirstLogin;

	/**
关注状态 0:未关注， 1：已关注
 */
@property (nonatomic, assign) int followStatus;

	/**
是否显示首充 1:不显示 0:显示
 */
@property (nonatomic, assign) int isFirstRecharge;

	/**
是否可以发布动态 1:否 0:是
 */
@property (nonatomic, assign) int isVideo;

	/**
是否为VIP 0:非vip 1:是vip
 */
@property (nonatomic, assign) int vipType;

	/**
用户token
 */
@property (nonatomic, copy) NSString * user_token;

	/**
是否弹出邀请码 1:弹出 2:不弹出
 */
@property (nonatomic, assign) int isPid;

	/**
用户头像id
 */
@property (nonatomic, assign) int64_t userAvatarId;

 +(NSMutableArray<ApiUserInfoLoginModel*>*)getFromArr:(NSArray*)list;

 -(NSDictionary*)modelToJSONObject;

 +(NSMutableArray*)modelToJSONArray:(NSMutableArray<ApiUserInfoLoginModel*>*)list;

 +(ApiUserInfoLoginModel*)getFromDict:(NSDictionary*)dict;

 +(void)cloneObj:(ApiUserInfoLoginModel*) source target:(ApiUserInfoLoginModel*)target;

@end

NS_ASSUME_NONNULL_END
