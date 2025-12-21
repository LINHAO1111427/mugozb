//此代码由 http://code.siwaha.com/ 生成，服务器修改后可重新生成

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN




/**
代币设置
 */
@interface CfgCurrencySettingModel : NSObject 


	/**
修改时间
 */
@property (nonatomic,copy) NSDate * upTime;

	/**
收益货币图标
 */
@property (nonatomic, copy) NSString * ticketIcon;

	/**
充值货币名称
 */
@property (nonatomic, copy) NSString * coinName;

	/**
null
 */
@property (nonatomic, assign) int64_t id_field;

	/**
充值货币图标
 */
@property (nonatomic, copy) NSString * coinIcon;

	/**
收益货币名称
 */
@property (nonatomic, copy) NSString * ticketName;

 +(NSMutableArray<CfgCurrencySettingModel*>*)getFromArr:(NSArray*)list;

 -(NSDictionary*)modelToJSONObject;

 +(NSMutableArray*)modelToJSONArray:(NSMutableArray<CfgCurrencySettingModel*>*)list;

 +(CfgCurrencySettingModel*)getFromDict:(NSDictionary*)dict;

 +(void)cloneObj:(CfgCurrencySettingModel*) source target:(CfgCurrencySettingModel*)target;

@end

NS_ASSUME_NONNULL_END
