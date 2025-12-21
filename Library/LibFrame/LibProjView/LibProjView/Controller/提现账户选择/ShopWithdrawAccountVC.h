//
//  ShopWithdrawAccountVC.h
//  Shopping
//
//  Created by ssssssss on 2020/8/6.
//  Copyright © 2020 klc. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
@class AppUsersCashAccountModel;
@interface ShopWithdrawAccountVC : UIViewController
@property (nonatomic, strong,nullable)AppUsersCashAccountModel *defaultModel;
@property (nonatomic, copy)void (^selectHandle)(AppUsersCashAccountModel * __nullable model);
@end

NS_ASSUME_NONNULL_END
