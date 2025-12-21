//此代码由 http://code.siwaha.com/ 生成，服务器修改后可重新生成

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN




/**
查看收费设置项
 */
@interface CustomerServiceSettingModel : NSObject 


	/**
客服QQ
 */
@property (nonatomic, copy) NSString * qq;

	/**
申诉电话
 */
@property (nonatomic, copy) NSString * complaintTelephone;

	/**
客服电话
 */
@property (nonatomic, copy) NSString * consumerHotline;

	/**
客服微信
 */
@property (nonatomic, copy) NSString * wechat;

	/**
null
 */
@property (nonatomic, assign) int64_t id_field;

	/**
客服微信二维码
 */
@property (nonatomic, copy) NSString * wechatCode;

 +(NSMutableArray<CustomerServiceSettingModel*>*)getFromArr:(NSArray*)list;

 -(NSDictionary*)modelToJSONObject;

 +(NSMutableArray*)modelToJSONArray:(NSMutableArray<CustomerServiceSettingModel*>*)list;

 +(CustomerServiceSettingModel*)getFromDict:(NSDictionary*)dict;

 +(void)cloneObj:(CustomerServiceSettingModel*) source target:(CustomerServiceSettingModel*)target;

@end

NS_ASSUME_NONNULL_END
