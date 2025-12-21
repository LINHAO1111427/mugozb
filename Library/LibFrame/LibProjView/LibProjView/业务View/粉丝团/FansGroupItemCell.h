//
//  FansGroupItemCell.h
//  LiveCommon
//
//  Created by klc_sl on 2020/3/19.
//  Copyright © 2020 . All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@class RanksDtoModel;
@class KlcAvatarView;
@interface FansGroupItemCell : UITableViewCell

///占位视图
@property (nonatomic, weak) UIView *bgView;

@property (weak, nonatomic) KlcAvatarView *userIcon;

@property (weak, nonatomic) UIImageView *userLevelImgV;

@property (weak, nonatomic) UIImageView *wealthLevelImgV;

@property (weak, nonatomic) UILabel *titleL;

@property (weak, nonatomic) UILabel *detailL;


@property (nonatomic,strong)RanksDtoModel *userModel;


@end

NS_ASSUME_NONNULL_END
