//此代码由 http://code.siwaha.com/ 生成，服务器修改后可重新生成

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN




/**
后台管理-三方设置-直播配置
 */
@interface AdminLiveConfigModel : NSObject 


	/**
男主播显示地址 0：显示真实地址 1：显示虚拟地址
 */
@property (nonatomic, assign) int maleAnchorShowAddress;

	/**
在线客服 0:隐藏 1:显示
 */
@property (nonatomic, assign) int showOnlineService;

	/**
聊天服务器带端口
 */
@property (nonatomic, copy) NSString * chatServer;

	/**
注销开关 0:开启 1:关闭
 */
@property (nonatomic, assign) int logOffSwitch;

	/**
私信女主播显示用户地址 0:关闭 1:开启
 */
@property (nonatomic, assign) int femaleAnchorLookCity;

	/**
是否开启幸运礼物 0：不开启 1：开启
 */
@property (nonatomic, assign) int isEnableLuckyGift;

	/**
短视频试看 0:关闭(默认) 1:开启
 */
@property (nonatomic, assign) int shortVideoTrial;

	/**
私聊红包 0:显示 1:隐藏
 */
@property (nonatomic, assign) int privateShowRedPack;

	/**
用户是贵族才能聊天 0:开启 1:关闭
 */
@property (nonatomic, assign) int isNobleChat;

	/**
提现规则
 */
@property (nonatomic, copy) NSString * withdrawalRule;

	/**
null
 */
@property (nonatomic, assign) int64_t id_field;

	/**
语音开播认证 0:开启认证 1:关闭认证
 */
@property (nonatomic, assign) int voiceStartCertification;

	/**
贵宾席费用
 */
@property (nonatomic, assign) double VIPStatesFee;

	/**
任务中心 0:隐藏 1:显示
 */
@property (nonatomic, assign) int showTaskCenter;

	/**
注销后多久可以注册(天) 0:表示不控制
 */
@property (nonatomic, assign) int logOffDay;

	/**
用户注销内容
 */
@property (nonatomic, copy) NSString * userCancel;

	/**
短视频试看时间(秒)
 */
@property (nonatomic, assign) int shortVideoTrialTime;

	/**
个人中心财富等级和魅力等级 0:显示 1:隐藏
 */
@property (nonatomic, assign) int showWealthAndCharm;

	/**
群聊红包 0:显示 1:隐藏
 */
@property (nonatomic, assign) int groupShowRedPack;

	/**
短视频评论开关 0：开 1：关
 */
@property (nonatomic, assign) int videoCommentSwitch;

	/**
踢出时长(分钟)
 */
@property (nonatomic, assign) int kickTime;

	/**
视频开播认证限制 0:开启认证 1:关闭认证
 */
@property (nonatomic, assign) int authIslimit;

	/**
banner跳转方式 0:app内 1:外部浏览器
 */
@property (nonatomic, assign) int jumpMode;

	/**
连麦等级限制
 */
@property (nonatomic, assign) int miclimit;

	/**
短视频是否需要收费 0:开启 1:关闭
 */
@property (nonatomic, assign) int isShortVideoFee;

	/**
主播发私信免费 0:开启 1:关闭
 */
@property (nonatomic, assign) int anchorTalkFree;

	/**
弹幕费用
 */
@property (nonatomic, assign) int barrageFee;

	/**
发言等级限制
 */
@property (nonatomic, assign) int barrageLimit;

	/**
女用户显示地址 0：显示真实地址 1：显示虚拟地址
 */
@property (nonatomic, assign) int femaleUserShowAddress;

	/**
主播和主播发起通话 0:开启 1:关闭
 */
@property (nonatomic, assign) int anchorToAnchor;

	/**
谁看过我是否需要VIP 0:开启 1:关闭
 */
@property (nonatomic, assign) int isVipSee;

	/**
在线客服地址
 */
@property (nonatomic, copy) NSString * onlineServiceUrl;

	/**
主播和主播可以私信 0:开启 1:关闭
 */
@property (nonatomic, assign) int anchorTalkAnchor;

	/**
女性才能认证 0:开启 1:关闭
 */
@property (nonatomic, assign) int authIsSex;

	/**
私聊扣费金额
 */
@property (nonatomic, assign) int privateCoin;

	/**
模拟消息每天发送次数
 */
@property (nonatomic, assign) int analogMessageCount;

	/**
短视频认证限制 0:开启认证 1:关闭认证
 */
@property (nonatomic, assign) int authShortVideo;

	/**
直播限制等级
 */
@property (nonatomic, assign) int levelLimit;

	/**
动态审核开关 0:开 1:关
 */
@property (nonatomic, assign) int dynamicAuditSwitch;

	/**
短视频是否需要审核 0:开启 1:关闭
 */
@property (nonatomic, assign) int isAuthShortVideo;

	/**
是否必须绑定手机号码 0:开启 1:关闭
 */
@property (nonatomic, assign) int isBindPhone;

	/**
注销后，再次注册继承上级关系  1：开启 0：关闭
 */
@property (nonatomic, assign) int logOffInheritSupper;

	/**
邀请赚钱 0:隐藏 1:显示
 */
@property (nonatomic, assign) int showInviteToMakeMoney;

	/**
用户和用户可以私信 0:开启 1:关闭
 */
@property (nonatomic, assign) int userTalkUser;

	/**
幸运礼物计算比例（幸运礼物参与运算的比例）
 */
@property (nonatomic, assign) double luckyGiftPerc;

	/**
主播和用户可以私信 0:开启 1:关闭
 */
@property (nonatomic, assign) int anchorTalkUser;

	/**
虚拟地址显示范围(千米)（结束值）
 */
@property (nonatomic, assign) int showAddressEnd;

	/**
用户和用户发起通话 0:开启 1:关闭
 */
@property (nonatomic, assign) int userToUser;

	/**
普通客服 0:隐藏 1:显示
 */
@property (nonatomic, assign) int showCommonService;

	/**
女性和女性可以私信 0:开启 1:关闭
 */
@property (nonatomic, assign) int femaleTalkFemale;

	/**
女性发私信免费 0:开启 1:关闭
 */
@property (nonatomic, assign) int femaleTalkFree;

	/**
iOS隐藏功能 0：不开启 1：开启
 */
@property (nonatomic, assign) int isFunctionTurnOn;

	/**
私聊扣费提示
 */
@property (nonatomic, copy) NSString * privateChatDeductionTips;

	/**
男用户显示地址 0：显示真实地址 1：显示虚拟地址
 */
@property (nonatomic, assign) int maleUserShowAddress;

	/**
女主播显示地址 0：显示真实地址 1：显示虚拟地址
 */
@property (nonatomic, assign) int femaleAnchorShowAddress;

	/**
隐私协议提示
 */
@property (nonatomic, copy) NSString * xieyiRule;

	/**
禁言时长(分钟)
 */
@property (nonatomic, assign) int shuttime;

	/**
模拟消息 0:开启 1:关闭
 */
@property (nonatomic, assign) int analogMessage;

	/**
模拟消息间隔(秒)
 */
@property (nonatomic, assign) int analogMessageInterval;

	/**
虚拟地址显示范围(千米)（起始值）
 */
@property (nonatomic, assign) int showAddressStart;

	/**
全局飘屏礼物金额
 */
@property (nonatomic, assign) int bidFee;

	/**
男性和男性可以私信 0:开启 1:关闭
 */
@property (nonatomic, assign) int manTalkMan;

 +(NSMutableArray<AdminLiveConfigModel*>*)getFromArr:(NSArray*)list;

 -(NSDictionary*)modelToJSONObject;

 +(NSMutableArray*)modelToJSONArray:(NSMutableArray<AdminLiveConfigModel*>*)list;

 +(AdminLiveConfigModel*)getFromDict:(NSDictionary*)dict;

 +(void)cloneObj:(AdminLiveConfigModel*) source target:(AdminLiveConfigModel*)target;

@end

NS_ASSUME_NONNULL_END
