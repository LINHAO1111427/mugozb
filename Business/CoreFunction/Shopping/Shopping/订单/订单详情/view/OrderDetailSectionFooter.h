//
//  OrderDetailSectionFooter.h
//  Shopping
//
//  Created by yww on 2020/8/4.
//  Copyright © 2020 klc. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
@class ShopUserOrderDetailDTOModel,OrderDetailSectionFooter,ShopGoodsChannelModel;
@protocol OrderDetailSectionFooterDelegate <NSObject>
@optional
- (void)OrderDetailSectionFooter:(OrderDetailSectionFooter *)footer btnClickWith:(NSInteger)tag model:(ShopUserOrderDetailDTOModel *)model;

@end
@interface OrderDetailSectionFooter : UIView
@property (nonatomic, strong)ShopUserOrderDetailDTOModel *model;
@property (nonatomic, weak)id<OrderDetailSectionFooterDelegate> delegate;
- (instancetype)initWithFrame:(CGRect)frame type:(OrderType)type;
@end

NS_ASSUME_NONNULL_END
