//
//  DisableMsgItemCell.h
//  LiveCommon
//
//  Created by klc_sl on 2020/3/19.
//  Copyright © 2020 . All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface DisableMsgItemCell : UITableViewCell

///占位视图
@property (nonatomic, weak) UIView *bgView;

@property (weak, nonatomic) UIImageView *userIcon;

@property (weak, nonatomic) UILabel *titleL;

@property (weak, nonatomic) UILabel *detailL;

@property (weak, nonatomic) UIButton *functionBtn;



@end

NS_ASSUME_NONNULL_END
