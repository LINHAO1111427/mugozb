//
//  ShopIncomeProfitShowView.h
//  Shopping
//
//  Created by yww on 2020/8/6.
//  Copyright © 2020 klc. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
@class ShopBusinessModel;
@class ShopWithdrawDTOModel;
@class AppUsersCashAccountModel;

@interface ShopIncomeProfitShowView : UIView

@property (nonatomic, strong)ShopBusinessModel *shopModel;
@property (nonatomic, copy)ShopWithdrawDTOModel *withdrawModel;
@property (strong, nonatomic)AppUsersCashAccountModel *accountModel;
  
@property (strong, nonatomic) UIButton *withdrawAccountBtn;//提现账号选择
@property (strong, nonatomic) UIButton *withdrawBtn;//提现

@property (strong, nonatomic) UITextField *withdrawInputTF;//提取金额

@end

NS_ASSUME_NONNULL_END
