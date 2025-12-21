//此代码由 http://code.siwaha.com/ 生成，服务器修改后可重新生成

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN




/**
后台管理-系统配置-APP版本管理
 */
@interface AdminVersionManageModel : NSObject 


	/**
ios包地址
 */
@property (nonatomic, copy) NSString * ipaPackUrl;

	/**
IOS最新版本code
 */
@property (nonatomic, assign) int ipaVersionCode;

	/**
ios包名
 */
@property (nonatomic, copy) NSString * iosPackName;

	/**
ios Plist地址
 */
@property (nonatomic, copy) NSString * ipaPlistUrl;

	/**
IOS更新说明
 */
@property (nonatomic, copy) NSString * ipaDesc;

	/**
IOS上架审核中版本的版本号
 */
@property (nonatomic, assign) int ipaShelves;

	/**
安卓最新版APK下载链接
 */
@property (nonatomic, copy) NSString * apkUrl;

	/**
ios图标地址
 */
@property (nonatomic, copy) NSString * iosIconUrl;

	/**
IOS最新版IPA下载链接
 */
@property (nonatomic, copy) NSString * ipaUrl;

	/**
IOS APP最新的版本号
 */
@property (nonatomic, copy) NSString * ipaVersion;

	/**
APK更新说明
 */
@property (nonatomic, copy) NSString * apkDesc;

	/**
ios应用名称
 */
@property (nonatomic, copy) NSString * iosApplicationName;

	/**
安卓APP最新的版本号
 */
@property (nonatomic, copy) NSString * apkVersion;

	/**
苹果下载方式 0:苹果/其他 1：外链
 */
@property (nonatomic, assign) int iosOpenInstall;

	/**
安卓APP最新版本code
 */
@property (nonatomic, assign) int apkVersionCode;

	/**
ipa是否强制更新 0:非强制 1:强制
 */
@property (nonatomic, assign) int isConstraintIpa;

	/**
null
 */
@property (nonatomic, assign) int64_t id_field;

	/**
apk是否强制更新 0:非强制 1:强制
 */
@property (nonatomic, assign) int isConstraintApk;

 +(NSMutableArray<AdminVersionManageModel*>*)getFromArr:(NSArray*)list;

 -(NSDictionary*)modelToJSONObject;

 +(NSMutableArray*)modelToJSONArray:(NSMutableArray<AdminVersionManageModel*>*)list;

 +(AdminVersionManageModel*)getFromDict:(NSDictionary*)dict;

 +(void)cloneObj:(AdminVersionManageModel*) source target:(AdminVersionManageModel*)target;

@end

NS_ASSUME_NONNULL_END
