//
//  OrderDetailTableViewCell.h
//  Shopping
//
//  Created by yww on 2020/8/4.
//  Copyright © 2020 klc. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
@class ShopSubOrderModel;
@interface OrderDetailTableViewCell : UITableViewCell
@property (nonatomic, assign)OrderType type;
@property (nonatomic, strong)ShopSubOrderModel *model;
@end

NS_ASSUME_NONNULL_END
