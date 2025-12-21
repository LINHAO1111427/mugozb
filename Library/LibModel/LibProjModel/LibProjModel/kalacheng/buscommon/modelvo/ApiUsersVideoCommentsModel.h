//此代码由 http://code.siwaha.com/ 生成，服务器修改后可重新生成

#import <Foundation/Foundation.h>

 @class ApiUsersVideoCommentsModel;
NS_ASSUME_NONNULL_BEGIN




/**
动态评论列表
 */
@interface ApiUsersVideoCommentsModel : NSObject 


	/**
评论时间(展示)
 */
@property (nonatomic, copy) NSString * addtimeStr;

	/**
用户id
 */
@property (nonatomic, assign) int64_t uid;

	/**
用户id
 */
@property (nonatomic, assign) int64_t toUid;

	/**
评论时间
 */
@property (nonatomic,copy) NSDate * addtime;

	/**
评论类型1评论2回复
 */
@property (nonatomic, assign) int commentType;

	/**
评论id
 */
@property (nonatomic, assign) int64_t commentid;

	/**
用户名称
 */
@property (nonatomic, copy) NSString * toUserName;

	/**
回复列表
 */
@property (nonatomic, strong) NSMutableArray<ApiUsersVideoCommentsModel*>* replyList;

	/**
用户头像
 */
@property (nonatomic, copy) NSString * avatar;

	/**
用户名称
 */
@property (nonatomic, copy) NSString * userName;

	/**
评论内容
 */
@property (nonatomic, copy) NSString * content;

 +(NSMutableArray<ApiUsersVideoCommentsModel*>*)getFromArr:(NSArray*)list;

 -(NSDictionary*)modelToJSONObject;

 +(NSMutableArray*)modelToJSONArray:(NSMutableArray<ApiUsersVideoCommentsModel*>*)list;

 +(ApiUsersVideoCommentsModel*)getFromDict:(NSDictionary*)dict;

 +(void)cloneObj:(ApiUsersVideoCommentsModel*) source target:(ApiUsersVideoCommentsModel*)target;

@end

NS_ASSUME_NONNULL_END
