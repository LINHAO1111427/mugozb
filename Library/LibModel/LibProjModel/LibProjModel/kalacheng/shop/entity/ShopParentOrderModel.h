//此代码由 http://code.siwaha.com/ 生成，服务器修改后可重新生成

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN




/**
父商品订单表
 */
@interface ShopParentOrderModel : NSObject 


	/**
用户id
 */
@property (nonatomic, assign) int64_t uid;

	/**
订单金额
 */
@property (nonatomic, assign) double amount;

	/**
下单时间
 */
@property (nonatomic,copy) NSDate * addTime;

	/**
支付时间
 */
@property (nonatomic,copy) NSDate * payTime;

	/**
实付金额
 */
@property (nonatomic, assign) double nhrAmount;

	/**
订单号
 */
@property (nonatomic, copy) NSString * orderNum;

	/**
null
 */
@property (nonatomic, assign) int64_t id_field;

	/**
备注
 */
@property (nonatomic, copy) NSString * remake;

	/**
支付渠道 1.支付宝 2.微信  
 */
@property (nonatomic, assign) int64_t channelId;

	/**
支付交易号(支付宝或者微信返回)
 */
@property (nonatomic, copy) NSString * payOrder;

	/**
订单状态 1.待付款 2.付款成功 3.付款失败 
 */
@property (nonatomic, assign) int status;

 +(NSMutableArray<ShopParentOrderModel*>*)getFromArr:(NSArray*)list;

 -(NSDictionary*)modelToJSONObject;

 +(NSMutableArray*)modelToJSONArray:(NSMutableArray<ShopParentOrderModel*>*)list;

 +(ShopParentOrderModel*)getFromDict:(NSDictionary*)dict;

 +(void)cloneObj:(ShopParentOrderModel*) source target:(ShopParentOrderModel*)target;

@end

NS_ASSUME_NONNULL_END
