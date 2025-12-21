//
//  OrderRefundVc.h
//  Shopping
//
//  Created by yww on 2020/11/13.
//  Copyright © 2020 KLC. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
 
typedef void(^OrderRefundCallBack)(BOOL isSubmitRefundSuccess);
@class ShopUserOrderDetailDTOModel;
@interface OrderRefundView : UIView
+ (void)showOrderRefundViewWith:(ShopUserOrderDetailDTOModel *)orderModel andCallBack:(OrderRefundCallBack)callBack;
@end
 
NS_ASSUME_NONNULL_END
