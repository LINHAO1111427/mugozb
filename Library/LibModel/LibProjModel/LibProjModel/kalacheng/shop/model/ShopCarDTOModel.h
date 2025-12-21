//此代码由 http://code.siwaha.com/ 生成，服务器修改后可重新生成

#import <Foundation/Foundation.h>

 @class ShopCarModel;
NS_ASSUME_NONNULL_BEGIN




/**
购物车列表返回
 */
@interface ShopCarDTOModel : NSObject 


	/**
商家id
 */
@property (nonatomic, assign) int64_t businessId;

	/**
商家logo
 */
@property (nonatomic, copy) NSString * businessLogo;

	/**
商家名称
 */
@property (nonatomic, copy) NSString * businessName;

	/**
购物车数据列表
 */
@property (nonatomic, strong) NSMutableArray<ShopCarModel*>* shopCarList;

	/**
安卓使用
 */
@property (nonatomic, assign) int viewType;

	/**
安卓使用1
 */
@property (nonatomic, assign) int checked;

 +(NSMutableArray<ShopCarDTOModel*>*)getFromArr:(NSArray*)list;

 -(NSDictionary*)modelToJSONObject;

 +(NSMutableArray*)modelToJSONArray:(NSMutableArray<ShopCarDTOModel*>*)list;

 +(ShopCarDTOModel*)getFromDict:(NSDictionary*)dict;

 +(void)cloneObj:(ShopCarDTOModel*) source target:(ShopCarDTOModel*)target;

@end

NS_ASSUME_NONNULL_END
