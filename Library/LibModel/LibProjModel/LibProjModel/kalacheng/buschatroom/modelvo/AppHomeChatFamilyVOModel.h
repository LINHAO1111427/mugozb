//此代码由 http://code.siwaha.com/ 生成，服务器修改后可重新生成

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN




/**
聊天家族显示VO
 */
@interface AppHomeChatFamilyVOModel : NSObject 


	/**
距离
 */
@property (nonatomic, assign) double distance;

	/**
家族排名
 */
@property (nonatomic, assign) int familyRank;

	/**
家族图标
 */
@property (nonatomic, copy) NSString * familyIcon;

	/**
家族描述
 */
@property (nonatomic, copy) NSString * familyDescription;

	/**
家族等级值（周）
 */
@property (nonatomic, assign) double familyWeekRating;

	/**
家族等级图标
 */
@property (nonatomic, copy) NSString * familyGradeIcon;

	/**
家族等级值（日）
 */
@property (nonatomic, assign) double familyDayRating;

	/**
家族id
 */
@property (nonatomic, assign) int64_t familyId;

	/**
家族等级值（月）
 */
@property (nonatomic, assign) double familyMonthRating;

	/**
是否正在申请 0:没有申请 1：申请中
 */
@property (nonatomic, assign) int64_t isApply;

	/**
我的家族 0：不是 1：是
 */
@property (nonatomic, assign) int isMyChatFamily;

	/**
加入房间需要的金币（0表示不需要）
 */
@property (nonatomic, assign) double joinFamilyCoin;

	/**
家族名称
 */
@property (nonatomic, copy) NSString * familyName;

	/**
家族人数 
 */
@property (nonatomic, assign) int familyNumber;

	/**
家族等级
 */
@property (nonatomic, assign) int familyGrade;

	/**
家族等级值（总）
 */
@property (nonatomic, assign) double familyTotalRating;

	/**
家族待审核人数 
 */
@property (nonatomic, assign) int familyCheckNumber;

 +(NSMutableArray<AppHomeChatFamilyVOModel*>*)getFromArr:(NSArray*)list;

 -(NSDictionary*)modelToJSONObject;

 +(NSMutableArray*)modelToJSONArray:(NSMutableArray<AppHomeChatFamilyVOModel*>*)list;

 +(AppHomeChatFamilyVOModel*)getFromDict:(NSDictionary*)dict;

 +(void)cloneObj:(AppHomeChatFamilyVOModel*) source target:(AppHomeChatFamilyVOModel*)target;

@end

NS_ASSUME_NONNULL_END
