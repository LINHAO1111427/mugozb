//此代码由 http://code.siwaha.com/ 生成，服务器修改后可重新生成

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN




/**
直播商品列表
 */
@interface ShopLiveGoodsModel : NSObject 


	/**
商品链接
 */
@property (nonatomic, copy) NSString * productLinks;

	/**
商品id
 */
@property (nonatomic, assign) int64_t goodsId;

	/**
商品价格
 */
@property (nonatomic, assign) double goodsPrice;

	/**
商品名称
 */
@property (nonatomic, copy) NSString * name;

	/**
null
 */
@property (nonatomic, assign) int64_t id_field;

	/**
是否讲解
 */
@property (nonatomic, assign) int idExplain;

	/**
排序
 */
@property (nonatomic, assign) int sort;

	/**
主播Id
 */
@property (nonatomic, assign) int64_t anchorId;

	/**
商品优惠价格
 */
@property (nonatomic, assign) double favorablePrice;

	/**
商品渠道id
 */
@property (nonatomic, assign) int64_t channelId;

	/**
商品图片地址
 */
@property (nonatomic, copy) NSString * goodsPicture;

 +(NSMutableArray<ShopLiveGoodsModel*>*)getFromArr:(NSArray*)list;

 -(NSDictionary*)modelToJSONObject;

 +(NSMutableArray*)modelToJSONArray:(NSMutableArray<ShopLiveGoodsModel*>*)list;

 +(ShopLiveGoodsModel*)getFromDict:(NSDictionary*)dict;

 +(void)cloneObj:(ShopLiveGoodsModel*) source target:(ShopLiveGoodsModel*)target;

@end

NS_ASSUME_NONNULL_END
