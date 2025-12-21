//此代码由 http://code.siwaha.com/ 生成，服务器修改后可重新生成

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN




/**
电视剧详情VO
 */
@interface TelevisionVideoDetailVOModel : NSObject 


	/**
打赏数（总）
 */
@property (nonatomic, assign) int rewardTotalNum;

	/**
创建时间
 */
@property (nonatomic,copy) NSDate * addTime;

	/**
电视剧总集数
 */
@property (nonatomic, assign) int totalEpisodes;

	/**
电视剧标题
 */
@property (nonatomic, copy) NSString * televisionVideoTitle;

	/**
观看数（总）
 */
@property (nonatomic, assign) int viewingTotalNum;

	/**
评论数（总）
 */
@property (nonatomic, assign) int commentTotalNum;

	/**
收藏数（总）
 */
@property (nonatomic, assign) int keepTotalNum;

	/**
电视剧id
 */
@property (nonatomic, assign) int64_t televisionVideoId;

	/**
电视剧分区名称
 */
@property (nonatomic, copy) NSString * televisionPartitionName;

	/**
电视剧封面图
 */
@property (nonatomic, copy) NSString * televisionVideoCoverImg;

	/**
电视剧描述
 */
@property (nonatomic, copy) NSString * televisionVideoDesc;

	/**
是否完结 0：未完结 1：已完结
 */
@property (nonatomic, assign) int isOver;

	/**
点赞数（总）
 */
@property (nonatomic, assign) int likeTotalNum;

	/**
电视剧分类名称
 */
@property (nonatomic, copy) NSString * televisionVideoTypeName;

	/**
电视剧预览图
 */
@property (nonatomic, copy) NSString * televisionVideoImg;

	/**
电视剧简介
 */
@property (nonatomic, copy) NSString * televisionVideoSummary;

 +(NSMutableArray<TelevisionVideoDetailVOModel*>*)getFromArr:(NSArray*)list;

 -(NSDictionary*)modelToJSONObject;

 +(NSMutableArray*)modelToJSONArray:(NSMutableArray<TelevisionVideoDetailVOModel*>*)list;

 +(TelevisionVideoDetailVOModel*)getFromDict:(NSDictionary*)dict;

 +(void)cloneObj:(TelevisionVideoDetailVOModel*) source target:(TelevisionVideoDetailVOModel*)target;

@end

NS_ASSUME_NONNULL_END
