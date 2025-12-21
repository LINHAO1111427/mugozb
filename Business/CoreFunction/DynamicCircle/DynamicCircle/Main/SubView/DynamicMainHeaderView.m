//
//  DynamicMainHeaderView.m
//  klcProject
//
//  Created by ssssssssssss on 2020/7/24.
//  Copyright © 2020 KLC. All rights reserved.
//

#import "DynamicMainHeaderView.h"
#import <LibProjView/NewPagedFlowView.h>
#import <LibProjView/PGIndexBannerSubiew.h>
#import <LibProjModel/HttpApiDynamicController.h>
#import <LibProjModel/HttpApiAppLogin.h>

@interface DynamicMainHeaderView()<
NewPagedFlowViewDelegate,
NewPagedFlowViewDataSource
>
@property (nonatomic, strong)NewPagedFlowView *pageFlowView;

@property(nonatomic,strong)NSMutableArray *imageMutArr;
@property (nonatomic, strong)UIView *topicView;//话题
@property (nonatomic, strong)NSArray *topicArray;
@property (nonatomic, strong)NSArray *sliderArray;

@end

@implementation DynamicMainHeaderView

- (void)loadVideoTypeList{
    kWeakSelf(self);
    int page = 0;
    int pageSize = kPageSize;
    [HttpApiDynamicController getTopicList:page pageSize:pageSize callback:^(int code, NSString *strMsg, NSArray<AppVideoTopicModel *> *arr) {
        if (code == 1) {
            weakself.topicArray = arr;
        }
    }];
}

- (void)loadSlidercallBack{
    kWeakSelf(self);
    [HttpApiAppLogin adslist:21 type:21 callback:^(int code, NSString *strMsg, NSArray<AppAdsModel *> *arr) {
        if (code == 1) {
            weakself.sliderArray = arr;
        }else{
        }
    }];
}

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self createUI];
    }
    return self;
}
- (UIView *)topicView{
    if (!_topicView) {
        _topicView = [[UIView alloc]initWithFrame:CGRectMake(0, _pageFlowView.maxY+10, kScreenWidth, 0.1)];
        _topicView.backgroundColor = [UIColor whiteColor];
    }
    return _topicView;
}

- (NewPagedFlowView *)pageFlowView{
    if (!_pageFlowView) {
        _pageFlowView = [[NewPagedFlowView alloc] initWithFrame:CGRectMake(10, 0, kScreenWidth-20, [[ProjConfig shareInstence].baseConfig adDynamicBannerHeightScaleToWidth:(kScreenWidth-20)])];
        _pageFlowView.delegate = self;
        _pageFlowView.dataSource = self;
        _pageFlowView.isFillet = YES;
        _pageFlowView.leftRightMargin = 0;
        _pageFlowView.topBottomMargin = 0;
        _pageFlowView.minimumPageAlpha = 0.1;
        _pageFlowView.isCarousel = YES;
        _pageFlowView.orientation = NewPagedFlowViewOrientationHorizontal;
        _pageFlowView.isOpenAutoScroll = YES;
        _pageFlowView.autoTime = 3;
        CGFloat y = _pageFlowView.height-18-5;
        UIPageControl *pageControl = [[UIPageControl alloc] initWithFrame:CGRectMake(12, y, kScreenWidth-48, 8)];
        _pageFlowView.pageControl = pageControl;
        [_pageFlowView addSubview:pageControl];
        _pageFlowView.backgroundColor = [UIColor whiteColor];
        _pageFlowView.clipsToBounds = YES;
    }
    return _pageFlowView;
}

- (void)createUI{
    self.backgroundColor = [UIColor whiteColor];
    [self addSubview:self.pageFlowView];
    [self addSubview:self.topicView];
}
- (void)layoutSubviews{
    [super layoutSubviews];
}

- (void)loadShowData{
    [self loadSlidercallBack];
    [self loadVideoTypeList];
}

- (void)setTopicArray:(NSArray *)topicArray{
    _topicArray = topicArray;
    [self updateTopicView];
    
    [self resetViewHeight];
}

- (void)updateTopicView{
    [self.topicView removeAllSubViews];
    
    if (_topicArray.count == 0) {
        return;
    }
    self.topicView.height = 100;
    
    UILabel *titleL = [[UILabel alloc] initWithFrame:CGRectMake(10, 0, 80, 20)];
    titleL.font = [UIFont systemFontOfSize:15 weight:UIFontWeightMedium];
    titleL.textColor = kRGBA_COLOR(@"#333333", 1.0);
    titleL.text = kLocalizationMsg(@"热门话题");
    [self.topicView addSubview:titleL];
    
    UIScrollView *topicBgScrollV = [[UIScrollView alloc] initWithFrame:CGRectMake(0, titleL.maxY+10, self.topicView.width, 60)];
    topicBgScrollV.showsHorizontalScrollIndicator = NO;
    [self.topicView addSubview:topicBgScrollV];
    
    CGFloat maxX = 10;
    for (int i = 0; i < self.topicArray.count; i++) {
        AppVideoTopicModel *model = self.topicArray[i];
        UIImageView *imageV = [[UIImageView alloc]initWithFrame:CGRectMake(10+115*i, 0, 105, 60)];
        imageV.contentMode = UIViewContentModeScaleAspectFill;
        imageV.userInteractionEnabled = YES;
        imageV.clipsToBounds = YES;
        imageV.layer.masksToBounds = YES;
        imageV.layer.cornerRadius = 8;
        [imageV sd_setImageWithURL:[NSURL URLWithString:model.image] placeholderImage:[UIImage imageWithColor:[UIColor lightGrayColor]]];
        [topicBgScrollV addSubview:imageV];
        
        UIButton *coverBtn = [[UIButton alloc]initWithFrame:imageV.bounds];
        coverBtn.backgroundColor = kRGBA_COLOR(@"#333333", 0.4);
        coverBtn.tag = i;
        [coverBtn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
        [imageV addSubview:coverBtn];
        
        UILabel *Label = [[UILabel alloc]initWithFrame:CGRectMake(10, 10, imageV.width-20, 19)];
        Label.textColor = [UIColor whiteColor];
        Label.text = [NSString stringWithFormat:@"# %@",model.name];
        Label.textAlignment = NSTextAlignmentLeft;
        Label.font = [UIFont systemFontOfSize:13];
        [imageV addSubview:Label];

        maxX = imageV.maxX;
    }
    topicBgScrollV.contentSize = CGSizeMake(maxX+10, 0);
}

- (void)setSliderArray:(NSArray *)sliderArray {
    _sliderArray = sliderArray;
    if (sliderArray.count == 0) {
        self.pageFlowView.height = 0;
        self.pageFlowView.hidden = YES;
        self.topicView.y = self.pageFlowView.maxY;
    }else{
        CGFloat height = [[ProjConfig shareInstence].baseConfig adDynamicBannerHeightScaleToWidth:self.pageFlowView.width];
        self.pageFlowView.height = height;
        self.pageFlowView.hidden = NO;
        
        self.topicView.y = self.pageFlowView.maxY+10;
    }
    self.imageMutArr = [NSMutableArray array];
    for (int i = 0; i < sliderArray.count; i++) {
        AppAdsModel *model = sliderArray[i];
        [self.imageMutArr addObject:model.thumb];
    }
    [self.pageFlowView reloadData];
    [self setNeedsLayout];
    
    [self resetViewHeight];
}

- (void)resetViewHeight{
    self.height = self.topicView.maxY;
    if (self.delegate && [self.delegate respondsToSelector:@selector(dynamicMainHeaderView:changeHeaderHeight:)]) {
        [self.delegate dynamicMainHeaderView:self changeHeaderHeight:self.height];
    }
}

- (void)btnClick:(UIButton *)btn{
    if(btn.tag >= 0 && btn.tag < self.topicArray.count){
        AppVideoTopicModel *model = self.topicArray[btn.tag];
        if (self.delegate && [self.delegate respondsToSelector:@selector(dynamicMainHeaderView:topicClick:selectedIndex:)]) {
            [self.delegate dynamicMainHeaderView:self topicClick:model selectedIndex:btn.tag];
        }
    }
}
#pragma mark NewPagedFlowView Delegate
- (NSMutableArray *)imageMutArr{
    if (!_imageMutArr) {
        _imageMutArr = [NSMutableArray array];
    }
    return _imageMutArr;
}
- (CGSize)sizeForPageInFlowView:(NewPagedFlowView *)flowView {
    return flowView.size;
}
- (void)didSelectCell:(UIView *)subView withSubViewIndex:(NSInteger)subIndex {
    if(subIndex>-1 && self.sliderArray!=nil ){
        AppAdsModel *model = self.sliderArray[subIndex];
        if (self.delegate && [self.delegate respondsToSelector:@selector(dynamicMainHeaderView:sliderClick:selectedIndex:)]) {
            [self.delegate dynamicMainHeaderView:self sliderClick:model selectedIndex:subIndex];
        }
    }
}

-(void)didScrollToPage:(NSInteger)pageNumber inFlowView:(NewPagedFlowView *)flowView {
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
    bannerView.clipsToBounds = YES;
    return bannerView;
}

@end
