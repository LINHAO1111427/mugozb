//
//  LiveUserListView.m
//  LiveCommon
//
//  Created by klc_sl on 2020/3/21.
//  Copyright © 2020 . All rights reserved.
//

#import "LiveUserListView.h"
#import <LibTools/LibTools.h>
#import <LibProjBase/LibProjBase.h>
#import <LibProjView/FunctionSheetBaseView.h>
#import <JXCategoryView/JXCategoryTitleView.h>
#import <JXCategoryView/JXCategoryIndicatorLineView.h>

#import "LiveOnlineUserList.h"
#import "FansContributionList.h"

@interface LiveUserListView ()<JXCategoryViewDelegate>

@end

@implementation LiveUserListView

+ (void)showUserListView{
    LiveUserListView *view = [[LiveUserListView alloc] init];
    [view createUI];
}


- (void)createUI{
     ///指示线
    JXCategoryIndicatorLineView *lineView = [[JXCategoryIndicatorLineView alloc] init];
    lineView.indicatorColor = [ProjConfig normalColors];
    lineView.lineStyle = JXCategoryIndicatorLineStyle_Normal;
    lineView.indicatorWidth = 30.0;

    JXCategoryTitleView *titleView = [[JXCategoryTitleView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 50)];
    titleView.delegate = self;
    titleView.titles = @[kLocalizationMsg(@"本场贡献榜"),kLocalizationMsg(@"在线观众席")];
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
 
    [FunctionSheetBaseView showView:self cover:NO];
    
    
    FansContributionList *fansV = [[FansContributionList alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, contentScroll.height)];
    [contentScroll addSubview:fansV];
    
    
    LiveOnlineUserList *onlineV = [[LiveOnlineUserList alloc] initWithFrame:CGRectMake(kScreenWidth, 0, kScreenWidth, contentScroll.height)];
    [contentScroll addSubview:onlineV];
}


@end
