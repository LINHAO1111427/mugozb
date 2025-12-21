//
//  FamilyInternalRankVc.m
//  Ranking
//
//  Created by ssssssss on 2020/12/24.
//  Copyright © 2020 KLC. All rights reserved.
//

#import "FamilyInternalRankVc.h"
#import "FamilyContributeRankVC.h"
#import "FamilyIncomeRankVC.h"

#import "JXCategoryView.h"
#import <JXCategoryView/JXCategoryTitleView.h>
#import <JXCategoryView/JXCategoryListContainerView.h>
#import <JXCategoryView/JXCategoryIndicatorLineView.h>

#import <LibTools/LibTools.h>
#import <LibProjBase/LibProjBase.h>

@interface FamilyInternalRankVc ()<JXCategoryViewDelegate, JXCategoryListContainerViewDelegate,JXCategoryTitleViewDataSource>

@property (nonatomic, strong) JXCategoryTitleView *titleView;
@property (nonatomic, copy) NSArray *titles;

@end

@implementation FamilyInternalRankVc

- (void)dealloc
{
    
}

#pragma mark - lazy
- (NSArray *)titles{
    if (!_titles) {
        _titles = @[@{@"type":@"2",@"title":kLocalizationMsg(@"贡献榜")},
                    @{@"type":@"1",@"title":kLocalizationMsg(@"收益榜")},];
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
    
    NSMutableArray *muArr = [[NSMutableArray alloc] init];
    for (NSDictionary *subDic in self.titles) {
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
    switch ([subDic[@"type"] intValue]) {
        case 1://收益
        {
            FamilyIncomeRankVC *list = [[FamilyIncomeRankVC alloc] init];
            list.familyId = self.familyId;
            return list;
        }
            break;
        case 2://贡献
        {
            FamilyContributeRankVC *list = [[FamilyContributeRankVC alloc] init];
            list.familyId = self.familyId;
            return list;
        }
            break;
        default:
        {
            return nil;
        }
            break;
    }
}


- (UIBarButtonItem *)rt_customBackItemWithTarget:(id)target action:(SEL)action{
    [BaseNavBarItem navBarBgClear:self foregroundColor:[UIColor whiteColor]];
    return [[UIBarButtonItem alloc] initWithCustomView:[BaseNavBarItem navBackBtnImage:[UIImage imageNamed:@"main_navbar_back"] target:target action:action]];
}


@end
