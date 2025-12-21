//此代码由 http://code.siwaha.com/ 生成，服务器修改后可重新生成

#import <Foundation/Foundation.h>

 @class ShopAttrValueModel;
NS_ASSUME_NONNULL_BEGIN




/**
商品属性返回
 */
@interface ShopGoodsAttrDTOModel : NSObject 


	/**
商品属性id
 */
@property (nonatomic, assign) int64_t attrId;

	/**
商品属性值
 */
@property (nonatomic, strong) NSMutableArray<ShopAttrValueModel*>* attrValueList;

	/**
商品属性名称
 */
@property (nonatomic, copy) NSString * attrName;

 +(NSMutableArray<ShopGoodsAttrDTOModel*>*)getFromArr:(NSArray*)list;

 -(NSDictionary*)modelToJSONObject;

 +(NSMutableArray*)modelToJSONArray:(NSMutableArray<ShopGoodsAttrDTOModel*>*)list;

 +(ShopGoodsAttrDTOModel*)getFromDict:(NSDictionary*)dict;

 +(void)cloneObj:(ShopGoodsAttrDTOModel*) source target:(ShopGoodsAttrDTOModel*)target;

@end

NS_ASSUME_NONNULL_END
