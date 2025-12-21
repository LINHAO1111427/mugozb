//
//  SVAdBannerView.m
//  ShortVideo
//
//  Created by klc_sl on 2021/5/17.
//  Copyright © 2021 KLC. All rights reserved.
//

#import "SVAdBannerView.h"
#import <LibProjView/NewPagedFlowView.h>
#import <LibProjView/PGIndexBannerSubiew.h>
#import <LibProjModel/ShortVideoAdsVOModel.h>

@interface SVAdBannerView () <NewPagedFlowViewDelegate,NewPagedFlowViewDataSource>

///广告轮播图
@property(nonatomic,weak)NewPagedFlowView *pageFlowView;
@end

@implementation SVAdBannerView

- (void)dealloc
{
    [_pageFlowView stopTimer];
}

- (NewPagedFlowView *)pageFlowView{
    if (!_pageFlowView) {
        NewPagedFlowView *pageFlowView = [[NewPagedFlowView alloc] initWithFrame:CGRectMake(15, 0, kScreenWidth-30, (kScreenWidth-30)/5.0)];
        pageFlowView.delegate = self;
        pageFlowView.dataSource = self;
        pageFlowView.isFillet = NO;
        pageFlowView.leftRightMargin = 0;
        pageFlowView.topBottomMargin = 0;
        pageFlowView.minimumPageAlpha = 0.1;
        pageFlowView.isCarousel = YES;
        pageFlowView.orientation = NewPagedFlowViewOrientationHorizontal;
        pageFlowView.isOpenAutoScroll = YES;
        pageFlowView.autoTime = 3;
        pageFlowView.layer.masksToBounds = YES;
        pageFlowView.layer.cornerRadius = 5;
        pageFlowView.clipsToBounds = YES;
        [self addSubview:pageFlowView];
        self.pageFlowView = pageFlowView;
        CGFloat y = pageFlowView.height-25;
        UIPageControl *pageControl = [[UIPageControl alloc] initWithFrame:CGRectMake(0, y, pageFlowView.width, 8)];
        pageFlowView.pageControl = pageControl;
        [pageFlowView addSubview:pageControl];
        pageFlowView.backgroundColor = [UIColor clearColor];
    }
    return _pageFlowView;
}

- (void)setAdList:(NSArray<ShortVideoAdsVOModel *> *)adList{
    _adList = adList;
    if (_adList.count > 0) {
        [self.pageFlowView reloadData];
        [self.pageFlowView startTimer];
    }else{
        [self.pageFlowView stopTimer];
        [self.pageFlowView removeFromSuperview];
        _pageFlowView = nil;
    }
}

- (void)stopScroll{
    [self.pageFlowView stopTimer];
    [self.pageFlowView removeFromSuperview];
    _pageFlowView = nil;
}


#pragma mark NewPagedFlowView Delegate
- (CGSize)sizeForPageInFlowView:(NewPagedFlowView *)flowView {
    return flowView.bounds.size;
}

- (void)didSelectCell:(UIView *)subView withSubViewIndex:(NSInteger)subIndex {
   // NSLog(@"过滤文字点击了第%ld张图"),(long)subIndex + 1);
    if (self.adItemClick && (self.adList.count > subIndex)) {
        ShortVideoAdsVOModel *voModel = self.adList[subIndex];
        self.adItemClick(voModel.adsUrl);
    }
}

-(void)didScrollToPage:(NSInteger)pageNumber inFlowView:(NewPagedFlowView *)flowView {
    //   // NSLog(@"过滤文字cell == %@"),flowView.reusableCells);
    //       // NSLog(@"过滤文字ViewController 滚动到了第%ld页"),pageNumber);
}

#pragma mark NewPagedFlowView Datasource
- (NSInteger)numberOfPagesInFlowView:(NewPagedFlowView *)flowView {
    return self.adList.count;
}

- (PGIndexBannerSubiew *)flowView:(NewPagedFlowView *)flowView cellForPageAtIndex:(NSInteger)index{
    PGIndexBannerSubiew *bannerView = [flowView dequeueReusableCell];
    if (!bannerView) {
        bannerView = [[PGIndexBannerSubiew alloc] init];
        bannerView.tag = index;
    }
    ShortVideoAdsVOModel *voModel = self.adList[index];
    
    [bannerView.mainImageView sd_setImageWithURL:[NSURL URLWithString:voModel.adsBannerUrl] placeholderImage:PlaholderImage];
    bannerView.mainImageView.contentMode = UIViewContentModeScaleAspectFill;
    bannerView.layer.masksToBounds = YES;
    bannerView.layer.cornerRadius = 5;
    bannerView.clipsToBounds = YES;
    
    return bannerView;
}

- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event{
    UIView *hitV = [super hitTest:point withEvent:event];
    if (hitV == self) {
        return nil;
    }
    return hitV;
}


@end
