//
//  TotalRankMainVc.m
//  Ranking
//
//  Created by ssssssss on 2020/12/24.
//  Copyright © 2020 KLC. All rights reserved.
//

#import "TotalRankMainVc.h"
#import "TotalIncomeRankTable.h"
#import "TotalConsortiaRankTable.h"
#import "TotalContributeRankTable.h"
#import "TotalFamilyRankTable.h"

#import "JXCategoryView.h"
#import <JXCategoryView/JXCategoryTitleView.h>
#import <JXCategoryView/JXCategoryListContainerView.h>
#import <JXCategoryView/JXCategoryIndicatorLineView.h>

#import <LibTools/LibTools.h>
#import <LibProjBase/LibProjBase.h>

@interface TotalRankMainVc ()<JXCategoryViewDelegate, JXCategoryListContainerViewDelegate,JXCategoryTitleViewDataSource>
@property (nonatomic, strong) JXCategoryTitleView *titleView;
@property (nonatomic, copy) NSArray *titles;
@end

@implementation TotalRankMainVc

- (void)dealloc
{
}

#pragma mark - lazy
- (NSArray *)titles{
    if (!_titles) {
        _titles = [[ProjConfig shareInstence].businessConfig getRankClassfiyArray];
    }
    return _titles;
}
#pragma mark -  初始化
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
}
- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationController.navigationBarHidden = NO;
    self.navigationController.navigationBar.translucent = YES;
    [self createCategoryTitleView];
}

 
- (void)createCategoryTitleView{
    JXCategoryIndicatorLineView *lineView = [[JXCategoryIndicatorLineView alloc] init];
    lineView.indicatorColor = [UIColor whiteColor];
    lineView.indicatorWidth = 10.0;
    
    int defaultSelectIndex = 0;
    NSMutableArray *muArr = [[NSMutableArray alloc] init];
    for (int i = 0; i<self.titles.count; i++) {
        NSDictionary *subDic = self.titles[i];
        if ([subDic[@"type"] intValue] == self.selectType) {
            defaultSelectIndex = i;
        }
        [muArr addObject:subDic[@"title"]];
    }
    
    JXCategoryTitleView *titleView = [[JXCategoryTitleView alloc] initWithFrame:CGRectMake((kScreenWidth-250)/2.0, 0, 250, kNavBarHeight-kStatusBarHeight)];
    titleView.delegate = self;
    titleView.titles = muArr;
    titleView.backgroundColor = [UIColor clearColor];
    titleView.averageCellSpacingEnabled = YES;
    titleView.indicators = @[lineView];
    titleView.titleFont = [UIFont systemFontOfSize:15];
    titleView.titleSelectedFont = [UIFont systemFontOfSize:20];
    titleView.titleColor = [UIColor whiteColor];
    titleView.titleSelectedColor = [UIColor whiteColor];
    _titleView = titleView;
     
    JXCategoryListContainerView *listContainerView = [[JXCategoryListContainerView alloc] initWithType:JXCategoryListContainerType_ScrollView delegate:self];
    listContainerView.frame = CGRectMake(0, 0, kScreenWidth, kScreenHeight);
    [self.view addSubview:listContainerView];
    //关联到categoryView
    titleView.listContainer = listContainerView;
    [self.navigationController.navigationBar addSubview:self.titleView];
    
    [titleView setDefaultSelectedIndex:defaultSelectIndex];
}

#pragma mark - delegate
- (void)categoryView:(JXCategoryBaseView *)categoryView didSelectedItemAtIndex:(NSInteger)index{
    self.view.layer.contents = (id)[UIImage imageNamed:(index ==1)?@"rank-user-shouyibang-bg":@"rank-user-gongxianbang-bg"].CGImage;
}

- (NSInteger)numberOfListsInlistContainerView:(JXCategoryListContainerView *)listContainerView{
    return self.titles.count;
}

- (id<JXCategoryListContentViewDelegate>)listContainerView:(JXCategoryListContainerView *)listContainerView initListForIndex:(NSInteger)index{
    
    NSDictionary *subDic = self.titles[index];
    int type = [subDic[@"type"] intValue];
    switch ([subDic[@"type"] intValue]) {
        case 1://收益
        {
            TotalIncomeRankTable *list = [[TotalIncomeRankTable alloc] init];
            if (self.selectType == type) {
                list.selectIndex = self.subSelectIndex;
            }
            return list;
        }
            break;
        case 2://贡献
        {
            TotalContributeRankTable *list = [[TotalContributeRankTable alloc] init];
            if (self.selectType == type) {
                list.selectIndex = self.subSelectIndex;
            }
            return list;
        }
            break;
        case 3://公会
        {
            TotalConsortiaRankTable *list = [[TotalConsortiaRankTable alloc] init];
            if (self.selectType == type) {
                list.selectIndex = self.subSelectIndex;
            }
            return list;
        }
            break;
        case 4://家族
        {
            TotalFamilyRankTable *list = [[TotalFamilyRankTable alloc] init];
            if (self.selectType == type) {
                list.selectIndex = self.subSelectIndex;
            }
            return list;
        }
            break;
        default:
        {
            TotalIncomeRankTable *list = [[TotalIncomeRankTable alloc] init];
            return list;
        }
            break;
    }
}


- (UIBarButtonItem *)rt_customBackItemWithTarget:(id)target action:(SEL)action{
    [BaseNavBarItem navBarBgClear:self foregroundColor:[UIColor whiteColor]];
    return [[UIBarButtonItem alloc] initWithCustomView:[BaseNavBarItem navBackBtnImage:[UIImage imageNamed:@"main_navbar_back"] target:target action:action]];
}


@end
