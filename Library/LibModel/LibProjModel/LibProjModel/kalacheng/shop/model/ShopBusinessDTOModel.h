//此代码由 http://code.siwaha.com/ 生成，服务器修改后可重新生成

#import <Foundation/Foundation.h>

 @class ShopBusinessModel;
 @class ShopLiveDetailDTOModel;
 @class ShopGoodsDTOModel;
NS_ASSUME_NONNULL_BEGIN




/**
商家主页返回
 */
@interface ShopBusinessDTOModel : NSObject 


	/**
商家
 */
@property (strong, nonatomic) ShopBusinessModel* business;

	/**
资源类型
 */
@property (nonatomic, assign) int sourceType;

	/**
直播信息
 */
@property (strong, nonatomic) ShopLiveDetailDTOModel* liveDetailDTO;

	/**
商品列表
 */
@property (nonatomic, strong) NSMutableArray<ShopGoodsDTOModel*>* goodsDTOList;

	/**
房间id
 */
@property (nonatomic, assign) int64_t roomId;

	/**
直播状态 0：关播中 1：开播中
 */
@property (nonatomic, assign) int status;

 +(NSMutableArray<ShopBusinessDTOModel*>*)getFromArr:(NSArray*)list;

 -(NSDictionary*)modelToJSONObject;

 +(NSMutableArray*)modelToJSONArray:(NSMutableArray<ShopBusinessDTOModel*>*)list;

 +(ShopBusinessDTOModel*)getFromDict:(NSDictionary*)dict;

 +(void)cloneObj:(ShopBusinessDTOModel*) source target:(ShopBusinessDTOModel*)target;

@end

NS_ASSUME_NONNULL_END
