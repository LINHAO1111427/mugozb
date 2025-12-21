//
//  FocusHeaderView.h
//  ShortVideo
//
//  Created by KLC on 2020/6/16.
//  Copyright © 2020 KLC. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <LibProjModel/ApiShortVideoDtoModel.h>
#import <LibProjModel/AppAdsModel.h>

NS_ASSUME_NONNULL_BEGIN
@class FocusHeaderView;
@protocol FocusHeaderViewDelegate <NSObject>
@optional
///每周必看
- (void)FocusHeaderView:(FocusHeaderView *)headerView weekMustBtnClick:(ApiShortVideoDtoModel *)model;
///更多
- (void)FocusHeaderView:(FocusHeaderView *)headerView mostBtnClick:(NSInteger)index;
///广告
- (void)FocusHeaderView:(FocusHeaderView *)headerView adItemClick:(NSString *)adUrl;

- (void)FocusHeaderView:(FocusHeaderView *)headerView heightForView:(CGFloat)viewHeight;

@end


@interface FocusHeaderView : UICollectionReusableView

@property (nonatomic, copy)NSArray *adList;
@property (nonatomic, copy)NSArray *weekList;
@property (nonatomic, copy)NSArray *funcArr;


@property (nonatomic, weak)id<FocusHeaderViewDelegate> delegate;


- (void)reloadAdData;

- (void)adBannerisScroll:(BOOL)scroll;


@end

NS_ASSUME_NONNULL_END
