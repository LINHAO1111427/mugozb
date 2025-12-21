//此代码由 http://code.siwaha.com/ 生成，服务器修改后可重新生成

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN




/**
商品详情表
 */
@interface ShopAttrComposeModel : NSObject 


	/**
商品属性值2id
 */
@property (nonatomic, assign) int64_t attribute2Id;

	/**
商品id
 */
@property (nonatomic, assign) int64_t goodsId;

	/**
商品价格
 */
@property (nonatomic, assign) double price;

	/**
商品属性值1id
 */
@property (nonatomic, assign) int64_t attribute1Id;

	/**
冻结库存
 */
@property (nonatomic, assign) int frozenStock;

	/**
null
 */
@property (nonatomic, assign) int64_t id_field;

	/**
属性值2名称
 */
@property (nonatomic, copy) NSString * name2;

	/**
库存
 */
@property (nonatomic, assign) int stock;

	/**
优惠价格
 */
@property (nonatomic, assign) double favorablePrice;

	/**
属性值1名称
 */
@property (nonatomic, copy) NSString * name1;

 +(NSMutableArray<ShopAttrComposeModel*>*)getFromArr:(NSArray*)list;

 -(NSDictionary*)modelToJSONObject;

 +(NSMutableArray*)modelToJSONArray:(NSMutableArray<ShopAttrComposeModel*>*)list;

 +(ShopAttrComposeModel*)getFromDict:(NSDictionary*)dict;

 +(void)cloneObj:(ShopAttrComposeModel*) source target:(ShopAttrComposeModel*)target;

@end

NS_ASSUME_NONNULL_END
