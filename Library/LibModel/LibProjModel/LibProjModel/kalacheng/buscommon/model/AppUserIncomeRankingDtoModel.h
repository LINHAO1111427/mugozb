//此代码由 http://code.siwaha.com/ 生成，服务器修改后可重新生成

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN




/**
我的邀请码-收入排行
 */
@interface AppUserIncomeRankingDtoModel : NSObject 


	/**
财富等级图标
 */
@property (nonatomic, copy) NSString * wealthGradeImg;

	/**
主播等级
 */
@property (nonatomic, assign) int anchorGrade;

	/**
序号
 */
@property (nonatomic, assign) int serialNumber;

	/**
用户等级
 */
@property (nonatomic, assign) int userGrade;

	/**
性别
 */
@property (nonatomic, assign) int sex;

	/**
用户等级图标
 */
@property (nonatomic, copy) NSString * userGradeImg;

	/**
用户头像
 */
@property (nonatomic, copy) NSString * avatar;

	/**
邀请人数
 */
@property (nonatomic, assign) int numberOfInvitations;

	/**
收入总映票
 */
@property (nonatomic, assign) double totalTicket;

	/**
贵族等级图标
 */
@property (nonatomic, copy) NSString * nobleGradeImg;

	/**
用户id 
 */
@property (nonatomic, assign) int64_t userId;

	/**
贵族头像框
 */
@property (nonatomic, copy) NSString * nobleAvatarFrame;

	/**
收入总金额
 */
@property (nonatomic, assign) double totalAmount;

	/**
主播等级图标
 */
@property (nonatomic, copy) NSString * anchorGradeImg;

	/**
1:在排名内 0: 不在排名内 是否在app端显示的排名里面,例如 1 - 100
 */
@property (nonatomic, assign) int isRanking;

	/**
财富等级
 */
@property (nonatomic, assign) int wealthGrade;

	/**
贵族等级
 */
@property (nonatomic, assign) int nobleGrade;

	/**
用户名
 */
@property (nonatomic, copy) NSString * username;

 +(NSMutableArray<AppUserIncomeRankingDtoModel*>*)getFromArr:(NSArray*)list;

 -(NSDictionary*)modelToJSONObject;

 +(NSMutableArray*)modelToJSONArray:(NSMutableArray<AppUserIncomeRankingDtoModel*>*)list;

 +(AppUserIncomeRankingDtoModel*)getFromDict:(NSDictionary*)dict;

 +(void)cloneObj:(AppUserIncomeRankingDtoModel*) source target:(AppUserIncomeRankingDtoModel*)target;

@end

NS_ASSUME_NONNULL_END
