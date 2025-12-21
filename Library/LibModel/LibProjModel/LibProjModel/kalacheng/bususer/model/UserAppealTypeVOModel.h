//此代码由 http://code.siwaha.com/ 生成，服务器修改后可重新生成

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN




/**
用户举报类型vo
 */
@interface UserAppealTypeVOModel : NSObject 


	/**
null
 */
@property (nonatomic, assign) int64_t id_field;

	/**
举报类型名称
 */
@property (nonatomic, copy) NSString * appealTypeName;

	/**
是否启用 1:启用 0：不启用
 */
@property (nonatomic, assign) int isEnable;

 +(NSMutableArray<UserAppealTypeVOModel*>*)getFromArr:(NSArray*)list;

 -(NSDictionary*)modelToJSONObject;

 +(NSMutableArray*)modelToJSONArray:(NSMutableArray<UserAppealTypeVOModel*>*)list;

 +(UserAppealTypeVOModel*)getFromDict:(NSDictionary*)dict;

 +(void)cloneObj:(UserAppealTypeVOModel*) source target:(UserAppealTypeVOModel*)target;

@end

NS_ASSUME_NONNULL_END
