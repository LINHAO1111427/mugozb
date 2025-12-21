//此代码由 http://code.siwaha.com/ 生成，服务器修改后可重新生成

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN




/**
寻觅-我的订单 显示的数量
 */
@interface AppShowOrderNumberVOModel : NSObject 


	/**
等待评价数量
 */
@property (nonatomic, assign) int waitingEvaluationNum;

	/**
进行中数量
 */
@property (nonatomic, assign) int processingNum;

 +(NSMutableArray<AppShowOrderNumberVOModel*>*)getFromArr:(NSArray*)list;

 -(NSDictionary*)modelToJSONObject;

 +(NSMutableArray*)modelToJSONArray:(NSMutableArray<AppShowOrderNumberVOModel*>*)list;

 +(AppShowOrderNumberVOModel*)getFromDict:(NSDictionary*)dict;

 +(void)cloneObj:(AppShowOrderNumberVOModel*) source target:(AppShowOrderNumberVOModel*)target;

@end

NS_ASSUME_NONNULL_END
