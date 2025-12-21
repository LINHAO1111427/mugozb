//此代码由 http://code.siwaha.com/ 生成，服务器修改后可重新生成

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN




/**
电视剧集用户显示的vo，主要用于收藏，观看记录等
 */
@interface TelevisionShowInfoVOModel : NSObject 


	/**
评论数
 */
@property (nonatomic, assign) int commentNum;

	/**
电视剧id
 */
@property (nonatomic, assign) int64_t televisionVideoId;

	/**
电视剧集id
 */
@property (nonatomic, assign) int64_t televisionEpisodeId;

	/**
视频时长（分钟）
 */
@property (nonatomic, assign) int televisionVideoDuration;

	/**
电视剧集描述
 */
@property (nonatomic, copy) NSString * televisionEpisodeDesc;

	/**
电视剧标题
 */
@property (nonatomic, copy) NSString * televisionVideoTitle;

	/**
第几集
 */
@property (nonatomic, assign) int whichEpisode;

	/**
电视剧集预览图
 */
@property (nonatomic, copy) NSString * televisionEpisodeImg;

	/**
观看数
 */
@property (nonatomic, assign) int viewingNum;

 +(NSMutableArray<TelevisionShowInfoVOModel*>*)getFromArr:(NSArray*)list;

 -(NSDictionary*)modelToJSONObject;

 +(NSMutableArray*)modelToJSONArray:(NSMutableArray<TelevisionShowInfoVOModel*>*)list;

 +(TelevisionShowInfoVOModel*)getFromDict:(NSDictionary*)dict;

 +(void)cloneObj:(TelevisionShowInfoVOModel*) source target:(TelevisionShowInfoVOModel*)target;

@end

NS_ASSUME_NONNULL_END
