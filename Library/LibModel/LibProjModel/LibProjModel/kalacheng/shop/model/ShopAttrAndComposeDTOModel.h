//此代码由 http://code.siwaha.com/ 生成，服务器修改后可重新生成

#import <Foundation/Foundation.h>

 @class ShopAttrComposeModel;
 @class ShopGoodsAttrDTOModel;
NS_ASSUME_NONNULL_BEGIN




/**
返回商品属性及属性值组合
 */
@interface ShopAttrAndComposeDTOModel : NSObject 


	/**
属性值组合
 */
@property (nonatomic, strong) NSMutableArray<ShopAttrComposeModel*>* attrComposeList;

	/**
属性及属性值
 */
@property (nonatomic, strong) NSMutableArray<ShopGoodsAttrDTOModel*>* shopGoodsAttrDTOS;

 +(NSMutableArray<ShopAttrAndComposeDTOModel*>*)getFromArr:(NSArray*)list;

 -(NSDictionary*)modelToJSONObject;

 +(NSMutableArray*)modelToJSONArray:(NSMutableArray<ShopAttrAndComposeDTOModel*>*)list;

 +(ShopAttrAndComposeDTOModel*)getFromDict:(NSDictionary*)dict;

 +(void)cloneObj:(ShopAttrAndComposeDTOModel*) source target:(ShopAttrAndComposeDTOModel*)target;

@end

NS_ASSUME_NONNULL_END
