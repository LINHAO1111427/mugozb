//此代码由 http://code.siwaha.com/ 生成，服务器修改后可重新生成

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN




/**
商品属性值表
 */
@interface ShopAttrValueModel : NSObject 


	/**
商品属性id
 */
@property (nonatomic, assign) int64_t attributeId;

	/**
商品id
 */
@property (nonatomic, assign) int64_t goodsId;

	/**
属性值名称
 */
@property (nonatomic, copy) NSString * name;

	/**
null
 */
@property (nonatomic, assign) int64_t id_field;

 +(NSMutableArray<ShopAttrValueModel*>*)getFromArr:(NSArray*)list;

 -(NSDictionary*)modelToJSONObject;

 +(NSMutableArray*)modelToJSONArray:(NSMutableArray<ShopAttrValueModel*>*)list;

 +(ShopAttrValueModel*)getFromDict:(NSDictionary*)dict;

 +(void)cloneObj:(ShopAttrValueModel*) source target:(ShopAttrValueModel*)target;

@end

NS_ASSUME_NONNULL_END
