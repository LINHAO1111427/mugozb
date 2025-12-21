//此代码由 http://code.siwaha.com/ 生成，服务器修改后可重新生成

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN




/**
技能标签VO
 */
@interface AppSkillTagVOModel : NSObject 


	/**
技能类型id
 */
@property (nonatomic, assign) int64_t skillTypeId;

	/**
技能标签名称
 */
@property (nonatomic, copy) NSString * skillTagName;

	/**
null
 */
@property (nonatomic, assign) int64_t id_field;

	/**
是否启用 0.不启用，1.启用
 */
@property (nonatomic, assign) int isEnable;

 +(NSMutableArray<AppSkillTagVOModel*>*)getFromArr:(NSArray*)list;

 -(NSDictionary*)modelToJSONObject;

 +(NSMutableArray*)modelToJSONArray:(NSMutableArray<AppSkillTagVOModel*>*)list;

 +(AppSkillTagVOModel*)getFromDict:(NSDictionary*)dict;

 +(void)cloneObj:(AppSkillTagVOModel*) source target:(AppSkillTagVOModel*)target;

@end

NS_ASSUME_NONNULL_END
