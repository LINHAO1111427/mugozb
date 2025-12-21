//
//  PaymentManager.h
//  LiveCommon
//
//  Created by admin on 2020/1/17.
//  Copyright © 2020 . All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

///1：金币充值  2：购物支付 3.待定 4.购买贵族
typedef enum {
    
    BusinessTypeCharge   = 1,  //金币充值
    BusinessTypeShop     = 2,  //购买商品
    BusinessTypeVip      = 4,  //购买VIP
    BusinessTypeSVip     = 5,  //购买SVIP
    BusinessTypeGuard    = 6,  //购买守护
    
}BusinessType;

typedef void(^CompleteBlock)(BOOL success, NSString *_Nullable msg);
typedef void(^_Nullable CancelBlock)(void);

@class PaymentParamModel;

@interface PaymentManager : NSObject

///弹窗选择支付方式
+ (void)startPay:(PaymentParamModel *)param businType:(BusinessType)businType result:(CompleteBlock)block cancel:(CancelBlock)cancel;


@end


@interface PaymentParamModel : NSObject


@property (nonatomic, assign) int64_t payId;
@property (nonatomic, assign) double price;

///可选
@property (nonatomic, assign) double discount; //本身折扣
@property (nonatomic, assign) double nobleDiscountMoney; //vip打折
@property (nonatomic, assign) double rechargeCoin; //充值的金币数

///受益人ID（比如买守护，粉丝团）
@property (nonatomic, assign) int64_t receiverUId;

///支付渠道ID 1:支付宝 2:微信 3:ios内购 11：钱方支付宝 12：钱方微信 21：汇潮支付宝 22：汇潮微信 31：首易信支付宝 32：首易信微信
@property (nonatomic, assign) int channelId;
///支付页面类型 1：APP支付， 2：web网页支付 3：扫码支付,4调起支付宝,5调起微信小程序,6金币支付
@property (nonatomic, assign) int pageType;


@end



NS_ASSUME_NONNULL_END
