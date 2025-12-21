//
//  TotalRankHeader.h
//  Ranking
//
//  Created by ssssssss on 2020/12/24.
//  Copyright © 2020 KLC. All rights reserved.
//

#import <UIKit/UIKit.h>

@class RankUserInfoHeaderView,TotalRankHeader;


NS_ASSUME_NONNULL_BEGIN

@protocol TotalRankHeaderDelegate <NSObject>
@optional

///更新用户的数据
- (void)showUserInfo:(id)userInfoM userHeaderView:(RankUserInfoHeaderView *)headerV;

- (void)TotalRankHeader:(TotalRankHeader *)headerV clickIndex:(NSInteger)index;

@end


@interface RankUserInfoHeaderView : UIControl

///用户ID
@property (nonatomic, assign)int64_t userId;
@property (nonatomic, weak)UIImageView *userIconV;
@property (nonatomic, weak)UILabel *userNameL;
@property (nonatomic, weak)UILabel *coinL;
@property (nonatomic, weak)UIImageView *levelImgV;

@end


@interface TotalRankHeader : UIView

@property (nonatomic, weak)UIImageView *bgImageV; ///背景图片imageView
@property (nonatomic, strong)NSArray *dataArray;
@property (nonatomic, weak)id<TotalRankHeaderDelegate> delegate;


@end

NS_ASSUME_NONNULL_END
