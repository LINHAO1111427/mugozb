//
//  OrderDetailHeaderView.h
//  Shopping
//
//  Created by yww on 2020/8/4.
//  Copyright © 2020 klc. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@class ShopUserOrderDetailDTOModel,LogisticsBeanModel;
@class OrderDetailHeaderView;
@protocol OrderDetailHeaderViewDeleagte <NSObject>
@optional
- (void)OrderDetailHeaderView:(OrderDetailHeaderView *)header logisticTapWith:(ShopUserOrderDetailDTOModel *)model;
@end
@interface OrderDetailHeaderView : UIView

@property (nonatomic, weak)id<OrderDetailHeaderViewDeleagte> delegate;
@property (nonatomic, strong)ShopUserOrderDetailDTOModel *model;
@property (nonatomic, assign)OrderType type;

+ (CGFloat)getHeaderHeight:(ShopUserOrderDetailDTOModel *)model;

@end

NS_ASSUME_NONNULL_END
