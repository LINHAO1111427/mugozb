//此代码由 http://code.siwaha.com/ 生成，服务器修改后可重新生成

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN




/**
后台管理-三方设置-短信区域
 */
@interface CfgSmsRegionModel : NSObject 


	/**
id
 */
@property (nonatomic, assign) int64_t id_field;

	/**
短信区域编码
 */
@property (nonatomic, copy) NSString * smsRegionCode;

	/**
短信区域名称
 */
@property (nonatomic, copy) NSString * smsRegionName;

 +(NSMutableArray<CfgSmsRegionModel*>*)getFromArr:(NSArray*)list;

 -(NSDictionary*)modelToJSONObject;

 +(NSMutableArray*)modelToJSONArray:(NSMutableArray<CfgSmsRegionModel*>*)list;

 +(CfgSmsRegionModel*)getFromDict:(NSDictionary*)dict;

 +(void)cloneObj:(CfgSmsRegionModel*) source target:(CfgSmsRegionModel*)target;

@end

NS_ASSUME_NONNULL_END
