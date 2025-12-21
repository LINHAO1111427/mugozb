//此代码由 http://code.siwaha.com/ 生成，服务器修改后可重新生成
#import <Foundation/Foundation.h>

#import <LibProjBase/PageInfo.h>


#import "HttpNoneModel.h"

#import "StartPayRetModel.h"

typedef void (^CallBackApiPay_HttpNone)(int code,NSString *strMsg,HttpNoneModel* model);
typedef void (^CallBackApiPay_StartPayRet)(int code,NSString *strMsg,StartPayRetModel* model);
NS_ASSUME_NONNULL_BEGIN



/**
支付相关的接口
 */
@interface HttpApiApiPay: NSObject



/**
 苹果内购校验  1校验成功  2苹果验证失败，返回数据为空
 @param orderNo 订单号
 @param payload 校验体（base64字符串）
 @param transactionId 苹果内购交易ID
 */
+(void) iosPayCallBack:(NSString *)orderNo payload:(NSString *)payload transactionId:(NSString *)transactionId  callback:(CallBackApiPay_HttpNone)callback;


/**
 选择充值规则进行充值,返回value为支付宝/微信支付等需要的参数
 @param channelId 支付渠道ID 1:支付宝 2:微信 3:ios内购 11：钱方支付宝 12：钱方微信 21：汇潮支付宝 22：汇潮微信 31：首易信支付宝 32：首易信微信
 @param productId 商品id
 @param type 业务类型 1：金币充值  2：购物支付 3.待定 4.购买贵族 5.购买SVIP 6.开通守护
 @param userId 受益人id
 */
+(void) startPay:(int64_t)channelId productId:(int64_t)productId type:(int)type userId:(int64_t)userId  callback:(CallBackApiPay_StartPayRet)callback;

@end

NS_ASSUME_NONNULL_END
