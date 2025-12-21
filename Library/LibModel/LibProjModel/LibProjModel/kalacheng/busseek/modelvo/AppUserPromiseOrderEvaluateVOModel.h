//此代码由 http://code.siwaha.com/ 生成，服务器修改后可重新生成

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN




/**
邀约订单评价VO
 */
@interface AppUserPromiseOrderEvaluateVOModel : NSObject 


	/**
订单评分 0-5
 */
@property (nonatomic, assign) double orderScore;

	/**
订单评论
 */
@property (nonatomic, copy) NSString * orderComment;

	/**
用户头像
 */
@property (nonatomic, copy) NSString * userAvatar;

	/**
null
 */
@property (nonatomic, assign) int64_t id_field;

	/**
用户名称
 */
@property (nonatomic, copy) NSString * userName;

	/**
被评论用户id
 */
@property (nonatomic, assign) int64_t toUserId;

	/**
用户ID
 */
@property (nonatomic, assign) int64_t userId;

	/**
邀约订单id
 */
@property (nonatomic, assign) int64_t promiseOrderId;

 +(NSMutableArray<AppUserPromiseOrderEvaluateVOModel*>*)getFromArr:(NSArray*)list;

 -(NSDictionary*)modelToJSONObject;

 +(NSMutableArray*)modelToJSONArray:(NSMutableArray<AppUserPromiseOrderEvaluateVOModel*>*)list;

 +(AppUserPromiseOrderEvaluateVOModel*)getFromDict:(NSDictionary*)dict;

 +(void)cloneObj:(AppUserPromiseOrderEvaluateVOModel*) source target:(AppUserPromiseOrderEvaluateVOModel*)target;

@end

NS_ASSUME_NONNULL_END
