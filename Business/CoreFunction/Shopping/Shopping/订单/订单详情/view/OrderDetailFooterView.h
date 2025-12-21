//
//  OrderDetailFooterView.h
//  Shopping
//
//  Created by yww on 2020/8/4.
//  Copyright © 2020 klc. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ShopUserOrderDetailDTOModel,ShopGoodsChannelModel;
NS_ASSUME_NONNULL_BEGIN
@protocol OrderDetailFooterViewDelegate <NSObject>
@optional
- (void)OrderDetailFooterViewLogisticBtnClick;

@end
@interface OrderDetailFooterView : UIView
@property (nonatomic, strong)ShopUserOrderDetailDTOModel *model;
@property (nonatomic, assign)OrderType type;
@property (nonatomic, weak)id<OrderDetailFooterViewDelegate> delegate;
@end

NS_ASSUME_NONNULL_END
