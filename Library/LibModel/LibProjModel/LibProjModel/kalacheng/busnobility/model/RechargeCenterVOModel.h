//此代码由 http://code.siwaha.com/ 生成，服务器修改后可重新生成

#import <Foundation/Foundation.h>

 @class RechargeRulesVOModel;
 @class FixedWithdrawRuleVOModel;
NS_ASSUME_NONNULL_BEGIN




/**
充值中心充值礼物model
 */
@interface RechargeCenterVOModel : NSObject 


	/**
提示文字
 */
@property (nonatomic, copy) NSString * promptContent;

	/**
充值中心充值礼包
 */
@property (nonatomic, strong) NSMutableArray<RechargeRulesVOModel*>* rechargeRulesVOList;

	/**
兑换金币 0:关闭 1:开启
 */
@property (nonatomic, assign) int coinExchange;

	/**
贵族折扣
 */
@property (nonatomic, assign) double nobleDiscount;

	/**
是否首次充值 0:是 1:否
 */
@property (nonatomic, assign) int isFirstRecharge;

	/**
贵族图标
 */
@property (nonatomic, copy) NSString * nobleIcon;

	/**
贵族名称
 */
@property (nonatomic, copy) NSString * nobleName;

	/**
用户金币
 */
@property (nonatomic, assign) double userCoin;

	/**
提现金额方式 0:灵活输入 1:固定数值
 */
@property (nonatomic, assign) int withdrawalAmountManner;

	/**
固定提现金额列表(固定数值时才有值)
 */
@property (nonatomic, strong) NSMutableArray<FixedWithdrawRuleVOModel*>* fixedWithdrawRuleVOList;

	/**
是否贵族 0:是 1:否
 */
@property (nonatomic, assign) int isVip;

 +(NSMutableArray<RechargeCenterVOModel*>*)getFromArr:(NSArray*)list;

 -(NSDictionary*)modelToJSONObject;

 +(NSMutableArray*)modelToJSONArray:(NSMutableArray<RechargeCenterVOModel*>*)list;

 +(RechargeCenterVOModel*)getFromDict:(NSDictionary*)dict;

 +(void)cloneObj:(RechargeCenterVOModel*) source target:(RechargeCenterVOModel*)target;

@end

NS_ASSUME_NONNULL_END
