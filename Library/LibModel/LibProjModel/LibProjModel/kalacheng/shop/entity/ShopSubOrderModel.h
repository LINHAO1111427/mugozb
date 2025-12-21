//此代码由 http://code.siwaha.com/ 生成，服务器修改后可重新生成

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN




/**
子商品订单表
 */
@interface ShopSubOrderModel : NSObject 


	/**
添加时间
 */
@property (nonatomic,copy) NSDate * addTime;

	/**
商品id
 */
@property (nonatomic, assign) int64_t goodsId;

	/**
商家id
 */
@property (nonatomic, assign) int64_t businessId;

	/**
订单号
 */
@property (nonatomic, copy) NSString * orderNum;

	/**
备注
 */
@property (nonatomic, copy) NSString * remake;

	/**
商品简介图片地址
 */
@property (nonatomic, copy) NSString * goodsPicture;

	/**
物流名称
 */
@property (nonatomic, copy) NSString * logisticsName;

	/**
sku组合名称
 */
@property (nonatomic, copy) NSString * skuName;

	/**
商家订单id
 */
@property (nonatomic, assign) int64_t businessOrderId;

	/**
商品价格
 */
@property (nonatomic, assign) double goodsPrice;

	/**
null
 */
@property (nonatomic, assign) int64_t id_field;

	/**
物流单号
 */
@property (nonatomic, copy) NSString * logisticsNum;

	/**
父订单(支付订单)id
 */
@property (nonatomic, assign) int64_t payId;

	/**
skuId
 */
@property (nonatomic, assign) int64_t composeId;

	/**
商品名称
 */
@property (nonatomic, copy) NSString * goodsName;

	/**
商品数量
 */
@property (nonatomic, assign) int goodsNum;

	/**
订单状态 1：待付款 2：待发货 3：待收货 4：已完成 5：已取消
 */
@property (nonatomic, assign) int status;

 +(NSMutableArray<ShopSubOrderModel*>*)getFromArr:(NSArray*)list;

 -(NSDictionary*)modelToJSONObject;

 +(NSMutableArray*)modelToJSONArray:(NSMutableArray<ShopSubOrderModel*>*)list;

 +(ShopSubOrderModel*)getFromDict:(NSDictionary*)dict;

 +(void)cloneObj:(ShopSubOrderModel*) source target:(ShopSubOrderModel*)target;

@end

NS_ASSUME_NONNULL_END
