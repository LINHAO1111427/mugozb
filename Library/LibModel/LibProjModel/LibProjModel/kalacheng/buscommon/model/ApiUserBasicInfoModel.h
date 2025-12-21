//此代码由 http://code.siwaha.com/ 生成，服务器修改后可重新生成

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN




/**
用户简要信息
 */
@interface ApiUserBasicInfoModel : NSObject 


	/**
角色 0:普通用户 1:主播
 */
@property (nonatomic, assign) int role;

	/**
签名
 */
@property (nonatomic, copy) NSString * signature;

	/**
加入房间隐身 0:不隐身 1:隐身
 */
@property (nonatomic, assign) int joinRoomShow;

	/**
用户等级图片
 */
@property (nonatomic, copy) NSString * userGradeImg;

	/**
直播封面
 */
@property (nonatomic, copy) NSString * liveThumb;

	/**
贵族名称
 */
@property (nonatomic, copy) NSString * nobleName;

	/**
被禁麦(麦克风) 0: 可以发言(默认) 1:被禁止发言
 */
@property (nonatomic, assign) int noTalking;

	/**
直播间 PK过程中 的魅力值
 */
@property (nonatomic, assign) double roomPKVotes;

	/**
贵族等级图片
 */
@property (nonatomic, copy) NSString * nobleGradeImg;

	/**
用户id
 */
@property (nonatomic, assign) int64_t uid;

	/**
是否在麦位上 1:在 0：不在
 */
@property (nonatomic, assign) int isInAssistant;

	/**
房间中的角色 1:主播 2:管理员 3:普通用户
 */
@property (nonatomic, assign) int roomRole;

	/**
财富等级图片
 */
@property (nonatomic, copy) NSString * wealthGradeImg;

	/**
性别 0:保密 1：男 2:女
 */
@property (nonatomic, assign) int sex;

	/**
是否僵尸粉 1:真实用户 0:僵尸粉
 */
@property (nonatomic, assign) int iszombiep;

	/**
头像
 */
@property (nonatomic, copy) NSString * avatar;

	/**
当前房间主播id
 */
@property (nonatomic, assign) int64_t anchorId;

	/**
用户对当前直播间总贡献值
 */
@property (nonatomic, assign) double currContValue;

	/**
贵族头像框
 */
@property (nonatomic, copy) NSString * nobleAvatarFrame;

	/**
播流地址
 */
@property (nonatomic, copy) NSString * pull;

	/**
PK过程的ID
 */
@property (nonatomic, assign) int64_t roomPkSid;

	/**
直播间魅力值
 */
@property (nonatomic, assign) double roomVotes;

	/**
主播等级图片
 */
@property (nonatomic, copy) NSString * anchorGradeImg;

	/**
麦克风状态 0: 关闭 1:开启
 */
@property (nonatomic, assign) int hostVolumed;

	/**
是否在房间中 1:在房间中 0:离开房间
 */
@property (nonatomic, assign) int isInTheRoom;

	/**
当前房间主持人id
 */
@property (nonatomic, assign) int64_t presenterUserId;

	/**
贵族等级
 */
@property (nonatomic, assign) int nobleGrade;

	/**
年龄
 */
@property (nonatomic, assign) int age;

	/**
用户名称
 */
@property (nonatomic, copy) NSString * username;

 +(NSMutableArray<ApiUserBasicInfoModel*>*)getFromArr:(NSArray*)list;

 -(NSDictionary*)modelToJSONObject;

 +(NSMutableArray*)modelToJSONArray:(NSMutableArray<ApiUserBasicInfoModel*>*)list;

 +(ApiUserBasicInfoModel*)getFromDict:(NSDictionary*)dict;

 +(void)cloneObj:(ApiUserBasicInfoModel*) source target:(ApiUserBasicInfoModel*)target;

@end

NS_ASSUME_NONNULL_END
