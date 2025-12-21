//此代码由 http://code.siwaha.com/ 生成，服务器修改后可重新生成

#import <Foundation/Foundation.h>

 @class ShopAttrComposeModel;
 @class ShopGoodsModel;
 @class ShopGoodsDTOModel;
 @class ShopGoodsAttrDTOModel;
NS_ASSUME_NONNULL_BEGIN




/**
商品详情返回
 */
@interface ShopGoodsDetailDTOModel : NSObject 


	/**
累计销量
 */
@property (nonatomic, assign) int totalSoldNum;

	/**
商品对应规格组合
 */
@property (nonatomic, strong) NSMutableArray<ShopAttrComposeModel*>* composeList;

	/**
商品信息
 */
@property (strong, nonatomic) ShopGoodsModel* shopGoods;

	/**
商家logo
 */
@property (nonatomic, copy) NSString * businessLogo;

	/**
商家名称
 */
@property (nonatomic, copy) NSString * businessName;

	/**
商家商品列表
 */
@property (nonatomic, strong) NSMutableArray<ShopGoodsDTOModel*>* shopGoodsDTOS;

	/**
推荐商品列表
 */
@property (nonatomic, strong) NSMutableArray<ShopGoodsDTOModel*>* recommendGoodsDTOS;

	/**
主播id
 */
@property (nonatomic, assign) int64_t anchorId;

	/**
在售商品数量
 */
@property (nonatomic, assign) int effectiveGoodsNum;

	/**
商品对应属性
 */
@property (nonatomic, strong) NSMutableArray<ShopGoodsAttrDTOModel*>* attrDTOList;

	/**
购物车数量
 */
@property (nonatomic, assign) int shopCarNum;

 +(NSMutableArray<ShopGoodsDetailDTOModel*>*)getFromArr:(NSArray*)list;

 -(NSDictionary*)modelToJSONObject;

 +(NSMutableArray*)modelToJSONArray:(NSMutableArray<ShopGoodsDetailDTOModel*>*)list;

 +(ShopGoodsDetailDTOModel*)getFromDict:(NSDictionary*)dict;

 +(void)cloneObj:(ShopGoodsDetailDTOModel*) source target:(ShopGoodsDetailDTOModel*)target;

@end

NS_ASSUME_NONNULL_END
