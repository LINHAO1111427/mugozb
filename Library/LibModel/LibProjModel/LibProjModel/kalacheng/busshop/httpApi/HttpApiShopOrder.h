//此代码由 http://code.siwaha.com/ 生成，服务器修改后可重新生成
#import <Foundation/Foundation.h>

#import <LibProjBase/PageInfo.h>


#import "HttpNoneModel.h"

#import "ApiShopLogisticsDTOModel.h"

#import "ShopBusinessOrderInfoDTOModel.h"

#import "ShopOrderNumDTOModel.h"

#import "ShopUserOrderDTOModel.h"

#import "ShopLogisticsDTOModel.h"

#import "ShopUserOrderDetailDTOModel.h"

typedef void (^CallBackShopOrder_HttpNone)(int code,NSString *strMsg,HttpNoneModel* model);
typedef void (^CallBackShopOrder_ApiShopLogisticsDTO)(int code,NSString *strMsg,ApiShopLogisticsDTOModel* model);
typedef void (^CallBackShopOrder_ShopBusinessOrderInfoDTO)(int code,NSString *strMsg,ShopBusinessOrderInfoDTOModel* model);
typedef void (^CallBackShopOrder_ShopOrderNumDTO)(int code,NSString *strMsg,ShopOrderNumDTOModel* model);
typedef void (^CallBackShopOrder_ShopUserOrderDTOArr)(int code,NSString *strMsg,NSArray<ShopUserOrderDTOModel*>* arr);
typedef void (^CallBackShopOrder_ShopLogisticsDTO)(int code,NSString *strMsg,ShopLogisticsDTOModel* model);
typedef void (^CallBackShopOrder_ShopUserOrderDetailDTO)(int code,NSString *strMsg,ShopUserOrderDetailDTOModel* model);
NS_ASSUME_NONNULL_BEGIN



/**
商品订单信息API
 */
@interface HttpApiShopOrder: NSObject



/**
 确认收货
 @param businessOrderId 商家订单id
 */
+(void) confirmReceipt:(int64_t)businessOrderId  callback:(CallBackShopOrder_HttpNone)callback;


/**
 获取物流信息
 @param number 物流单号
 @param orderNo 订单编号
 */
+(void) getLogistics:(NSString *)number orderNo:(NSString *)orderNo  callback:(CallBackShopOrder_ApiShopLogisticsDTO)callback;


/**
 获取商家订单数据
 @param searchDay 区分日期标识 0:今日 1:昨日 2:本周 3:上周 4:上月
 */
+(void) getBusinessOrderInfo:(int)searchDay  callback:(CallBackShopOrder_ShopBusinessOrderInfoDTO)callback;


/**
 提醒发货
 @param businessOrderId 商家订单id
 */
+(void) remindMerchantsOfDelivery:(int64_t)businessOrderId  callback:(CallBackShopOrder_HttpNone)callback;


/**
 获取订单数量
 @param type 1:买家 2:卖家
 */
+(void) getOrderNum:(int)type  callback:(CallBackShopOrder_ShopOrderNumDTO)callback;


/**
 确认发货
 @param businessOrderId 商家订单id
 @param logisticsName 物流名称
 @param logisticsNum 物流单号
 */
+(void) confirmSent:(int64_t)businessOrderId logisticsName:(NSString *)logisticsName logisticsNum:(NSString *)logisticsNum  callback:(CallBackShopOrder_HttpNone)callback;


/**
 获取用户订单列表
 @param pageIndex 当前页
 @param pageSize 每页大小
 @param quitStatus 退款订单状态 0:全部 1:待审核 2:待发货 3:待收货 4:退款中 5:退款完成 6:退款失败
 @param status 订单状态 0:全部 1:待付款 2:待发货 3:待收货 4:订单完成
 */
+(void) getUserOrderList:(int)pageIndex pageSize:(int)pageSize quitStatus:(int)quitStatus status:(int)status  callback:(CallBackShopOrder_ShopUserOrderDTOArr)callback;


/**
 获取可用物流列表
 */
+(void) getLogisticsList:(CallBackShopOrder_ShopLogisticsDTO)callback;


/**
 获取订单详情
 @param businessOrderId 商家订单id
 */
+(void) getUserOrderDetail:(int64_t)businessOrderId  callback:(CallBackShopOrder_ShopUserOrderDetailDTO)callback;


/**
 修改订单地址信息
 @param addressId 订单地址id
 @param businessOrderId 商家订单id
 */
+(void) updateOrderAddress:(int64_t)addressId businessOrderId:(int64_t)businessOrderId  callback:(CallBackShopOrder_HttpNone)callback;


/**
 取消订单
 @param businessOrderId 商家订单id
 */
+(void) cancelOrder:(int64_t)businessOrderId  callback:(CallBackShopOrder_HttpNone)callback;


/**
 获取主播(商家)订单列表
 @param pageIndex 当前页
 @param pageSize 每页大小
 @param quitStatus 退款订单状态0,全部 1,待审核 2,待发货 3,待收货 4,退款中 5.退款完成 6.退款失败
 @param status 订单状态0.全部 1.待付款 2.待发货 3.待收货 4.订单完成
 */
+(void) getAnchorOrderList:(int)pageIndex pageSize:(int)pageSize quitStatus:(int)quitStatus status:(int)status  callback:(CallBackShopOrder_ShopUserOrderDTOArr)callback;

@end

NS_ASSUME_NONNULL_END
