//此代码由 http://code.siwaha.com/ 生成，服务器修改后可重新生成

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN




/**
贵族中心贵族价格
 */
@interface NobleCenterVipPriceDTOModel : NSObject 


	/**
ios价格
 */
@property (nonatomic, assign) double iosCoin;

	/**
苹果项目id
 */
@property (nonatomic, copy) NSString * iosId;

	/**
支付类型 1:金币 2:RMB 3.人民币/金币
 */
@property (nonatomic, assign) int payType;

	/**
有效时间（月）
 */
@property (nonatomic, assign) int endDay;

	/**
名称
 */
@property (nonatomic, copy) NSString * name;

	/**
安卓价格
 */
@property (nonatomic, assign) double androidCoin;

	/**
贵族对应的价格id
 */
@property (nonatomic, assign) int64_t id_field;

	/**
赠送金币
 */
@property (nonatomic, assign) double sendCoin;

	/**
金币价格
 */
@property (nonatomic, assign) double coin;

 +(NSMutableArray<NobleCenterVipPriceDTOModel*>*)getFromArr:(NSArray*)list;

 -(NSDictionary*)modelToJSONObject;

 +(NSMutableArray*)modelToJSONArray:(NSMutableArray<NobleCenterVipPriceDTOModel*>*)list;

 +(NobleCenterVipPriceDTOModel*)getFromDict:(NSDictionary*)dict;

 +(void)cloneObj:(NobleCenterVipPriceDTOModel*) source target:(NobleCenterVipPriceDTOModel*)target;

@end

NS_ASSUME_NONNULL_END
