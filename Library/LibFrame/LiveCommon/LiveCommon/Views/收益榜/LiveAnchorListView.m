//
//  LiveAnchorListView.m
//  LiveCommon
//
//  Created by klc_sl on 2020/3/21.
//  Copyright © 2020 . All rights reserved.
//

#import "LiveAnchorListView.h"
#import <LibTools/LibTools.h>
#import <LibProjBase/LibProjBase.h>
#import <LibProjView/FunctionSheetBaseView.h>
#import <JXCategoryView/JXCategoryTitleView.h>
#import <JXCategoryView/JXCategoryIndicatorLineView.h>

#import "LiveEarningsList.h"

@interface LiveAnchorListView ()<JXCategoryViewDelegate>

@end

@implementation LiveAnchorListView

+ (void)showAnchorListView{
    LiveAnchorListView *view = [[LiveAnchorListView alloc] init];
    [view createUI];
    [FunctionSheetBaseView showView:view cover:NO];
}


- (void)createUI{
     ///指示线
    JXCategoryIndicatorLineView *lineView = [[JXCategoryIndicatorLineView alloc] init];
    lineView.indicatorColor = [ProjConfig normalColors];
    lineView.lineStyle = JXCategoryIndicatorLineStyle_Normal;
    lineView.indicatorWidth = 30.0;

    JXCategoryTitleView *titleView = [[JXCategoryTitleView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 50)];
    titleView.delegate = self;
    titleView.titles = @[kLocalizationMsg(@"今日收益榜"),kLocalizationMsg(@"累计收益榜")];
    titleView.averageCellSpacingEnabled = YES;
    titleView.indicators = @[lineView];
    titleView.backgroundColor = [UIColor clearColor];
    titleView.titleFont = [UIFont systemFontOfSize:13];
    titleView.titleColor = [UIColor grayColor];
    titleView.titleSelectedColor = [UIColor blackColor];
    [self addSubview:titleView];
    
    ///内部视图
    UIScrollView *contentScroll = [[UIScrollView alloc] initWithFrame:CGRectMake(0, titleView.maxY, kScreenWidth, 400)];
    contentScroll.contentSize = CGSizeMake(kScreenWidth*2.0, 0);
    contentScroll.pagingEnabled = YES;
    contentScroll.scrollEnabled = NO;
    contentScroll.bounces = NO;
    [self addSubview:contentScroll];
    
    
    UIImageView *imgV = [[UIImageView alloc] initWithFrame:lineView.bounds];
    imgV.image = [UIImage imageNamed:@"Indicator_line_bottom"];
    [lineView addSubview:imgV];
    titleView.contentScrollView = contentScroll;

    
    self.frame = CGRectMake(0, 0, kScreenWidth, contentScroll.maxY);
 
    LiveEarningsList *todayEarnings = [[LiveEarningsList alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, contentScroll.height) earningType:1];
    [contentScroll addSubview:todayEarnings];
    
    LiveEarningsList *totalEarnings = [[LiveEarningsList alloc] initWithFrame:CGRectMake(kScreenWidth, 0, kScreenWidth, contentScroll.height) earningType:0];
    [contentScroll addSubview:totalEarnings];
}


@end
