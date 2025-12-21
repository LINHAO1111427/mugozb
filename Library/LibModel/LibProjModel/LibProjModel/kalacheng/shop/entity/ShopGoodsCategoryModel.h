//此代码由 http://code.siwaha.com/ 生成，服务器修改后可重新生成

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN




/**
商品类别表
 */
@interface ShopGoodsCategoryModel : NSObject 


	/**
累计成交金额
 */
@property (nonatomic, assign) double totalAmount;

	/**
商品累计销量
 */
@property (nonatomic, assign) int sale;

	/**
添加时间
 */
@property (nonatomic,copy) NSDate * addTime;

	/**
商品数量
 */
@property (nonatomic, assign) int num;

	/**
商品分类名称
 */
@property (nonatomic, copy) NSString * name;

	/**
null
 */
@property (nonatomic, assign) int64_t id_field;

	/**
备注
 */
@property (nonatomic, copy) NSString * remake;

	/**
排序
 */
@property (nonatomic, assign) int sort;

	/**
上级分类ID
 */
@property (nonatomic, assign) int64_t parentId;

 +(NSMutableArray<ShopGoodsCategoryModel*>*)getFromArr:(NSArray*)list;

 -(NSDictionary*)modelToJSONObject;

 +(NSMutableArray*)modelToJSONArray:(NSMutableArray<ShopGoodsCategoryModel*>*)list;

 +(ShopGoodsCategoryModel*)getFromDict:(NSDictionary*)dict;

 +(void)cloneObj:(ShopGoodsCategoryModel*) source target:(ShopGoodsCategoryModel*)target;

@end

NS_ASSUME_NONNULL_END
