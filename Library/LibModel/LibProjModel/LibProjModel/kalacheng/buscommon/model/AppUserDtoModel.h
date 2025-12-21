//此代码由 http://code.siwaha.com/ 生成，服务器修改后可重新生成

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN




/**
用户信息 增添了用户等级图标，主播等级图标，贵族等级图标 
 */
@interface AppUserDtoModel : NSObject 


	/**
贵族等级名称
 */
@property (nonatomic, copy) NSString * nobleGradeName;

	/**
直属上级代理（后台管理员）
 */
@property (nonatomic, assign) int64_t agentId;

	/**
是否是一对一演示账号 1:是 0:否
 */
@property (nonatomic, assign) int isOOOAccount;

	/**
主播等级
 */
@property (nonatomic, assign) int anchorGrade;

	/**
角色类型
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
主播粉丝团群聊id
 */
@property (nonatomic, assign) int64_t groupId;

	/**
用户等级图标
 */
@property (nonatomic, copy) NSString * userGradeImg;

	/**
直属上级
 */
@property (nonatomic, assign) int64_t pid;

	/**
短视频剩余可观看私密视频次数
 */
@property (nonatomic, assign) int readShortVideoNumber;

	/**
是否加入极光 0:未加入 1:已加入
 */
@property (nonatomic, assign) int isJoinJg;

	/**
贵族等级图标
 */
@property (nonatomic, copy) NSString * nobleGradeImg;

	/**
角色id
 */
@property (nonatomic, assign) int64_t userid;

	/**
累计提现佣金
 */
@property (nonatomic, assign) double totalAmountCash;

	/**
注册类型
 */
@property (nonatomic, assign) int regType;

	/**
财富等级图标
 */
@property (nonatomic, copy) NSString * wealthGradeImg;

	/**
剩余佣金/可提现佣金
 */
@property (nonatomic, assign) double amount;

	/**
映票总额
 */
@property (nonatomic, assign) double votestotal;

	/**
用户等级
 */
@property (nonatomic, assign) int userGrade;

	/**
性别
 */
@property (nonatomic, assign) int sex;

	/**
用户头像
 */
@property (nonatomic, copy) NSString * avatar;

	/**
经纪人ID
 */
@property (nonatomic, assign) int64_t managerId;

	/**
所属公会ID
 */
@property (nonatomic, assign) int64_t guildId;

	/**
贵族头像框
 */
@property (nonatomic, copy) NSString * nobleAvatarFrame;

	/**
总收益佣金
 */
@property (nonatomic, assign) double totalAmount;

	/**
主播等级图标
 */
@property (nonatomic, copy) NSString * anchorGradeImg;

	/**
累计充值金额
 */
@property (nonatomic, assign) double totalCharge;

	/**
财富等级
 */
@property (nonatomic, assign) int wealthGrade;

	/**
邀请码
 */
@property (nonatomic, copy) NSString * inviteCode;

	/**
映票余额/可提现金额
 */
@property (nonatomic, assign) double votes;

	/**
经纪人公会ID
 */
@property (nonatomic, assign) int64_t managerCoId;

	/**
贵族等级
 */
@property (nonatomic, assign) int nobleGrade;

	/**
是否开通SVIP服务 1:是 0:否
 */
@property (nonatomic, assign) int isSvip;

	/**
用户年龄
 */
@property (nonatomic, assign) int age;

	/**
当前装备靓号
 */
@property (nonatomic, copy) NSString * goodnum;

	/**
用户的余额
 */
@property (nonatomic, assign) double coin;

	/**
用户名
 */
@property (nonatomic, copy) NSString * username;

 +(NSMutableArray<AppUserDtoModel*>*)getFromArr:(NSArray*)list;

 -(NSDictionary*)modelToJSONObject;

 +(NSMutableArray*)modelToJSONArray:(NSMutableArray<AppUserDtoModel*>*)list;

 +(AppUserDtoModel*)getFromDict:(NSDictionary*)dict;

 +(void)cloneObj:(AppUserDtoModel*) source target:(AppUserDtoModel*)target;

@end

NS_ASSUME_NONNULL_END
