//此代码由 http://code.siwaha.com/ 生成，服务器修改后可重新生成

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN




/**
商品渠道表
 */
@interface ShopGoodsChannelModel : NSObject 


	/**
添加时间
 */
@property (nonatomic,copy) NSDate * addTime;

	/**
null
 */
@property (nonatomic, assign) int64_t id_field;

	/**
排序
 */
@property (nonatomic, assign) int sort;

	/**
渠道名称
 */
@property (nonatomic, copy) NSString * goodsChannel;

 +(NSMutableArray<ShopGoodsChannelModel*>*)getFromArr:(NSArray*)list;

 -(NSDictionary*)modelToJSONObject;

 +(NSMutableArray*)modelToJSONArray:(NSMutableArray<ShopGoodsChannelModel*>*)list;

 +(ShopGoodsChannelModel*)getFromDict:(NSDictionary*)dict;

 +(void)cloneObj:(ShopGoodsChannelModel*) source target:(ShopGoodsChannelModel*)target;

@end

NS_ASSUME_NONNULL_END
