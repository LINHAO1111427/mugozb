//此代码由 http://code.siwaha.com/ 生成，服务器修改后可重新生成

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN




/**

 */
@interface ApiLinkEntityModel : NSObject 


	/**
会话ID
 */
@property (nonatomic, assign) int64_t sessionID;

 +(NSMutableArray<ApiLinkEntityModel*>*)getFromArr:(NSArray*)list;

 -(NSDictionary*)modelToJSONObject;

 +(NSMutableArray*)modelToJSONArray:(NSMutableArray<ApiLinkEntityModel*>*)list;

 +(ApiLinkEntityModel*)getFromDict:(NSDictionary*)dict;

 +(void)cloneObj:(ApiLinkEntityModel*) source target:(ApiLinkEntityModel*)target;

@end

NS_ASSUME_NONNULL_END
