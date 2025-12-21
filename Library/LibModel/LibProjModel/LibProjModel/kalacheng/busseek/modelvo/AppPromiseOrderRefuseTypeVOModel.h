//此代码由 http://code.siwaha.com/ 生成，服务器修改后可重新生成

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN




/**
邀约订单拒绝类型VO
 */
@interface AppPromiseOrderRefuseTypeVOModel : NSObject 


	/**
拒绝类型名称
 */
@property (nonatomic, copy) NSString * refuseTypeName;

	/**
null
 */
@property (nonatomic, assign) int64_t id_field;

	/**
是否启用 1:启用 0：不启用
 */
@property (nonatomic, assign) int isEnable;

 +(NSMutableArray<AppPromiseOrderRefuseTypeVOModel*>*)getFromArr:(NSArray*)list;

 -(NSDictionary*)modelToJSONObject;

 +(NSMutableArray*)modelToJSONArray:(NSMutableArray<AppPromiseOrderRefuseTypeVOModel*>*)list;

 +(AppPromiseOrderRefuseTypeVOModel*)getFromDict:(NSDictionary*)dict;

 +(void)cloneObj:(AppPromiseOrderRefuseTypeVOModel*) source target:(AppPromiseOrderRefuseTypeVOModel*)target;

@end

NS_ASSUME_NONNULL_END
