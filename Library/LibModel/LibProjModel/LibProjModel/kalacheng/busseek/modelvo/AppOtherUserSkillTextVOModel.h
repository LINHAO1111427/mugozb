//此代码由 http://code.siwaha.com/ 生成，服务器修改后可重新生成

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN




/**
其他用户技能描述VO
 */
@interface AppOtherUserSkillTextVOModel : NSObject 


	/**
技能类型id
 */
@property (nonatomic, assign) int64_t skillTypeId;

	/**
技能文字描述
 */
@property (nonatomic, copy) NSString * skillTextDescription;

	/**
用户头像
 */
@property (nonatomic, copy) NSString * userAvatar;

	/**
null
 */
@property (nonatomic, assign) int64_t id_field;

	/**
用户名
 */
@property (nonatomic, copy) NSString * userName;

 +(NSMutableArray<AppOtherUserSkillTextVOModel*>*)getFromArr:(NSArray*)list;

 -(NSDictionary*)modelToJSONObject;

 +(NSMutableArray*)modelToJSONArray:(NSMutableArray<AppOtherUserSkillTextVOModel*>*)list;

 +(AppOtherUserSkillTextVOModel*)getFromDict:(NSDictionary*)dict;

 +(void)cloneObj:(AppOtherUserSkillTextVOModel*) source target:(AppOtherUserSkillTextVOModel*)target;

@end

NS_ASSUME_NONNULL_END
