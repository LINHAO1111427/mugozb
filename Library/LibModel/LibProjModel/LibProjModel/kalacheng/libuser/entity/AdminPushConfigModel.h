//此代码由 http://code.siwaha.com/ 生成，服务器修改后可重新生成

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN




/**
后台管理-三方设置-推送配置
 */
@interface AdminPushConfigModel : NSObject 


	/**
腾讯SecretKey
 */
@property (nonatomic, copy) NSString * txSecretKey;

	/**
voip推送authKeyPath
 */
@property (nonatomic, copy) NSString * voipAuthKeyPath;

	/**
vivo推送SecretKey
 */
@property (nonatomic, copy) NSString * vivoSecretKey;

	/**
oppo推送SecretKey
 */
@property (nonatomic, copy) NSString * oppoSecretKey;

	/**
华为推送AppSecret
 */
@property (nonatomic, copy) NSString * hwAppSecret;

	/**
小米推送通道id
 */
@property (nonatomic, copy) NSString * miPassageId;

	/**
vivo推送AppId
 */
@property (nonatomic, copy) NSString * vivoAppId;

	/**
APNS推送teamId
 */
@property (nonatomic, copy) NSString * apnsTeamId;

	/**
APNS推送keyId/p12Pwd
 */
@property (nonatomic, copy) NSString * apnsKeyId;

	/**
华为推送AppId
 */
@property (nonatomic, copy) NSString * hwAppId;

	/**
极光推送模式
 */
@property (nonatomic, assign) int jpushSandbox;

	/**
小米推送SecretKey
 */
@property (nonatomic, copy) NSString * miSecretKey;

	/**
voip推送p12Pwd
 */
@property (nonatomic, copy) NSString * voipKeyId;

	/**
APNS推送authKeyPath
 */
@property (nonatomic, copy) NSString * apnsAuthKeyPath;

	/**
oppo推送AppKey
 */
@property (nonatomic, copy) NSString * oppoAppKey;

	/**
安卓包名
 */
@property (nonatomic, copy) NSString * androidPackageNames;

	/**
ios包名
 */
@property (nonatomic, copy) NSString * iosPackageNames;

	/**
腾讯AppId
 */
@property (nonatomic, copy) NSString * txAppId;

	/**
极光推送APP_KEY
 */
@property (nonatomic, copy) NSString * jpushKey;

	/**
vivo推送AppKey
 */
@property (nonatomic, copy) NSString * vivoAppKey;

	/**
null
 */
@property (nonatomic, assign) int64_t id_field;

	/**
极光推送master_secret
 */
@property (nonatomic, copy) NSString * jpushSecret;

	/**
oppo推送通道id
 */
@property (nonatomic, copy) NSString * oppoPassageId;

	/**
极光jpushRSA
 */
@property (nonatomic, copy) NSString * jpushRSA;

 +(NSMutableArray<AdminPushConfigModel*>*)getFromArr:(NSArray*)list;

 -(NSDictionary*)modelToJSONObject;

 +(NSMutableArray*)modelToJSONArray:(NSMutableArray<AdminPushConfigModel*>*)list;

 +(AdminPushConfigModel*)getFromDict:(NSDictionary*)dict;

 +(void)cloneObj:(AdminPushConfigModel*) source target:(AdminPushConfigModel*)target;

@end

NS_ASSUME_NONNULL_END
