//此代码由 http://code.siwaha.com/ 生成，服务器修改后可重新生成

#import <Foundation/Foundation.h>

 @class AppUserPromiseOrderEvaluateVOModel;
NS_ASSUME_NONNULL_BEGIN




/**
邀约订单评价显示
 */
@interface AppShowUserPromiseOrderEvaluateVOModel : NSObject 


	/**
综合得分（平均值）
 */
@property (nonatomic, assign) double orderComplexScore;

	/**
评论和每一条的评分
 */
@property (nonatomic, strong) NSMutableArray<AppUserPromiseOrderEvaluateVOModel*>* appUserPromiseOrderEvaluateVOList;

	/**
获得的标签和数量 json格式
 */
@property (nonatomic, copy) NSString * promiseTag;

	/**
用户ID
 */
@property (nonatomic, assign) int64_t userId;

 +(NSMutableArray<AppShowUserPromiseOrderEvaluateVOModel*>*)getFromArr:(NSArray*)list;

 -(NSDictionary*)modelToJSONObject;

 +(NSMutableArray*)modelToJSONArray:(NSMutableArray<AppShowUserPromiseOrderEvaluateVOModel*>*)list;

 +(AppShowUserPromiseOrderEvaluateVOModel*)getFromDict:(NSDictionary*)dict;

 +(void)cloneObj:(AppShowUserPromiseOrderEvaluateVOModel*) source target:(AppShowUserPromiseOrderEvaluateVOModel*)target;

@end

NS_ASSUME_NONNULL_END
