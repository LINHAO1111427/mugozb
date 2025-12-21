//此代码由 http://code.siwaha.com/ 生成，服务器修改后可重新生成

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN




/**
购物车生成订单请求
 */
@interface ShopCarAskDTOModel : NSObject 


	/**
商品id
 */
@property (nonatomic, assign) int64_t goodsId;

	/**
商品数量
 */
@property (nonatomic, assign) int goodsNum;

	/**
商品skuId
 */
@property (nonatomic, assign) int64_t skuId;

	/**
购物车id
 */
@property (nonatomic, assign) int64_t carId;

 +(NSMutableArray<ShopCarAskDTOModel*>*)getFromArr:(NSArray*)list;

 -(NSDictionary*)modelToJSONObject;

 +(NSMutableArray*)modelToJSONArray:(NSMutableArray<ShopCarAskDTOModel*>*)list;

 +(ShopCarAskDTOModel*)getFromDict:(NSDictionary*)dict;

 +(void)cloneObj:(ShopCarAskDTOModel*) source target:(ShopCarAskDTOModel*)target;

@end

NS_ASSUME_NONNULL_END
