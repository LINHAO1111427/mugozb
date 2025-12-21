//此代码由 http://code.siwaha.com/ 生成，服务器修改后可重新生成

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN




/**
映票兑换金币设置
 */
@interface TicketExchangeRuleModel : NSObject 


	/**
金币数量
 */
@property (nonatomic, assign) int coinNum;

	/**
映票数量
 */
@property (nonatomic, assign) int ticketNum;

	/**
排序序号
 */
@property (nonatomic, assign) int sortNum;

	/**
null
 */
@property (nonatomic, assign) int64_t id_field;

 +(NSMutableArray<TicketExchangeRuleModel*>*)getFromArr:(NSArray*)list;

 -(NSDictionary*)modelToJSONObject;

 +(NSMutableArray*)modelToJSONArray:(NSMutableArray<TicketExchangeRuleModel*>*)list;

 +(TicketExchangeRuleModel*)getFromDict:(NSDictionary*)dict;

 +(void)cloneObj:(TicketExchangeRuleModel*) source target:(TicketExchangeRuleModel*)target;

@end

NS_ASSUME_NONNULL_END
