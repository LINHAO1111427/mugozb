//此代码由 http://code.siwaha.com/ 生成，服务器修改后可重新生成

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN




/**
商品信息表
 */
@interface ShopGoodsModel : NSObject 


	/**
商品链接
 */
@property (nonatomic, copy) NSString * productLinks;

	/**
创建时间
 */
@property (nonatomic,copy) NSDate * addTime;

	/**
商品已售数量
 */
@property (nonatomic, assign) int soldNum;

	/**
商品编号
 */
@property (nonatomic, copy) NSString * num;

	/**
商家id
 */
@property (nonatomic, assign) int64_t businessId;

	/**
审核备注
 */
@property (nonatomic, copy) NSString * remake;

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
商品简介图片地址
 */
@property (nonatomic, copy) NSString * goodsPicture;

	/**
修改时间
 */
@property (nonatomic,copy) NSDate * upTime;

	/**
是否自营 1:自营 2:非自营
 */
@property (nonatomic, assign) int myGoods;

	/**
商品价格
 */
@property (nonatomic, assign) double price;

	/**
null
 */
@property (nonatomic, assign) int64_t id_field;

	/**
商品详情
 */
@property (nonatomic, copy) NSString * present;

	/**
商品名称
 */
@property (nonatomic, copy) NSString * goodsName;

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
状态 1：未上架; 2:上架中; 3:冻结中
 */
@property (nonatomic, assign) int status;

 +(NSMutableArray<ShopGoodsModel*>*)getFromArr:(NSArray*)list;

 -(NSDictionary*)modelToJSONObject;

 +(NSMutableArray*)modelToJSONArray:(NSMutableArray<ShopGoodsModel*>*)list;

 +(ShopGoodsModel*)getFromDict:(NSDictionary*)dict;

 +(void)cloneObj:(ShopGoodsModel*) source target:(ShopGoodsModel*)target;

@end

NS_ASSUME_NONNULL_END
