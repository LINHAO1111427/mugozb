//此代码由 http://code.siwaha.com/ 生成，服务器修改后可重新生成

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN




/**
购物车表
 */
@interface ShopCarModel : NSObject 


	/**
sku组合名
 */
@property (nonatomic, copy) NSString * skuName;

	/**
用户id
 */
@property (nonatomic, assign) int64_t uid;

	/**
添加时间
 */
@property (nonatomic,copy) NSDate * addTime;

	/**
商品id
 */
@property (nonatomic, assign) int64_t goodsId;

	/**
商品价格(单价)
 */
@property (nonatomic, assign) double goodsPrice;

	/**
商家id
 */
@property (nonatomic, assign) int64_t businessId;

	/**
null
 */
@property (nonatomic, assign) int64_t id_field;

	/**
skuId
 */
@property (nonatomic, assign) int64_t composeId;

	/**
商品名称
 */
@property (nonatomic, copy) NSString * goodsName;

	/**
商品数量
 */
@property (nonatomic, assign) int goodsNum;

	/**
商品图片
 */
@property (nonatomic, copy) NSString * goodsPicture;

 +(NSMutableArray<ShopCarModel*>*)getFromArr:(NSArray*)list;

 -(NSDictionary*)modelToJSONObject;

 +(NSMutableArray*)modelToJSONArray:(NSMutableArray<ShopCarModel*>*)list;

 +(ShopCarModel*)getFromDict:(NSDictionary*)dict;

 +(void)cloneObj:(ShopCarModel*) source target:(ShopCarModel*)target;

@end

NS_ASSUME_NONNULL_END
