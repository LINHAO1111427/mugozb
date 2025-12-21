//此代码由 http://code.siwaha.com/ 生成，服务器修改后可重新生成

#import <Foundation/Foundation.h>

 @class LiveLiveModel;
 @class ShopLiveGoodsModel;
 @class ShopBusinessModel;
NS_ASSUME_NONNULL_BEGIN




/**
商家直播信息
 */
@interface ShopLiveInfoDTOModel : NSObject 


	/**
直播信息
 */
@property (strong, nonatomic) LiveLiveModel* appUsersLive;

	/**
讲解商品
 */
@property (strong, nonatomic) ShopLiveGoodsModel* shopLiveGoods;

	/**
商家信息
 */
@property (strong, nonatomic) ShopBusinessModel* shopBusiness;

 +(NSMutableArray<ShopLiveInfoDTOModel*>*)getFromArr:(NSArray*)list;

 -(NSDictionary*)modelToJSONObject;

 +(NSMutableArray*)modelToJSONArray:(NSMutableArray<ShopLiveInfoDTOModel*>*)list;

 +(ShopLiveInfoDTOModel*)getFromDict:(NSDictionary*)dict;

 +(void)cloneObj:(ShopLiveInfoDTOModel*) source target:(ShopLiveInfoDTOModel*)target;

@end

NS_ASSUME_NONNULL_END
