//此代码由 http://code.siwaha.com/ 生成，服务器修改后可重新生成

#import <Foundation/Foundation.h>

 @class VoicePkVOModel;
 @class OneRedPacketVOModel;
 @class ApiUserBasicInfoModel;
 @class ApiUsersVoiceAssistanModel;
 @class AppShareConfigModel;
NS_ASSUME_NONNULL_BEGIN




/**
APP加入直播响应
 */
@interface AppJoinRoomVOModel : NSObject 


	/**
对方封面图
 */
@property (nonatomic, copy) NSString * otherLiveThumb;

	/**
坐骑名称
 */
@property (nonatomic, copy) NSString * carName;

	/**
多人语音PK相关信息
 */
@property (strong, nonatomic) VoicePkVOModel* voicePkVO;

	/**
PK时当前直播间血条值
 */
@property (nonatomic, assign) int currVotesPk;

	/**
观看人数
 */
@property (nonatomic, assign) int watchNumber;

	/**
当前用户贵族名称
 */
@property (nonatomic, copy) NSString * nobleName;

	/**
主播年龄
 */
@property (nonatomic, assign) int anchorAge;

	/**
房间试看时间(秒),0标识没有限制
 */
@property (nonatomic, assign) int freeWatchTime;

	/**
当前用户贵族等级图标
 */
@property (nonatomic, copy) NSString * nobleGradeImg;

	/**
房间红包集合
 */
@property (strong, nonatomic) OneRedPacketVOModel* oneRedPacketVO;

	/**
房间号
 */
@property (nonatomic, assign) int64_t roomId;

	/**
守护类型 1:普通守护 2:尊贵守护
 */
@property (nonatomic, assign) int guardUsersType;

	/**
主播贵族等级图标
 */
@property (nonatomic, copy) NSString * anchorNobleGradeImg;

	/**
直播间观众列表
 */
@property (nonatomic, strong) NSMutableArray<ApiUserBasicInfoModel*>* userList;

	/**
直播状态 1:正常直播 2:连麦 3:互动 4:pk
 */
@property (nonatomic, assign) int liveStatus;

	/**
房间模式 0:普通房间 1:私密房间 2:收费房间 3:计时房间 4:贵族房间
 */
@property (nonatomic, assign) int roomType;

	/**
当前房间总魅力值
 */
@property (nonatomic, assign) double roomTotalVotes;

	/**
连麦状态 1:开 0:关
 */
@property (nonatomic, assign) int ismic;

	/**
pk进行状态(视频才有效，且一般只有 3，4) 1:匹配成功通知主播环节 2:倒计时环节 3:正式PK环节 4:PK结果展示环节 5:PK结束
 */
@property (nonatomic, assign) int pkProcess;

	/**
主播贵族勋章
 */
@property (nonatomic, copy) NSString * anchorNobleMedal;

	/**
直播间推送警告内容
 */
@property (nonatomic, copy) NSString * noticeMsg;

	/**
是否有直播购 0:没有直播购 1:有直播购
 */
@property (nonatomic, assign) int liveFunction;

	/**
主播贵族头像框
 */
@property (nonatomic, copy) NSString * anchorNobleAvatarFrame;

	/**
是否是粉丝团成员 0:否 1:是
 */
@property (nonatomic, assign) int isFans;

	/**
房间模式名称
 */
@property (nonatomic, copy) NSString * roomTypeName;

	/**
PK时对方直播间血条值
 */
@property (nonatomic, assign) int fromVotesPk;

	/**
主播id
 */
@property (nonatomic, assign) int64_t anchorId;

	/**
是否守护 1:是 0:否
 */
@property (nonatomic, assign) int isSh;

	/**
pk是否胜利（pkProcess = 4 时有效） 1：我方赢了 0：平局 -1：我方输了
 */
@property (nonatomic, assign) int isWin;

	/**
主播开关麦状态 0:关麦 1:开麦(音量)
 */
@property (nonatomic, assign) int onOffState;

	/**
当前用户主播等级图标
 */
@property (nonatomic, copy) NSString * anchorGradeImg;

	/**
资源类型：0视频一般直播，1视频私密直播，2视频收费直播，3视频计时直播 4语音普通直播，5语音私密直播 6 one2one语音 7one2one视频 8文字动态 9视频动态 10图片动态11多人直播贵族房间12语音计时13语音付费14语音贵族
 */
@property (nonatomic, assign) int sourceType;

	/**
房间模式对应的值 密码房间：密码  收费房间：收费金额
 */
@property (nonatomic, copy) NSString * roomTypeVal;

	/**
守护人数
 */
@property (nonatomic, assign) int guardNumber;

	/**
是否有贵族弹幕特权 0:没有 1:有
 */
@property (nonatomic, assign) int gzdmPrivilege;

	/**
PK时剩余时间
 */
@property (nonatomic, assign) int pkTime;

	/**
角色 1:普通用户 2:管理员 3:主播
 */
@property (nonatomic, assign) int role;

	/**
当前用户财富等级图标
 */
@property (nonatomic, copy) NSString * anchorWealthGradeImg;

	/**
直播类型 1:视频 2:语音 3:1v1 4:电台 5:派对 6:短视频 7:动态
 */
@property (nonatomic, assign) int liveType;

	/**
用户头像
 */
@property (nonatomic, copy) NSString * userAvatar;

	/**
当前用户等级图标
 */
@property (nonatomic, copy) NSString * userGradeImg;

	/**
坐骑静态图
 */
@property (nonatomic, copy) NSString * carThumb;

	/**
封面图
 */
@property (nonatomic, copy) NSString * liveThumb;

	/**
当前用户贵族勋章
 */
@property (nonatomic, copy) NSString * nobleMedal;

	/**
标题
 */
@property (nonatomic, copy) NSString * title;

	/**
主播名称
 */
@property (nonatomic, copy) NSString * anchorName;

	/**
推送内容
 */
@property (nonatomic, copy) NSString * content;

	/**
语音直播间背景
 */
@property (nonatomic, copy) NSString * voiceThumb;

	/**
直播横幅
 */
@property (nonatomic, copy) NSString * shopLiveBanner;

	/**
对方房间类型
 */
@property (nonatomic, assign) int otherRoomType;

	/**
主播靓号
 */
@property (nonatomic, copy) NSString * anchorGoodNum;

	/**
语音直播间麦位列表
 */
@property (nonatomic, strong) NSMutableArray<ApiUsersVoiceAssistanModel*>* assistanList;

	/**
分享配置信息
 */
@property (strong, nonatomic) AppShareConfigModel* share;

	/**
开播时间
 */
@property (nonatomic, assign) int64_t startTime;
 
	/**
频道id
 */
@property (nonatomic, assign) int64_t channelId;

	/**
对方房间号
 */
@property (nonatomic, assign) int64_t otherRoomId;

	/**
公告
 */
@property (nonatomic, copy) NSString * notice;

	/**
当前用户财富等级图标
 */
@property (nonatomic, copy) NSString * wealthGradeImg;

	/**
主播头像
 */
@property (nonatomic, copy) NSString * anchorAvatar;

	/**
用户靓号
 */
@property (nonatomic, copy) NSString * userGoodNum;

	/**
当前用户名称
 */
@property (nonatomic, copy) NSString * userName;

	/**
当前主持人信息
 */
@property (strong, nonatomic) ApiUsersVoiceAssistanModel* presenterAssistant;

	/**
房间锁 1:上锁了 0:未上锁
 */
@property (nonatomic, assign) int liveLockStatus;

	/**
主播性别 0：保密 1：男 2：女
 */
@property (nonatomic, assign) int anchorSex;

	/**
是否关注 1:关注 0:未关注
 */
@property (nonatomic, assign) int isFollow;

	/**
当前用户贵族头像框
 */
@property (nonatomic, copy) NSString * nobleAvatarFrame;

	/**
拉流地址
 */
@property (nonatomic, copy) NSString * pull;

	/**
直播间标识
 */
@property (nonatomic, copy) NSString * showid;

	/**
坐骑动态图
 */
@property (nonatomic, copy) NSString * carSwf;

	/**
对方拉流地址
 */
@property (nonatomic, copy) NSString * otherPull;

	/**
当前主播魅力值
 */
@property (nonatomic, assign) double votes;

	/**
当前用户的贵族等级
 */
@property (nonatomic, assign) int nobleGrade;

	/**
坐骑动态图时长
 */
@property (nonatomic, copy) NSString * carSwftime;

	/**
0:没有在PK 1:房间Pk 2:单人Pk 3:激情团战
 */
@property (nonatomic, assign) int pkType;

 +(NSMutableArray<AppJoinRoomVOModel*>*)getFromArr:(NSArray*)list;

 -(NSDictionary*)modelToJSONObject;

 +(NSMutableArray*)modelToJSONArray:(NSMutableArray<AppJoinRoomVOModel*>*)list;

 +(AppJoinRoomVOModel*)getFromDict:(NSDictionary*)dict;

 +(void)cloneObj:(AppJoinRoomVOModel*) source target:(AppJoinRoomVOModel*)target;

@end

NS_ASSUME_NONNULL_END
