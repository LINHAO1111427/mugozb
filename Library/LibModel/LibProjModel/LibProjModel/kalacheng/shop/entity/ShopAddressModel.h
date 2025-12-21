//此代码由 http://code.siwaha.com/ 生成，服务器修改后可重新生成

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN




/**
收货地址表
 */
@interface ShopAddressModel : NSObject 


	/**
区
 */
@property (nonatomic, copy) NSString * area;

	/**
用户id
 */
@property (nonatomic, assign) int64_t uid;

	/**
是否默认 1:默认 0:非默认
 */
@property (nonatomic, assign) int isDefault;

	/**
详情地址
 */
@property (nonatomic, copy) NSString * address;

	/**
添加时间
 */
@property (nonatomic,copy) NSDate * addTime;

	/**
市
 */
@property (nonatomic, copy) NSString * city;

	/**
收货人手机号
 */
@property (nonatomic, copy) NSString * phoneNum;

	/**
null
 */
@property (nonatomic, assign) int64_t id_field;

	/**
省
 */
@property (nonatomic, copy) NSString * pro;

	/**
收货人姓名
 */
@property (nonatomic, copy) NSString * userName;

 +(NSMutableArray<ShopAddressModel*>*)getFromArr:(NSArray*)list;

 -(NSDictionary*)modelToJSONObject;

 +(NSMutableArray*)modelToJSONArray:(NSMutableArray<ShopAddressModel*>*)list;

 +(ShopAddressModel*)getFromDict:(NSDictionary*)dict;

 +(void)cloneObj:(ShopAddressModel*) source target:(ShopAddressModel*)target;

@end

NS_ASSUME_NONNULL_END
