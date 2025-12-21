//
//  RefundOrderCheckVc.h
//  Shopping
//
//  Created by yww on 2020/11/14.
//  Copyright © 2020 KLC. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@class ShopBusinessOrderModel;
@interface RefundOrderCheckVc : UIViewController
- (instancetype)initWithModel:(ShopBusinessOrderModel *)model;
@end

NS_ASSUME_NONNULL_END
