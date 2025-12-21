//
//  ShortVideoHomeViewController.m
//  ShortVideo
//
//  Created by ssssssss on 2020/6/19.
//  Copyright © 2020 KLC. All rights reserved.
//

#import "ShortVideoHomeViewController.h"
#import "FocusBasicViewController.h"
#import "ShortVideoListViewController.h"

@interface ShortVideoHomeViewController ()<JXCategoryViewDelegate, JXCategoryListContainerViewDelegate>

@property (nonatomic, weak) JXCategoryTitleView *titleView;
@property (nonatomic, strong)JXCategoryIndicatorLineView *lineView;

@property(nonatomic,assign)BOOL canLRScroll;//是否可以左右滑动

@property (nonatomic,copy) NSArray* typeArr;//类型

@end

@implementation ShortVideoHomeViewController

- (UIBarButtonItem *)rt_customBackItemWithTarget:(id)target action:(SEL)action{
    return [[UIBarButtonItem alloc] init];
}

- (instancetype)init{
    self = [super init];
    if (self) {
        _typeArr = [[ProjConfig shareInstence].businessConfig getShortVideoClassfiyArray];
    }
    return self;
}
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    ///如果放到rt_customBackItemWithTarget下，启动时就不会调用了
    [BaseNavBarItem navBarBgClear:self foregroundColor:[UIColor blackColor]];
    
    self.navigationController.navigationBar.translucent = YES;
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(svCanLRScroll:) name:@"shortViewCanScroll" object:nil];
    [self addCategoryView];
        
    [self changeTitleColor];
}

- (void)addCategoryView{
    
    NSMutableArray *titles = [[NSMutableArray alloc] init];
    //子控制器列表
    for (NSDictionary *dic in self.typeArr) {
        [titles addObject:dic[@"title"]];
    }
    JXCategoryIndicatorLineView *lineView = [[JXCategoryIndicatorLineView alloc] init];
    lineView.indicatorColor = [UIColor whiteColor];
    lineView.indicatorWidth = 16.0;
    self.lineView = lineView;
    
    JXCategoryListContainerView *listContainerView = [[JXCategoryListContainerView alloc] initWithType:JXCategoryListContainerType_ScrollView delegate:self];
    listContainerView.contentScrollView.scrollEnabled = NO;
    listContainerView.contentScrollView.backgroundColor = [UIColor blackColor];
    listContainerView.frame = CGRectMake(0, 0, kScreenWidth, kScreenHeight-kTabBarHeight);
    [self.view addSubview:listContainerView];
    
    JXCategoryTitleView *titleView = [[JXCategoryTitleView alloc] initWithFrame:CGRectMake(0, 5, self.typeArr.count * 70, kNavBarHeight-kStatusBarHeight-8)];
    titleView.delegate = self;
    titleView.titles = titles;
    titleView.titleColorGradientEnabled = NO;
    titleView.titleLabelAnchorPointStyle = JXCategoryTitleLabelAnchorPointStyleBottom;
    titleView.averageCellSpacingEnabled = YES;
    titleView.titleLabelZoomEnabled = YES;
    titleView.titleLabelZoomScale = 1.2;
    titleView.indicators = @[lineView];
    titleView.backgroundColor = [UIColor clearColor];
    titleView.titleFont = kFont(18);
    titleView.titleSelectedFont = kFont(22);
    titleView.cellSpacing = 15;
    titleView.titleColor = [UIColor whiteColor];
    titleView.titleSelectedColor = [UIColor whiteColor];
    [self.navigationController.navigationBar addSubview:titleView];
    titleView.centerX = titleView.superview.width/2.0;
    [titleView setDefaultSelectedIndex:self.homeDefaultSelectedIndex];
    self.titleView = titleView;
    
    self.titleView.listContainer = listContainerView;
    titleView.listContainer.contentScrollView.scrollEnabled  = YES;

}

- (void)searchBtnClick{
    [RouteManager routeForName:RN_base_searchAnchorVC currentC:self];
}
- (void)svCanLRScroll:(NSNotification *)notice{
    BOOL canScroll = [[notice object] boolValue];
    self.titleView.listContainer.contentScrollView.scrollEnabled = canScroll;
}

#pragma mark - JXCategoryViewDelegate

- (void)categoryView:(JXCategoryBaseView *)categoryView didSelectedItemAtIndex:(NSInteger)index {
    //侧滑手势处理
    //    if (_shouldHandleScreenEdgeGesture) {
    self.navigationController.interactivePopGestureRecognizer.enabled = (index == 0);
    //    }
    [self changeTitleColor];
}

- (void)changeTitleColor{
    NSString *imageName;
    NSDictionary *subDic = self.typeArr[self.titleView.selectedIndex];
    if ([subDic[@"logicType"] intValue] == 2) {
        imageName = @"icon_nav_search_black";
        self.titleView.titleColor = kRGB_COLOR(@"#333333");
        self.titleView.titleSelectedColor = kRGB_COLOR(@"#333333");
        self.lineView.indicatorColor = kRGB_COLOR(@"#333333");
    }else{
        imageName = @"main_navbar_sousuo";
        self.titleView.titleColor = [UIColor whiteColor];
        self.titleView.titleSelectedColor = [UIColor whiteColor];
        self.lineView.indicatorColor = [UIColor whiteColor];
    }
    [self.titleView reloadDataWithoutListContainer];
    kWeakSelf(self);
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:[BaseNavBarItem navItemImageName:imageName clickHandle:^{
        [weakself searchBtnClick];
    }]];
}

- (void)categoryView:(JXCategoryBaseView *)categoryView scrollingFromLeftIndex:(NSInteger)leftIndex toRightIndex:(NSInteger)rightIndex ratio:(CGFloat)ratio {
}


#pragma mark - JXCategoryListContainerViewDelegate
- (id<JXCategoryListContentViewDelegate>)listContainerView:(JXCategoryListContainerView *)listContainerView initListForIndex:(NSInteger)index {
    NSDictionary *dict = self.typeArr[index];
    int type = [dict[@"logicType"] intValue];
    
    switch (type) {
        case 0:{//推荐
            ShortVideoListViewController *recommendVc = [[ShortVideoListViewController alloc]init];
            recommendVc.dataType = 0;
            recommendVc.index = 0;
            recommendVc.type = 0;
            recommendVc.sort = -1;
            recommendVc.classifyId = -1;
            return recommendVc;
        }
            break;
        case 1:{//关注
            ShortVideoListViewController *attentVc = [[ShortVideoListViewController alloc]init];
            attentVc.dataType = 0;
            attentVc.index = 0;
            attentVc.type = 1;
            attentVc.sort = -1;
            attentVc.classifyId = -1;
            return attentVc;
        }
            break;
            
        case 2:{//看点
            FocusBasicViewController *focusVc = [[FocusBasicViewController alloc]init];
            return focusVc;
        }
            break;
            
        default:{
            ShortVideoListViewController *recommendVc = [[ShortVideoListViewController alloc]init];
            recommendVc.dataType = 0;
            recommendVc.index = 0;
            recommendVc.type = 0;
            recommendVc.sort = -1;
            recommendVc.classifyId = -1;
            return recommendVc;
        }
            break;
    }
    
}

- (NSInteger)numberOfListsInlistContainerView:(JXCategoryListContainerView *)listContainerView {
    return self.typeArr.count;
}

@end
