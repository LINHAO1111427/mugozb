//
//  PurchaseTableViewCell.h
//  Shopping
//
//  Created by klc on 2020/7/9.
//  Copyright © 2020 klc. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ShopCarModel;

NS_ASSUME_NONNULL_BEGIN
@class PurchaseTableViewCell;
@protocol PurchaseTableViewCellDelagate <NSObject>
@optional
- (void)PurchaseTableViewCell:(PurchaseTableViewCell *)cell selectedClick:(BOOL)selected;
- (void)PurchaseTableViewCell:(PurchaseTableViewCell *)cell buyNumChange:(int)num;
- (void)PurchaseTableViewCellAttributeBtnClick:(PurchaseTableViewCell *)cell;
- (void)PurchaseTableViewCellCommodityClick:(PurchaseTableViewCell *)cell;
@end

@interface PurchaseTableViewCell : UITableViewCell

@property (nonatomic, assign)BOOL lastOne;

@property (nonatomic, weak)id<PurchaseTableViewCellDelagate> delegate;

@property (nonatomic, strong)ShopCarModel *commodityModel;

@property (nonatomic, assign)BOOL isSelectGoods;

@end

NS_ASSUME_NONNULL_END
