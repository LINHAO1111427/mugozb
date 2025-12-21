//此代码由 http://code.siwaha.com/ 生成，服务器修改后可重新生成

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN




/**
邀请用户响应
 */
@interface OOOInviteRetModel : NSObject 


	/**
(对方)用户状态 0:离线 1:忙碌 2:在线 3:通话中 4:看直播 5:匹配中 6:直播中 7:离开
 */
@property (nonatomic, assign) int userStatus;

	/**
(对方)封面图
 */
@property (nonatomic, copy) NSString * thumb;

	/**
(付费方)用户ID
 */
@property (nonatomic, assign) int64_t feeUid;

	/**
主播粉丝团群聊id
 */
@property (nonatomic, assign) int64_t groupId;

	/**
(对方)性别
 */
@property (nonatomic, assign) int sex;

	/**
(对方)用户头像
 */
@property (nonatomic, copy) NSString * userAvatar;

	/**
(对方)展示视频封面
 */
@property (nonatomic, copy) NSString * videoImg;

	/**
等待用户超时的毫秒数
 */
@property (nonatomic, assign) int64_t inviteTimeOutMilliSecond;

	/**
0:语音 1:视频
 */
@property (nonatomic, assign) int isVideo;

	/**
会话ID
 */
@property (nonatomic, assign) int64_t sessionId;

	/**
(对方)用户名称
 */
@property (nonatomic, copy) NSString * userName;

	/**
(对方)用户id
 */
@property (nonatomic, assign) int64_t userId;

	/**
(受益方)通话每分钟费用
 */
@property (nonatomic, assign) double oooFee;

	/**
(付费方)金币数量
 */
@property (nonatomic, assign) double feeCoin;

	/**
(主持人)用户ID
 */
@property (nonatomic, assign) int64_t hostUid;

	/**
(对方)视频地址
 */
@property (nonatomic, copy) NSString * videoUrl;

	/**
(付费方)免费通话时长
 */
@property (nonatomic, assign) int freeCallDuration;

	/**
(对方)贵族等级
 */
@property (nonatomic, assign) int nobleGrade;

	/**
是否付费 0:不付费 1:付费
 */
@property (nonatomic, assign) int whetherToPay;

 +(NSMutableArray<OOOInviteRetModel*>*)getFromArr:(NSArray*)list;

 -(NSDictionary*)modelToJSONObject;

 +(NSMutableArray*)modelToJSONArray:(NSMutableArray<OOOInviteRetModel*>*)list;

 +(OOOInviteRetModel*)getFromDict:(NSDictionary*)dict;

 +(void)cloneObj:(OOOInviteRetModel*) source target:(OOOInviteRetModel*)target;

@end

NS_ASSUME_NONNULL_END
