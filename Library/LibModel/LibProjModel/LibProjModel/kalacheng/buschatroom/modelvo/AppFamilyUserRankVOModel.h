//此代码由 http://code.siwaha.com/ 生成，服务器修改后可重新生成

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN




/**
聊天家族内部排行榜VO
 */
@interface AppFamilyUserRankVOModel : NSObject 


	/**
财富等级图片
 */
@property (nonatomic, copy) NSString * wealthGradeImg;

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
用户排名
 */
@property (nonatomic, assign) int userRank;

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

 +(NSMutableArray<AppFamilyUserRankVOModel*>*)getFromArr:(NSArray*)list;

 -(NSDictionary*)modelToJSONObject;

 +(NSMutableArray*)modelToJSONArray:(NSMutableArray<AppFamilyUserRankVOModel*>*)list;

 +(AppFamilyUserRankVOModel*)getFromDict:(NSDictionary*)dict;

 +(void)cloneObj:(AppFamilyUserRankVOModel*) source target:(AppFamilyUserRankVOModel*)target;

@end

NS_ASSUME_NONNULL_END
