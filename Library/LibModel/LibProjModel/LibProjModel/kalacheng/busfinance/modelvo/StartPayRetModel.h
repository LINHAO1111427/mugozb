//此代码由 http://code.siwaha.com/ 生成，服务器修改后可重新生成

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN




/**
支付返回给前端的信息
 */
@interface StartPayRetModel : NSObject 


	/**
扫码URL
 */
@property (nonatomic, copy) NSString * scanUrl;

	/**
订单ID
 */
@property (nonatomic, copy) NSString * orderId;

	/**
appid
 */
@property (nonatomic, copy) NSString * appid;

	/**
ios支付id
 */
@property (nonatomic, copy) NSString * iosPayId;

	/**
微信支付信息
 */
@property (nonatomic, copy) NSString * WXPayInfo;

	/**
支付宝支付信息
 */
@property (nonatomic, copy) NSString * aliPayInfo;

	/**
小程序原始ID
 */
@property (nonatomic, copy) NSString * originalId;

	/**
支付URL
 */
@property (nonatomic, copy) NSString * url;

 +(NSMutableArray<StartPayRetModel*>*)getFromArr:(NSArray*)list;

 -(NSDictionary*)modelToJSONObject;

 +(NSMutableArray*)modelToJSONArray:(NSMutableArray<StartPayRetModel*>*)list;

 +(StartPayRetModel*)getFromDict:(NSDictionary*)dict;

 +(void)cloneObj:(StartPayRetModel*) source target:(StartPayRetModel*)target;

@end

NS_ASSUME_NONNULL_END
