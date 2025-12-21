//此代码由 http://code.siwaha.com/ 生成，服务器修改后可重新生成

#import <Foundation/Foundation.h>

 @class KeyValueDtoModel;
 @class AppHomeHallDTOModel;
 @class AppLiveChannelModel;
 @class AppHotSortModel;
NS_ASSUME_NONNULL_BEGIN




/**
首页数据
 */
@interface HomeDtoModel : NSObject 


	/**
业务类型值TAG
 */
@property (nonatomic, strong) NSMutableArray<KeyValueDtoModel*>* headerTypes;

	/**
热门主播(语音)
 */
@property (nonatomic, strong) NSMutableArray<AppHomeHallDTOModel*>* hotAnchors;

	/**
直播频道
 */
@property (nonatomic, strong) NSMutableArray<AppLiveChannelModel*>* liveChannels;

	/**
视频分类(视频)
 */
@property (nonatomic, strong) NSMutableArray<AppHotSortModel*>* hotSorts;

 +(NSMutableArray<HomeDtoModel*>*)getFromArr:(NSArray*)list;

 -(NSDictionary*)modelToJSONObject;

 +(NSMutableArray*)modelToJSONArray:(NSMutableArray<HomeDtoModel*>*)list;

 +(HomeDtoModel*)getFromDict:(NSDictionary*)dict;

 +(void)cloneObj:(HomeDtoModel*) source target:(HomeDtoModel*)target;

@end

NS_ASSUME_NONNULL_END
