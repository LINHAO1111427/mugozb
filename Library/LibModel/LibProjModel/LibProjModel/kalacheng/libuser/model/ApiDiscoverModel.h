//此代码由 http://code.siwaha.com/ 生成，服务器修改后可重新生成

#import <Foundation/Foundation.h>

 @class AppUserModel;
 @class AppVideoTopicModel;
NS_ASSUME_NONNULL_BEGIN




/**
发现页数据
 */
@interface ApiDiscoverModel : NSObject 


	/**
热门主播
 */
@property (nonatomic, strong) NSMutableArray<AppUserModel*>* anchor;

	/**
热门话题
 */
@property (nonatomic, strong) NSMutableArray<AppVideoTopicModel*>* hotTopics;

 +(NSMutableArray<ApiDiscoverModel*>*)getFromArr:(NSArray*)list;

 -(NSDictionary*)modelToJSONObject;

 +(NSMutableArray*)modelToJSONArray:(NSMutableArray<ApiDiscoverModel*>*)list;

 +(ApiDiscoverModel*)getFromDict:(NSDictionary*)dict;

 +(void)cloneObj:(ApiDiscoverModel*) source target:(ApiDiscoverModel*)target;

@end

NS_ASSUME_NONNULL_END
