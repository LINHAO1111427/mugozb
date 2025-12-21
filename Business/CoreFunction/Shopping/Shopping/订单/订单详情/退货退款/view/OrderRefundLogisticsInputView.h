//
//  OderRefundLogisticsInputView.h
//  Shopping
//
//  Created by yww on 2020/11/16.
//  Copyright © 2020 KLC. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
@class OrderRefundLogisticsInputView;
typedef void(^OrderLogisticsRefundCallBack)(BOOL isLogistics,NSString *name,NSString *num_NO,OrderRefundLogisticsInputView *inputView);
 
@interface OrderRefundLogisticsInputView : UIView
+ (void)showOrderLogisticsRefundViewCallBack:(OrderLogisticsRefundCallBack)callBack;
@end

NS_ASSUME_NONNULL_END
 
 
