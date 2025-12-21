//此代码由 http://code.siwaha.com/ 生成，服务器修改后可重新生成

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN




/**
后台管理-系统配置-登录开关
 */
@interface AdminLoginSwitchModel : NSObject 


	/**
一键授权 0：关闭 1：开启
 */
@property (nonatomic, assign) int androidOneClickAuthorization;

	/**
注册默认头像
 */
@property (nonatomic, copy) NSString * defaultUserAvatar;

	/**
默认个性签名
 */
@property (nonatomic, copy) NSString * defaultSignature;

	/**
登录方式 1:QQ 2:微信
 */
@property (nonatomic, copy) NSString * loginType;

	/**
null
 */
@property (nonatomic, assign) int64_t id_field;

	/**
必填邀请码
 */
@property (nonatomic, assign) int isRegCode;

	/**
邀请码弹窗显示 1：只显示一次 2：未填邀请码，每次打开app均显示
 */
@property (nonatomic, assign) int invitationPopDisplay;

	/**
邀请绑定方式 1：邀请码绑定 2：OpenInstall自动绑定 3:关闭
 */
@property (nonatomic, assign) int invitationBindingMethod;

	/**
openInstall的appKey
 */
@property (nonatomic, copy) NSString * openInstallAppKey;

	/**
分享方式 1:QQ 2:qq空间 3:微信 4:微信朋友圈
 */
@property (nonatomic, copy) NSString * shareType;

	/**
游客模式 0：关闭 1：开启
 */
@property (nonatomic, assign) int touristMode;

 +(NSMutableArray<AdminLoginSwitchModel*>*)getFromArr:(NSArray*)list;

 -(NSDictionary*)modelToJSONObject;

 +(NSMutableArray*)modelToJSONArray:(NSMutableArray<AdminLoginSwitchModel*>*)list;

 +(AdminLoginSwitchModel*)getFromDict:(NSDictionary*)dict;

 +(void)cloneObj:(AdminLoginSwitchModel*) source target:(AdminLoginSwitchModel*)target;

@end

NS_ASSUME_NONNULL_END
