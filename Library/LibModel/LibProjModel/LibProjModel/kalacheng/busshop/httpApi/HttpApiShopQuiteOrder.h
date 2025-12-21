//此代码由 http://code.siwaha.com/ 生成，服务器修改后可重新生成
#import <Foundation/Foundation.h>

#import <LibProjBase/PageInfo.h>


#import "HttpNoneModel.h"

#import "ApplyRefundDTOModel.h"

typedef void (^CallBackShopQuiteOrder_HttpNone)(int code,NSString *strMsg,HttpNoneModel* model);
typedef void (^CallBackShopQuiteOrder_ApplyRefundDTO)(int code,NSString *strMsg,ApplyRefundDTOModel* model);
NS_ASSUME_NONNULL_BEGIN



/**
退款订单控制器
 */
@interface HttpApiShopQuiteOrder: NSObject



/**
 确认申请退款
 @param businessOrderId 商家订单id
 @param reasonId 退款原因id
 @param refundNotes 退款备注
 @param refundNotesImages 退款备注图片
 @param type 1.仅退款，2.退货退款
 */
+(void) applyRefund:(int64_t)businessOrderId reasonId:(int64_t)reasonId refundNotes:(NSString *)refundNotes refundNotesImages:(NSString *)refundNotesImages type:(int)type  callback:(CallBackShopQuiteOrder_HttpNone)callback;


/**
 退款-卖家收货
 @param businessOrderId 商家订单id
 @param reason 拒绝原因
 @param state 退款审核状态：1.同意，2.拒绝
 */
+(void) sellerReceipt:(int64_t)businessOrderId reason:(NSString *)reason state:(int)state  callback:(CallBackShopQuiteOrder_HttpNone)callback;


/**
 申请退款
 @param businessOrderId 商家订单id
 */
+(void) beforApplyRefund:(int64_t)businessOrderId  callback:(CallBackShopQuiteOrder_ApplyRefundDTO)callback;


/**
 退款审核
 @param businessOrderId 商家订单id
 @param reason 拒绝原因
 @param state 退款审核状态：1.同意，2.拒绝
 */
+(void) refundAudit:(int64_t)businessOrderId reason:(NSString *)reason state:(int)state  callback:(CallBackShopQuiteOrder_HttpNone)callback;


/**
 取消申请退款
 @param businessOrderId 商家订单id
 */
+(void) cancelApplyRefund:(int64_t)businessOrderId  callback:(CallBackShopQuiteOrder_HttpNone)callback;


/**
 退款-买家发货
 @param businessOrderId 商家订单id
 @param logisticsName 物流名称
 @param logisticsNum 物流单号
 */
+(void) buyerDeliver:(int64_t)businessOrderId logisticsName:(NSString *)logisticsName logisticsNum:(NSString *)logisticsNum  callback:(CallBackShopQuiteOrder_HttpNone)callback;

@end

NS_ASSUME_NONNULL_END
