//此代码由 http://code.siwaha.com/ 生成，服务器修改后可重新生成
#import <Foundation/Foundation.h>

#import <LibProjBase/PageInfo.h>


#import "ShopAttrComposeModel.h"

#import "ShopGoodsAttrCompositeModel.h"
#import "ShopGoodsChannelModel.h"

#import "HttpNoneModel.h"

#import "ShopGoods_creatGoods.h"
#import "ShopGoodsDTOModel.h"

#import "ShopGoodsDetailDTOModel.h"

#import "ShopGoodsModel.h"

#import "ShopGoodsAttrDTOModel.h"

#import "ShopGoodsCategoryModel.h"

#import "ShopGoods_updateGoods.h"
#import "ShopAttrAndComposeDTOModel.h"

#import "ShopGoodsAttrModel.h"

#import "ShopLiveGoodsDTOModel.h"

typedef void (^CallBackShopGoods_ShopAttrComposeArr)(int code,NSString *strMsg,NSArray<ShopAttrComposeModel*>* arr);
typedef void (^CallBackShopGoods_ShopGoodsChannelArr)(int code,NSString *strMsg,NSArray<ShopGoodsChannelModel*>* arr);
typedef void (^CallBackShopGoods_HttpNone)(int code,NSString *strMsg,HttpNoneModel* model);
typedef void (^CallBackShopGoods_ShopGoodsDTOArr)(int code,NSString *strMsg,NSArray<ShopGoodsDTOModel*>* arr);
typedef void (^CallBackShopGoods_ShopGoodsDetailDTO)(int code,NSString *strMsg,ShopGoodsDetailDTOModel* model);
typedef void (^CallBackShopGoods_ShopGoods)(int code,NSString *strMsg,ShopGoodsModel* model);
typedef void (^CallBackShopGoods_ShopGoodsAttrDTOArr)(int code,NSString *strMsg,NSArray<ShopGoodsAttrDTOModel*>* arr);
typedef void (^CallBackShopGoods_ShopGoodsCategoryArr)(int code,NSString *strMsg,NSArray<ShopGoodsCategoryModel*>* arr);
typedef void (^CallBackShopGoods_ShopAttrAndComposeDTO)(int code,NSString *strMsg,ShopAttrAndComposeDTOModel* model);
typedef void (^CallBackShopGoods_ShopGoodsAttrArr)(int code,NSString *strMsg,NSArray<ShopGoodsAttrModel*>* arr);
typedef void (^CallBackShopGoods_ShopLiveGoodsDTO)(int code,NSString *strMsg,ShopLiveGoodsDTOModel* model);
NS_ASSUME_NONNULL_BEGIN



/**
商品相关接口API
 */
@interface HttpApiShopGoods: NSObject



/**
 商品属性添加
 @param goodsId 商品id
 @param shopGoodsAttrCompositeEntities shopGoodsAttrCompositeEntities
 */
+(void) createAttribute:(int64_t)goodsId shopGoodsAttrCompositeEntities:(NSMutableArray<ShopGoodsAttrCompositeModel*>* )shopGoodsAttrCompositeEntities  callback:(CallBackShopGoods_ShopAttrComposeArr)callback;


/**
 商品渠道列表
 */
+(void) getChannelList:(CallBackShopGoods_ShopGoodsChannelArr)callback;




/**
 商品录入
 @param categoryId 分类id
 @param channelId 渠道id
 @param detailPicture 商品详情图片地址
 @param favorablePrice 优惠价格
 @param goodsId 商品id
 @param goodsName 商品名称
 @param goodsPicture 商品简介图片地址
 @param present 商品详情
 @param price 商品价格
 @param productLinks 商品链接
 @param type 渠道类型 1：第三方 2：自营
 */
+(void) creatGoods:(ShopGoods_creatGoods*)_mdl callback:(CallBackShopGoods_HttpNone)callback;
/**
 商品录入
 @param categoryId 分类id
 @param channelId 渠道id
 @param detailPicture 商品详情图片地址
 @param favorablePrice 优惠价格
 @param goodsId 商品id
 @param goodsName 商品名称
 @param goodsPicture 商品简介图片地址
 @param present 商品详情
 @param price 商品价格
 @param productLinks 商品链接
 @param type 渠道类型 1：第三方 2：自营
 */
+(void) creatGoods:(int64_t)categoryId channelId:(int64_t)channelId detailPicture:(NSString *)detailPicture favorablePrice:(double)favorablePrice goodsId:(int64_t)goodsId goodsName:(NSString *)goodsName goodsPicture:(NSString *)goodsPicture present:(NSString *)present price:(double)price productLinks:(NSString *)productLinks type:(int)type  callback:(CallBackShopGoods_HttpNone)callback;


/**
 设置讲解中状态
 @param liveGoodsId 直播商品id
 @param roomId 房间号
 */
+(void) setExplainStatus:(int64_t)liveGoodsId roomId:(int64_t)roomId  callback:(CallBackShopGoods_HttpNone)callback;


/**
 删除商品
 @param goodsId 商品id
 */
+(void) delGoods:(int64_t)goodsId  callback:(CallBackShopGoods_HttpNone)callback;


/**
 商品列表
 @param pageIndex 当前页
 @param pageSize 每页大小
 @param status 商品状态 0：全部 1：待上架 2：已上架 3：冻结中
 */
+(void) getGoodsList:(int)pageIndex pageSize:(int)pageSize status:(int)status  callback:(CallBackShopGoods_ShopGoodsDTOArr)callback;


/**
 商品详情
 @param goodsId 商品id
 */
+(void) getGoodsDetail:(int64_t)goodsId  callback:(CallBackShopGoods_ShopGoodsDetailDTO)callback;


/**
 商品上下架
 @param goodsId 商品id
 @param status 商品状态 1：下架 2：上架
 */
+(void) upAndLower:(int64_t)goodsId status:(int)status  callback:(CallBackShopGoods_ShopGoods)callback;


/**
 获取商品属性
 @param goodsId 商品id
 */
+(void) getArrDetailList:(int64_t)goodsId  callback:(CallBackShopGoods_ShopGoodsAttrDTOArr)callback;


/**
 商品类别
 */
+(void) getCategoryList:(CallBackShopGoods_ShopGoodsCategoryArr)callback;


/**
 修改直播间商品排序
 @param liveGoodsId 直播商品id
 @param sort 排序
 */
+(void) updateLiveGoodsSort:(int64_t)liveGoodsId sort:(int)sort  callback:(CallBackShopGoods_HttpNone)callback;


/**
 商品修改序号
 @param goodsId 商品id
 @param sort 商品排序
 */
+(void) updateGoodsSort:(int64_t)goodsId sort:(int)sort  callback:(CallBackShopGoods_HttpNone)callback;




/**
 商品修改
 @param categoryId 分类id
 @param channelId 渠道id
 @param detailPicture 商品详情图片地址
 @param favorablePrice 优惠价格
 @param goodsId 商品id
 @param goodsName 商品名称
 @param goodsPicture 商品简介图片地址
 @param present 商品详情
 @param price 商品价格
 @param productLinks 商品链接
 @param sort 商品排序
 @param type 渠道类型 1 第三方 2自营
 */
+(void) updateGoods:(ShopGoods_updateGoods*)_mdl callback:(CallBackShopGoods_HttpNone)callback;
/**
 商品修改
 @param categoryId 分类id
 @param channelId 渠道id
 @param detailPicture 商品详情图片地址
 @param favorablePrice 优惠价格
 @param goodsId 商品id
 @param goodsName 商品名称
 @param goodsPicture 商品简介图片地址
 @param present 商品详情
 @param price 商品价格
 @param productLinks 商品链接
 @param sort 商品排序
 @param type 渠道类型 1 第三方 2自营
 */
+(void) updateGoods:(int64_t)categoryId channelId:(int64_t)channelId detailPicture:(NSString *)detailPicture favorablePrice:(double)favorablePrice goodsId:(int64_t)goodsId goodsName:(NSString *)goodsName goodsPicture:(NSString *)goodsPicture present:(NSString *)present price:(double)price productLinks:(NSString *)productLinks sort:(int)sort type:(int)type  callback:(CallBackShopGoods_HttpNone)callback;


/**
 直播开播商品列表
 @param pageIndex 当前页
 @param pageSize 每页大小
 @param status 商品状态 0：全部 1：待上架 2：已上架 3：冻结中
 */
+(void) getLiveGoodsList:(int)pageIndex pageSize:(int)pageSize status:(int)status  callback:(CallBackShopGoods_ShopGoodsDTOArr)callback;


/**
 获取商品属性组合值列表
 @param goodsId 商品id
 */
+(void) getAttrCompose:(int64_t)goodsId  callback:(CallBackShopGoods_ShopAttrAndComposeDTO)callback;


/**
 商品信息
 @param productId 商品id
 */
+(void) getShopGoods:(int64_t)productId  callback:(CallBackShopGoods_ShopGoods)callback;


/**
 添加直播商品
 @param goodsId 商品id
 @param optType 操作类型 1：增加 2：删除
 @param sort 排序
 */
+(void) saveLiveGoods:(int64_t)goodsId optType:(int)optType sort:(int)sort  callback:(CallBackShopGoods_HttpNone)callback;


/**
 设置商品价格与库存
 @param shopAttrComposes shopAttrComposes
 */
+(void) setPriceInventory:(NSMutableArray<ShopAttrComposeModel*>* )shopAttrComposes  callback:(CallBackShopGoods_ShopGoodsAttrArr)callback;


/**
 商品属性修改
 @param goodsId 商品id
 @param shopGoodsAttrCompositeEntities shopGoodsAttrCompositeEntities
 */
+(void) updateAttribute:(int64_t)goodsId shopGoodsAttrCompositeEntities:(NSMutableArray<ShopGoodsAttrCompositeModel*>* )shopGoodsAttrCompositeEntities  callback:(CallBackShopGoods_ShopAttrComposeArr)callback;


/**
 直播间商品列表
 @param anchorId 主播Id
 */
+(void) getLiveGoods:(int64_t)anchorId  callback:(CallBackShopGoods_ShopLiveGoodsDTO)callback;

@end

NS_ASSUME_NONNULL_END
