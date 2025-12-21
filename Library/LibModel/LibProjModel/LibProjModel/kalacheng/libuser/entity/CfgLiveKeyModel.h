//此代码由 http://code.siwaha.com/ 生成，服务器修改后可重新生成

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN




/**
后台管理-三方设置-直播配置
 */
@interface CfgLiveKeyModel : NSObject 


	/**
美颜开关
 */
@property (nonatomic, assign) int beautySwitch;

	/**
美颜key
 */
@property (nonatomic, copy) NSString * beautyKey;

	/**
短视频SDK secretKey
 */
@property (nonatomic, copy) NSString * videoClipsSecretKey;

	/**
直播云appid
 */
@property (nonatomic, copy) NSString * liveAppid;

	/**
短视频SDKKey
 */
@property (nonatomic, copy) NSString * videoClipsKey;

	/**
IM appId
 */
@property (nonatomic, copy) NSString * imAppid;

	/**
一键登录appid
 */
@property (nonatomic, copy) NSString * numberAuthAppid;

	/**
美颜信息
 */
@property (nonatomic, copy) NSString * beautyKeyInfo;

	/**
美颜appid
 */
@property (nonatomic, copy) NSString * beautyAppid;

	/**
直播CDN Cfg Key
 */
@property (nonatomic, copy) NSString * cdnCfgKey;

	/**
一键登录secretKey
 */
@property (nonatomic, copy) NSString * numberAuthSecretKey;

	/**
直播CDN secretKey
 */
@property (nonatomic, copy) NSString * cdnSecretKey;

	/**
imIp
 */
@property (nonatomic, copy) NSString * imIp;

	/**
一键登录信息
 */
@property (nonatomic, copy) NSString * numberAuthInfo;

	/**
null
 */
@property (nonatomic, assign) int64_t id_field;

	/**
imkey
 */
@property (nonatomic, copy) NSString * imKey;

	/**
一键登录key
 */
@property (nonatomic, copy) NSString * numberAuthKey;

	/**
IM secretKey
 */
@property (nonatomic, copy) NSString * imSecretKey;

	/**
直播CDNInfo
 */
@property (nonatomic, copy) NSString * cdnInfo;

	/**
腾讯appManager
 */
@property (nonatomic, copy) NSString * tencentAppManager;

	/**
直播云secretKey
 */
@property (nonatomic, copy) NSString * liveSecretKey;

	/**
直播key
 */
@property (nonatomic, copy) NSString * liveKey;

	/**
腾讯appId
 */
@property (nonatomic, assign) int64_t tencentAppId;

	/**
短视频SDK Info
 */
@property (nonatomic, copy) NSString * videoClipsInfo;

	/**
直播CDN appid
 */
@property (nonatomic, copy) NSString * cdnAppId;

	/**
短视频SDK appid
 */
@property (nonatomic, copy) NSString * videoClipsAppId;

	/**
一键登录开关
 */
@property (nonatomic, assign) int numberAuthSwitch;

	/**
直播录制key
 */
@property (nonatomic, copy) NSString * liveRecordKey;

	/**
liveKey信息
 */
@property (nonatomic, copy) NSString * liveKeyInfo;

	/**
腾讯key
 */
@property (nonatomic, copy) NSString * tencentKey;

	/**
imProt
 */
@property (nonatomic, assign) int imProt;

	/**
美颜secretKey
 */
@property (nonatomic, copy) NSString * beautySecretKey;

	/**
imInfo
 */
@property (nonatomic, copy) NSString * imInfo;

	/**
直播项目Id
 */
@property (nonatomic, copy) NSString * projectId;

 +(NSMutableArray<CfgLiveKeyModel*>*)getFromArr:(NSArray*)list;

 -(NSDictionary*)modelToJSONObject;

 +(NSMutableArray*)modelToJSONArray:(NSMutableArray<CfgLiveKeyModel*>*)list;

 +(CfgLiveKeyModel*)getFromDict:(NSDictionary*)dict;

 +(void)cloneObj:(CfgLiveKeyModel*) source target:(CfgLiveKeyModel*)target;

@end

NS_ASSUME_NONNULL_END
