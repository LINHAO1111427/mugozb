//此代码由 http://code.siwaha.com/ 生成，服务器修改后可重新生成

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN




/**
电视剧推荐vo
 */
@interface TelevisionVideoRecommendVOModel : NSObject 


	/**
电视剧id
 */
@property (nonatomic, assign) int64_t televisionVideoId;

	/**
电视剧总集数
 */
@property (nonatomic, assign) int totalEpisodes;

	/**
电视剧封面图
 */
@property (nonatomic, copy) NSString * televisionVideoCoverImg;

	/**
电视剧标题
 */
@property (nonatomic, copy) NSString * televisionVideoTitle;

	/**
观看数（总）
 */
@property (nonatomic, assign) int viewingTotalNum;

	/**
点赞数（总）
 */
@property (nonatomic, assign) int likeTotalNum;

	/**
电视剧预览图
 */
@property (nonatomic, copy) NSString * televisionVideoImg;

 +(NSMutableArray<TelevisionVideoRecommendVOModel*>*)getFromArr:(NSArray*)list;

 -(NSDictionary*)modelToJSONObject;

 +(NSMutableArray*)modelToJSONArray:(NSMutableArray<TelevisionVideoRecommendVOModel*>*)list;

 +(TelevisionVideoRecommendVOModel*)getFromDict:(NSDictionary*)dict;

 +(void)cloneObj:(TelevisionVideoRecommendVOModel*) source target:(TelevisionVideoRecommendVOModel*)target;

@end

NS_ASSUME_NONNULL_END
