//此代码由 http://code.siwaha.com/ 生成，服务器修改后可重新生成

#import <Foundation/Foundation.h>

 @class ShopGoodsAttrModel;
 @class ShopAttrValueModel;
NS_ASSUME_NONNULL_BEGIN




/**
商品属性属性值组合实体
 */
@interface ShopGoodsAttrCompositeModel : NSObject 


	/**
商品属性
 */
@property (strong, nonatomic) ShopGoodsAttrModel* shopGoodsAttr;

	/**
属性值
 */
@property (nonatomic, strong) NSMutableArray<ShopAttrValueModel*>* shopAttrValues;

 +(NSMutableArray<ShopGoodsAttrCompositeModel*>*)getFromArr:(NSArray*)list;

 -(NSDictionary*)modelToJSONObject;

 +(NSMutableArray*)modelToJSONArray:(NSMutableArray<ShopGoodsAttrCompositeModel*>*)list;

 +(ShopGoodsAttrCompositeModel*)getFromDict:(NSDictionary*)dict;

 +(void)cloneObj:(ShopGoodsAttrCompositeModel*) source target:(ShopGoodsAttrCompositeModel*)target;

@end

NS_ASSUME_NONNULL_END
