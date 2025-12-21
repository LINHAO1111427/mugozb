//此代码由 http://code.siwaha.com/ 生成，服务器修改后可重新生成

#import <Foundation/Foundation.h>

 @class AppHomeFamilyUserVOModel;
NS_ASSUME_NONNULL_BEGIN




/**
聊天家族显示详细VO
 */
@interface AppHomeChatFamilyInfoVOModel : NSObject 


	/**
家族待审核成员前5个
 */
@property (nonatomic, strong) NSMutableArray<AppHomeFamilyUserVOModel*>* appHomeFamilyCheckUserVOList;

	/**
总排名
 */
@property (nonatomic, assign) int totalRating;

	/**
家族图标
 */
@property (nonatomic, copy) NSString * familyIcon;

	/**
家族描述
 */
@property (nonatomic, copy) NSString * familyDescription;

	/**
家族等级图标
 */
@property (nonatomic, copy) NSString * familyGradeIcon;

	/**
我在这个家族中的角色 0：不是本家族成员 1：族长 2：副族长 3：长老 4：成员
 */
@property (nonatomic, assign) int myFamilyRole;

	/**
家族id
 */
@property (nonatomic, assign) int64_t familyId;

	/**
是否正在申请 0:没有申请 1：申请中
 */
@property (nonatomic, assign) int64_t isApply;

	/**
我的家族 0：不是 1：是
 */
@property (nonatomic, assign) int isMyChatFamily;

	/**
家族成员前5个（第一个为族长）
 */
@property (nonatomic, strong) NSMutableArray<AppHomeFamilyUserVOModel*>* appHomeFamilyUserVOList;

	/**
家族下一个等级起始值
 */
@property (nonatomic, assign) double familyNextGradeStartVal;

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
家族下一个等级
 */
@property (nonatomic, assign) int familyNextGrade;

	/**
家族等级值（总）
 */
@property (nonatomic, assign) double familyTotalRating;

	/**
家族公告（对内）
 */
@property (nonatomic, copy) NSString * familyProclamation;

	/**
周排名
 */
@property (nonatomic, assign) int weekRating;

	/**
家族待审核人数 
 */
@property (nonatomic, assign) int familyCheckNumber;

	/**
家族状态 -2：家族已解散 -1：审核拒绝 0：审核中 1：审核通过 2：申请解散
 */
@property (nonatomic, assign) int familyStatus;

 +(NSMutableArray<AppHomeChatFamilyInfoVOModel*>*)getFromArr:(NSArray*)list;

 -(NSDictionary*)modelToJSONObject;

 +(NSMutableArray*)modelToJSONArray:(NSMutableArray<AppHomeChatFamilyInfoVOModel*>*)list;

 +(AppHomeChatFamilyInfoVOModel*)getFromDict:(NSDictionary*)dict;

 +(void)cloneObj:(AppHomeChatFamilyInfoVOModel*) source target:(AppHomeChatFamilyInfoVOModel*)target;

@end

NS_ASSUME_NONNULL_END
