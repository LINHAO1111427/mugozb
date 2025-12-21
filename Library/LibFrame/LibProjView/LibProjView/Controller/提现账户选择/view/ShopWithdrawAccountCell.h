//
//  ShopWithdrawAccountCell.h
//  Shopping
//
//  Created by ssssssss on 2020/8/6.
//  Copyright © 2020 klc. All rights reserved.
//

#import <UIKit/UIKit.h>


NS_ASSUME_NONNULL_BEGIN

FOUNDATION_EXPORT NSString *const ShopWithdrawAccountCellIdentifier;

@class AppUsersCashAccountModel;
@interface ShopWithdrawAccountCell : UITableViewCell

@property (strong, nonatomic) UIView *topBgView;
@property (strong, nonatomic) UIView *bottomBgView;

@property (strong, nonatomic, readonly)AppUsersCashAccountModel *accountModel;
@property (nonatomic, copy) void (^deleteModel)(AppUsersCashAccountModel *accountModel);
- (void)setDefaultModel:(AppUsersCashAccountModel *)defaultModel showModel:(AppUsersCashAccountModel *)accountModel;
@end

NS_ASSUME_NONNULL_END
