//此代码由 http://code.siwaha.com/ 生成，服务器修改后可重新生成

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN




/**
聊天家族显示用户信息VO
 */
@interface AppHomeFamilyUserVOModel : NSObject 


	/**
家族角色 1：族长 2：副族长 3：长老 4：成员
 */
@property (nonatomic, assign) int familyRole;

	/**
财富等级图片
 */
@property (nonatomic, copy) NSString * wealthGradeImg;

	/**
是否被禁言 0：没有被禁言 1：被禁言了
 */
@property (nonatomic, assign) int isItBanned;

	/**
申请原因
 */
@property (nonatomic, copy) NSString * applyReason;

	/**
对家族贡献（日）
 */
@property (nonatomic, assign) double familyDayContribution;

	/**
性别 0:未设置 1:男 2:女
 */
@property (nonatomic, assign) int sex;

	/**
用户头像
 */
@property (nonatomic, copy) NSString * userAvatar;

	/**
贵族勋章
 */
@property (nonatomic, copy) NSString * nobleMedal;

	/**
用户名称
 */
@property (nonatomic, copy) NSString * userName;

	/**
贵族等级图片
 */
@property (nonatomic, copy) NSString * nobleGradeImg;

	/**
用户ID
 */
@property (nonatomic, assign) int64_t userId;

	/**
在家族收益（日）
 */
@property (nonatomic, assign) double familyDayIncome;

	/**
贵族头像框
 */
@property (nonatomic, copy) NSString * nobleAvatarFrame;

	/**
在家族收益（总）
 */
@property (nonatomic, assign) double familyTotalIncome;

	/**
等级图片
 */
@property (nonatomic, copy) NSString * gradeImg;

	/**
对家族贡献（总）
 */
@property (nonatomic, assign) double familyTotalContribution;

	/**
年龄
 */
@property (nonatomic, assign) int age;

 +(NSMutableArray<AppHomeFamilyUserVOModel*>*)getFromArr:(NSArray*)list;

 -(NSDictionary*)modelToJSONObject;

 +(NSMutableArray*)modelToJSONArray:(NSMutableArray<AppHomeFamilyUserVOModel*>*)list;

 +(AppHomeFamilyUserVOModel*)getFromDict:(NSDictionary*)dict;

 +(void)cloneObj:(AppHomeFamilyUserVOModel*) source target:(AppHomeFamilyUserVOModel*)target;

@end

NS_ASSUME_NONNULL_END
