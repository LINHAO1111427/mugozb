//此代码由 http://code.siwaha.com/ 生成，服务器修改后可重新生成

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN




/**
邀约订单申诉类型VO
 */
@interface AppPromiseOrderAppealTypeVOModel : NSObject 


	/**
null
 */
@property (nonatomic, assign) int64_t id_field;

	/**
申诉类型名称
 */
@property (nonatomic, copy) NSString * appealTypeName;

	/**
是否启用 1:启用 0：不启用
 */
@property (nonatomic, assign) int isEnable;

 +(NSMutableArray<AppPromiseOrderAppealTypeVOModel*>*)getFromArr:(NSArray*)list;

 -(NSDictionary*)modelToJSONObject;

 +(NSMutableArray*)modelToJSONArray:(NSMutableArray<AppPromiseOrderAppealTypeVOModel*>*)list;

 +(AppPromiseOrderAppealTypeVOModel*)getFromDict:(NSDictionary*)dict;

 +(void)cloneObj:(AppPromiseOrderAppealTypeVOModel*) source target:(AppPromiseOrderAppealTypeVOModel*)target;

@end

NS_ASSUME_NONNULL_END
