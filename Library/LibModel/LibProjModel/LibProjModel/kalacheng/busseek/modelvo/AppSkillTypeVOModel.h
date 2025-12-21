//此代码由 http://code.siwaha.com/ 生成，服务器修改后可重新生成

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN




/**
技能类型表VO
 */
@interface AppSkillTypeVOModel : NSObject 


	/**
技能描述
 */
@property (nonatomic, copy) NSString * skillDescription;

	/**
技能名称
 */
@property (nonatomic, copy) NSString * skillName;

	/**
技能最高价格(每小时)/金币
 */
@property (nonatomic, assign) double highestPrice;

	/**
是否推荐 0.不推荐，1.推荐中
 */
@property (nonatomic, assign) int isRecommend;

	/**
技能最低价格(每小时)/金币
 */
@property (nonatomic, assign) double lowestPrice;

	/**
推荐技能最高价格(每小时)/金币
 */
@property (nonatomic, assign) double recommendHighestPrice;

	/**
null
 */
@property (nonatomic, assign) int64_t id_field;

	/**
技能图片
 */
@property (nonatomic, copy) NSString * skillImage;

	/**
分类描述
 */
@property (nonatomic, copy) NSString * classifyDescription;

	/**
分类图片
 */
@property (nonatomic, copy) NSString * classifyImage;

	/**
是否启用 0.不启用，1.启用
 */
@property (nonatomic, assign) int isEnable;

	/**
推荐技能最低价格(每小时)/金币
 */
@property (nonatomic, assign) double recommendLowestPrice;

 +(NSMutableArray<AppSkillTypeVOModel*>*)getFromArr:(NSArray*)list;

 -(NSDictionary*)modelToJSONObject;

 +(NSMutableArray*)modelToJSONArray:(NSMutableArray<AppSkillTypeVOModel*>*)list;

 +(AppSkillTypeVOModel*)getFromDict:(NSDictionary*)dict;

 +(void)cloneObj:(AppSkillTypeVOModel*) source target:(AppSkillTypeVOModel*)target;

@end

NS_ASSUME_NONNULL_END
