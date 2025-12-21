//此代码由 http://code.siwaha.com/ 生成，服务器修改后可重新生成

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN




/**
APP消息未读数
 */
@interface ApiNoReadModel : NSObject 


	/**
总未读数
 */
@property (nonatomic, assign) int64_t totalNoRead;

	/**
短视频未读数
 */
@property (nonatomic, assign) int64_t shortVideoNoRead;

	/**
通知未读数
 */
@property (nonatomic, assign) int64_t systemNoRead;

	/**
官方未读数
 */
@property (nonatomic, assign) int64_t officialNewsNoRead;

	/**
动态未读数
 */
@property (nonatomic, assign) int64_t videoNoRead;

 +(NSMutableArray<ApiNoReadModel*>*)getFromArr:(NSArray*)list;

 -(NSDictionary*)modelToJSONObject;

 +(NSMutableArray*)modelToJSONArray:(NSMutableArray<ApiNoReadModel*>*)list;

 +(ApiNoReadModel*)getFromDict:(NSDictionary*)dict;

 +(void)cloneObj:(ApiNoReadModel*) source target:(ApiNoReadModel*)target;

@end

NS_ASSUME_NONNULL_END
