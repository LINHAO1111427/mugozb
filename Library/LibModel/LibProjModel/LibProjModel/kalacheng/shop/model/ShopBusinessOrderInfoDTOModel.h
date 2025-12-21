//此代码由 http://code.siwaha.com/ 生成，服务器修改后可重新生成

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN




/**
获取商家订单数据
 */
@interface ShopBusinessOrderInfoDTOModel : NSObject 


	/**
卖货收入
 */
@property (nonatomic, assign) double income;

	/**
订单金额
 */
@property (nonatomic, assign) double price;

	/**
订单数量
 */
@property (nonatomic, assign) int count;

 +(NSMutableArray<ShopBusinessOrderInfoDTOModel*>*)getFromArr:(NSArray*)list;

 -(NSDictionary*)modelToJSONObject;

 +(NSMutableArray*)modelToJSONArray:(NSMutableArray<ShopBusinessOrderInfoDTOModel*>*)list;

 +(ShopBusinessOrderInfoDTOModel*)getFromDict:(NSDictionary*)dict;

 +(void)cloneObj:(ShopBusinessOrderInfoDTOModel*) source target:(ShopBusinessOrderInfoDTOModel*)target;

@end

NS_ASSUME_NONNULL_END
