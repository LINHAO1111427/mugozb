//此代码由 http://code.siwaha.com/ 生成，服务器修改后可重新生成

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN




/**
主播认证及状态
 */
@interface MyAnchorVOModel : NSObject 


	/**
主播审核状态
 */
@property (nonatomic, assign) int anchorAuditStatus;

	/**
角色 0:普通用户 1:主播
 */
@property (nonatomic, assign) int role;

	/**
主播审核原因
 */
@property (nonatomic, copy) NSString * anchorAuditReason;

 +(NSMutableArray<MyAnchorVOModel*>*)getFromArr:(NSArray*)list;

 -(NSDictionary*)modelToJSONObject;

 +(NSMutableArray*)modelToJSONArray:(NSMutableArray<MyAnchorVOModel*>*)list;

 +(MyAnchorVOModel*)getFromDict:(NSDictionary*)dict;

 +(void)cloneObj:(MyAnchorVOModel*) source target:(MyAnchorVOModel*)target;

@end

NS_ASSUME_NONNULL_END
