//
//  AddWithdrawalAccountVC.h
//  CapitalMarket
//
//  Created by klc on 2020/3/26.
//  Copyright © 2020 . All rights reserved.
//

#import <UIKit/UIKit.h>
#import <LibProjModel/HttpApiAPPFinance.h>
NS_ASSUME_NONNULL_BEGIN
@class AppUsersCashAccountModel;
@interface ShopAddWithdrawalAccountVC : UIViewController

@property (nonatomic, copy)NSString *navTitle;

@property (nonatomic, assign)BOOL isEdit;

- (instancetype)initWith:(BOOL)isEidt model:(AppUsersCashAccountModel *)model;

@end

NS_ASSUME_NONNULL_END
