//
//  SetFunctionItemCell.h
//  LiveCommon
//
//  Created by klc_sl on 2020/3/19.
//  Copyright © 2020 . All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
@class SetFunctionItemCell;
@protocol SetFunctionItemCellDeleagte <NSObject>
@optional
- (void)SetFunctionItemCell:(SetFunctionItemCell*)cell switchShopChange:(BOOL)switchOn;

@end
@interface SetFunctionItemCell : UITableViewCell

///占位视图
@property (nonatomic, weak) UIView *bgView;

@property (weak, nonatomic) UIImageView *imageV;

@property (weak, nonatomic) UILabel *titleL;

@property (weak, nonatomic) UILabel *detailL;

@property (nonatomic, weak)UISwitch *shopSwitch;

@property (nonatomic, weak)id<SetFunctionItemCellDeleagte> delegate;
@end

NS_ASSUME_NONNULL_END
