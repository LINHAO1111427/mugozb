//此代码由 http://code.siwaha.com/ 生成，服务器修改后可重新生成

#import <Foundation/Foundation.h>

 @class ShopLiveGoodsModel;
NS_ASSUME_NONNULL_BEGIN




/**
直播间商品列表返回
 */
@interface ShopLiveGoodsDTOModel : NSObject 


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
直播商品列表
 */
@property (nonatomic, strong) NSMutableArray<ShopLiveGoodsModel*>* liveGoodsList;

 +(NSMutableArray<ShopLiveGoodsDTOModel*>*)getFromArr:(NSArray*)list;

 -(NSDictionary*)modelToJSONObject;

 +(NSMutableArray*)modelToJSONArray:(NSMutableArray<ShopLiveGoodsDTOModel*>*)list;

 +(ShopLiveGoodsDTOModel*)getFromDict:(NSDictionary*)dict;

 +(void)cloneObj:(ShopLiveGoodsDTOModel*) source target:(ShopLiveGoodsDTOModel*)target;

@end

NS_ASSUME_NONNULL_END
