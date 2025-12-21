//此代码由 http://code.siwaha.com/ 生成，服务器修改后可重新生成

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN




/**
分享配置
 */
@interface AppShareConfigModel : NSObject 


	/**
直播分享标题
 */
@property (nonatomic, copy) NSString * shareTitle;

	/**
家族分享标题
 */
@property (nonatomic, copy) NSString * familyShareTitle;

	/**
ios下载链接
 */
@property (nonatomic, copy) NSString * ipaEwm;

	/**
分享logo
 */
@property (nonatomic, copy) NSString * logo;

	/**
直播话术
 */
@property (nonatomic, copy) NSString * shareDes;

	/**
家族分享话术
 */
@property (nonatomic, copy) NSString * familyShareDes;

	/**
null
 */
@property (nonatomic, assign) int64_t id_field;

	/**
推广分享话术
 */
@property (nonatomic, copy) NSString * inviteShareDes;

	/**
视图分享话术
 */
@property (nonatomic, copy) NSString * videoShareDes;

	/**
视图分享标题
 */
@property (nonatomic, copy) NSString * videoShareTitle;

	/**
android下载二维码
 */
@property (nonatomic, copy) NSString * apkEwm;

	/**
推广分享标题
 */
@property (nonatomic, copy) NSString * inviteShareTitle;

 +(NSMutableArray<AppShareConfigModel*>*)getFromArr:(NSArray*)list;

 -(NSDictionary*)modelToJSONObject;

 +(NSMutableArray*)modelToJSONArray:(NSMutableArray<AppShareConfigModel*>*)list;

 +(AppShareConfigModel*)getFromDict:(NSDictionary*)dict;

 +(void)cloneObj:(AppShareConfigModel*) source target:(AppShareConfigModel*)target;

@end

NS_ASSUME_NONNULL_END
