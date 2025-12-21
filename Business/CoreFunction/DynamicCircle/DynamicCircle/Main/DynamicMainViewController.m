//
//  DynamicMainViewController.m
//  DynamicCircle
//
//  Created by KLC on 2020/7/1.
//  Copyright © 2020 . All rights reserved.
//

#import "DynamicMainViewController.h"
 
#import <MJRefresh/MJRefresh.h>

#import <LibProjModel/KLCAppConfig.h>
#import <LibProjModel/APPConfigModel.h>
#import <LibProjModel/KLCUserInfo.h>
#import <LibProjModel/AdminLiveConfigModel.h>

#import <LibProjBase/LibProjBase.h>
#import <LibProjBase/BaseNavBarItem.h>
#import <LibProjView/FunctionSelectManager.h>
#import <LibProjView/DynamicClassfiyListVC.h>
#import "DynamicMainHeaderView.h"
#import <LibProjView/PublicMethodObj.h>

@interface DynamicMainViewController ()<JXCategoryViewDelegate,JXCategoryTitleViewDataSource,JXPagerViewDelegate,DynamicMainHeaderViewDelegate>

@property (nonatomic, weak) JXCategoryTitleView *titleView;
@property (nonatomic, strong) JXPagerView *pagingView;
@property (nonatomic, strong) DynamicMainHeaderView *dynamicHeader;
@property (nonatomic, assign) BOOL isPush;
@property(nonatomic, copy)NSArray * dynamicClassfiyArr;//动态分类类型

@end

@implementation DynamicMainViewController

- (UIBarButtonItem *)rt_customBackItemWithTarget:(id)target action:(SEL)action{
    return [[UIBarButtonItem alloc] init];
}

- (DynamicMainHeaderView *)dynamicHeader{
    if (!_dynamicHeader) {
        _dynamicHeader = [[DynamicMainHeaderView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 0.01)];
        _dynamicHeader.delegate = self;
    }
    return _dynamicHeader;
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    if (!self.isPush) {
        self.isPush = NO;
        [self loadData:YES];
    }
}


- (NSArray *)dynamicClassfiyArr{
    return [[ProjConfig shareInstence].businessConfig getDynamicClassfiyTypeArray];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIButton *btn = [UIButton buttonWithType:0];
    [btn setTitle:kLocalizationMsg(@"动态") forState:UIControlStateNormal];
    [btn setTitleColor:kRGBA_COLOR(@"#333333", 1.0) forState:UIControlStateNormal];
    btn.titleLabel.font = [UIFont systemFontOfSize:20 weight:UIFontWeightSemibold];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:btn];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:[BaseNavBarItem navItemImageName:@"icon_nav_dynamic_publish" clickHandle:^{
        [self publishBtnClick];
    }]];
    [self addCategoryView];
}

#pragma mark - notifications

-(void)updateNotify:(NSNotification *)sender{
    [self loadData:YES];
}

- (void)publishBtnClick{
    NSArray *items = @[
        [[MainFunctionModel alloc] initWithType:MainFunctionForDynamicVideo title:kLocalizationMsg(@"小视频") icon:nil],
        [[MainFunctionModel alloc] initWithType:MainFunctionForDynamicPic title:kLocalizationMsg(@"照片") icon:nil]
    ];
    [FunctionSelectManager showFunction:items];
}

- (void)loadData:(BOOL)isRefresh{
    if (isRefresh) {
        [self.dynamicHeader loadShowData];
    }
}

- (void)addCategoryView{

    NSMutableArray *titles = [[NSMutableArray alloc] init];
    for (int i = 0; i < self.dynamicClassfiyArr.count; i++) {
        NSDictionary *dic = self.dynamicClassfiyArr[i];
        NSString *title =dic[@"title"];
        [titles addObject:title];
    }
    ///默认选第几个
    NSInteger selectedIndex = 0;
    //标题
    JXCategoryTitleView *titleView = [[JXCategoryTitleView alloc] initWithFrame:CGRectMake(0, self.dynamicHeader.maxY, 250, kNavBarHeight-kStatusBarHeight-10)];
    titleView.delegate = self;
    titleView.titles = titles;
    titleView.backgroundColor = [UIColor clearColor];
    titleView.titleFont = [UIFont systemFontOfSize:18];
    titleView.titleSelectedFont = [UIFont systemFontOfSize:18 weight:UIFontWeightMedium];
    titleView.titleColor = [[UIColor blackColor] colorWithAlphaComponent:0.6];
    titleView.averageCellSpacingEnabled = NO;
    titleView.contentEdgeInsetLeft = titleView.contentEdgeInsetRight = 10;
    titleView.cellSpacing = 15;
    titleView.titleSelectedColor = [UIColor blackColor];
    [self.view addSubview:self.titleView];
    _titleView = titleView;
    self.navigationItem.titleView = titleView;

    [self.titleView setDefaultSelectedIndex:selectedIndex];
    self.titleView.listContainer.contentScrollView.scrollEnabled  = YES;
    
    self.pagingView = [[JXPagerView alloc] initWithDelegate:self];
    self.pagingView.frame = CGRectMake(0, 0, kScreenWidth,kScreenHeight-kNavBarHeight-kTabBarHeight);
    self.pagingView.listContainerView.backgroundColor = [UIColor whiteColor];
    self.pagingView.defaultSelectedIndex = selectedIndex;
    [self.view addSubview:self.pagingView];
    kWeakSelf(self);
    self.pagingView.mainTableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [weakself loadData:YES];
    }];
    self.titleView.listContainer = (id<JXCategoryViewListContainer>)self.pagingView.listContainerView;
    [self.titleView reloadData];
         
}

#pragma mark - JXPagerViewDelegate
- (UIView *)tableHeaderViewInPagerView:(JXPagerView *)pagerView {
    return self.dynamicHeader;
}

- (NSUInteger)tableHeaderViewHeightInPagerView:(JXPagerView *)pagerView {
    return _dynamicHeader.height;
}

- (NSUInteger)heightForPinSectionHeaderInPagerView:(JXPagerView *)pagerView {
    return 50;
}

- (UIView *)viewForPinSectionHeaderInPagerView:(JXPagerView *)pagerView {
    return self.titleView;
}

- (NSInteger)numberOfListsInPagerView:(JXPagerView *)pagerView {
    return self.dynamicClassfiyArr.count;
}

- (id<JXPagerViewListViewDelegate>)pagerView:(JXPagerView *)pagerView initListAtIndex:(NSInteger)index {
    NSDictionary *dict = self.dynamicClassfiyArr[index];
    NSDictionary *validListDict = pagerView.validListDict;
    id validVC = validListDict[@(index)];
    if (!validVC) {
        kWeakSelf(self);
        DynamicClassfiyListVC *listVC = [[DynamicClassfiyListVC alloc] init];
        listVC.type = [dict[@"type"] intValue];
        [self addChildViewController:listVC];
        listVC.pushNextPageBlock = ^{
            weakself.isPush = YES;
        };
        return listVC;
    }
    return validVC;
}

#pragma mark - JXCategoryViewDelegate

- (void)categoryView:(JXCategoryBaseView *)categoryView didSelectedItemAtIndex:(NSInteger)index {
    self.navigationController.interactivePopGestureRecognizer.enabled = (index == 0);
//    _pagingView.listContainerView.scrollView.scrollEnabled = (index != 0);
}


#pragma mark - DynamicMainHeaderViewDelegate

- (void)dynamicMainHeaderView:(DynamicMainHeaderView *)headerView changeHeaderHeight:(CGFloat)height{
    [self.pagingView.mainTableView.mj_header endRefreshing];
    self.dynamicHeader.height = height;
    self.titleView.y = self.dynamicHeader.height;
    [self.pagingView reloadData];
}

//话题
- (void)dynamicMainHeaderView:(DynamicMainHeaderView *)headerView topicClick:(AppVideoTopicModel *)model selectedIndex:(NSInteger)index{
    self.isPush = YES;
    [RouteManager routeForName:RN_dynamic_topic currentC:self parameters:@{@"topicName":model.name, @"topicId":@(model.id_field)}];
}

//banner
- (void)dynamicMainHeaderView:(DynamicMainHeaderView *)headerView sliderClick:(AppAdsModel *)model selectedIndex:(NSInteger)index{
    if (model.url.length != 0 && model.url != nil && model.url != NULL ) {
        self.isPush = YES;
        [PublicMethodObj showUrl:model.url];
    }
}


#pragma mark - JXCategoryListContentViewDelegate
- (UIView *)listView{
    return self.view;
}


@end
