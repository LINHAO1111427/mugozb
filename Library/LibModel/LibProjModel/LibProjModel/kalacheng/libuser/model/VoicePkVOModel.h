//此代码由 http://code.siwaha.com/ 生成，服务器修改后可重新生成

#import <Foundation/Foundation.h>

 @class PkGiftSenderModel;
 @class AppStrickerVOModel;
 @class PkUserVoiceAssistanModel;
 @class ApiPkResultRoomModel;
NS_ASSUME_NONNULL_BEGIN




/**
语音直播间PK信息
 */
@interface VoicePkVOModel : NSObject 


	/**
对方直播间房主ID
 */
@property (nonatomic, assign) int64_t otherAnchorId;

	/**
对方房间showid
 */
@property (nonatomic, copy) NSString * otherShowId;

	/**
对方直播间总的PK礼物值 (房间PK时是右队)
 */
@property (nonatomic, assign) double otherTotalVotes;

	/**
当前主持人年龄
 */
@property (nonatomic, assign) int thisAge;

	/**
对方主持人性别
 */
@property (nonatomic, assign) int otherSex;

	/**
对面主持人礼物值 （房间PK时为右队）
 */
@property (nonatomic, assign) double otherAnchorVotes;

	/**
当前PK房间送礼排行榜 （房间PK时为左队的排行榜）
 */
@property (nonatomic, strong) NSMutableArray<PkGiftSenderModel*>* thisSenders;

	/**
对手Pk房间送礼排行榜 （房间PK时为右队的排行榜）
 */
@property (nonatomic, strong) NSMutableArray<PkGiftSenderModel*>* otherSenders;

	/**
PK开始倒计时时长 单位秒
 */
@property (nonatomic, assign) int64_t pkCountdownMillis;

	/**
当前主持人,等级对应的头像框 =
 */
@property (nonatomic, copy) NSString * thisAvatarFrame;

	/**
表情包
 */
@property (strong, nonatomic) AppStrickerVOModel* appStrickerVO;

	/**
对方表情包
 */
@property (strong, nonatomic) AppStrickerVOModel* otherAppStrickerVO;

	/**
当前房主ID
 */
@property (nonatomic, assign) int64_t thisAnchorId;

	/**
当前总的PK礼物值 (房间PK时是左队)
 */
@property (nonatomic, assign) double totalVotes;

	/**
当前房间showid
 */
@property (nonatomic, copy) NSString * thisShowId;

	/**
当前主持人用户名
 */
@property (nonatomic, copy) NSString * thisUsername;

	/**
本房间麦位副播 (房间PK时为左边麦位 )
 */
@property (nonatomic, strong) NSMutableArray<PkUserVoiceAssistanModel*>* thisAssistans;

	/**
PK发起时主播麦克风  1开启 0关闭 默认开启 
 */
@property (nonatomic, assign) int hostVolumn;

	/**
pk进行状态 1:匹配成功通知主播环节 2:倒计时环节 3:正式PK环节 4:PK结果展示环节 5:PK结束
 */
@property (nonatomic, assign) int pkProcess;

	/**
当前主持人性别
 */
@property (nonatomic, assign) int thisSex;

	/**
对方房间副播麦位集合 (房间PK时为右边麦位 )
 */
@property (nonatomic, strong) NSMutableArray<PkUserVoiceAssistanModel*>* otherAssistans;

	/**
当前主持人头像
 */
@property (nonatomic, copy) NSString * thisAvatar;

	/**
当前主持人礼物值 （房间PK时为左队）
 */
@property (nonatomic, assign) double anchorVotes;

	/**
当前Pk进行状态的截止时刻
 */
@property (nonatomic, assign) int64_t processEndMills;

	/**
当前主持人ID
 */
@property (nonatomic, assign) int64_t thisPresenterUserId;

	/**
对方主持人用户名
 */
@property (nonatomic, copy) NSString * otherUsername;

	/**
对方主持人,等级对应的头像框 =
 */
@property (nonatomic, copy) NSString * otherAvatarFrame;

	/**
当前房间ID
 */
@property (nonatomic, assign) int64_t thisRoomID;

	/**
PK发起时对手主播麦克风  1开启 0关闭 默认开启 
 */
@property (nonatomic, assign) int otherHostVolumn;

	/**
对方主持人ID
 */
@property (nonatomic, assign) int64_t otherPresenterUserId;

	/**
PK结果信息 0:不在PK中 1:匹配成功通知主播环节 2:倒计时环节 3:正式PK环节 4:PK结果展示环节 5:PK结束
 */
@property (strong, nonatomic) ApiPkResultRoomModel* pkResultRoom;

	/**
当前Pk进行状态的结束时长 单位：秒
 */
@property (nonatomic, assign) int64_t processEndTime;

	/**
pk随机主题
 */
@property (nonatomic, copy) NSString * rdTitle;

	/**
对方主持人的头像
 */
@property (nonatomic, copy) NSString * otherAvatar;

	/**
PK时长 单位秒
 */
@property (nonatomic, assign) int64_t pkMillis;

	/**
对方主持人年龄
 */
@property (nonatomic, assign) int otherAge;

	/**
对方房间ID
 */
@property (nonatomic, assign) int64_t otherRoomID;

	/**
pk类型 1:房间PK 2:单人PK 3:激情团战
 */
@property (nonatomic, assign) int pkType;

 +(NSMutableArray<VoicePkVOModel*>*)getFromArr:(NSArray*)list;

 -(NSDictionary*)modelToJSONObject;

 +(NSMutableArray*)modelToJSONArray:(NSMutableArray<VoicePkVOModel*>*)list;

 +(VoicePkVOModel*)getFromDict:(NSDictionary*)dict;

 +(void)cloneObj:(VoicePkVOModel*) source target:(VoicePkVOModel*)target;

@end

NS_ASSUME_NONNULL_END
