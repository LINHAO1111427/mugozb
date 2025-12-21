//
//  myGuardVc.m
//  MineCenter
//
//  Created by ssssssssssss on 2020/12/15.
//  Copyright © 2020 KLC. All rights reserved.
//

#import "myGuardCenterVc.h"

#import "beGuardVc.h"
#import "guardOtherVc.h"

#import "JXCategoryTitleView.h"
#import "JXCategoryListContainerView.h"
#import "JXCategoryIndicatorLineView.h"

@interface myGuardCenterVc ()<JXCategoryViewDelegate,JXCategoryListContainerViewDelegate>
@property (nonatomic, weak) JXCategoryTitleView *titleView;
@property (nonatomic, copy) NSArray *titles;
@end

@implementation myGuardCenterVc

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationItem.title = @"守护中心";
    [self createUI];
}
- (void)createUI{
    _titles = @[@"我守护的",@"守护我的"];
    
    JXCategoryIndicatorLineView *lineView = [[JXCategoryIndicatorLineView alloc] init];
    lineView.indicatorColor = [ProjConfig normalColors];
    lineView.indicatorWidth = 20.0;
    
    JXCategoryTitleView *titleView = [[JXCategoryTitleView alloc] initWithFrame:CGRectMake(0, kNavBarHeight, 250, kNavBarHeight-kStatusBarHeight-10)];
    titleView.delegate = self;
    titleView.titles = _titles;
    titleView.backgroundColor = [UIColor clearColor];
    titleView.averageCellSpacingEnabled = YES;
    titleView.indicators = @[lineView];
    titleView.titleFont = [UIFont systemFontOfSize:15];
    titleView.titleSelectedFont = [UIFont systemFontOfSize:18];
    titleView.titleColor = kRGB_COLOR(@"#666666");
    titleView.titleSelectedColor = [ProjConfig normalColors];
    _titleView = titleView;
    [self.view addSubview:titleView];
    
    JXCategoryListContainerView *listContainerView = [[JXCategoryListContainerView alloc] initWithType:JXCategoryListContainerType_ScrollView delegate:self];
    listContainerView.frame = CGRectMake(0, kNavBarHeight, kScreenWidth, kScreenHeight-kNavBarHeight-(kNavBarHeight-kStatusBarHeight-10));
    [self.view addSubview:listContainerView];
    //关联到categoryView
    titleView.listContainer = listContainerView;
}
 
#pragma mark - delegate
- (NSInteger)numberOfListsInlistContainerView:(JXCategoryListContainerView *)listContainerView{
    return self.titles.count;
}

- (id<JXCategoryListContentViewDelegate>)listContainerView:(JXCategoryListContainerView *)listContainerView initListForIndex:(NSInteger)index{
    
    switch (index) {
        case 0:
        {
            guardOtherVc *guard = [[guardOtherVc alloc] init];
            return guard;
        }
            break;
        case 1:
        {
            beGuardVc *guard = [[beGuardVc alloc] init];
            return guard;
        }
            break;
        default:
        {
            guardOtherVc *guard = [[guardOtherVc alloc] init];
            return guard;
        }
            break;
    }
}


- (UIBarButtonItem *)rt_customBackItemWithTarget:(id)target action:(SEL)action{
    
    [BaseNavBarItem navbar:self bgImage:nil foregroundColor:nil];
    return [[UIBarButtonItem alloc] initWithCustomView:[BaseNavBarItem navBackBtnImage:[UIImage imageNamed:@"main-navbar-back-black"] target:target action:action]];

}

@end
