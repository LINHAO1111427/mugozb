//此代码由 http://code.siwaha.com/ 生成，服务器修改后可重新生成

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN




/**
电视剧剧集统计的一些数据VO（观看/点赞 ...）
 */
@interface TelevisionEpisodeDataVOModel : NSObject 


	/**
评论数
 */
@property (nonatomic, assign) int commentNum;

	/**
电视剧集id
 */
@property (nonatomic, assign) int64_t televisionEpisodeId;

	/**
收藏数
 */
@property (nonatomic, assign) int keepNum;

	/**
打赏数
 */
@property (nonatomic, assign) int rewardNum;

	/**
观看数
 */
@property (nonatomic, assign) int viewingNum;

	/**
点赞数
 */
@property (nonatomic, assign) int likeNum;

 +(NSMutableArray<TelevisionEpisodeDataVOModel*>*)getFromArr:(NSArray*)list;

 -(NSDictionary*)modelToJSONObject;

 +(NSMutableArray*)modelToJSONArray:(NSMutableArray<TelevisionEpisodeDataVOModel*>*)list;

 +(TelevisionEpisodeDataVOModel*)getFromDict:(NSDictionary*)dict;

 +(void)cloneObj:(TelevisionEpisodeDataVOModel*) source target:(TelevisionEpisodeDataVOModel*)target;

@end

NS_ASSUME_NONNULL_END
