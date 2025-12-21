//此代码由 http://code.siwaha.com/ 生成，服务器修改后可重新生成

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN




/**
聊天家族举报类型VO
 */
@interface AppChatFamilyAppealTypeVOModel : NSObject 


	/**
null
 */
@property (nonatomic, assign) int64_t id_field;

	/**
举报类型名称
 */
@property (nonatomic, copy) NSString * appealTypeName;

 +(NSMutableArray<AppChatFamilyAppealTypeVOModel*>*)getFromArr:(NSArray*)list;

 -(NSDictionary*)modelToJSONObject;

 +(NSMutableArray*)modelToJSONArray:(NSMutableArray<AppChatFamilyAppealTypeVOModel*>*)list;

 +(AppChatFamilyAppealTypeVOModel*)getFromDict:(NSDictionary*)dict;

 +(void)cloneObj:(AppChatFamilyAppealTypeVOModel*) source target:(AppChatFamilyAppealTypeVOModel*)target;

@end

NS_ASSUME_NONNULL_END
