//
//  ShopOrderTableHeaderView.h
//  Shopping
//
//  Created by klc on 2020/7/20.
//  Copyright © 2020 klc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <LibProjModel/ShopAddressModel.h>

NS_ASSUME_NONNULL_BEGIN
@class ShopOrderTableHeaderView;
@protocol ShopOrderTableHeaderViewDelgate <NSObject>
@optional
- (void)ShopOrderTableHeaderViewAddressBtnClick:(ShopOrderTableHeaderView*)headerV;

@end
@interface ShopOrderTableHeaderView : UIView
@property (nonatomic, strong)ShopAddressModel *addressModel;
@property (nonatomic, weak)id<ShopOrderTableHeaderViewDelgate> delegate;
@end

NS_ASSUME_NONNULL_END
