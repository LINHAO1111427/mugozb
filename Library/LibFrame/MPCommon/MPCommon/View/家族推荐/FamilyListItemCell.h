//
//  FamilyListItemCell.h
//  OTMLive
//
//  Created by klc_sl on 2020/12/18.
//  Copyright © 2020 KLC. All rights reserved.
//

#import <UIKit/UIKit.h>

@class AdminUserModel;

NS_ASSUME_NONNULL_BEGIN

@interface FamilyListItemCell : UICollectionViewCell

@property(nonatomic, weak)UIImageView *userIcon; ///用户头像

@property (nonatomic, weak)UILabel *userNameL;  ///名称

@property (nonatomic, weak)UILabel *coinL;  ///金币

@property (nonatomic, weak)UIView *bgColorV;

@property (nonatomic, weak)UIButton *joinBtn;

- (void)selectOneItem:(BOOL)selected;


@property (nonatomic, strong)AdminUserModel *userModel;

@end

NS_ASSUME_NONNULL_END
