//此代码由 http://code.siwaha.com/ 生成，服务器修改后可重新生成

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN




/**
订单数量信息
 */
@interface ShopOrderNumDTOModel : NSObject 


	/**
已完成
 */
@property (nonatomic, assign) int finishedNum;

	/**
待收货
 */
@property (nonatomic, assign) int toBeReceivedNum;

	/**
待付款
 */
@property (nonatomic, assign) int toBePayNum;

	/**
待发货
 */
@property (nonatomic, assign) int toBeDeliveredNum;

	/**
退货
 */
@property (nonatomic, assign) int cancelGoodsNum;

 +(NSMutableArray<ShopOrderNumDTOModel*>*)getFromArr:(NSArray*)list;

 -(NSDictionary*)modelToJSONObject;

 +(NSMutableArray*)modelToJSONArray:(NSMutableArray<ShopOrderNumDTOModel*>*)list;

 +(ShopOrderNumDTOModel*)getFromDict:(NSDictionary*)dict;

 +(void)cloneObj:(ShopOrderNumDTOModel*) source target:(ShopOrderNumDTOModel*)target;

@end

NS_ASSUME_NONNULL_END
