//
//  HomeSquareHeaderView.m
//  MPVideoLive
//
//  Created by ssssssss on 2020/1/10.
//  Copyright © 2020 Orely. All rights reserved.
//

#import "HomeSquareHeaderView.h"
#import <JXCategoryView/JXCategoryTitleView.h>
#import <JXCategoryView/JXCategoryIndicatorBackgroundView.h>
#import <LibProjView/NewPagedFlowView.h>
#import <LibProjView/PGIndexBannerSubiew.h>
#import <LibProjModel/HttpApiHome.h>
#import <LibProjModel/HomeDtoModel.h>
#import <LibProjModel/HttpApiAppLogin.h>
#import <LibProjView/ScrollviewGuideBar.h>
#import <LibProjModel/AppHotSortModel.h>
#import <SDWebImage.h>
#import <Masonry.h>
#import "LiveMainTextAdBanner.h"
#import <LibProjModel/HttpApiPublicLive.h>

@interface HomeSquareHeaderView ()<NewPagedFlowViewDelegate,NewPagedFlowViewDataSource,JXCategoryViewDelegate>

///轮播
@property(nonatomic,strong)NewPagedFlowView *pageFlowView;
///分类图
@property(nonatomic,strong)UIView *classfiyView;

@property(nonatomic, assign)NSInteger chennelIndex; ///第几个频道
///
@property (nonatomic, copy)NSArray<AppAdsModel *> *sliderArray;
///文字广告
@property (nonatomic,weak)LiveMainTextAdBanner *labBannerV;
///广告背景
@property(nonatomic,weak)UIView *adListBgView;
///广告列表
@property (nonatomic, copy)NSArray<LiveHomeAdsVOModel *> *adItemList;
///广告的文字
@property (nonatomic, copy)NSString *adbannerStr;

@end

@implementation HomeSquareHeaderView

#pragma  mark  请求网络接口

- (void)startTimer{
    [_pageFlowView startTimer];
    [_labBannerV adBannerisScroll:YES];
}
- (void)stopTimer{
    [_pageFlowView stopTimer];
    [_labBannerV adBannerisScroll:NO];
}

///获取广告数据
- (void)loadAdData{
    [self loadBannerAdList];
    
    if (self.liveType == 1) {
        [self getAdBannerStr];
        [self getAdItemList];
    }
}

///获取banner广告列表
- (void)loadBannerAdList{
    kWeakSelf(self);
    int type = 0;
    int pid = 0;
    if (self.liveType == 1) {
        type = 2;// 0启动图 1 直播,12推荐 13附近 短视频n
        pid = 2;//1启动图 2直播 3推荐 4附近 5一对一 6短视频
    }else{
        type = 15;// 0启动图 1 直播,12推荐 13附近 短视频n
        pid = 15;//1启动图 2直播 3推荐 4附近 5一对一 6短视频
    }
    [HttpApiAppLogin adslist:pid type:type callback:^(int code, NSString *strMsg, NSArray<AppAdsModel *> *arr) {
        if (code == 1 && arr.count > 0) {
            if (arr.count > 0) {
                weakself.sliderArray = arr;
                weakself.pageFlowView.height = [[ProjConfig shareInstence].baseConfig adHomeBannerHeightScaleToWidth:self.pageFlowView.width];
                weakself.pageFlowView.hidden = NO;
                [weakself.pageFlowView reloadData];
            }else{
                weakself.sliderArray = nil;
                weakself.pageFlowView.height = 0.1;
                weakself.pageFlowView.hidden = YES;
                [weakself.pageFlowView stopTimer];
            }
            [weakself reloadViewHeight];
        }
    }];
}
///获取
- (void)getAdItemList{
    kWeakSelf(self);
    [HttpApiPublicLive getLiveHomeAdsList:1 callback:^(int code, NSString *strMsg, NSArray<LiveHomeAdsVOModel *> *arr) {
        if (code == 1) {
            weakself.adItemList = arr;
        }
    }];
}

///获取直播首页的文字广告
- (void)getAdBannerStr{
    kWeakSelf(self);
    [HttpApiPublicLive getLiveHomeAdsList:2 callback:^(int code, NSString *strMsg, NSArray<LiveHomeAdsVOModel *> *arr) {
        NSString *adBannerStr = @"";
        if (code == 1 && arr.count > 0) {
            LiveHomeAdsVOModel *AdModel = arr.firstObject;
            adBannerStr = AdModel.adsDescription;
        }
        [weakself setAdbannerStr:adBannerStr];
    }];
    
}



- (void)reloadAdData{
    [self loadAdData];
}

///广告文字banner
- (void)setAdbannerStr:(NSString *)adbannerStr{
    _adbannerStr = adbannerStr;
    if (adbannerStr.length > 0) {
        self.labBannerV.height = 30;
        [self.labBannerV showAdText:adbannerStr];
    }else{
        [_labBannerV removeFromSuperview];
        _labBannerV = nil;
    }
    [self reloadViewHeight];
}

///广告小图标
- (void)setAdItemList:(NSArray<LiveHomeAdsVOModel *> *)adItemList {
    _adItemList = adItemList;
    
    [self.adListBgView removeAllSubViews];
    
    if (adItemList.count > 0) {
        
        int lineCount = 4;
        CGFloat maxHeight = 20;
        CGFloat width = 64;
        CGFloat margin = (kScreenWidth - 64*lineCount)/(lineCount*2.0);
        
        for (int i = 0; i < adItemList.count; i++) {
            
            LiveHomeAdsVOModel *adModel = adItemList[i];
            
            CGFloat viewX = margin+(width+margin*2)*(i%lineCount);
            CGFloat viewY = 20 + (width+10)*(i/lineCount);

            UIButton *btn = [[UIButton alloc]initWithFrame:CGRectMake(viewX, viewY, width, width)];
            btn.tag = 99693+i;
            [btn addTarget:self action:@selector(adItemBtnClick:) forControlEvents:UIControlEventTouchUpInside];
            [self.adListBgView addSubview:btn];
            UIImageView *imgV = [[UIImageView alloc] initWithFrame:CGRectMake((width-40)/2.0, 0, 40, 40)];
            imgV.contentMode = UIViewContentModeScaleAspectFill;
            imgV.layer.masksToBounds = YES;
            imgV.layer.cornerRadius = 5;
            [imgV sd_setImageWithURL:[NSURL URLWithString:adModel.adsIcon]];
            [btn addSubview:imgV];
            UILabel *titleL = [[UILabel alloc] init];
            [btn addSubview:titleL];
            
            titleL.text = [NSString stringWithFormat:@"%d",i];
            titleL.text = adModel.adsTitle;
            titleL.font = [UIFont systemFontOfSize:14];
            titleL.textColor = kRGB_COLOR(@"#333333");
            titleL.textAlignment = NSTextAlignmentCenter;
            [titleL mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.equalTo(imgV.mas_bottom).mas_offset(5);
                make.centerX.equalTo(btn);
                make.width.mas_lessThanOrEqualTo(width+margin*2);
            }];

            maxHeight = btn.maxY;
        }
        self.adListBgView.height = maxHeight+10;
    }else{
        self.adListBgView.height = 0.1;
        [self.adListBgView removeFromSuperview];
    }
    [self reloadViewHeight];
}

- (void)setDtoModel:(HomeDtoModel *)dtoModel {
    _dtoModel = dtoModel;
    NSArray *liveChannels = dtoModel.liveChannels;
    
    [self addSubview:self.pageFlowView];
    [self addSubview:self.classfiyView];
    
    CGFloat classfiyViewHeight = 0.01;
    [self.classfiyView removeAllSubViews];

    if (dtoModel.hotSorts.count > 0) {
        UIView *hotBgV = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 0.01)];
        [self.classfiyView addSubview:hotBgV];
        CGFloat scale = 100/60.0;
        CGFloat magin = 5;
        CGFloat width = (kScreenWidth-10-magin*2)/3.0;
        CGFloat height = width/scale;
        NSArray *sortArr = dtoModel.hotSorts;
        NSInteger num = (sortArr.count-1)/3+1;
        classfiyViewHeight = 10+(height+5)*num;
        for (int i = 0; i < sortArr.count; i++) {
            NSInteger row = i/3;
            NSInteger col = i%3;
            AppHotSortModel *sortModel = sortArr[i];
            UIButton *btn = [[UIButton alloc]initWithFrame:CGRectMake(5+(width+magin)*col, 10+(height+5)*row, width, height)];
            btn.layer.cornerRadius = 8;
            btn.clipsToBounds = YES;
            [btn sd_setBackgroundImageWithURL:[NSURL URLWithString:sortModel.image] forState:UIControlStateNormal placeholderImage:PlaholderImage];
            btn.tag = i;
            [btn addTarget:self action:@selector(hotSortBtnClick:) forControlEvents:UIControlEventTouchUpInside];
            btn.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
            btn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
            [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            btn.titleLabel.lineBreakMode = 0;
            btn.titleEdgeInsets = UIEdgeInsetsMake(0, width-28, 0, 8);
            btn.titleLabel.font = [UIFont boldSystemFontOfSize:16];
            [btn setTitle:sortModel.name forState:UIControlStateNormal];
            [hotBgV addSubview:btn];
        }
        hotBgV.height = classfiyViewHeight;
    }

    ///直播频道
    if (liveChannels.count > 0) {
        ///分类View
        CGFloat fontSize = 15;
        NSMutableArray *titles = [[NSMutableArray alloc] initWithCapacity:1];
        for (AppLiveChannelModel *model in liveChannels) {
            [titles addObject:model.title];
        }

        JXCategoryTitleView *titleV = [[JXCategoryTitleView alloc] initWithFrame:CGRectMake(0, classfiyViewHeight, kScreenWidth, 50)];
        titleV.delegate = self;
        titleV.titleColorGradientEnabled = YES;
        titleV.averageCellSpacingEnabled = NO;
        titleV.titles = titles;
        titleV.cellWidthIncrement = 15;
        titleV.contentEdgeInsetLeft = titleV.contentEdgeInsetRight = 12;
        titleV.backgroundColor = [UIColor clearColor];
        titleV.titleFont = [UIFont systemFontOfSize:kTitleViewTitleFont];
        titleV.titleSelectedFont = [UIFont systemFontOfSize:kTitleViewTitleSelectedFont];
        titleV.cellSpacing = 10;
        titleV.titleFont = [UIFont systemFontOfSize:fontSize];
        titleV.titleSelectedFont = [UIFont systemFontOfSize:fontSize];
        titleV.titleColor = kRGB_COLOR(@"#AAAAAA");
        titleV.titleSelectedColor = kRGB_COLOR(@"#DC92F5");
        [titleV setDefaultSelectedIndex:self.chennelIndex];
        [self.classfiyView addSubview:titleV];
        
        JXCategoryIndicatorBackgroundView *backgroundView = [[JXCategoryIndicatorBackgroundView alloc] init];
        backgroundView.indicatorHeight = titleV.height-20;
//        backgroundView.indicatorWidthIncrement = 20;
        backgroundView.indicatorColor = kRGB_COLOR(@"#F9E9FF");
        backgroundView.indicatorCornerRadius = JXCategoryViewAutomaticDimension;
        titleV.indicators = @[backgroundView];

        if (self.chennelIndex == 0) {
            [self selectChennelIndex:self.chennelIndex];
        }
        
        ///滑动条
        ScrollviewGuideBar *guideBar = [[ScrollviewGuideBar alloc]initWithFrame:CGRectMake(0, titleV.maxY+2, 30, 3) barColor:kRGB_COLOR(@"#AAAAAA") backColor:kRGB_COLOR(@"#EEEEEE")];
        [self.classfiyView addSubview:guideBar];
        guideBar.centerX = titleV.centerX;
        guideBar.relationScrollV = titleV.collectionView;
        
        classfiyViewHeight = guideBar.maxY+5;
    }
    
    self.classfiyView.frame = CGRectMake(0, self.pageFlowView.maxY, kScreenWidth, classfiyViewHeight);
    
    [self reloadViewHeight];
    
    [self loadAdData];
}

- (void)adItemBtnClick:(UIButton *)btn{
    NSInteger selectIndex = btn.tag-99693;
    if (self.adItemList.count > selectIndex) {
        LiveHomeAdsVOModel *ads = self.adItemList[selectIndex];
        if (self.delegate && [self.delegate respondsToSelector:@selector(clickAdvertising:)]) {
            [self.delegate clickAdvertising:ads.adsUrl];
        }
    }
}


///选择某一个频道
- (void)selectChennelIndex:(NSInteger)index{
    self.chennelIndex = index;
    NSArray *liveChannels = _dtoModel.liveChannels;
    if (liveChannels.count > index) {
        AppLiveChannelModel *model = liveChannels[index];
        if (self.delegate && [self.delegate respondsToSelector:@selector(LiveMainHeaderSelectType:)]) {
            [self.delegate LiveMainHeaderSelectType:model.id_field];
        }
    }
}

- (void)reloadViewHeight{
    CGFloat viewMaxY = 0;
    if (self.sliderArray.count > 0) {
        viewMaxY = self.pageFlowView.maxY;
    }
    if (self.adbannerStr.length > 0) {
        _labBannerV.y = viewMaxY+3;
        viewMaxY = _labBannerV.maxY;
    }
    if (self.adItemList.count > 0) {
        _adListBgView.y = viewMaxY;
        viewMaxY = _adListBgView.maxY;
    }
    self.classfiyView.y = viewMaxY;
    viewMaxY = self.classfiyView.maxY;
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(changeHeaderViewHeight:)]) {
        [self.delegate changeHeaderViewHeight:viewMaxY];
    }
}

- (void)hotSortBtnClick:(UIButton *)btn{
    AppHotSortModel *model = self.dtoModel.hotSorts[btn.tag];
    if (self.delegate && [self.delegate respondsToSelector:@selector(hotSortSelectedIndex:hotSortModel:)]) {
        [self.delegate hotSortSelectedIndex:btn.tag hotSortModel:model];
    }
}


#pragma mark - JXCategoryViewDelegate
- (void)categoryView:(JXCategoryBaseView *)categoryView didClickSelectedItemAtIndex:(NSInteger)index{
    [self selectChennelIndex:index];
}

#pragma mark NewPagedFlowView Delegate
- (CGSize)sizeForPageInFlowView:(NewPagedFlowView *)flowView {
    return CGSizeMake(kScreenWidth-10, [[ProjConfig shareInstence].baseConfig adHomeBannerHeightScaleToWidth:kScreenWidth-10]);
}

- (void)didSelectCell:(UIView *)subView withSubViewIndex:(NSInteger)subIndex {
    if (subIndex >= 0 && self.sliderArray.count > 0){
        AppAdsModel *ads = self.sliderArray[subIndex];
        if (self.delegate && [self.delegate respondsToSelector:@selector(clickAdvertising:)]) {
            [self.delegate clickAdvertising:ads.url];
        }
    }
}

#pragma mark NewPagedFlowView Datasource
- (NSInteger)numberOfPagesInFlowView:(NewPagedFlowView *)flowView {
    return self.sliderArray.count;
}

- (PGIndexBannerSubiew *)flowView:(NewPagedFlowView *)flowView cellForPageAtIndex:(NSInteger)index{
    PGIndexBannerSubiew *bannerView = [flowView dequeueReusableCell];
    if (!bannerView) {
        bannerView = [[PGIndexBannerSubiew alloc] init];
        bannerView.tag = index;
    }
    AppAdsModel *ads = self.sliderArray[index];
    [bannerView.mainImageView sd_setImageWithURL:[NSURL URLWithString:ads.thumb] placeholderImage:PlaholderImage];
    bannerView.mainImageView.contentMode = UIViewContentModeScaleAspectFill;
    bannerView.mainImageView.clipsToBounds = YES;
    return bannerView;
}


- (NewPagedFlowView *)pageFlowView{
    if (!_pageFlowView) {
        _pageFlowView= [[NewPagedFlowView alloc] initWithFrame:CGRectMake(5, 0, kScreenWidth-10, 0.1)];
        _pageFlowView.delegate = self;
        _pageFlowView.dataSource = self;
        _pageFlowView.isFillet = NO;
        _pageFlowView.leftRightMargin = 0;
        _pageFlowView.topBottomMargin = 0;
        _pageFlowView.minimumPageAlpha = 0.1;
        _pageFlowView.isCarousel = YES;
        _pageFlowView.orientation = NewPagedFlowViewOrientationHorizontal;
        _pageFlowView.isOpenAutoScroll = YES;
        _pageFlowView.layer.masksToBounds = YES;
        _pageFlowView.layer.cornerRadius = 5.0;
        _pageFlowView.autoTime = 5;
        [self addSubview:_pageFlowView];
        _pageFlowView.hidden = YES;
        UIPageControl *pageControl = [[UIPageControl alloc] init];
        _pageFlowView.pageControl = pageControl;
        [_pageFlowView addSubview:pageControl];
        _pageFlowView.backgroundColor = [UIColor clearColor];
        [pageControl mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.equalTo(_pageFlowView).mas_offset(-5);
            make.centerX.equalTo(_pageFlowView);
        }];
    }
    return _pageFlowView;
}

- (UIView *)classfiyView{
    if (!_classfiyView) {
        _classfiyView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 0.1)];
    }
    return _classfiyView;
}

- (LiveMainTextAdBanner *)labBannerV{
    if (!_labBannerV) {
        LiveMainTextAdBanner *adBanner = [[LiveMainTextAdBanner alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 0.1)];
        [self addSubview:adBanner];
        _labBannerV = adBanner;
    }
    return _labBannerV;
}

- (UIView *)adListBgView{
    if (!_adListBgView) {
        UIView *adListBgView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 0.1)];
        [self addSubview:adListBgView];
        _adListBgView = adListBgView;
    }
    return _adListBgView;
}

@end
