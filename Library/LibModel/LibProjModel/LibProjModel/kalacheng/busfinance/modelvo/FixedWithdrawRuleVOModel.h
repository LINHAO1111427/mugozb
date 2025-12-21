//此代码由 http://code.siwaha.com/ 生成，服务器修改后可重新生成

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN




/**
收益固定提现规则VO
 */
@interface FixedWithdrawRuleVOModel : NSObject 


	/**
排序值
 */
@property (nonatomic, assign) int sortNum;

	/**
null
 */
@property (nonatomic, assign) int id_field;

	/**
提现数量
 */
@property (nonatomic, assign) double withdrawNum;

	/**
是否启用 0:不启用 1:启用
 */
@property (nonatomic, assign) int isEnable;

 +(NSMutableArray<FixedWithdrawRuleVOModel*>*)getFromArr:(NSArray*)list;

 -(NSDictionary*)modelToJSONObject;

 +(NSMutableArray*)modelToJSONArray:(NSMutableArray<FixedWithdrawRuleVOModel*>*)list;

 +(FixedWithdrawRuleVOModel*)getFromDict:(NSDictionary*)dict;

 +(void)cloneObj:(FixedWithdrawRuleVOModel*) source target:(FixedWithdrawRuleVOModel*)target;

@end

NS_ASSUME_NONNULL_END
