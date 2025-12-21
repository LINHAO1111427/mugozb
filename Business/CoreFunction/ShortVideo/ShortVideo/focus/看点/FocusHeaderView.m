//
//  FocusHeaderView.m
//  ShortVideo
//
//  Created by KLC on 2020/6/16.
//  Copyright © 2020 KLC. All rights reserved.
//

#import "FocusHeaderView.h"
#import <LibProjView/NewPagedFlowView.h>
#import <LibProjView/PGIndexBannerSubiew.h>
#import <LibTools/LibTools.h>
#import <SDWebImage/SDWebImage.h>
#import <LibProjModel/HttpApiShortVideoAdsController.h>
#import "FocusTextAdBanner.h"

@interface FocusHeaderView()<
NewPagedFlowViewDelegate,
NewPagedFlowViewDataSource,
UIScrollViewDelegate
>

///轮播
@property(nonatomic,weak)NewPagedFlowView *pageFlowView;
///本周必看
@property(nonatomic,strong)UIView *weekMustLoookView;
///最多系列
@property(nonatomic,strong)UIView *mostView;
///文字广告
@property (nonatomic,weak)FocusTextAdBanner *labBannerV;
///广告背景
@property(nonatomic,weak)UIView *adListBgView;

@property (nonatomic, copy)NSArray *adItemList;

@property (nonatomic, copy)NSString *adbannerStr;



@end

@implementation FocusHeaderView

- (UIView *)weekMustLoookView{
    if (!_weekMustLoookView) {
        UIView *weekMustLoookView = [[UIView alloc]initWithFrame:CGRectMake(12, 0, kScreenWidth-24, 0.1)];
        weekMustLoookView.backgroundColor = [UIColor whiteColor];
        [self addSubview:weekMustLoookView];
        self.weekMustLoookView = weekMustLoookView;
    }
    return _weekMustLoookView;
}

- (NewPagedFlowView *)pageFlowView{
    if (!_pageFlowView) {
        NewPagedFlowView *pageFlowView = [[NewPagedFlowView alloc] initWithFrame:CGRectMake(5, 5, kScreenWidth-10, 0.1)];
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
        [self addSubview:pageFlowView];
        self.pageFlowView = pageFlowView;
        CGFloat y = pageFlowView.height-18;
        UIPageControl *pageControl = [[UIPageControl alloc] initWithFrame:CGRectMake(12, y, kScreenWidth-24, 8)];
        pageFlowView.pageControl = pageControl;
        [pageFlowView addSubview:pageControl];
        pageFlowView.backgroundColor = [UIColor clearColor];
    }
    return _pageFlowView;
}

- (FocusTextAdBanner *)labBannerV{
    if (!_labBannerV) {
        FocusTextAdBanner *adBanner = [[FocusTextAdBanner alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 0.1)];
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


- (void)reloadAdData{
    [self getAdBannerStr];
    [self getAdItemList];
}


- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self){
        self.backgroundColor = [UIColor whiteColor];
        [self getAdBannerStr];
        [self getAdItemList];
    }
    return self;
}
- (void)layoutSubviews{
    [super layoutSubviews];
}

- (void)getAdItemList{
    kWeakSelf(self);
    [HttpApiShortVideoAdsController getShortVideoWatchAdsVO:1 callback:^(int code, NSString *strMsg, NSArray<ShortVideoWatchAdsModel *> *arr) {
        weakself.adItemList = arr;
    }];
}

- (void)getAdBannerStr{
    kWeakSelf(self);
    [HttpApiShortVideoAdsController getShortVideoWatchAdsVO:2 callback:^(int code, NSString *strMsg, NSArray<ShortVideoWatchAdsModel *> *arr) {
        NSString *adBannerStr = @"";
        if (code == 1 && arr.count > 0) {
            ShortVideoWatchAdsModel *AdModel = arr.firstObject;
            adBannerStr = AdModel.adsDescription;
        }
        [weakself setAdbannerStr:adBannerStr];
    }];
}


- (void)setFuncArr:(NSArray *)funcArr{
    _funcArr = funcArr;
    if (!_mostView) {
        UIView *mostView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 144)];
        mostView.backgroundColor = [UIColor whiteColor];
        self.mostView = mostView;
        [self addSubview:self.mostView];
        
        NSArray *arr = funcArr;
        
        CGFloat width = 64;
        CGFloat margin = (kScreenWidth - 64*arr.count)/(arr.count*2.0);
        
        for (int i = 0; i < arr.count; i++) {
            NSDictionary *dic = arr[i];
            NSString *imageName = dic[@"image"];
            NSString *title = dic[@"title"];
            
            UIButton *btn = [[UIButton alloc]initWithFrame:CGRectMake(margin+(width+margin*2)*i, 20, width, width)];
            [btn setImage:[UIImage imageNamed:imageName] forState:UIControlStateNormal];
            [btn setTitle:title forState:UIControlStateNormal];
            [btn setTitleColor:kRGB_COLOR(@"#333333") forState:UIControlStateNormal];
            btn.titleLabel.font = [UIFont systemFontOfSize:14];
            btn.tag = i;
            [btn addTarget:self action:@selector(mostBtnClick:) forControlEvents:UIControlEventTouchUpInside];
            btn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
            [btn setTitleEdgeInsets:UIEdgeInsetsMake(btn.imageView.frame.size.height+5,-btn.imageView.frame.size.width, 0.0,0.0)];
            [btn setImageEdgeInsets:UIEdgeInsetsMake(-btn.titleLabel.bounds.size.height,(btn.frame.size.width-btn.imageView.bounds.size.width)/2.0,5,(btn.frame.size.width-btn.imageView.bounds.size.width)/2.0)];
            [self.mostView addSubview:btn];
        }
        
        UIView *line = [[UIView alloc]initWithFrame:CGRectMake(0, width+40, kScreenWidth, 0.4) ];
        line.backgroundColor = kRGB_COLOR(@"#DEDEDE");
        [self.mostView addSubview:line];
        
        UILabel *titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(12, line.maxY, kScreenWidth-24, 39)];
        titleLabel.text = kLocalizationMsg(@"热门分类");
        titleLabel.textAlignment = NSTextAlignmentLeft;
        titleLabel.font = [UIFont boldSystemFontOfSize:15];
        titleLabel.textColor = kRGB_COLOR(@"#333333");
        [self.mostView addSubview:titleLabel];
        [self setNeedsLayout];
        
        [self setViewFrame];
    }
}

- (void)setAdbannerStr:(NSString *)adbannerStr{
    _adbannerStr = adbannerStr;
    if (adbannerStr.length > 0) {
        self.labBannerV.height = 30;
        [self.labBannerV showAdText:adbannerStr];
    }else{
        [_labBannerV removeFromSuperview];
        _labBannerV = nil;
        
    }
    [self setViewFrame];
}


- (void)adBannerisScroll:(BOOL)scroll{
    [_labBannerV adBannerisScroll:scroll];
    scroll?[_pageFlowView startTimer]:[_pageFlowView stopTimer];
}

- (void)setAdItemList:(NSArray<ShortVideoWatchAdsModel *> *)adItemList{
    _adItemList = adItemList;
    
    [self.adListBgView removeAllSubViews];
    
    if (adItemList.count > 0) {
        
        int lineCount = 4;
        CGFloat maxHeight = 20;
        CGFloat width = 64;
        CGFloat margin = (kScreenWidth - 64*lineCount)/(lineCount*2.0);
        
        for (int i = 0; i < adItemList.count; i++) {
            
            ShortVideoWatchAdsModel *adModel = adItemList[i];
            
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
    [self setViewFrame];
}


- (void)setWeekList:(NSArray *)weekList {
    _weekList = weekList;
    self.weekMustLoookView.y = self.pageFlowView.maxY;
    [self.weekMustLoookView removeAllSubViews];
    CGFloat width = kScreenWidth/4.0;
    CGFloat height = width*120/90.0;
    if (weekList.count == 0) {
        self.weekMustLoookView.height = 0;
        return;
    }else{
        self.weekMustLoookView.height = height+40;
    }
    
    UILabel *titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth-24, 40)];
    titleLabel.text = kLocalizationMsg(@"本周必看");
    titleLabel.textAlignment = NSTextAlignmentLeft;
    titleLabel.font = [UIFont boldSystemFontOfSize:14];
    titleLabel.textColor = kRGB_COLOR(@"#333333");
    [self.weekMustLoookView addSubview:titleLabel];
    
    
    UIScrollView *scrollV = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 40, kScreenWidth-24, height)];
    scrollV.backgroundColor = [UIColor whiteColor];
    scrollV.showsHorizontalScrollIndicator = NO;
    scrollV.contentSize = CGSizeMake(weekList.count*(width+10), height);
    [self.weekMustLoookView addSubview:scrollV];
    
    for (int i = 0; i < weekList.count; i++) {
        kWeakSelf(self);
        ApiShortVideoDtoModel *model = weekList[i];
        UIImageView *bgImageV = [[UIImageView alloc]initWithFrame:CGRectMake((width+10)*i, 0, width, height)];
        bgImageV.layer.cornerRadius = 5;
        bgImageV.contentMode = UIViewContentModeScaleAspectFill;
        bgImageV.clipsToBounds = YES;
        bgImageV.tag = i;
        bgImageV.userInteractionEnabled = YES;
        [bgImageV sd_setImageWithURL:[NSURL URLWithString:model.thumb] placeholderImage:[UIImage imageWithColor:[UIColor lightGrayColor]]];
        [bgImageV klc_whenTapped:^{
            [weakself weekLookBtnClick:bgImageV.tag];
        }];
        if (model.type == 2 && model.isPrivate && !model.isPay) {
            UIBlurEffect* effect = [UIBlurEffect effectWithStyle:UIBlurEffectStyleLight];
            UIVisualEffectView* effectView = [[UIVisualEffectView alloc] initWithEffect:effect];
            effectView.frame = bgImageV.bounds;
            effectView.userInteractionEnabled = NO;
            [bgImageV addSubview:effectView];
        }
        
        UILabel *lookLabel = [[UILabel alloc]initWithFrame:CGRectMake(5, height-20, width-10, 20)];
        lookLabel.textColor = [UIColor whiteColor];
        lookLabel.textAlignment = NSTextAlignmentLeft;
        lookLabel.font = [UIFont systemFontOfSize:11];
        lookLabel.text = [NSString stringWithFormat:kLocalizationMsg(@"%@观看"),[NSString stringForCompressNum:model.looks]];
        [bgImageV addSubview:lookLabel];
        [scrollV addSubview:bgImageV];
    }
    [self setNeedsLayout];
    
    [self setViewFrame];
}

///设置广告
- (void)setAdList:(NSArray *)adList {
    _adList = adList;
    if (adList.count == 0) {
        [self.pageFlowView stopTimer];
        self.pageFlowView.height = 0;
        self.pageFlowView.hidden = YES;
    }else{
        [self.pageFlowView startTimer];
        self.pageFlowView.height = kScreenWidth/3.0;
        self.pageFlowView.hidden = NO;
    }
    [self.pageFlowView reloadData];
    [self setNeedsLayout];
    
    [self setViewFrame];
}

- (void)weekLookBtnClick:(NSInteger)index{
    if (self.weekList.count > index) {
        ApiShortVideoDtoModel *model = self.weekList[index];
        if (self.delegate && [self.delegate respondsToSelector:@selector(FocusHeaderView:weekMustBtnClick:)]) {
            [self.delegate FocusHeaderView:self weekMustBtnClick:model];
        }
    }
}

- (void)mostBtnClick:(UIButton *)btn{
    if (self.delegate && [self.delegate respondsToSelector:@selector(FocusHeaderView:mostBtnClick:)]) {
        if (self.funcArr.count > btn.tag) {
            NSDictionary *dic = self.funcArr[btn.tag];
            [self.delegate FocusHeaderView:self mostBtnClick:[dic[@"funcId"] intValue]];
        }
    }
}


- (void)adItemBtnClick:(UIButton *)btn{
    NSInteger index = btn.tag-99693;
    if (self.adItemList.count > index) {
        ShortVideoWatchAdsModel *model = self.adItemList[index];
        if (self.delegate && [self.delegate respondsToSelector:@selector(FocusHeaderView:adItemClick:)]) {
            [self.delegate FocusHeaderView:self adItemClick:model.adsUrl];
        }
    }
}

- (void)setViewFrame{
    CGFloat y = 5;
    if (self.adList.count > 0) {
        self.pageFlowView.y = y;
        y = self.pageFlowView.maxY;
    }
    if (self.adbannerStr.length > 0) {
        _labBannerV.y = y;
        y = _labBannerV.maxY;
    }
    self.adListBgView.y = y;
    self.weekMustLoookView.y = self.adListBgView.maxY ;
    self.mostView.y = self.weekMustLoookView.maxY;
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(FocusHeaderView:heightForView:)]) {
        [self.delegate FocusHeaderView:self heightForView:self.mostView.maxY];
    }
}


#pragma mark NewPagedFlowView Delegate
- (CGSize)sizeForPageInFlowView:(NewPagedFlowView *)flowView {
    return flowView.size;
}

- (void)didSelectCell:(UIView *)subView withSubViewIndex:(NSInteger)subIndex {
   // NSLog(@"过滤文字点击了第%ld张图"),(long)subIndex + 1);
    if(subIndex>-1 && self.adList!=nil && self.adList.count>subIndex){
        AppAdsModel *model = self.adList[subIndex];
        if (self.delegate && [self.delegate respondsToSelector:@selector(FocusHeaderView:adItemClick:)]) {
            [self.delegate FocusHeaderView:self adItemClick:model.url];
        }
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
    AppAdsModel *model = self.adList[index];
    [bannerView.mainImageView sd_setImageWithURL:[NSURL URLWithString:model.thumb] placeholderImage:PlaholderImage];
    bannerView.mainImageView.contentMode = UIViewContentModeScaleAspectFill;
    bannerView.layer.masksToBounds = YES;
    bannerView.layer.cornerRadius = 5.0;
    return bannerView;
}

-(void)dealloc{
    [_pageFlowView stopTimer];

    [_labBannerV removeFromSuperview];
    _labBannerV = nil;
}

@end
