//此代码由 http://code.siwaha.com/ 生成，服务器修改后可重新生成

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN




/**
商品属性表
 */
@interface ShopGoodsAttrModel : NSObject 


	/**
商品id
 */
@property (nonatomic, assign) int64_t goodsId;

	/**
属性名称
 */
@property (nonatomic, copy) NSString * name;

	/**
null
 */
@property (nonatomic, assign) int64_t id_field;

 +(NSMutableArray<ShopGoodsAttrModel*>*)getFromArr:(NSArray*)list;

 -(NSDictionary*)modelToJSONObject;

 +(NSMutableArray*)modelToJSONArray:(NSMutableArray<ShopGoodsAttrModel*>*)list;

 +(ShopGoodsAttrModel*)getFromDict:(NSDictionary*)dict;

 +(void)cloneObj:(ShopGoodsAttrModel*) source target:(ShopGoodsAttrModel*)target;

@end

NS_ASSUME_NONNULL_END
