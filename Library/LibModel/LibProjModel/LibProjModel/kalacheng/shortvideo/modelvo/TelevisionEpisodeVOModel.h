//此代码由 http://code.siwaha.com/ 生成，服务器修改后可重新生成

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN




/**
电视剧集简单的VO，用于详情显示集数
 */
@interface TelevisionEpisodeVOModel : NSObject 


	/**
电视剧id
 */
@property (nonatomic, assign) int64_t televisionVideoId;

	/**
电视剧集id
 */
@property (nonatomic, assign) int64_t televisionEpisodeId;

	/**
电视剧集描述
 */
@property (nonatomic, copy) NSString * televisionEpisodeDesc;

	/**
第几集
 */
@property (nonatomic, assign) int whichEpisode;

	/**
电视剧集预览图
 */
@property (nonatomic, copy) NSString * televisionEpisodeImg;

 +(NSMutableArray<TelevisionEpisodeVOModel*>*)getFromArr:(NSArray*)list;

 -(NSDictionary*)modelToJSONObject;

 +(NSMutableArray*)modelToJSONArray:(NSMutableArray<TelevisionEpisodeVOModel*>*)list;

 +(TelevisionEpisodeVOModel*)getFromDict:(NSDictionary*)dict;

 +(void)cloneObj:(TelevisionEpisodeVOModel*) source target:(TelevisionEpisodeVOModel*)target;

@end

NS_ASSUME_NONNULL_END
