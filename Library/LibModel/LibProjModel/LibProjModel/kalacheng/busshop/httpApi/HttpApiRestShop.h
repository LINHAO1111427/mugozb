//此代码由 http://code.siwaha.com/ 生成，服务器修改后可重新生成
#import <Foundation/Foundation.h>

#import <LibProjBase/PageInfo.h>


#import "ShopBusinessDTOModel.h"

typedef void (^CallBackRestShop_ShopBusinessDTO)(int code,NSString *strMsg,ShopBusinessDTOModel* model);
NS_ASSUME_NONNULL_BEGIN



/**
重构购物接口
 */
@interface HttpApiRestShop: NSObject



/**
 商家中心
 @param businessId 商家id
 */
+(void) businessCenter:(int64_t)businessId  callback:(CallBackRestShop_ShopBusinessDTO)callback;


/**
 搜索店内宝贝
 @param businessId 商家id
 @param productName 商品名称
 */
+(void) searchBusinessProduct:(int64_t)businessId productName:(NSString *)productName  callback:(CallBackRestShop_ShopBusinessDTO)callback;

@end

NS_ASSUME_NONNULL_END
