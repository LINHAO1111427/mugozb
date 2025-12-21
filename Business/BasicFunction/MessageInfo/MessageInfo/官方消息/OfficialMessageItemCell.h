//
//  OfficialMessageItemCell.h
//  Message
//
//  Created by klc_sl on 2020/8/25.
//  Copyright © 2020 KLC. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@class AppOfficialNewsDTOModel;

@interface OfficialMessageItemCell : UITableViewCell

@property (nonatomic, weak)UIView *bgView;

@property (nonatomic, weak)UILabel *timeL;

@property (nonatomic, weak)UIImageView *logo;

@property (nonatomic, weak)UILabel *titleL;

@property (nonatomic, weak)UILabel *contentL;


@property (nonatomic, weak)AppOfficialNewsDTOModel *model;


@end

NS_ASSUME_NONNULL_END
