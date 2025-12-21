//此代码由 http://code.siwaha.com/ 生成，服务器修改后可重新生成

#import <Foundation/Foundation.h>

 @class ApiShortVideoDtoModel;
 @class AppHotSortModel;
 @class AppAdsModel;
NS_ASSUME_NONNULL_BEGIN




/**
发现页数据
 */
@interface ApiShortVideoModel : NSObject 


	/**
本周必看
 */
@property (nonatomic, strong) NSMutableArray<ApiShortVideoDtoModel*>* weekList;

	/**
热门分类
 */
@property (nonatomic, strong) NSMutableArray<AppHotSortModel*>* classifyList;

	/**
广告图
 */
@property (nonatomic, strong) NSMutableArray<AppAdsModel*>* adsList;

 +(NSMutableArray<ApiShortVideoModel*>*)getFromArr:(NSArray*)list;

 -(NSDictionary*)modelToJSONObject;

 +(NSMutableArray*)modelToJSONArray:(NSMutableArray<ApiShortVideoModel*>*)list;

 +(ApiShortVideoModel*)getFromDict:(NSDictionary*)dict;

 +(void)cloneObj:(ApiShortVideoModel*) source target:(ApiShortVideoModel*)target;

@end

NS_ASSUME_NONNULL_END
