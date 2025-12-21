//
//  FamilyInfoAtUserDetailView.h
//  UserInfo
//
//  Created by klc_sl on 2021/8/25.
//  Copyright © 2021 KLC. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface FamilyInfoAtUserDetailView : UIView

@property (nonatomic, weak)UIImageView *familyIconV;  ///家族图标
@property (nonatomic, weak)UILabel *familyNameL;// 家族名称
@property (nonatomic, weak)UIImageView *familyLevelV;// 家族等级图标

///内容
@property (nonatomic, weak)UIView *contentBgView;

///加载技能列表
- (void)reloadShowData:(int64_t)userId;

///显示内容
- (void)changeViewLayout:(CGFloat)headerH;


@property (nonatomic, copy)void(^viewHeightBlock)(BOOL hasFamily);

@end

NS_ASSUME_NONNULL_END
