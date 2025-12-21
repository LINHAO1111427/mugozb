//此代码由 http://code.siwaha.com/ 生成，服务器修改后可重新生成

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN




/**
商品列表返回
 */
@interface ShopGoodsDTOModel : NSObject 


	/**
商品链接
 */
@property (nonatomic, copy) NSString * productLinks;

	/**
商品已售数量
 */
@property (nonatomic, assign) int soldNum;

	/**
商品id
 */
@property (nonatomic, assign) int64_t goodsId;

	/**
商品管理排序
 */
@property (nonatomic, assign) int sort;

	/**
商品分类名称
 */
@property (nonatomic, copy) NSString * categoryName;

	/**
商品优惠价格
 */
@property (nonatomic, assign) double favorablePrice;

	/**
商品简介图片地址
 */
@property (nonatomic, copy) NSString * goodsPicture;

	/**
直播商品排序
 */
@property (nonatomic, assign) int liveSort;

	/**
商品价格
 */
@property (nonatomic, assign) double price;

	/**
是否选取 0 没有选取 1 选取
 */
@property (nonatomic, assign) int checked;

	/**
商品渠道名称
 */
@property (nonatomic, copy) NSString * channelName;

	/**
商品详情
 */
@property (nonatomic, copy) NSString * present;

	/**
商品名称
 */
@property (nonatomic, copy) NSString * goodsName;

	/**
属性名称
 */
@property (nonatomic, copy) NSString * attrName;

	/**
商品分类Id
 */
@property (nonatomic, assign) int64_t categoryId;

	/**
商品渠道id
 */
@property (nonatomic, assign) int64_t channelId;

	/**
商品详情图片地址
 */
@property (nonatomic, copy) NSString * detailPicture;

	/**
状态
 */
@property (nonatomic, assign) int status;

 +(NSMutableArray<ShopGoodsDTOModel*>*)getFromArr:(NSArray*)list;

 -(NSDictionary*)modelToJSONObject;

 +(NSMutableArray*)modelToJSONArray:(NSMutableArray<ShopGoodsDTOModel*>*)list;

 +(ShopGoodsDTOModel*)getFromDict:(NSDictionary*)dict;

 +(void)cloneObj:(ShopGoodsDTOModel*) source target:(ShopGoodsDTOModel*)target;

@end

NS_ASSUME_NONNULL_END
