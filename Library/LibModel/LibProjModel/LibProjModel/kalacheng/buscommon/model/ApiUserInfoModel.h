//此代码由 http://code.siwaha.com/ 生成，服务器修改后可重新生成

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN




/**
APP登录接口返回值
 */
@interface ApiUserInfoModel : NSObject 


	/**
主播等级
 */
@property (nonatomic, assign) int anchorGrade;

	/**
与他人链接的状态（互动状态）0：未链接 1：申请连麦 2：被邀请连麦 3：连麦进行中 11：邀请他人互动 12：被邀请互动 13：互动进行中 21：邀请他人PK 22：被邀请PK 23：PK中
 */
@property (nonatomic, assign) int linkOtherStatus;

	/**
加入房间隐身 0:不隐身 1:隐身
 */
@property (nonatomic, assign) int joinRoomShow;

	/**
群id
 */
@property (nonatomic, assign) int64_t groupId;

	/**
用户真实在线状态 0:离线 1:在线
 */
@property (nonatomic, assign) int onlineStatus;

	/**
贵族名称
 */
@property (nonatomic, copy) NSString * nobleName;

	/**
被禁麦(麦克风) 0: 可以发言(默认) 1:被禁止发言
 */
@property (nonatomic, assign) int noTalking;

	/**
pid
 */
@property (nonatomic, assign) int64_t pid;

	/**
贵族等级图片
 */
@property (nonatomic, copy) NSString * nobleGradeImg;

	/**
用户设置的在线状态 0:在线 1:忙碌 2:离开 3:通话中
 */
@property (nonatomic, assign) int userSetOnlineStatus;

	/**
直播房间号
 */
@property (nonatomic, assign) int64_t roomId;

	/**
ooo二级分类id
 */
@property (nonatomic, assign) int64_t oooTwoClassifyId;

	/**
对方Uid 包括：连麦/互动/PK
 */
@property (nonatomic, assign) int64_t otherUid;

	/**
全站广播功能 0:关闭功能 1:开启功能
 */
@property (nonatomic, assign) int broadCast;

	/**
是否开启青少年模式 1:开启 2:未开启
 */
@property (nonatomic, assign) int isYouthModel;

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
是否开启僵尸粉 1:未开启(默认) 0:已开启
 */
@property (nonatomic, assign) int iszombie;

	/**
是否显示首充 1:不显示 0:显示
 */
@property (nonatomic, assign) int isFirstRecharge;

	/**
0:直播 1:是演示视频的直播
 */
@property (nonatomic, assign) int roomIsVideo;

	/**
纬度
 */
@property (nonatomic, assign) double lat;

	/**
直播状态 0:未进行直播 1:直播主播 2:直播观众
 */
@property (nonatomic, assign) int liveStatus;

	/**
房间类型 0:普通房间 1:密码房间 2:门票房间 3:计时房间 4:贵族房间
 */
@property (nonatomic, assign) int roomType;

	/**
身高
 */
@property (nonatomic, assign) int height;

	/**
是否允许连麦 0:关 1:开
 */
@property (nonatomic, assign) int canLinkMic;

	/**
房间号(跟随用)
 */
@property (nonatomic, assign) int64_t gsRoomId;

	/**
经度
 */
@property (nonatomic, assign) double lng;

	/**
用户等级
 */
@property (nonatomic, assign) int userGrade;

	/**
是否真人 0:不是 1:是
 */
@property (nonatomic, assign) int iszombiep;

	/**
体重
 */
@property (nonatomic, assign) double weight;

	/**
隐藏位置 0:未开启 1:开启
 */
@property (nonatomic, assign) int whetherEnablePositioningShow;

	/**
PK过程的ID
 */
@property (nonatomic, assign) int64_t roomPkSid;

	/**
主播等级图片
 */
@property (nonatomic, copy) NSString * anchorGradeImg;

	/**
三围
 */
@property (nonatomic, copy) NSString * sanwei;

	/**
多人语音直播状态 0:不在语音房间中 2:上麦标识 3:被邀上麦中 4:被踢下麦 5:下麦标识 6:申请上麦中 8:被踢出房间
 */
@property (nonatomic, assign) int voiceStatus;

	/**
财富等级
 */
@property (nonatomic, assign) int wealthGrade;

	/**
离线时间
 */
@property (nonatomic,copy) NSDate * lastOffLineTime;

	/**
上级经纪人公会ID，对应AdminUser表。Co=company公司
 */
@property (nonatomic, assign) int64_t managerCoId;

	/**
用户类型 1:admin 2:会员  3：游客
 */
@property (nonatomic, assign) int userType;

	/**
是否开通SVIP服务 1:是 0:否
 */
@property (nonatomic, assign) int isSvip;

	/**
海报
 */
@property (nonatomic, copy) NSString * poster;

	/**
金币/充值金额 
 */
@property (nonatomic, assign) double coin;

	/**
用户状态 1:禁用 0:解禁
 */
@property (nonatomic, assign) int status;

	/**
生日
 */
@property (nonatomic, copy) NSString * birthday;

	/**
直属上级代理（后台管理员）
 */
@property (nonatomic, assign) int64_t agentId;

	/**
是否开启消息推送 0:开启 1:关闭
 */
@property (nonatomic, assign) int isPush;

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
直播类型 0:没有直播,无类型 1:视频直播  2:语音直播
 */
@property (nonatomic, assign) int liveType;

	/**
用户等级图片
 */
@property (nonatomic, copy) NSString * userGradeImg;

	/**
视频通话费用
 */
@property (nonatomic, assign) double videoCoin;

	/**
直播封面
 */
@property (nonatomic, copy) NSString * liveThumb;

	/**
贵族勋章
 */
@property (nonatomic, copy) NSString * nobleMedal;

	/**
与他人链接的会话ID（互动会话ID）
 */
@property (nonatomic, assign) int64_t linkOtherSid;

	/**
短视频剩余可观看私密视频次数
 */
@property (nonatomic, assign) int readShortVideoNumber;

	/**
直播房间标识
 */
@property (nonatomic, copy) NSString * showId;

	/**
充值隐身 0:不隐身 1:隐身
 */
@property (nonatomic, assign) int chargeShow;

	/**
主播是否认证 0:未认证 1:已认证  后台添加主播时,如果是认证状态, 需要添加认证记录
 */
@property (nonatomic, assign) int isAnchorAuth;

	/**
语音通话费用
 */
@property (nonatomic, assign) double voiceCoin;

	/**
一对一直播状态 0:未进行直播 1:通话中 2:邀请他人通话 3:正在被邀请
 */
@property (nonatomic, assign) int oooLiveStatus;

	/**
魅力积分
 */
@property (nonatomic, assign) int charmPoint;

	/**
对方直播房间号
 */
@property (nonatomic, assign) int64_t otherRoomId;

	/**
财富等级图片
 */
@property (nonatomic, copy) NSString * wealthGradeImg;

	/**
地址
 */
@property (nonatomic, copy) NSString * address;

	/**
隐藏距离 0:不隐藏 1:隐藏
 */
@property (nonatomic, assign) int hideDistance;

	/**
魅力等级图片
 */
@property (nonatomic, copy) NSString * charmGradeImg;

	/**
性别 1:男 2:女
 */
@property (nonatomic, assign) int sex;

	/**
手机号，以后要删掉的
 */
@property (nonatomic, copy) NSString * mobile;

	/**
魅力等级
 */
@property (nonatomic, assign) int charmGrade;

	/**
消费总额（财富积分）
 */
@property (nonatomic, assign) double consumption;

	/**
头像
 */
@property (nonatomic, copy) NSString * avatar;

	/**
上级经纪人ID，对应AdminUser表
 */
@property (nonatomic, assign) int64_t managerId;

	/**
手机号长度
 */
@property (nonatomic, assign) int mobileLength;

	/**
用户ID
 */
@property (nonatomic, assign) int64_t userId;

	/**
礼物全局广播 0:关闭 1:开启
 */
@property (nonatomic, assign) int giftGlobalBroadcast;

	/**
职业
 */
@property (nonatomic, copy) NSString * vocation;

	/**
贵族头像框
 */
@property (nonatomic, copy) NSString * nobleAvatarFrame;

	/**
注册时间
 */
@property (nonatomic, copy) NSString * createTime;

	/**
ooo导航分类关联app_live_channel表
 */
@property (nonatomic, assign) int64_t headNo;

	/**
映票余额/可提现金额
 */
@property (nonatomic, assign) double votes;

	/**
是否开启勿扰 0:未开启 1:开启
 */
@property (nonatomic, assign) int isNotDisturb;

	/**
贵族等级
 */
@property (nonatomic, assign) int nobleGrade;

	/**
是否绑定上级 1：未绑定 2：已绑定
 */
@property (nonatomic, assign) int isPid;

	/**
年龄
 */
@property (nonatomic, assign) int age;

	/**
靓号
 */
@property (nonatomic, copy) NSString * goodnum;

	/**
贡献榜排行隐身 0:不隐身 1:隐身
 */
@property (nonatomic, assign) int devoteShow;

	/**
昵称
 */
@property (nonatomic, copy) NSString * username;

 +(NSMutableArray<ApiUserInfoModel*>*)getFromArr:(NSArray*)list;

 -(NSDictionary*)modelToJSONObject;

 +(NSMutableArray*)modelToJSONArray:(NSMutableArray<ApiUserInfoModel*>*)list;

 +(ApiUserInfoModel*)getFromDict:(NSDictionary*)dict;

 +(void)cloneObj:(ApiUserInfoModel*) source target:(ApiUserInfoModel*)target;

@end

NS_ASSUME_NONNULL_END
