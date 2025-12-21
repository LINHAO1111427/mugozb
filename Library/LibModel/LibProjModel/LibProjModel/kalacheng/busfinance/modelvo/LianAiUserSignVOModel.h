//此代码由 http://code.siwaha.com/ 生成，服务器修改后可重新生成

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN




/**
恋爱用户签到配置VO
 */
@interface LianAiUserSignVOModel : NSObject 


	/**
赠送积分数
 */
@property (nonatomic, assign) double giftScore;

	/**
排序值
 */
@property (nonatomic, assign) int sortValue;

	/**
null
 */
@property (nonatomic, assign) int64_t id_field;

	/**
是否已经签过了 0：未签 1：已签
 */
@property (nonatomic, assign) int isSign;

 +(NSMutableArray<LianAiUserSignVOModel*>*)getFromArr:(NSArray*)list;

 -(NSDictionary*)modelToJSONObject;

 +(NSMutableArray*)modelToJSONArray:(NSMutableArray<LianAiUserSignVOModel*>*)list;

 +(LianAiUserSignVOModel*)getFromDict:(NSDictionary*)dict;

 +(void)cloneObj:(LianAiUserSignVOModel*) source target:(LianAiUserSignVOModel*)target;

@end

NS_ASSUME_NONNULL_END
