//此代码由 http://code.siwaha.com/ 生成，服务器修改后可重新生成

#import <Foundation/Foundation.h>

 @class AppHomeFamilyUserVOModel;
NS_ASSUME_NONNULL_BEGIN




/**
聊天家族显示用户信息VO
 */
@interface AppHomeMyFamilyVOModel : NSObject 


	/**
家族角色 1：族长 2：副族长 3：长老 4：成员
 */
@property (nonatomic, assign) int familyRole;

	/**
家族图标
 */
@property (nonatomic, copy) NSString * familyIcon;

	/**
族长名称
 */
@property (nonatomic, copy) NSString * patriarchName;

	/**
家族描述
 */
@property (nonatomic, copy) NSString * familyDescription;

	/**
审核备注
 */
@property (nonatomic, copy) NSString * checkRemark;

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
家族成员前5个（第一个为族长）
 */
@property (nonatomic, strong) NSMutableArray<AppHomeFamilyUserVOModel*>* appHomeFamilyUserVOList;

	/**
家族名称
 */
@property (nonatomic, copy) NSString * familyName;

	/**
家族人数 
 */
@property (nonatomic, assign) int familyNumber;

	/**
族长id
 */
@property (nonatomic, assign) int64_t patriarchId;

	/**
家族等级
 */
@property (nonatomic, assign) int familyGrade;

	/**
家族状态 -2：家族已解散 -1：审核拒绝 0：审核中 1：审核通过 2：申请解散
 */
@property (nonatomic, assign) int familyStatus;

 +(NSMutableArray<AppHomeMyFamilyVOModel*>*)getFromArr:(NSArray*)list;

 -(NSDictionary*)modelToJSONObject;

 +(NSMutableArray*)modelToJSONArray:(NSMutableArray<AppHomeMyFamilyVOModel*>*)list;

 +(AppHomeMyFamilyVOModel*)getFromDict:(NSDictionary*)dict;

 +(void)cloneObj:(AppHomeMyFamilyVOModel*) source target:(AppHomeMyFamilyVOModel*)target;

@end

NS_ASSUME_NONNULL_END
