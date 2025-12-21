//
//  HomeCarouselHeaderView.h
//  LibProjView
//
//  Created by KLC on 2020/7/15.
//  Copyright © 2020 . All rights reserved.
//

#import <UIKit/UIKit.h>
#import <LibProjModel/AppAdsModel.h>
NS_ASSUME_NONNULL_BEGIN
 
//首页轮播
@class HomeCarouselHeaderView;
@protocol HomeCarouselHeaderViewDelegate <NSObject>
@optional
- (void)HomeCarouselHeaderView:(HomeCarouselHeaderView *)headerviewView withModel:(AppAdsModel *)model;
@end
@interface HomeCarouselHeaderView : UICollectionReusableView

@property(nonatomic,weak)id<HomeCarouselHeaderViewDelegate> delegate;
@property(nonatomic,strong)NSMutableArray *sliderArray;

+ (CGFloat)viewHeight;

- (void)startScroll;
- (void)stopScroll;


@end
NS_ASSUME_NONNULL_END
