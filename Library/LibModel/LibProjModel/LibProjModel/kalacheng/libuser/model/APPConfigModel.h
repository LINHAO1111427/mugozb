//此代码由 http://code.siwaha.com/ 生成，服务器修改后可重新生成

#import <Foundation/Foundation.h>

 @class AdminKeywordManageModel;
 @class CfgPayWayDTOModel;
 @class AdminPushConfigModel;
 @class CoinDisplaySettingsVOModel;
 @class CustomerServiceSettingModel;
 @class CfgSmsRegionModel;
 @class AdminLiveConfigModel;
 @class CfgLiveKeyModel;
 @class AppBackpackManageVOModel;
 @class OooLiveConfigVOModel;
 @class AdminLoginSwitchModel;
 @class AdminVersionManageModel;
NS_ASSUME_NONNULL_BEGIN




/**
初始化APP公共设置
 */
@interface APPConfigModel : NSObject 


	/**
鉴黄功能 0：关闭 1：开启
 */
@property (nonatomic, assign) int haveMonitoring;

	/**
视频管理员人数上限
 */
@property (nonatomic, assign) int liveManagerLimit;

	/**
关键字屏蔽配置
 */
@property (strong, nonatomic) AdminKeywordManageModel* keywordManage;

	/**
语音管理员人数上限
 */
@property (nonatomic, assign) int voiceManagerLimit;

	/**
支付设置
 */
@property (nonatomic, strong) NSMutableArray<CfgPayWayDTOModel*>* payConfigList;

	/**
极光相关配置
 */
@property (strong, nonatomic) AdminPushConfigModel* adminPushConfig;

	/**
贵族才能查看附近的人 0:关闭 1:开启
 */
@property (nonatomic, assign) int nobleShowNearby;

	/**
金币显示设置
 */
@property (strong, nonatomic) CoinDisplaySettingsVOModel* coinDisplaySettingsVO;

	/**
当前时间
 */
@property (nonatomic, assign) int64_t currTime;

	/**
客服服务设置
 */
@property (strong, nonatomic) CustomerServiceSettingModel* customerServiceSetting;

	/**
语音消息是否检测后由服务器端发送
 */
@property (nonatomic, assign) int voiceMsgCheckedSend;

	/**
直播画质
 */
@property (nonatomic, assign) int imageQuality;

	/**
货币图标
 */
@property (nonatomic, copy) NSString * vcUnitIcon;

	/**
收益提现需要认证 0：关闭 1：开启
 */
@property (nonatomic, assign) int incomeCashAuth;

	/**
收益货币图标
 */
@property (nonatomic, copy) NSString * ticketIcon;

	/**
短信区域配置
 */
@property (nonatomic, strong) NSMutableArray<CfgSmsRegionModel*>* cfgSmsRegionVOList;

	/**
货币名称
 */
@property (nonatomic, copy) NSString * vcUnit;

	/**
直播云下相关配置
 */
@property (strong, nonatomic) AdminLiveConfigModel* adminLiveConfig;

	/**
直播相关Key
 */
@property (strong, nonatomic) CfgLiveKeyModel* liveKey;

	/**
游客的用户Token
 */
@property (nonatomic, copy) NSString * visitorUserToken;

	/**
微信支付的AppId
 */
@property (nonatomic, copy) NSString * wxAppId;

	/**
恋爱广告间隔
 */
@property (nonatomic, assign) int lianAiAdsInterval;

	/**
游客的用户id
 */
@property (nonatomic, assign) int64_t visitorUserID;

	/**
系统背景图设置
 */
@property (strong, nonatomic) AppBackpackManageVOModel* appBackpackManageVO;

	/**
一对一配置
 */
@property (strong, nonatomic) OooLiveConfigVOModel* oooLiveConfigVO;

	/**
鉴黄间隔（秒）
 */
@property (nonatomic, assign) int monitoringInterval;

	/**
登录开关
 */
@property (strong, nonatomic) AdminLoginSwitchModel* loginSwitch;

	/**
APP版本配置
 */
@property (strong, nonatomic) AdminVersionManageModel* versionManage;

	/**
收益货币名称
 */
@property (nonatomic, copy) NSString * ticketName;

 +(NSMutableArray<APPConfigModel*>*)getFromArr:(NSArray*)list;

 -(NSDictionary*)modelToJSONObject;

 +(NSMutableArray*)modelToJSONArray:(NSMutableArray<APPConfigModel*>*)list;

 +(APPConfigModel*)getFromDict:(NSDictionary*)dict;

 +(void)cloneObj:(APPConfigModel*) source target:(APPConfigModel*)target;

@end

NS_ASSUME_NONNULL_END
