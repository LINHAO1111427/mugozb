//
//  MyCommodityManageVC.m
//  Shopping
//
//  Created by klc on 2020/7/3.
//  Copyright © 2020 klc. All rights reserved.
//

#import "MyCommodityManageVC.h"
#import "MyCommodityListVC.h"

@interface MyCommodityManageVC ()
<
JXCategoryViewDelegate,
JXCategoryListContainerViewDelegate,
JXCategoryTitleViewDataSource
>
@property (nonatomic, weak) JXCategoryTitleView *titleView;
@property(nonatomic,assign)NSInteger selectedIndex;
@property (nonatomic, strong) NSMutableArray *titles;
@property(nonatomic,strong)NSArray* typeArr;
@end

@implementation MyCommodityManageVC
- (NSArray *)typeArr{
    if (!_typeArr) {
        _typeArr = @[
            @{@"title":kLocalizationMsg(@"全部"),@"status":@"0"},
            @{@"title":kLocalizationMsg(@"已上架"),@"status":@"2"},
            @{@"title":kLocalizationMsg(@"待上架"),@"status":@"1"},
            @{@"title":kLocalizationMsg(@"冻结中"),@"status":@"3"},
        ];
    }
    return _typeArr;
}
- (NSMutableArray *)titles{
    if (!_titles) {
        _titles = [NSMutableArray array];
    }
    return _titles;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title  = kLocalizationMsg(@"商品管理");
    [self addCategoryView];
}

- (void)addCategoryView{
    [self.titleView removeAllSubViews];
    [self.titleView removeFromSuperview];
    [self.titles removeAllObjects];
    self.titleView = nil;
    for (NSDictionary *dic in self.typeArr) {
        [self.titles addObject:dic[@"title"]];
    }
    JXCategoryIndicatorLineView *lineView = [[JXCategoryIndicatorLineView alloc] init];
    lineView.indicatorColor = kRGB_COLOR(@"#FF5500");
    lineView.indicatorWidth = 16.0;
    JXCategoryTitleView *titleView = [[JXCategoryTitleView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kNavBarHeight-kStatusBarHeight)];
    titleView.delegate = self;
    titleView.titleDataSource = self;
    titleView.titles = self.titles;
    titleView.titleLabelAnchorPointStyle = JXCategoryTitleLabelAnchorPointStyleBottom;
    titleView.indicators = @[lineView];
    titleView.backgroundColor = kRGB_COLOR(@"#F4F4F4");
    titleView.titleFont = [UIFont systemFontOfSize:13];
    titleView.titleSelectedFont = [UIFont systemFontOfSize:13];
    titleView.titleColor = kRGB_COLOR(@"#2B2C2C");
    titleView.titleSelectedColor = kRGB_COLOR(@"#FF5500");
    [titleView setDefaultSelectedIndex:0];
    self.titleView = titleView;
    self.selectedIndex = 0;

//    self.titleView.contentEdgeInsetLeft = self.titleView.contentEdgeInsetRight = 15;

    JXCategoryListContainerView *listContainerView = [[JXCategoryListContainerView alloc] initWithType:JXCategoryListContainerType_ScrollView delegate:self];
    listContainerView.frame = CGRectMake(0, kNavBarHeight-kStatusBarHeight, kScreenWidth, kScreenHeight-kNavBarHeight-kNavBarHeight+kStatusBarHeight);
    [self.view addSubview:listContainerView];
    self.titleView.listContainer = listContainerView;
    [self.view addSubview:self.titleView];
}

#pragma mark - JXCategoryViewDelegate
- (void)categoryView:(JXCategoryBaseView *)categoryView didClickSelectedItemAtIndex:(NSInteger)index {
    self.selectedIndex = index;
}
- (void)categoryView:(JXCategoryBaseView *)categoryView didSelectedItemAtIndex:(NSInteger)index {
    //侧滑手势处理
    //    if (_shouldHandleScreenEdgeGesture) {
    self.navigationController.interactivePopGestureRecognizer.enabled = (index == 0);
    //    }
    self.selectedIndex = index;
}

- (void)categoryView:(JXCategoryBaseView *)categoryView didScrollSelectedItemAtIndex:(NSInteger)index {
    self.selectedIndex = index;
}
- (void)categoryView:(JXCategoryBaseView *)categoryView scrollingFromLeftIndex:(NSInteger)leftIndex toRightIndex:(NSInteger)rightIndex ratio:(CGFloat)ratio {
    
}


#pragma mark - JXCategoryListContainerViewDelegate
- (id<JXCategoryListContentViewDelegate>)listContainerView:(JXCategoryListContainerView *)listContainerView initListForIndex:(NSInteger)index {
    NSDictionary *dict = self.typeArr[index];
    int status = [dict[@"status"] intValue];
    MyCommodityListVC *listVc = [[MyCommodityListVC alloc]init];
    listVc.status = status;
    return listVc;
}


- (NSInteger)numberOfListsInlistContainerView:(JXCategoryListContainerView *)listContainerView {
    return self.titles.count;
}

@end
