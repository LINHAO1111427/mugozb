//此代码由 http://code.siwaha.com/ 生成，服务器修改后可重新生成

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN




/**
后台管理用户信息表
 */
@interface AdminUserModel : NSObject 


	/**
累计收益金币
 */
@property (nonatomic, assign) double coinTotal;

	/**
序号
 */
@property (nonatomic, assign) double serialNumber;

	/**
用户退出状态
 */
@property (nonatomic, assign) int quitState;

	/**
固定邀请码链接
 */
@property (nonatomic, copy) NSString * inviteCodeLink;

	/**
手机号
 */
@property (nonatomic, copy) NSString * mobile;

	/**
用户简介
 */
@property (nonatomic, copy) NSString * desr;

	/**
用户状态,用来判断用户是否入会
 */
@property (nonatomic, assign) int userState;

	/**
固定邀请码
 */
@property (nonatomic, copy) NSString * inviteCode;

	/**
公会名称
 */
@property (nonatomic, copy) NSString * name;

	/**
家族LOGO
 */
@property (nonatomic, copy) NSString * logo;

	/**
null
 */
@property (nonatomic, assign) int64_t id_field;

	/**
联系人
 */
@property (nonatomic, copy) NSString * contacts;

	/**
登录账号
 */
@property (nonatomic, copy) NSString * username;

 +(NSMutableArray<AdminUserModel*>*)getFromArr:(NSArray*)list;

 -(NSDictionary*)modelToJSONObject;

 +(NSMutableArray*)modelToJSONArray:(NSMutableArray<AdminUserModel*>*)list;

 +(AdminUserModel*)getFromDict:(NSDictionary*)dict;

 +(void)cloneObj:(AdminUserModel*) source target:(AdminUserModel*)target;

@end

NS_ASSUME_NONNULL_END
