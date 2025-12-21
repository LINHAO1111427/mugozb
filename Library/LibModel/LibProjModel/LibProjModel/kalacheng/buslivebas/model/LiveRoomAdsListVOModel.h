//此代码由 http://code.siwaha.com/ 生成，服务器修改后可重新生成

#import <Foundation/Foundation.h>

 @class LiveRoomAdsModel;
NS_ASSUME_NONNULL_BEGIN




/**
直播间内广告VO
 */
@interface LiveRoomAdsListVOModel : NSObject 


	/**
二级广告
 */
@property (nonatomic, strong) NSMutableArray<LiveRoomAdsModel*>* twoLiveRoomAdsList;

	/**
一级广告
 */
@property (strong, nonatomic) LiveRoomAdsModel* liveRoomAds;

 +(NSMutableArray<LiveRoomAdsListVOModel*>*)getFromArr:(NSArray*)list;

 -(NSDictionary*)modelToJSONObject;

 +(NSMutableArray*)modelToJSONArray:(NSMutableArray<LiveRoomAdsListVOModel*>*)list;

 +(LiveRoomAdsListVOModel*)getFromDict:(NSDictionary*)dict;

 +(void)cloneObj:(LiveRoomAdsListVOModel*) source target:(LiveRoomAdsListVOModel*)target;

@end

NS_ASSUME_NONNULL_END
