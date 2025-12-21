//此代码由 http://code.siwaha.com/ 生成，服务器修改后可重新生成

#import <Foundation/Foundation.h>

 @class TelevisionEpisodeVOModel;
NS_ASSUME_NONNULL_BEGIN




/**
电视剧集信息VO
 */
@interface TelevisionEpisodeInfoVOModel : NSObject 


	/**
是否点赞 1：点赞了 0：没有点赞
 */
@property (nonatomic, assign) int isLike;

	/**
打赏数
 */
@property (nonatomic, assign) int rewardNum;

	/**
需要支付金币数量
 */
@property (nonatomic, assign) double payCoinNum;

	/**
电视剧标题
 */
@property (nonatomic, copy) NSString * televisionVideoTitle;

	/**
点赞数
 */
@property (nonatomic, assign) int likeNum;

	/**
是否需要登录 0：不需要 1：需要
 */
@property (nonatomic, assign) int isLogin;

	/**
电视剧id
 */
@property (nonatomic, assign) int64_t televisionVideoId;

	/**
需要开通贵族或支付金币时，提示的图片，其他时间为空字符串
 */
@property (nonatomic, copy) NSString * promptImg;

	/**
试看时长（秒）
 */
@property (nonatomic, assign) int trialTime;

	/**
收藏数
 */
@property (nonatomic, assign) int keepNum;

	/**
电视剧集预览图
 */
@property (nonatomic, copy) NSString * televisionEpisodeImg;

	/**
需要开通贵族或支付金币时，提示的文字，其他时间为空字符串
 */
@property (nonatomic, copy) NSString * promptText;

	/**
选集列表
 */
@property (nonatomic, strong) NSMutableArray<TelevisionEpisodeVOModel*>* anthologyList;

	/**
电视视频地址
 */
@property (nonatomic, copy) NSString * televisionVideoUrl;

	/**
电视剧总集数
 */
@property (nonatomic, assign) int totalEpisodes;

	/**
观看数（总）
 */
@property (nonatomic, assign) int viewingTotalNum;

	/**
第几集
 */
@property (nonatomic, assign) int whichEpisode;

	/**
是否收藏 1：收藏了 0：没有收藏
 */
@property (nonatomic, assign) int isKeep;

	/**
所属用户
 */
@property (nonatomic, assign) int64_t userId;

	/**
评论数
 */
@property (nonatomic, assign) int commentNum;

	/**
是否需要开通贵族 0：不需要 1：需要
 */
@property (nonatomic, assign) int isOpenNoble;

	/**
电视剧集id
 */
@property (nonatomic, assign) int64_t televisionEpisodeId;

	/**
是否需要支付金币 0：不需要 1：需要
 */
@property (nonatomic, assign) int isPayCoin;

	/**
付费封面图
 */
@property (nonatomic, copy) NSString * paidCoverImage;

	/**
电视剧集描述
 */
@property (nonatomic, copy) NSString * televisionEpisodeDesc;

	/**
是否完结 0：未完结 1：已完结
 */
@property (nonatomic, assign) int isOver;

	/**
观看时长（秒）
 */
@property (nonatomic, assign) int64_t watchTime;

 +(NSMutableArray<TelevisionEpisodeInfoVOModel*>*)getFromArr:(NSArray*)list;

 -(NSDictionary*)modelToJSONObject;

 +(NSMutableArray*)modelToJSONArray:(NSMutableArray<TelevisionEpisodeInfoVOModel*>*)list;

 +(TelevisionEpisodeInfoVOModel*)getFromDict:(NSDictionary*)dict;

 +(void)cloneObj:(TelevisionEpisodeInfoVOModel*) source target:(TelevisionEpisodeInfoVOModel*)target;

@end

NS_ASSUME_NONNULL_END
