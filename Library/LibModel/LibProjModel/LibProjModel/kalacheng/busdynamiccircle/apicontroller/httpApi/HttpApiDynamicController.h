//此代码由 http://code.siwaha.com/ 生成，服务器修改后可重新生成
#import <Foundation/Foundation.h>

#import <LibProjBase/PageInfo.h>


#import "HttpNoneModel.h"

#import "AppVideoTopicModel.h"

#import "DynamicAppealTypeVOModel.h"

#import "DynamicController_publishDynamic.h"
#import "ApiUsersVideoCommentsModel.h"

#import "MyInfoDynamicCircleModel.h"

#import "ApiUserVideoModel.h"

typedef void (^CallBackDynamicController_HttpNone)(int code,NSString *strMsg,HttpNoneModel* model);
typedef void (^CallBackDynamicController_AppVideoTopicArr)(int code,NSString *strMsg,NSArray<AppVideoTopicModel*>* arr);
typedef void (^CallBackDynamicController_DynamicAppealTypeVOArr)(int code,NSString *strMsg,NSArray<DynamicAppealTypeVOModel*>* arr);
typedef void (^CallBackDynamicController_ApiUsersVideoComments)(int code,NSString *strMsg,ApiUsersVideoCommentsModel* model);
typedef void (^CallBackDynamicController_MyInfoDynamicCircleArr)(int code,NSString *strMsg,NSArray<MyInfoDynamicCircleModel*>* arr);
typedef void (^CallBackDynamicController_ApiUserVideoPageArr)(int code,NSString *strMsg,PageInfo *pageInfo,NSArray<ApiUserVideoModel*>* arr);
typedef void (^CallBackDynamicController_ApiUserVideoArr)(int code,NSString *strMsg,NSArray<ApiUserVideoModel*>* arr);
typedef void (^CallBackDynamicController_ApiUserVideo)(int code,NSString *strMsg,ApiUserVideoModel* model);
typedef void (^CallBackDynamicController_ApiUsersVideoCommentsPageArr)(int code,NSString *strMsg,PageInfo *pageInfo,NSArray<ApiUsersVideoCommentsModel*>* arr);
NS_ASSUME_NONNULL_BEGIN



/**
动态API（新）
 */
@interface HttpApiDynamicController: NSObject



/**
 动态点赞/取消
 @param dynamicId 动态id
 */
+(void) dynamicZan:(int64_t)dynamicId  callback:(CallBackDynamicController_HttpNone)callback;


/**
 动态话题列表
 @param page 页数
 @param pageSize 每页的条数
 */
+(void) getTopicList:(int)page pageSize:(int)pageSize  callback:(CallBackDynamicController_AppVideoTopicArr)callback;


/**
 动态添加/取消收藏（返回 1：收藏成功 -1：取消收藏）
 @param dynamicId 动态id
 */
+(void) addOrdelDynamicCollect:(int64_t)dynamicId  callback:(CallBackDynamicController_HttpNone)callback;


/**
 删除动态
 @param dynamicId 动态id
 */
+(void) delDynamic:(int64_t)dynamicId  callback:(CallBackDynamicController_HttpNone)callback;


/**
 删除评论/回复
 @param commentId 评论id
 */
+(void) delComment:(int64_t)commentId  callback:(CallBackDynamicController_HttpNone)callback;


/**
 获取动态举报类型
 */
+(void) getDynamicAppealTypeList:(CallBackDynamicController_DynamicAppealTypeVOArr)callback;




/**
 发布动态(新)code为3时请先认证
 @param address 详细地址
 @param channelId 频道id
 @param city 城市
 @param coin 默认0元即可， 填写金币金额
 @param content 动态内容
 @param height 视频高
 @param hidePublishingAddress 隐藏发布位置 0:未开启 1:开启
 @param href 视频地址(视频类型时才传入)
 @param images 动态图片（逗号拼接）
 @param isPrivate 是否私密 0：正常 1：私密
 @param lat 纬度
 @param lng 经度
 @param musicId 音乐id
 @param sourceFrom 资源来源 1:首页发布动态 2:其他地方发布出来的动态
 @param thumb 动态封面图
 @param title 动态标题
 @param topicId 动态话题ID
 @param type 类型 0:只有文字 1:视频动态 2:图片动态
 @param videoTime 视频时长
 @param width 视频宽
 */
+(void) publishDynamic:(DynamicController_publishDynamic*)_mdl callback:(CallBackDynamicController_HttpNone)callback;
/**
 发布动态(新)code为3时请先认证
 @param address 详细地址
 @param channelId 频道id
 @param city 城市
 @param coin 默认0元即可， 填写金币金额
 @param content 动态内容
 @param height 视频高
 @param hidePublishingAddress 隐藏发布位置 0:未开启 1:开启
 @param href 视频地址(视频类型时才传入)
 @param images 动态图片（逗号拼接）
 @param isPrivate 是否私密 0：正常 1：私密
 @param lat 纬度
 @param lng 经度
 @param musicId 音乐id
 @param sourceFrom 资源来源 1:首页发布动态 2:其他地方发布出来的动态
 @param thumb 动态封面图
 @param title 动态标题
 @param topicId 动态话题ID
 @param type 类型 0:只有文字 1:视频动态 2:图片动态
 @param videoTime 视频时长
 @param width 视频宽
 */
+(void) publishDynamic:(NSString *)address channelId:(int64_t)channelId city:(NSString *)city coin:(double)coin content:(NSString *)content height:(int)height hidePublishingAddress:(int)hidePublishingAddress href:(NSString *)href images:(NSString *)images isPrivate:(int)isPrivate lat:(double)lat lng:(double)lng musicId:(int64_t)musicId sourceFrom:(int)sourceFrom thumb:(NSString *)thumb title:(NSString *)title topicId:(int64_t)topicId type:(int)type videoTime:(NSString *)videoTime width:(int)width  callback:(CallBackDynamicController_HttpNone)callback;


/**
 发布评论/回复
 @param commentType 评论类型1评论2回复
 @param content 评论内容
 @param objId 视频/评论id
 */
+(void) addComment:(int)commentType content:(NSString *)content objId:(int64_t)objId  callback:(CallBackDynamicController_ApiUsersVideoComments)callback;


/**
 获取用户非文本的动态信息（现在只有封面）
 @param toUserId 被查看者用户ID
 */
+(void) getNoTextDynamicCircle:(int64_t)toUserId  callback:(CallBackDynamicController_MyInfoDynamicCircleArr)callback;


/**
 查询评论个数
 @param dynamicId 动态id
 */
+(void) getCommentCount:(int64_t)dynamicId  callback:(CallBackDynamicController_HttpNone)callback;


/**
 获取动态列表
 @param hotId 话题id
 @param page 页数
 @param pageSize 每页的条数
 @param touid 要查看的用户的ID(只查询这个人的动态时需要传)
 @param type 类型 0:全部 1:推荐 2:关注 3：点赞 4：收藏
 */
+(void) getDynamicList:(int64_t)hotId page:(int)page pageSize:(int)pageSize touid:(int64_t)touid type:(int)type  callback:(CallBackDynamicController_ApiUserVideoPageArr)callback;


/**
 搜索动态
 @param pageIndex 页数
 @param pageSize 每页的条数
 @param searchText 搜索的文字
 */
+(void) getSearchDynamicList:(int)pageIndex pageSize:(int)pageSize searchText:(NSString *)searchText  callback:(CallBackDynamicController_ApiUserVideoArr)callback;


/**
 获取动态详情
 @param commentId 评论id(通知列表的commentId)没有则传-1
 @param dynamicId 视频ID
 @param type 来源 -1:查看详情 1:消息评论 2:消息点赞
 */
+(void) getDynamicInfo:(int)commentId dynamicId:(int64_t)dynamicId type:(int)type  callback:(CallBackDynamicController_ApiUserVideo)callback;


/**
 动态评论列表
 @param dynamicId 动态id
 @param page 页数
 @param pageSize 每页的条数
 */
+(void) getCommentBasicInfo:(int64_t)dynamicId page:(int)page pageSize:(int)pageSize  callback:(CallBackDynamicController_ApiUsersVideoCommentsPageArr)callback;


/**
 添加动态举报信息
 @param dynamicAppealDescription 动态举报描述
 @param dynamicAppealImages 动态举报图片
 @param dynamicAppealTypeId 动态举报分类id
 @param dynamicAppealTypeName 动态举报分类名称
 @param dynamicId 被举报的动态id
 */
+(void) addDynamicAppeal:(NSString *)dynamicAppealDescription dynamicAppealImages:(NSString *)dynamicAppealImages dynamicAppealTypeId:(int64_t)dynamicAppealTypeId dynamicAppealTypeName:(NSString *)dynamicAppealTypeName dynamicId:(int64_t)dynamicId  callback:(CallBackDynamicController_HttpNone)callback;


/**
 动态置顶和取消置顶
 @param dynamicId 动态id
 @param optType 操作类型 1:个人动态置顶 2:个人动态取消置顶
 */
+(void) addDynamicPersonalTop:(int64_t)dynamicId optType:(int)optType  callback:(CallBackDynamicController_HttpNone)callback;

@end

NS_ASSUME_NONNULL_END
