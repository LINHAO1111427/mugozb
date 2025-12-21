//此代码由 http://code.siwaha.com/ 生成，服务器修改后可重新生成

#import <Foundation/Foundation.h>

 @class CommentLableVOModel;
NS_ASSUME_NONNULL_BEGIN




/**
主播评价列表
 */
@interface AnchorCommentVOModel : NSObject 


	/**
评论信息
 */
@property (nonatomic, strong) NSMutableArray<CommentLableVOModel*>* commentList;

	/**
评论标签字符串集
 */
@property (nonatomic, copy) NSString * tableInfoIds;

	/**
用户头像
 */
@property (nonatomic, copy) NSString * avatar;

	/**
用户id
 */
@property (nonatomic, assign) int64_t userid;

	/**
用户名称
 */
@property (nonatomic, copy) NSString * username;

 +(NSMutableArray<AnchorCommentVOModel*>*)getFromArr:(NSArray*)list;

 -(NSDictionary*)modelToJSONObject;

 +(NSMutableArray*)modelToJSONArray:(NSMutableArray<AnchorCommentVOModel*>*)list;

 +(AnchorCommentVOModel*)getFromDict:(NSDictionary*)dict;

 +(void)cloneObj:(AnchorCommentVOModel*) source target:(AnchorCommentVOModel*)target;

@end

NS_ASSUME_NONNULL_END
