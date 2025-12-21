//
//  CommodityDetailBottomView.h
//  Shopping
//
//  Created by klc on 2020/7/8.
//  Copyright © 2020 klc. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
@class CommodityDetailBottomView;
@protocol CommodityDetailBottomViewDelegate <NSObject>
@optional
- (void)CommodityDetailBottomViewBtnClick:(CommodityDetailBottomView*)bottomView index:(NSInteger)index;
- (void)CommodityDetailBottomViewShopCartBtnClick:(CommodityDetailBottomView*)bottomView;
- (void)CommodityDetailBottomViewBuyBtnClick:(CommodityDetailBottomView*)bottomView;
@end
@interface CommodityDetailBottomView : UIView
@property (nonatomic, assign)id<CommodityDetailBottomViewDelegate> delegate;
@end

NS_ASSUME_NONNULL_END
