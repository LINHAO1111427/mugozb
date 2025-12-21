//
//  OrderRefundCommodityCheckView.h
//  Shopping
//
//  Created by yww on 2020/11/16.
//  Copyright © 2020 KLC. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
@class OrderRefundCommodityCheckView;
typedef void(^OrderCommodityRefundCallBack)(BOOL isClose,BOOL isAgree,NSString *reason,OrderRefundCommodityCheckView *inputView);

@interface OrderRefundCommodityCheckView : UIView
+ (void)showOrderLogisticsRefundViewCallBack:(OrderCommodityRefundCallBack)callBack;
@end

NS_ASSUME_NONNULL_END
