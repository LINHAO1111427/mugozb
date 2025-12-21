//
//  OrderDetailSectionHeader.h
//  Shopping
//
//  Created by yww on 2020/8/4.
//  Copyright © 2020 klc. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
@class ShopUserOrderDetailDTOModel;
@class OrderDetailSectionHeader;
@protocol OrderDetailSectionHeaderDelegate <NSObject>
@optional
- (void)OrderDetailSectionHeader:(OrderDetailSectionHeader *)header shopBtnClickWith:(ShopUserOrderDetailDTOModel *)model;
- (void)OrderDetailSectionHeader:(OrderDetailSectionHeader *)header coversationBtnClickWith:(ShopUserOrderDetailDTOModel *)model;
@end
@interface OrderDetailSectionHeader : UIView
@property (nonatomic, weak)id<OrderDetailSectionHeaderDelegate> delegate;
@property (nonatomic, strong)ShopUserOrderDetailDTOModel *model;
@property (nonatomic, assign)OrderType type;
@end

NS_ASSUME_NONNULL_END
