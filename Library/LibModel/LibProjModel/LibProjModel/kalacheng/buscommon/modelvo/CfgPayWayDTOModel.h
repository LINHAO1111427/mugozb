//此代码由 http://code.siwaha.com/ 生成，服务器修改后可重新生成

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN




/**
支付设置
 */
@interface CfgPayWayDTOModel : NSObject 


	/**
支付页面类型 1：APP支付， 2：web网页支付 3：扫码支付,4调起支付宝,5调起微信小程序,6金币支付
 */
@property (nonatomic, assign) int pageType;

	/**
支付设备 1：安卓 2：ios
 */
@property (nonatomic, copy) NSString * payEquipment;

	/**
微信开放平台应用APPID
 */
@property (nonatomic, copy) NSString * appId;

	/**
支付渠道名称
 */
@property (nonatomic, copy) NSString * name;

	/**
支付渠道类型 1：支付宝  2：微信 3:ios内购，12微信+支付宝，6输入银行卡（人民币）
 */
@property (nonatomic, assign) int payChannel;

	/**
null
 */
@property (nonatomic, assign) int64_t id_field;

 +(NSMutableArray<CfgPayWayDTOModel*>*)getFromArr:(NSArray*)list;

 -(NSDictionary*)modelToJSONObject;

 +(NSMutableArray*)modelToJSONArray:(NSMutableArray<CfgPayWayDTOModel*>*)list;

 +(CfgPayWayDTOModel*)getFromDict:(NSDictionary*)dict;

 +(void)cloneObj:(CfgPayWayDTOModel*) source target:(CfgPayWayDTOModel*)target;

@end

NS_ASSUME_NONNULL_END
