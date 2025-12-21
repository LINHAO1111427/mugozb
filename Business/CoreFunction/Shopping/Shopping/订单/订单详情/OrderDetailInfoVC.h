//
//  OrderDetailInfoVC.h
//  Shopping
//
//  Created by yww on 2020/8/4.
//  Copyright © 2020 klc. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface OrderDetailInfoVC : UIViewController
@property (nonatomic, strong)NSNumber *odType;
@property (nonatomic, strong)NSNumber *order_id;
@property (nonatomic, copy)NSString *navTitle;
@end

NS_ASSUME_NONNULL_END
