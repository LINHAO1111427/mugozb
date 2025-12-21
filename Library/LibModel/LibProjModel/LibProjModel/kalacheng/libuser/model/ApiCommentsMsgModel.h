//此代码由 http://code.siwaha.com/ 生成，服务器修改后可重新生成

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN




/**
动态评论消息
 */
@interface ApiCommentsMsgModel : NSObject 


	/**
用户id
 */
@property (nonatomic, assign) int64_t uid;

	/**
角色，0普通用户，1主播
 */
@property (nonatomic, assign) int role;

	/**
评论类型-1无0只有文字1视频动态2图片动态
 */
@property (nonatomic, assign) int sourceType;

	/**
消息时间
 */
@property (nonatomic,copy) NSDate * addtime;

	/**
是否已读0已读1未读
 */
@property (nonatomic, assign) int isRead;

	/**
评论id
 */
@property (nonatomic, assign) int64_t commentId;

	/**
动态/短视频id
 */
@property (nonatomic, assign) int64_t videoId;

	/**
用户头像
 */
@property (nonatomic, copy) NSString * avatar;

	/**
类型1评论2点赞
 */
@property (nonatomic, assign) int type;

	/**
用户名称
 */
@property (nonatomic, copy) NSString * userName;

	/**
评论内容
 */
@property (nonatomic, copy) NSString * content;

	/**
图片或视频地址
 */
@property (nonatomic, copy) NSString * url;

 +(NSMutableArray<ApiCommentsMsgModel*>*)getFromArr:(NSArray*)list;

 -(NSDictionary*)modelToJSONObject;

 +(NSMutableArray*)modelToJSONArray:(NSMutableArray<ApiCommentsMsgModel*>*)list;

 +(ApiCommentsMsgModel*)getFromDict:(NSDictionary*)dict;

 +(void)cloneObj:(ApiCommentsMsgModel*) source target:(ApiCommentsMsgModel*)target;

@end

NS_ASSUME_NONNULL_END
