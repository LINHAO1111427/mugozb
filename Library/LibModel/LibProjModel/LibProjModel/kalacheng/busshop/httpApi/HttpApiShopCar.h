//此代码由 http://code.siwaha.com/ 生成，服务器修改后可重新生成
#import <Foundation/Foundation.h>

#import <LibProjBase/PageInfo.h>


#import "HttpNoneModel.h"

#import "ShopParentOrderModel.h"

#import "ShopCarAskDTOModel.h"
#import "ShopAddressModel.h"

#import "ShopCarDTOModel.h"

typedef void (^CallBackShopCar_HttpNone)(int code,NSString *strMsg,HttpNoneModel* model);
typedef void (^CallBackShopCar_ShopParentOrder)(int code,NSString *strMsg,ShopParentOrderModel* model);
typedef void (^CallBackShopCar_ShopAddressArr)(int code,NSString *strMsg,NSArray<ShopAddressModel*>* arr);
typedef void (^CallBackShopCar_ShopCarDTOArr)(int code,NSString *strMsg,NSArray<ShopCarDTOModel*>* arr);
NS_ASSUME_NONNULL_BEGIN



/**
购物车相关API
 */
@interface HttpApiShopCar: NSObject



/**
 删除收货地址
 @param addressId 收货地址id
 */
+(void) delShopAddress:(int64_t)addressId  callback:(CallBackShopCar_HttpNone)callback;


/**
 修改收货地址
 @param address 收货人地址
 @param addressId 收货地址id
 @param area 区
 @param city 城市
 @param isDefault 是否默认 1：默认 0：非默认
 @param phoneNum 收货人手机号
 @param pro 省份
 @param userName 收货人姓名
 */
+(void) updateShopAddress:(NSString *)address addressId:(int64_t)addressId area:(NSString *)area city:(NSString *)city isDefault:(int)isDefault phoneNum:(NSString *)phoneNum pro:(NSString *)pro userName:(NSString *)userName  callback:(CallBackShopCar_HttpNone)callback;


/**
 添加商品到购物车
 @param composeId 商品属性组合id(skuId)
 @param goodsId 商品id
 @param goodsNum 商品数量
 */
+(void) saveShopCar:(int64_t)composeId goodsId:(int64_t)goodsId goodsNum:(int)goodsNum  callback:(CallBackShopCar_HttpNone)callback;


/**
 购物车确认订单接口
 @param addressId 收货地址id
 @param shopCarDTOS shopCarDTOS
 */
+(void) purchaseGoods:(int64_t)addressId shopCarDTOS:(NSMutableArray<ShopCarAskDTOModel*>* )shopCarDTOS  callback:(CallBackShopCar_ShopParentOrder)callback;


/**
 收货地址列表
 */
+(void) getShopAddrList:(CallBackShopCar_ShopAddressArr)callback;


/**
 删除购物车中商品
 @param shopCarId 购物车id
 */
+(void) delShopCar:(int64_t)shopCarId  callback:(CallBackShopCar_HttpNone)callback;


/**
 购物车商品列表
 */
+(void) getShopCarList:(CallBackShopCar_ShopCarDTOArr)callback;


/**
 添加地址
 @param address 详细地址
 @param area 区
 @param city 城市
 @param isDefault 是否默认 1：默认 0：非默认
 @param phoneNum 收货人手机号
 @param pro 省份
 @param userName 收货人姓名
 */
+(void) saveAddress:(NSString *)address area:(NSString *)area city:(NSString *)city isDefault:(int)isDefault phoneNum:(NSString *)phoneNum pro:(NSString *)pro userName:(NSString *)userName  callback:(CallBackShopCar_HttpNone)callback;


/**
 修改购物车
 @param composeId 商品属性组合id(skuId)
 @param goodsNum 商品数量
 @param shopCarId 购物车id
 */
+(void) updateShopCar:(int64_t)composeId goodsNum:(int)goodsNum shopCarId:(int64_t)shopCarId  callback:(CallBackShopCar_HttpNone)callback;

@end

NS_ASSUME_NONNULL_END
