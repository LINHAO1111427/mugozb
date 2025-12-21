//此代码由 http://code.siwaha.com/ 生成，服务器修改后可重新生成

#import <Foundation/Foundation.h>

 @class AppScheduleVOModel;
 @class AppSkillTagVOModel;
NS_ASSUME_NONNULL_BEGIN




/**
用户技能VO
 */
@interface AppUserSkillVOModel : NSObject 


	/**
档期集合
 */
@property (nonatomic, strong) NSMutableArray<AppScheduleVOModel*>* appScheduleVOList;

	/**
技能每小时单价
 */
@property (nonatomic, assign) double unitPrice;

	/**
技能最高价格(每小时)/金币
 */
@property (nonatomic, assign) double highestPrice;

	/**
技能最低价格(每小时)/金币
 */
@property (nonatomic, assign) double lowestPrice;

	/**
城市
 */
@property (nonatomic, copy) NSString * city;

	/**
个性签名
 */
@property (nonatomic, copy) NSString * signature;

	/**
技能文字描述
 */
@property (nonatomic, copy) NSString * skillTextDescription;

	/**
推荐技能最高价格(每小时)/金币
 */
@property (nonatomic, assign) double recommendHighestPrice;

	/**
用户头像
 */
@property (nonatomic, copy) NSString * userAvatar;

	/**
用户名称
 */
@property (nonatomic, copy) NSString * userName;

	/**
用户ID
 */
@property (nonatomic, assign) int64_t userId;

	/**
推荐技能最低价格(每小时)/金币
 */
@property (nonatomic, assign) double recommendLowestPrice;

	/**
是否关注 1:关注了 0：未关注
 */
@property (nonatomic, assign) int isAttention;

	/**
技能名称
 */
@property (nonatomic, copy) NSString * skillName;

	/**
档期 1：早上 2：中午 3：晚上,(多个用逗号隔开)
 */
@property (nonatomic, copy) NSString * schedule;

	/**
技能标签集合
 */
@property (nonatomic, strong) NSMutableArray<AppSkillTagVOModel*>* appSkillTagVOList;

	/**
技能类型id
 */
@property (nonatomic, assign) int64_t skillTypeId;

	/**
技能特权展示图片，多张，英文逗号隔开，就是下面多张图片和一个合集
 */
@property (nonatomic, copy) NSString * featuredPicture;

	/**
null
 */
@property (nonatomic, assign) int64_t id_field;

	/**
技能图片
 */
@property (nonatomic, copy) NSString * skillImage;

	/**
技能标签id集
 */
@property (nonatomic, copy) NSString * skillTypeTagIds;

 +(NSMutableArray<AppUserSkillVOModel*>*)getFromArr:(NSArray*)list;

 -(NSDictionary*)modelToJSONObject;

 +(NSMutableArray*)modelToJSONArray:(NSMutableArray<AppUserSkillVOModel*>*)list;

 +(AppUserSkillVOModel*)getFromDict:(NSDictionary*)dict;

 +(void)cloneObj:(AppUserSkillVOModel*) source target:(AppUserSkillVOModel*)target;

@end

NS_ASSUME_NONNULL_END
