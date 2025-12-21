//此代码由 http://code.siwaha.com/ 生成，服务器修改后可重新生成

#import <Foundation/Foundation.h>

 @class RechargeCenterGiftPackVOModel;
NS_ASSUME_NONNULL_BEGIN




/**
充值中心充值礼物model
 */
@interface RechargeRulesVOModel : NSObject 


	/**
首充礼包
 */
@property (nonatomic, strong) NSMutableArray<RechargeCenterGiftPackVOModel*>* gifList;

	/**
充值价格
 */
@property (nonatomic, assign) double money;

	/**
苹果项目ID
 */
@property (nonatomic, copy) NSString * productId;

	/**
充值折扣描述
 */
@property (nonatomic, copy) NSString * dicountDesr;

	/**
贵族折扣金额
 */
@property (nonatomic, assign) double nobleDiscountMoney;

	/**
名称
 */
@property (nonatomic, copy) NSString * name;

	/**
折扣金额
 */
@property (nonatomic, assign) double discountMoney;

	/**
充值价格id
 */
@property (nonatomic, assign) int64_t id_field;

	/**
金币数量
 */
@property (nonatomic, assign) double coin;

 +(NSMutableArray<RechargeRulesVOModel*>*)getFromArr:(NSArray*)list;

 -(NSDictionary*)modelToJSONObject;

 +(NSMutableArray*)modelToJSONArray:(NSMutableArray<RechargeRulesVOModel*>*)list;

 +(RechargeRulesVOModel*)getFromDict:(NSDictionary*)dict;

 +(void)cloneObj:(RechargeRulesVOModel*) source target:(RechargeRulesVOModel*)target;

@end

NS_ASSUME_NONNULL_END
