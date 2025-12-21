//此代码由 http://code.siwaha.com/ 生成，服务器修改后可重新生成
#import <Foundation/Foundation.h>

#import <LibProjBase/PageInfo.h>


#import "TelevisionVideoSimpleVOModel.h"

#import "TelevisionPartitionVideoVOModel.h"

#import "TelevisionVideoTypeVOModel.h"

#import "HttpNoneModel.h"

#import "TelevisionVideoRecommendVOModel.h"

#import "TelevisionEpisodeCommentVOModel.h"

#import "TelevisionEpisodeDataVOModel.h"

#import "TelevisionVideoDetailVOModel.h"

#import "TelevisionShowInfoVOModel.h"

#import "TelevisionEpisodeInfoVOModel.h"

typedef void (^CallBackTelevisionVideoController_TelevisionVideoSimpleVOArr)(int code,NSString *strMsg,NSArray<TelevisionVideoSimpleVOModel*>* arr);
typedef void (^CallBackTelevisionVideoController_TelevisionPartitionVideoVOArr)(int code,NSString *strMsg,NSArray<TelevisionPartitionVideoVOModel*>* arr);
typedef void (^CallBackTelevisionVideoController_TelevisionVideoTypeVOArr)(int code,NSString *strMsg,NSArray<TelevisionVideoTypeVOModel*>* arr);
typedef void (^CallBackTelevisionVideoController_HttpNone)(int code,NSString *strMsg,HttpNoneModel* model);
typedef void (^CallBackTelevisionVideoController_TelevisionVideoRecommendVOArr)(int code,NSString *strMsg,NSArray<TelevisionVideoRecommendVOModel*>* arr);
typedef void (^CallBackTelevisionVideoController_TelevisionEpisodeCommentVOArr)(int code,NSString *strMsg,NSArray<TelevisionEpisodeCommentVOModel*>* arr);
typedef void (^CallBackTelevisionVideoController_TelevisionEpisodeDataVO)(int code,NSString *strMsg,TelevisionEpisodeDataVOModel* model);
typedef void (^CallBackTelevisionVideoController_TelevisionVideoDetailVO)(int code,NSString *strMsg,TelevisionVideoDetailVOModel* model);
typedef void (^CallBackTelevisionVideoController_TelevisionShowInfoVOArr)(int code,NSString *strMsg,NSArray<TelevisionShowInfoVOModel*>* arr);
typedef void (^CallBackTelevisionVideoController_TelevisionEpisodeInfoVO)(int code,NSString *strMsg,TelevisionEpisodeInfoVOModel* model);
NS_ASSUME_NONNULL_BEGIN



/**
电视视频
 */
@interface HttpApiTelevisionVideoController: NSObject



/**
 获取放映厅电视剧（bannner图一样的那个）（接口取消使用）
 @param pageIndex 页数
 @param pageSize 每页条数
 */
+(void) getShowHomeTelevisionVideo:(int)pageIndex pageSize:(int)pageSize  callback:(CallBackTelevisionVideoController_TelevisionVideoSimpleVOArr)callback;


/**
 获取分区下的电视剧信息
 */
+(void) getPartitionVideo:(CallBackTelevisionVideoController_TelevisionPartitionVideoVOArr)callback;


/**
 获取电视剧分类
 */
+(void) getTelevisionVideoTypeList:(CallBackTelevisionVideoController_TelevisionVideoTypeVOArr)callback;


/**
 添加用户的观看记录
 @param televisionEpisodeId 电视剧集id
 @param televisionVideoId 电视剧id
 @param watchTime 观看时长（秒）
 */
+(void) addWatchHistory:(int64_t)televisionEpisodeId televisionVideoId:(int64_t)televisionVideoId watchTime:(int64_t)watchTime  callback:(CallBackTelevisionVideoController_HttpNone)callback;


/**
 获取标签推荐
 @param televisionVideoId 电视剧id
 */
+(void) getTelevisionVideoRecommend:(int64_t)televisionVideoId  callback:(CallBackTelevisionVideoController_TelevisionVideoRecommendVOArr)callback;


/**
 获取电视剧集的评论列表
 @param pageIndex 页数
 @param pageSize 每页条数
 @param televisionEpisodeId 电视剧集id
 */
+(void) televisionEpisodeCommentList:(int)pageIndex pageSize:(int)pageSize televisionEpisodeId:(int64_t)televisionEpisodeId  callback:(CallBackTelevisionVideoController_TelevisionEpisodeCommentVOArr)callback;


/**
 购买电视剧集
 @param televisionEpisodeId 电视剧集id
 */
+(void) buyTelevisionEpisode:(int64_t)televisionEpisodeId  callback:(CallBackTelevisionVideoController_HttpNone)callback;


/**
 电视剧搜索 （电视剧名称）
 @param pageIndex 页数
 @param pageSize 每页条数
 @param searchStr 搜索字段
 */
+(void) searchTelevisionVideo:(int)pageIndex pageSize:(int)pageSize searchStr:(NSString *)searchStr  callback:(CallBackTelevisionVideoController_TelevisionVideoRecommendVOArr)callback;


/**
  查询电视剧集的观看、点赞等数据
 @param televisionEpisodeId 电视剧集id
 */
+(void) getTelevisionEpisodeData:(int64_t)televisionEpisodeId  callback:(CallBackTelevisionVideoController_TelevisionEpisodeDataVO)callback;


/**
 获取电视剧详细信息
 @param televisionVideoId 电视剧id
 */
+(void) getTelevisionVideoDetail:(int64_t)televisionVideoId  callback:(CallBackTelevisionVideoController_TelevisionVideoDetailVO)callback;


/**
 获取我的购买记录
 @param pageIndex 页数
 @param pageSize 每页条数
 */
+(void) getBuyTelevisionEpisodeRecord:(int)pageIndex pageSize:(int)pageSize  callback:(CallBackTelevisionVideoController_TelevisionShowInfoVOArr)callback;


/**
 电视剧集评论
 @param commentContext 评论内容
 @param televisionEpisodeId 电视剧集id
 @param toCommentId 被评论的评论id（评论传0）
 @param toUserId 被评论用户id（评论传0）
 */
+(void) televisionEpisodeComment:(NSString *)commentContext televisionEpisodeId:(int64_t)televisionEpisodeId toCommentId:(int64_t)toCommentId toUserId:(int64_t)toUserId  callback:(CallBackTelevisionVideoController_HttpNone)callback;


/**
 获取电视剧集信息（参数是电视剧id）
 @param televisionVideoId 电视剧id
 */
+(void) getTelevisionEpisodeInfo:(int64_t)televisionVideoId  callback:(CallBackTelevisionVideoController_TelevisionEpisodeInfoVO)callback;


/**
 获取电视分类下电视剧
 @param pageIndex 页数
 @param pageSize 每页条数
 @param televisionVideoTypeId 电视分类id
 */
+(void) getTelevisionTypeVideo:(int)pageIndex pageSize:(int)pageSize televisionVideoTypeId:(int64_t)televisionVideoTypeId  callback:(CallBackTelevisionVideoController_TelevisionVideoSimpleVOArr)callback;


/**
 我的观看记录
 @param pageIndex 页数
 @param pageSize 每页条数
 */
+(void) getMyTelevisionWatchHistory:(int)pageIndex pageSize:(int)pageSize  callback:(CallBackTelevisionVideoController_TelevisionShowInfoVOArr)callback;


/**
 电视剧集点赞/取消
 @param optType  操作类型(目标值) 1：点赞 0：取消点赞
 @param televisionEpisodeId 电视剧集id
 */
+(void) televisionEpisodeLike:(int)optType televisionEpisodeId:(int64_t)televisionEpisodeId  callback:(CallBackTelevisionVideoController_HttpNone)callback;


/**
 获取我收藏的电视剧集
 @param pageIndex 页数
 @param pageSize 每页条数
 */
+(void) getMyTelevisionVideoKeep:(int)pageIndex pageSize:(int)pageSize  callback:(CallBackTelevisionVideoController_TelevisionShowInfoVOArr)callback;


/**
 电视剧集收藏/取消
 @param optType  操作类型(目标值) 1：收藏 0：取消收藏
 @param televisionEpisodeId 电视剧集id
 */
+(void) televisionEpisodeKeep:(int)optType televisionEpisodeId:(int64_t)televisionEpisodeId  callback:(CallBackTelevisionVideoController_HttpNone)callback;


/**
 获取电视剧集信息（参数是电视剧集id）
 @param televisionEpisodeId 电视剧集id
 */
+(void) getTelevisionEpisodeInfo1:(int64_t)televisionEpisodeId  callback:(CallBackTelevisionVideoController_TelevisionEpisodeInfoVO)callback;

@end

NS_ASSUME_NONNULL_END
