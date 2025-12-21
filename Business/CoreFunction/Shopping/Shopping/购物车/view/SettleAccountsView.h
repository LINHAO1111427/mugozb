//
//  SettleAccountsView.h
//  Shopping
//
//  Created by klc on 2020/7/18.
//  Copyright © 2020 klc. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
@protocol SettleAccountsViewDelegate <NSObject>
@optional
///全选
- (void)SettleAccountsViewSelectedBtnClick:(BOOL)selected;
///结算
- (void)SettleAccountsViewSettleBtnClick;

@end
@interface SettleAccountsView : UIView
@property (nonatomic, weak)id<SettleAccountsViewDelegate> delegate;

/// 更改结算信息
/// @param amount 金额
/// @param num 数目
/// @param allSelected      是否全部选中
- (void)changeAmountMoney:(CGFloat)amount commodityNum:(NSInteger)num allSelected:(BOOL)allSelected;

@end

NS_ASSUME_NONNULL_END
