//此代码由 http://code.siwaha.com/ 生成，服务器修改后可重新生成

#import <Foundation/Foundation.h>

 @class ShopLiveGoodsModel;
NS_ASSUME_NONNULL_BEGIN




/**
商家主页主播开播返回
 */
@interface ShopLiveDetailDTOModel : NSObject 


	/**
直播封面图
 */
@property (nonatomic, copy) NSString * thumb;

	/**
直播间人数
 */
@property (nonatomic, assign) int liveUsers;

	/**
直播标题
 */
@property (nonatomic, copy) NSString * title;

	/**
直播橱窗商品列表
 */
@property (nonatomic, strong) NSMutableArray<ShopLiveGoodsModel*>* liveGoodsList;

 +(NSMutableArray<ShopLiveDetailDTOModel*>*)getFromArr:(NSArray*)list;

 -(NSDictionary*)modelToJSONObject;

 +(NSMutableArray*)modelToJSONArray:(NSMutableArray<ShopLiveDetailDTOModel*>*)list;

 +(ShopLiveDetailDTOModel*)getFromDict:(NSDictionary*)dict;

 +(void)cloneObj:(ShopLiveDetailDTOModel*) source target:(ShopLiveDetailDTOModel*)target;

@end

NS_ASSUME_NONNULL_END
