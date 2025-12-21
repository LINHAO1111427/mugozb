//此代码由 http://code.siwaha.com/ 生成，服务器修改后可重新生成

#import <Foundation/Foundation.h>

 @class ShopOrderReturnProcessDTOModel;
 @class ShopParentOrderModel;
 @class ShopBusinessOrderModel;
 @class ShopSubOrderModel;
NS_ASSUME_NONNULL_BEGIN




/**
订单详情返回
 */
@interface ShopUserOrderDetailDTOModel : NSObject 


	/**
退款流程集合
 */
@property (nonatomic, strong) NSMutableArray<ShopOrderReturnProcessDTOModel*>* processList;

	/**
父订单信息
 */
@property (strong, nonatomic) ShopParentOrderModel* parentOrder;

	/**
商家订单信息
 */
@property (strong, nonatomic) ShopBusinessOrderModel* businessOrder;

	/**
卖家发货物流信息
 */
@property (nonatomic, copy) NSString * sellerLogisticsContent;

	/**
订单显示的天数
 */
@property (nonatomic, copy) NSString * refundShowDay;

	/**
对应的商品信息
 */
@property (nonatomic, strong) NSMutableArray<ShopSubOrderModel*>* subOrderList;

	/**
主播id
 */
@property (nonatomic, assign) int64_t anchorId;

	/**
买家头像
 */
@property (nonatomic, copy) NSString * buyUserAvatar;

	/**
截至时间
 */
@property (nonatomic,copy) NSDate * closingDate;

	/**
物流名称
 */
@property (nonatomic, copy) NSString * logisticsName;

	/**
卖家发货物流时间点
 */
@property (nonatomic,copy) NSDate * sellerLogisticsTime;

	/**
买家ID
 */
@property (nonatomic, assign) int64_t buyUserId;

	/**
买家名称
 */
@property (nonatomic, copy) NSString * buyUserName;

	/**
退货物流名称
 */
@property (nonatomic, copy) NSString * refundLogisticsName;

	/**
买家发货物流单号
 */
@property (nonatomic, copy) NSString * logisticsNum;

	/**
退货物流单号
 */
@property (nonatomic, copy) NSString * refundLogisticsNum;

	/**
商品总数量
 */
@property (nonatomic, assign) int goodsNum;

	/**
买家发货物流信息
 */
@property (nonatomic, copy) NSString * buyerLogisticsContent;

	/**
买家发货物流时间点
 */
@property (nonatomic,copy) NSDate * buyerLogisticsTime;

 +(NSMutableArray<ShopUserOrderDetailDTOModel*>*)getFromArr:(NSArray*)list;

 -(NSDictionary*)modelToJSONObject;

 +(NSMutableArray*)modelToJSONArray:(NSMutableArray<ShopUserOrderDetailDTOModel*>*)list;

 +(ShopUserOrderDetailDTOModel*)getFromDict:(NSDictionary*)dict;

 +(void)cloneObj:(ShopUserOrderDetailDTOModel*) source target:(ShopUserOrderDetailDTOModel*)target;

@end

NS_ASSUME_NONNULL_END
