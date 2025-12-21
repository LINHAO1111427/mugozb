//
//  PurchaseSectionHeaderView.h
//  Shopping
//
//  Created by klc on 2020/7/11.
//  Copyright © 2020 klc. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ShopCarDTOModel;

NS_ASSUME_NONNULL_BEGIN
@class PurchaseSectionHeaderView;
@protocol PurchaseSectionHeaderViewDelagate <NSObject>
@optional
- (void)PurchaseSectionHeaderView:(PurchaseSectionHeaderView *)headerV selectedClick:(BOOL)selected;
- (void)PurchaseSectionHeaderViewShopBtnClick:(PurchaseSectionHeaderView *)headerV;
@end
@interface PurchaseSectionHeaderView : UIView

@property (nonatomic, strong)ShopCarDTOModel *sectionModel;
@property (nonatomic, assign)NSInteger sectionNum;
@property (nonatomic, weak)id<PurchaseSectionHeaderViewDelagate> delegate;
@end

NS_ASSUME_NONNULL_END
