//
//  HomeCarouselHeaderView.m
//  LibProjView
//
//  Created by KLC on 2020/7/15.
//  Copyright © 2020 . All rights reserved.
//

#import "HomeCarouselHeaderView.h"
#import <LibTools/LibTools.h>
#import <SDWebImage/SDWebImage.h>
#import <SDWebImage/UIImageView+WebCache.h>
#import "NewPagedFlowView.h"
#import "PGIndexBannerSubiew.h"
@interface HomeCarouselHeaderView()<NewPagedFlowViewDelegate,
NewPagedFlowViewDataSource>
@property(nonatomic,strong)NewPagedFlowView *pageFlowView;
@property(nonatomic,strong)NSMutableArray *imageMutArr;
@end

@implementation HomeCarouselHeaderView
- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self createUI];
        self.layer.masksToBounds = YES;
        self.clipsToBounds = YES;
    }
    return self;
}
- (NSMutableArray *)imageMutArr{
    if (!_imageMutArr) {
        _imageMutArr = [NSMutableArray array];
    }
    return _imageMutArr;
}
 
- (NewPagedFlowView *)pageFlowView{
    if (!_pageFlowView) {
        _pageFlowView= [[NewPagedFlowView alloc] initWithFrame:CGRectMake(5, 0, kScreenWidth-10, [[ProjConfig shareInstence].baseConfig adHomeBannerHeightScaleToWidth:(kScreenWidth-10)])];
        _pageFlowView.delegate = self;
        _pageFlowView.dataSource = self;
        _pageFlowView.isFillet = NO;
        _pageFlowView.leftRightMargin = 0;
        _pageFlowView.topBottomMargin = 0;
        _pageFlowView.minimumPageAlpha = 0.1;
        _pageFlowView.isCarousel = YES;
        _pageFlowView.orientation = NewPagedFlowViewOrientationHorizontal;
        _pageFlowView.isOpenAutoScroll = YES;
        _pageFlowView.autoTime = 3;
        _pageFlowView.layer.masksToBounds = YES;
        _pageFlowView.layer.cornerRadius = 5.0;
        CGFloat y = _pageFlowView.height-18;
        UIPageControl *pageControl = [[UIPageControl alloc] initWithFrame:CGRectMake(0, y, kScreenWidth-24, 8)];
        _pageFlowView.pageControl = pageControl;
        pageControl.centerX = _pageFlowView.centerX;
        [_pageFlowView addSubview:pageControl];
        _pageFlowView.backgroundColor = [UIColor clearColor];
    }
    return _pageFlowView;
}
- (void)createUI{
    self.backgroundColor = [UIColor clearColor];
    [self addSubview:self.pageFlowView];
}

- (void)setSliderArray:(NSMutableArray *)sliderArray{
    _sliderArray = sliderArray;
     if (sliderArray.count == 0) {
         self.pageFlowView.height = 0;
         self.pageFlowView.hidden = YES;
     }else{
         self.pageFlowView.height = [[ProjConfig shareInstence].baseConfig adHomeBannerHeightScaleToWidth:self.pageFlowView.width];
         self.pageFlowView.hidden = NO;
     }
     self.imageMutArr = [NSMutableArray array];
     for (int i = 0; i < sliderArray.count; i++) {
         AppAdsModel *model = sliderArray[i];
         [self.imageMutArr addObject:model.thumb];
     }

     [self.pageFlowView reloadData];
}
 
 
- (void)startScroll{
    [_pageFlowView startTimer];
}

- (void)stopScroll{
    [_pageFlowView stopTimer];
}

+ (CGFloat)viewHeight{
    return [[ProjConfig shareInstence].baseConfig adHomeBannerHeightScaleToWidth:(kScreenWidth-10)];
}

#pragma mark NewPagedFlowView Delegate
- (CGSize)sizeForPageInFlowView:(NewPagedFlowView *)flowView {
    return flowView.size;
}


- (void)didSelectCell:(UIView *)subView withSubViewIndex:(NSInteger)subIndex {
   // NSLog(@"过滤文字点击了第%ld张图"),(long)subIndex + 1);
    if(subIndex>-1 && self.sliderArray!=nil ){
        AppAdsModel *model = self.sliderArray[subIndex];
        if (self.delegate && [self.delegate respondsToSelector:@selector(HomeCarouselHeaderView:withModel:)]) {
            [self.delegate HomeCarouselHeaderView:self withModel:model];
        }
    }
    
}

-(void)didScrollToPage:(NSInteger)pageNumber inFlowView:(NewPagedFlowView *)flowView {
//   // NSLog(@"过滤文字cell == %@"),flowView.reusableCells);
//       // NSLog(@"过滤文字ViewController 滚动到了第%ld页"),pageNumber);
}

#pragma mark NewPagedFlowView Datasource
- (NSInteger)numberOfPagesInFlowView:(NewPagedFlowView *)flowView {
    return self.imageMutArr.count;
}

- (PGIndexBannerSubiew *)flowView:(NewPagedFlowView *)flowView cellForPageAtIndex:(NSInteger)index{
    PGIndexBannerSubiew *bannerView = [flowView dequeueReusableCell];
    if (!bannerView) {
        bannerView = [[PGIndexBannerSubiew alloc] init];
        bannerView.tag = index;
    }
    [bannerView.mainImageView sd_setImageWithURL:[NSURL URLWithString:self.imageMutArr[index]] placeholderImage:PlaholderImage];
    bannerView.mainImageView.contentMode = UIViewContentModeScaleAspectFill;
    bannerView.mainImageView.clipsToBounds = YES;
    
    return bannerView;
}


@end
