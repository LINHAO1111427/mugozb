//此代码由 http://code.siwaha.com/ 生成，服务器修改后可重新生成

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN




/**
支持的提现方式
 */
@interface WithdrawalMethodModel : NSObject 


	/**
支付宝提现 0：不支持 1：支持
 */
@property (nonatomic, assign) int haveAliPay;

	/**
微信提现 0：不支持 1：支持
 */
@property (nonatomic, assign) int haveWeiXinPay;

	/**
银行卡提现 0：不支持 1：支持
 */
@property (nonatomic, assign) int haveBankCard;

 +(NSMutableArray<WithdrawalMethodModel*>*)getFromArr:(NSArray*)list;

 -(NSDictionary*)modelToJSONObject;

 +(NSMutableArray*)modelToJSONArray:(NSMutableArray<WithdrawalMethodModel*>*)list;

 +(WithdrawalMethodModel*)getFromDict:(NSDictionary*)dict;

 +(void)cloneObj:(WithdrawalMethodModel*) source target:(WithdrawalMethodModel*)target;

@end

NS_ASSUME_NONNULL_END
