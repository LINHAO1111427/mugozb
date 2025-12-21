//此代码由 http://code.siwaha.com/ 生成，服务器修改后可重新生成

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN




/**
动态举报类型VO
 */
@interface DynamicAppealTypeVOModel : NSObject 


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

 +(NSMutableArray<DynamicAppealTypeVOModel*>*)getFromArr:(NSArray*)list;

 -(NSDictionary*)modelToJSONObject;

 +(NSMutableArray*)modelToJSONArray:(NSMutableArray<DynamicAppealTypeVOModel*>*)list;

 +(DynamicAppealTypeVOModel*)getFromDict:(NSDictionary*)dict;

 +(void)cloneObj:(DynamicAppealTypeVOModel*) source target:(DynamicAppealTypeVOModel*)target;

@end

NS_ASSUME_NONNULL_END
