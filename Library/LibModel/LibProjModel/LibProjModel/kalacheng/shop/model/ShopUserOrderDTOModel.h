//此代码由 http://code.siwaha.com/ 生成，服务器修改后可重新生成

#import <Foundation/Foundation.h>

 @class ShopBusinessOrderModel;
 @class AppUserModel;
 @class ShopSubOrderModel;
NS_ASSUME_NONNULL_BEGIN




/**
用户(主播)订单列表返回
 */
@interface ShopUserOrderDTOModel : NSObject 


	/**
商家订单信息
 */
@property (strong, nonatomic) ShopBusinessOrderModel* businessOrder;

	/**
买家信息
 */
@property (strong, nonatomic) AppUserModel* buyUser;

	/**
买家发货物流单号
 */
@property (nonatomic, copy) NSString * logisticsNum;

	/**
退货物流单号
 */
@property (nonatomic, copy) NSString * refundLogisticsNum;

	/**
对应的商品信息
 */
@property (nonatomic, strong) NSMutableArray<ShopSubOrderModel*>* subOrderList;

	/**
主播id
 */
@property (nonatomic, assign) int64_t anchorId;

	/**
商品总数量
 */
@property (nonatomic, assign) int goodsNum;

 +(NSMutableArray<ShopUserOrderDTOModel*>*)getFromArr:(NSArray*)list;

 -(NSDictionary*)modelToJSONObject;

 +(NSMutableArray*)modelToJSONArray:(NSMutableArray<ShopUserOrderDTOModel*>*)list;

 +(ShopUserOrderDTOModel*)getFromDict:(NSDictionary*)dict;

 +(void)cloneObj:(ShopUserOrderDTOModel*) source target:(ShopUserOrderDTOModel*)target;

@end

NS_ASSUME_NONNULL_END
