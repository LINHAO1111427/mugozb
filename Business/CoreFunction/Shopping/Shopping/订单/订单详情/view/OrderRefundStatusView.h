//
//  OrderRefundStatusView.h
//  Shopping
//
//  Created by yww on 2020/11/13.
//  Copyright © 2020 KLC. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@class ShopUserOrderDetailDTOModel;
@interface OrderRefundStatusView : UIView
@property (nonatomic, strong)ShopUserOrderDetailDTOModel *model;
@end

NS_ASSUME_NONNULL_END
