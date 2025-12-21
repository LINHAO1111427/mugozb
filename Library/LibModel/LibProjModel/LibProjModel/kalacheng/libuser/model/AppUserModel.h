//此代码由 http://code.siwaha.com/ 生成，服务器修改后可重新生成

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN




/**
用户基础信息表
 */
@interface AppUserModel : NSObject 


	/**
当前版本号
 */
@property (nonatomic, copy) NSString * appVersion;

	/**
加入房间隐身 0:不隐身 1:隐身
 */
@property (nonatomic, assign) int joinRoomShow;

	/**
连续签到次数
 */
@property (nonatomic, assign) int signCount;

	/**
用户在线状态 0:离线 1:在线
 */
@property (nonatomic, assign) int onlineStatus;

	/**
用户当前设备信息ID
 */
@property (nonatomic, copy) NSString * deviceId;

	/**
推送平台 1:小米 2:华为 3:vivo 4:oppo 5:苹果 6:极光 7:apns 8:miApns
 */
@property (nonatomic, assign) int pushPlatform;

	/**
用户设置的在线状态 0:在线 1:忙碌 2:离开 3:通话中
 */
@property (nonatomic, assign) int userSetOnlineStatus;

	/**
null
 */
@property (nonatomic, assign) int64_t userid;

	/**
跟随房间类型 1:视频 2:语音
 */
@property (nonatomic, assign) int gsRoomType;

	/**
用户积分
 */
@property (nonatomic, assign) int score;

	/**
是否开启青少年模式 1:开启 2:未开启
 */
@property (nonatomic, assign) int isYouthModel;

	/**
密码
 */
@property (nonatomic, copy) NSString * password;

	/**
手机型号
 */
@property (nonatomic, copy) NSString * phoneModel;

	/**
星座
 */
@property (nonatomic, copy) NSString * constellation;

	/**
省份
 */
@property (nonatomic, copy) NSString * province;

	/**
是否关闭提示音 0:开启 1:关闭
 */
@property (nonatomic, assign) int isTone;

	/**
累计提现映票
 */
@property (nonatomic, assign) double totalCash;

	/**
手机号区域 例如:86
 */
@property (nonatomic, copy) NSString * smsRegion;

	/**
上次抽奖进度
 */
@property (nonatomic, assign) int lastGameNum;

	/**
用户当前的位置信息ID
 */
@property (nonatomic, copy) NSString * ipaddr;

	/**
是否热门显示 1:否 0:是
 */
@property (nonatomic, assign) int ishot;

	/**
视频直播状态:0:未进行直播 1:直播中的主播 2:直播中的观众
 */
@property (nonatomic, assign) int liveStatus;

	/**
房间类型 0:是一般直播 1:是私密直播 2:是收费直播 3:是计时直播 4:贵族房间
 */
@property (nonatomic, assign) int roomType;

	/**
身高（CM）
 */
@property (nonatomic, assign) int height;

	/**
房间号(跟随用)
 */
@property (nonatomic, assign) int64_t gsRoomId;

	/**
僵尸粉比例
 */
@property (nonatomic, assign) double zombieRatio;

	/**
映票总额
 */
@property (nonatomic, assign) double votestotal;

	/**
经度
 */
@property (nonatomic, assign) double lng;

	/**
推送平台对应的id
 */
@property (nonatomic, copy) NSString * pushRegisterId;

	/**
用户等级
 */
@property (nonatomic, assign) int userGrade;

	/**
是否有直播购 0:没有直播购 1:有直播购
 */
@property (nonatomic, assign) int liveFunction;

	/**
微信企业ID
 */
@property (nonatomic, copy) NSString * openid;

	/**
最大僵尸粉数量
 */
@property (nonatomic, assign) int zombieMaxNum;

	/**
是否真人 0:不是 1:是
 */
@property (nonatomic, assign) int iszombiep;

	/**
0:未编辑过 1:编辑过了
 */
@property (nonatomic, assign) int cityEdit;

	/**
所属公会ID
 */
@property (nonatomic, assign) int64_t guildId;

	/**
上次登录时间(连续登录用)
 */
@property (nonatomic,copy) NSDate * lastLoginDay;

	/**
最大连续签到天数
 */
@property (nonatomic, assign) int maxSignCount;

	/**
累计充值金额
 */
@property (nonatomic, assign) double totalCharge;

	/**
财富等级
 */
@property (nonatomic, assign) int wealthGrade;

	/**
离线时间
 */
@property (nonatomic,copy) NSDate * lastOffLineTime;

	/**
海报
 */
@property (nonatomic, copy) NSString * poster;

	/**
用户状态 1:禁用 0:正常
 */
@property (nonatomic, assign) int status;

	/**
角色 0:普通用户 1:主播
 */
@property (nonatomic, assign) int role;

	/**
城市
 */
@property (nonatomic, copy) NSString * city;

	/**
个性签名
 */
@property (nonatomic, copy) NSString * signature;

	/**
首页一对一排序编号(附近使用)
 */
@property (nonatomic, assign) int oooHomePageSortNo;

	/**
连续登录天数
 */
@property (nonatomic, assign) int awardLoginDay;

	/**
删除状态 0:未删除(默认) 1:已删除
 */
@property (nonatomic, assign) int delFlag;

	/**
短视频剩余可观看私密视频次数
 */
@property (nonatomic, assign) int readShortVideoNumber;

	/**
最后登录ip
 */
@property (nonatomic, copy) NSString * lastLoginIp;

	/**
充值隐身 0:不隐身 1:隐身
 */
@property (nonatomic, assign) int chargeShow;

	/**
禁用时间
 */
@property (nonatomic,copy) NSDate * lockTime;

	/**
真实姓名
 */
@property (nonatomic, copy) NSString * nickname;

	/**
登录邮箱
 */
@property (nonatomic, copy) NSString * userEmail;

	/**
一对一直播状态:0:未进行直播 1:通话中 2:邀请他人通话 3:正在被邀请
 */
@property (nonatomic, assign) int oooLiveStatus;

	/**
注册类型
 */
@property (nonatomic, assign) int regType;

	/**
直播频道
 */
@property (nonatomic, assign) int channelId;

	/**
魅力积分
 */
@property (nonatomic, assign) int charmPoint;

	/**
地址
 */
@property (nonatomic, copy) NSString * address;

	/**
盐
 */
@property (nonatomic, copy) NSString * salt;

	/**
性别 0:未设置 1:男 2:女 
 */
@property (nonatomic, assign) int sex;

	/**
手机厂商
 */
@property (nonatomic, copy) NSString * phoneFirm;

	/**
魅力等级
 */
@property (nonatomic, assign) int charmGrade;

	/**
用户头像
 */
@property (nonatomic, copy) NSString * avatar;

	/**
上级经纪人ID，对应AdminUser表
 */
@property (nonatomic, assign) int64_t managerId;

	/**
职业
 */
@property (nonatomic, copy) NSString * vocation;

	/**
上次登录时间
 */
@property (nonatomic,copy) NSDate * lastLoginTime;

	/**
注册时间
 */
@property (nonatomic,copy) NSDate * createTime;

	/**
映票余额/可提现金额
 */
@property (nonatomic, assign) double votes;

	/**
青少年密码
 */
@property (nonatomic, copy) NSString * youthPassword;

	/**
贡献榜排行隐身 0:不隐身 1:隐身
 */
@property (nonatomic, assign) int devoteShow;

	/**
展示声音
 */
@property (nonatomic, copy) NSString * voice;

	/**
是否推荐 0:不推荐 1:推荐中
 */
@property (nonatomic, assign) int isRecommend;

	/**
是否是一对一演示账号 1:是 0:否
 */
@property (nonatomic, assign) int isOOOAccount;

	/**
主播等级
 */
@property (nonatomic, assign) int anchorGrade;

	/**
主播粉丝团群聊id
 */
@property (nonatomic, assign) int64_t groupId;

	/**
直属上级
 */
@property (nonatomic, assign) int64_t pid;

	/**
操作用户名,如禁用操作/解禁操作等
 */
@property (nonatomic, copy) NSString * optUserName;

	/**
注册来源
 */
@property (nonatomic, copy) NSString * source;

	/**
当前版本code
 */
@property (nonatomic, copy) NSString * appVersionCode;

	/**
是否加入极光 0:未加入 1:已加入
 */
@property (nonatomic, assign) int isJoinJg;

	/**
ooo二级分类id
 */
@property (nonatomic, assign) int64_t oooTwoClassifyId;

	/**
全站广播功能 0:关闭功能 1:开启功能
 */
@property (nonatomic, assign) int broadCast;

	/**
累计提现佣金
 */
@property (nonatomic, assign) double totalAmountCash;

	/**
手机系统
 */
@property (nonatomic, copy) NSString * phoneSystem;

	/**
是否开启僵尸粉 1:未开启(默认) 0:已开启
 */
@property (nonatomic, assign) int iszombie;

	/**
直播封面图
 */
@property (nonatomic, copy) NSString * liveThumbs;

	/**
纬度
 */
@property (nonatomic, assign) double lat;

	/**
用户个人网站
 */
@property (nonatomic, copy) NSString * userUrl;

	/**
注册时ip
 */
@property (nonatomic, copy) NSString * registerIp;

	/**
上次签到时间
 */
@property (nonatomic,copy) NSDate * signTime;

	/**
层级
 */
@property (nonatomic, assign) int level;

	/**
是否超管 1:否 0:是
 */
@property (nonatomic, assign) int issuper;

	/**
体重（KG）
 */
@property (nonatomic, assign) double weight;

	/**
隐藏位置 0:未开启 1:开启
 */
@property (nonatomic, assign) int whetherEnablePositioningShow;

	/**
开播随机僵尸粉数量
 */
@property (nonatomic, assign) int openLiveZombieNum;

	/**
是否显示在首页 1:展示在首页 0:不展示在首页
 */
@property (nonatomic, assign) int isShowHomePage;

	/**
总收益佣金
 */
@property (nonatomic, assign) double totalAmount;

	/**
三围
 */
@property (nonatomic, copy) NSString * sanwei;

	/**
被踢到期时间戳
 */
@property (nonatomic, assign) int64_t kickTime;

	/**
多人语音直播状态 0:不在语音房间中 2:上麦标识 3:被邀上麦中 4:被踢下麦 5:下麦标识 6:申请上麦中 8:被踢出房间
 */
@property (nonatomic, assign) int voiceStatus;

	/**
房间类型值
 */
@property (nonatomic, copy) NSString * roomTypeVal;

	/**
苹果voip
 */
@property (nonatomic, copy) NSString * voipToken;

	/**
上级经纪人公会ID，对应AdminUser表。Co=company公司
 */
@property (nonatomic, assign) int64_t managerCoId;

	/**
用户类型 1:-- 2:会员  3：游客
 */
@property (nonatomic, assign) int userType;

	/**
用户是否开通svip 1:是 0:否
 */
@property (nonatomic, assign) int isSvip;

	/**
激活码
 */
@property (nonatomic, copy) NSString * userActivationKey;

	/**
金币 /充值金额
 */
@property (nonatomic, assign) double coin;

	/**
生日
 */
@property (nonatomic, copy) NSString * birthday;

	/**
主播星级id
 */
@property (nonatomic, assign) int64_t starId;

	/**
直属上级代理（后台管理员）
 */
@property (nonatomic, assign) int64_t agentId;

	/**
是否开启消息推送 0:开启 1:关闭
 */
@property (nonatomic, assign) int isPush;

	/**
微信唯一ID
 */
@property (nonatomic, copy) NSString * unionid;

	/**
主播积分
 */
@property (nonatomic, assign) int anchorPoint;

	/**
注册方式 1:手机注册 2:微信注册 3:QQ注册
 */
@property (nonatomic, copy) NSString * loginType;

	/**
视频通话时间金币 /min
 */
@property (nonatomic, assign) double videoCoin;

	/**
封面
 */
@property (nonatomic, copy) NSString * liveThumb;

	/**
展示视频
 */
@property (nonatomic, copy) NSString * video;

	/**
主播是否认证 0:未认证 1:已认证  后台添加主播时,如果是认证状态, 需要添加认证记录
 */
@property (nonatomic, assign) int isAnchorAuth;

	/**
语音通话时间金币 /min
 */
@property (nonatomic, assign) double voiceCoin;

	/**
是否自动填充主播分成比例  0:自动  1:人工调整
 */
@property (nonatomic, assign) int isAutomatic;

	/**
剩余佣金/可提现佣金
 */
@property (nonatomic, assign) double amount;

	/**
手机唯一标识
 */
@property (nonatomic, copy) NSString * phoneUuid;

	/**
用户积分
 */
@property (nonatomic, assign) int userPoint;

	/**
隐藏距离 0:不隐藏 1:隐藏
 */
@property (nonatomic, assign) int hideDistance;

	/**
手机号
 */
@property (nonatomic, copy) NSString * mobile;

	/**
修改密码时间
 */
@property (nonatomic,copy) NSDate * updatePwdTime;

	/**
展示视频封面
 */
@property (nonatomic, copy) NSString * videoImg;

	/**
微信号
 */
@property (nonatomic, copy) NSString * wechat;

	/**
消费总额(财富积分)
 */
@property (nonatomic, assign) double consumption;

	/**
是否是多人直播演示账号 1:多人视频直播演示账号 2:多人语音直播演示账号 0:否
 */
@property (nonatomic, assign) int isLiveAccount;

	/**
用户资料图片,英文逗号隔开
 */
@property (nonatomic, copy) NSString * portrait;

	/**
分成方案
 */
@property (nonatomic, assign) int64_t dealScalePlan;

	/**
禁用原因
 */
@property (nonatomic, copy) NSString * lockReason;

	/**
礼物全局广播 0:关闭 1:开启
 */
@property (nonatomic, assign) int giftGlobalBroadcast;

	/**
ooo导航分类关联app_live_channel表
 */
@property (nonatomic, assign) int64_t headNo;

	/**
是否开起回放 1:未开启 0:已开启
 */
@property (nonatomic, assign) int isrecord;

	/**
邀请码
 */
@property (nonatomic, copy) NSString * inviteCode;

	/**
是否开启勿扰 0:未开启 1:开启
 */
@property (nonatomic, assign) int isNotDisturb;

	/**
贵族等级
 */
@property (nonatomic, assign) int nobleGrade;

	/**
房间标题
 */
@property (nonatomic, copy) NSString * roomTitle;

	/**
当前装备靓号
 */
@property (nonatomic, copy) NSString * goodnum;

	/**
用户名
 */
@property (nonatomic, copy) NSString * username;

 +(NSMutableArray<AppUserModel*>*)getFromArr:(NSArray*)list;

 -(NSDictionary*)modelToJSONObject;

 +(NSMutableArray*)modelToJSONArray:(NSMutableArray<AppUserModel*>*)list;

 +(AppUserModel*)getFromDict:(NSDictionary*)dict;

 +(void)cloneObj:(AppUserModel*) source target:(AppUserModel*)target;

@end

NS_ASSUME_NONNULL_END
