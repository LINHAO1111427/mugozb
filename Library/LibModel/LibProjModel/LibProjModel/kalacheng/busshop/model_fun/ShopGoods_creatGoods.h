//此代码由 http://code.siwaha.com/ 生成，服务器修改后可重新生成

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN




/**
 * 商品录入
*/
@interface ShopGoods_creatGoods : NSObject 


 +(ShopGoods_creatGoods*)getFromDict:(NSDictionary*)dict;

 +(NSMutableArray<ShopGoods_creatGoods*>*)getFromArr:(NSArray*)list;


	
	/**
分类id
 */
@property (nonatomic, assign) int64_t categoryId;


	
	/**
渠道id
 */
@property (nonatomic, assign) int64_t channelId;


	
	/**
商品详情图片地址
 */
@property (nonatomic, copy) NSString * detailPicture;


	
	/**
优惠价格
 */
@property (nonatomic, assign) double favorablePrice;


	
	/**
商品id
 */
@property (nonatomic, assign) int64_t goodsId;


	
	/**
商品名称
 */
@property (nonatomic, copy) NSString * goodsName;


	
	/**
商品简介图片地址
 */
@property (nonatomic, copy) NSString * goodsPicture;


	
	/**
商品详情
 */
@property (nonatomic, copy) NSString * present;


	
	/**
商品价格
 */
@property (nonatomic, assign) double price;


	
	/**
商品链接
 */
@property (nonatomic, copy) NSString * productLinks;


	
	/**
渠道类型 1：第三方 2：自营
 */
@property (nonatomic, assign) int type;

@end

NS_ASSUME_NONNULL_END
