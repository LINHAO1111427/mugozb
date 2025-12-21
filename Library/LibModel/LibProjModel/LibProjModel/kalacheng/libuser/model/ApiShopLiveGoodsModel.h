//此代码由 http://code.siwaha.com/ 生成，服务器修改后可重新生成

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN




/**
讲解商品数据
 */
@interface ApiShopLiveGoodsModel : NSObject 


	/**
null
 */
@property (nonatomic, assign) int64_t serialVersionUID;

	/**
null
 */
@property (nonatomic, assign) int64_t id_field;

	/**
排序
 */
@property (nonatomic, assign) int sort;

	/**
主播Id
 */
@property (nonatomic, assign) int64_t anchorId;

	/**
商品id
 */
@property (nonatomic, assign) int64_t goodsId;

	/**
商品名称
 */
@property (nonatomic, copy) NSString * name;

	/**
商品图片地址
 */
@property (nonatomic, copy) NSString * goodsPicture;

	/**
是否讲解
 */
@property (nonatomic, assign) int idExplain;

	/**
商品价格
 */
@property (nonatomic, assign) double goodsPrice;

	/**
商品链接
 */
@property (nonatomic, copy) NSString * productLinks;

	/**
商品渠道id
 */
@property (nonatomic, assign) int64_t channelId;

 +(NSMutableArray<ApiShopLiveGoodsModel*>*)getFromArr:(NSArray*)list;

 -(NSDictionary*)modelToJSONObject;

 +(NSMutableArray*)modelToJSONArray:(NSMutableArray<ApiShopLiveGoodsModel*>*)list;

 +(ApiShopLiveGoodsModel*)getFromDict:(NSDictionary*)dict;

 +(void)cloneObj:(ApiShopLiveGoodsModel*) source target:(ApiShopLiveGoodsModel*)target;

@end

NS_ASSUME_NONNULL_END
