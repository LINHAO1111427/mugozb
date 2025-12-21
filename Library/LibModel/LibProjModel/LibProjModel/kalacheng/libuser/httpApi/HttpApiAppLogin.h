//此代码由 http://code.siwaha.com/ 生成，服务器修改后可重新生成
#import <Foundation/Foundation.h>

#import <LibProjBase/PageInfo.h>


#import "CfgCurrencySettingModel.h"

#import "UserTokenModel.h"

#import "HttpNoneModel.h"

#import "AppAdsModel.h"

#import "ApiUserInfoLoginModel.h"

#import "AppLogin_ChartLogin.h"
#import "AppPostsModel.h"

#import "AppMedalModel.h"

#import "ApiVersionModel.h"

#import "SingleStringModel.h"

#import "CfgPayWayDTOModel.h"

#import "APPConfigModel.h"

#import "NobLiveGiftModel.h"

#import "AppGradeModel.h"

#import "CfgShareDomainNameModel.h"

typedef void (^CallBackAppLogin_CfgCurrencySetting)(int code,NSString *strMsg,CfgCurrencySettingModel* model);
typedef void (^CallBackAppLogin_UserToken)(int code,NSString *strMsg,UserTokenModel* model);
typedef void (^CallBackAppLogin_HttpNone)(int code,NSString *strMsg,HttpNoneModel* model);
typedef void (^CallBackAppLogin_AppAdsArr)(int code,NSString *strMsg,NSArray<AppAdsModel*>* arr);
typedef void (^CallBackAppLogin_ApiUserInfoLogin)(int code,NSString *strMsg,ApiUserInfoLoginModel* model);
typedef void (^CallBackAppLogin_AppPosts)(int code,NSString *strMsg,AppPostsModel* model);
typedef void (^CallBackAppLogin_AppMedalArr)(int code,NSString *strMsg,NSArray<AppMedalModel*>* arr);
typedef void (^CallBackAppLogin_ApiVersion)(int code,NSString *strMsg,ApiVersionModel* model);
typedef void (^CallBackAppLogin_SingleString)(int code,NSString *strMsg,SingleStringModel* model);
typedef void (^CallBackAppLogin_CfgPayWayDTOArr)(int code,NSString *strMsg,NSArray<CfgPayWayDTOModel*>* arr);
typedef void (^CallBackAppLogin_APPConfig)(int code,NSString *strMsg,APPConfigModel* model);
typedef void (^CallBackAppLogin_NobLiveGiftArr)(int code,NSString *strMsg,NSArray<NobLiveGiftModel*>* arr);
typedef void (^CallBackAppLogin_AppGradeArr)(int code,NSString *strMsg,NSArray<AppGradeModel*>* arr);
typedef void (^CallBackAppLogin_CfgShareDomainNameArr)(int code,NSString *strMsg,NSArray<CfgShareDomainNameModel*>* arr);
NS_ASSUME_NONNULL_BEGIN



/**
用户登录接口API(不需要验证token的接口走这)
 */
@interface HttpApiAppLogin: NSObject



/**
 获取金币映票名称信息
 */
+(void) getCfgCurrency:(CallBackAppLogin_CfgCurrencySetting)callback;


/**
 手机号注册
 @param appVersion 当前版本号
 @param appVersionCode 当前版本code
 @param code 验证码
 @param mobile 手机号码
 @param password 密码
 @param phoneFirm 手机厂商
 @param phoneModel 手机型号
 @param phoneUuid 手机唯一标识
 @param smsRegion 手机号区域
 */
+(void) register:(NSString *)appVersion appVersionCode:(NSString *)appVersionCode code:(NSString *)code mobile:(NSString *)mobile password:(NSString *)password phoneFirm:(NSString *)phoneFirm phoneModel:(NSString *)phoneModel phoneUuid:(NSString *)phoneUuid smsRegion:(NSString *)smsRegion  callback:(CallBackAppLogin_UserToken)callback;


/**
 添加已经阅读平台使用协议
 */
+(void) addUseLicense:(CallBackAppLogin_HttpNone)callback;


/**
 app获取验证码
 @param isInternational 平台 1:国内 2:国外
 @param key key
 @param smsType 类型 1:注册 2:找回密码 3:验证码登录 4:用户注销 5:绑定手机号 6:青少年验证码 7:修改手机号 8:微信公众号登录
 @param tel 手机号码
 @param tm 时间yyyy-MM-dd HH:mm:ss格式
 */
+(void) getSMSCode:(int)isInternational key:(NSString *)key smsType:(int)smsType tel:(NSString *)tel tm:(NSString *)tm  callback:(CallBackAppLogin_HttpNone)callback;


/**
 获取轮播图列表 启动图:(1,0) 直播:(2,1) 推荐:(3,12) 附近:(4,13) 一对一:[(5,n),全部(5,1)，推荐(5,23)] 短视频看点:(6,7) 视频分类:(6,8) 动态:(21,21) 语聊(15,1) 电台(16,16) 直播购(17,17)
 @param pid 一级分类
 @param type 二级分类: 0:启动图 1:直播 2:推荐 3:附近
 */
+(void) adslist:(int)pid type:(int)type  callback:(CallBackAppLogin_AppAdsArr)callback;


/**
 密码登录
 @param appVersion app当前版本号
 @param appVersionCode 当前版本code
 @param mobile 手机号码
 @param password 密码
 @param phoneFirm 手机厂商
 @param phoneModel 手机型号
 @param phoneUuid 手机唯一标识
 @param smsRegion 手机号区域
 */
+(void) login:(NSString *)appVersion appVersionCode:(NSString *)appVersionCode mobile:(NSString *)mobile password:(NSString *)password phoneFirm:(NSString *)phoneFirm phoneModel:(NSString *)phoneModel phoneUuid:(NSString *)phoneUuid smsRegion:(NSString *)smsRegion  callback:(CallBackAppLogin_ApiUserInfoLogin)callback;
//  /api/login/upJiguang
//  /api/login/upJiguang  此函数没有开放POST请求。




/**
 第三方登录
 @param appVersion app当前版本号
 @param appVersionCode 当前版本code
 @param nickname 昵称
 @param openid 第三方标识
 @param phoneFirm 手机厂商
 @param phoneModel 手机型号
 @param phoneUuid 手机唯一标识
 @param pic 图片地址
 @param sex 性别 0:保密 1:男 2:女
 @param type 类型 1:QQ 2:微信 3：苹果登录 4：app唯一标识登录
 */
+(void) ChartLogin:(AppLogin_ChartLogin*)_mdl callback:(CallBackAppLogin_ApiUserInfoLogin)callback;
/**
 第三方登录
 @param appVersion app当前版本号
 @param appVersionCode 当前版本code
 @param nickname 昵称
 @param openid 第三方标识
 @param phoneFirm 手机厂商
 @param phoneModel 手机型号
 @param phoneUuid 手机唯一标识
 @param pic 图片地址
 @param sex 性别 0:保密 1:男 2:女
 @param type 类型 1:QQ 2:微信 3：苹果登录 4：app唯一标识登录
 */
+(void) ChartLogin:(NSString *)appVersion appVersionCode:(NSString *)appVersionCode nickname:(NSString *)nickname openid:(NSString *)openid phoneFirm:(NSString *)phoneFirm phoneModel:(NSString *)phoneModel phoneUuid:(NSString *)phoneUuid pic:(NSString *)pic sex:(int)sex type:(int)type  callback:(CallBackAppLogin_ApiUserInfoLogin)callback;


/**
 获取平台使用协议
 */
+(void) getUseLicense:(CallBackAppLogin_AppPosts)callback;


/**
 获取勋章图片地址
 */
+(void) getMedalList:(CallBackAppLogin_AppMedalArr)callback;


/**
 版本控制
 @param type 类型 1:安卓 2:ios
 @param versionCode 版本号
 */
+(void) getAppUpdateInfo:(int)type versionCode:(int)versionCode  callback:(CallBackAppLogin_ApiVersion)callback;


/**
 app获取验证码(舍弃)
 @param isInternational 平台 1:国内 2:国外
 @param smsType 类型 1:注册 2:找回密码 3:验证码登录 4:用户注销 5:绑定手机号 6:青少年验证码 7:修改手机号 8:微信公众号登录
 @param tel 手机号码
 */
+(void) getVerCode:(int)isInternational smsType:(int)smsType tel:(NSString *)tel  callback:(CallBackAppLogin_HttpNone)callback;


/**
 忘记密码
 @param code 短信验证码
 @param freshPwd 新密码
 @param freshPwd2 再次输入新密码
 @param phone 手机号码
 */
+(void) forget_pwd:(NSString *)code freshPwd:(NSString *)freshPwd freshPwd2:(NSString *)freshPwd2 phone:(NSString *)phone  callback:(CallBackAppLogin_SingleString)callback;


/**
 获取支付通道
 */
+(void) getPayWay:(CallBackAppLogin_CfgPayWayDTOArr)callback;


/**
 一键登录
 @param appVersion 当前版本号
 @param appVersionCode 当前版本code
 @param carrier 运营商
 @param loginTokenVerify 加密的token
 @param loginType 登录厂商 2:轩嗵
 @param phoneFirm 手机厂商
 @param phoneModel 手机型号
 @param phoneUuid 手机唯一标识
 */
+(void) oneClickLogin:(NSString *)appVersion appVersionCode:(NSString *)appVersionCode carrier:(NSString *)carrier loginTokenVerify:(NSString *)loginTokenVerify loginType:(int)loginType phoneFirm:(NSString *)phoneFirm phoneModel:(NSString *)phoneModel phoneUuid:(NSString *)phoneUuid  callback:(CallBackAppLogin_ApiUserInfoLogin)callback;
//  /api/login/appSite
//  /api/login/appSite  此函数没有开放POST请求。


/**
 初始化APP公共设置
 */
+(void) getConfig:(CallBackAppLogin_APPConfig)callback;


/**
 获取礼物列表
 */
+(void) giftList:(CallBackAppLogin_NobLiveGiftArr)callback;


/**
 版本控制
 @param appVersion 版本号
 @param type 类型 1:安卓 2:ios
 @param versionCode 版本code
 */
+(void) getAppUpdateInfoNew:(NSString *)appVersion type:(int)type versionCode:(int)versionCode  callback:(CallBackAppLogin_ApiVersion)callback;


/**
 包含用户等级，财富等级，主播等级，贵族等级
 */
+(void) getGradeList:(CallBackAppLogin_AppGradeArr)callback;


/**
 app获取验证码(舍弃)
 @param isInternational 平台 1:国内 2:国外
 @param smsType 类型 1:注册 2:找回密码 3:验证码登录 4:用户注销 5:绑定手机号 6:青少年验证码 7:修改手机号 8:微信公众号登录
 @param tel 手机号码
 */
+(void) getMsgCode:(int)isInternational smsType:(int)smsType tel:(NSString *)tel  callback:(CallBackAppLogin_HttpNone)callback;


/**
 手机验证码登录
 @param appVersion 当前版本号
 @param appVersionCode 当前版本code
 @param code 验证码
 @param mobile 手机号码
 @param phoneFirm 手机厂商
 @param phoneModel 手机型号
 @param phoneUuid 手机唯一标识
 @param smsRegion 手机号区域
 */
+(void) phoneCodeLogin:(NSString *)appVersion appVersionCode:(NSString *)appVersionCode code:(NSString *)code mobile:(NSString *)mobile phoneFirm:(NSString *)phoneFirm phoneModel:(NSString *)phoneModel phoneUuid:(NSString *)phoneUuid smsRegion:(NSString *)smsRegion  callback:(CallBackAppLogin_ApiUserInfoLogin)callback;


/**
 获取分享域名
 */
+(void) getShareDomainNames:(CallBackAppLogin_CfgShareDomainNameArr)callback;


/**
 绑定手机号码
 @param code 验证码
 @param mobile 绑定手机号码
 @param smsRegion 手机号区域
 */
+(void) bindMobile:(NSString *)code mobile:(NSString *)mobile smsRegion:(NSString *)smsRegion  callback:(CallBackAppLogin_HttpNone)callback;

@end

NS_ASSUME_NONNULL_END
