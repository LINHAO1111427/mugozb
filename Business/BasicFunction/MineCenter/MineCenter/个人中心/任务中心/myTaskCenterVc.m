//
//  myTaskCenterVc.m
//  MineCenter
//
//  Created by ssssssss on 2020/12/14.
//  Copyright © 2020 KLC. All rights reserved.
//

#import "myTaskCenterVc.h"

#import "userTaskCenterVc.h"
#import "anchorTaskCenterVc.h"

#import "JXCategoryTitleView.h"
#import "JXCategoryListContainerView.h"
#import "JXCategoryIndicatorLineView.h"

@interface myTaskCenterVc ()<JXCategoryViewDelegate,JXCategoryListContainerViewDelegate>
@property (nonatomic, weak) JXCategoryTitleView *titleView;
@property (nonatomic, copy) NSArray *titles;
@end

@implementation myTaskCenterVc

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationController.navigationBar.translucent = YES;
    [self createUI];
}
- (void)createUI{
    if ([ProjConfig getAppType] == 4) {
        _titles = @[kLocalizationMsg(@"用户任务")];
    }else{
        _titles = @[kLocalizationMsg(@"用户任务"),kLocalizationMsg(@"主播任务")];
    }
    
    JXCategoryIndicatorLineView *lineView = [[JXCategoryIndicatorLineView alloc] init];
    lineView.indicatorColor = [ProjConfig normalColors];
    lineView.indicatorWidth = 10.0;
    
    JXCategoryTitleView *titleView = [[JXCategoryTitleView alloc] initWithFrame:CGRectMake(0, 0, 250, kNavBarHeight-kStatusBarHeight-10)];
    titleView.delegate = self;
    titleView.titles = _titles;
    titleView.backgroundColor = [UIColor clearColor];
    titleView.averageCellSpacingEnabled = YES;
    titleView.indicators = @[lineView];
    titleView.titleFont = [UIFont systemFontOfSize:15];
    titleView.titleSelectedFont = [UIFont systemFontOfSize:18];
    titleView.defaultSelectedIndex = [self.isAnchor intValue]==1?1:0;
    titleView.titleColor = kRGB_COLOR(@"#666666");
    titleView.titleSelectedColor = [ProjConfig normalColors];
    _titleView = titleView;
    self.navigationItem.titleView = titleView;
    
    JXCategoryListContainerView *listContainerView = [[JXCategoryListContainerView alloc] initWithType:JXCategoryListContainerType_ScrollView delegate:self];
    listContainerView.frame = CGRectMake(0, kNavBarHeight, kScreenWidth, kScreenHeight-kNavBarHeight);
    [self.view addSubview:listContainerView];
    //关联到categoryView
    titleView.listContainer = listContainerView;
}
#pragma mark - delegate
- (void)categoryView:(JXCategoryBaseView *)categoryView didSelectedItemAtIndex:(NSInteger)index{
     
}

- (NSInteger)numberOfListsInlistContainerView:(JXCategoryListContainerView *)listContainerView{
    return self.titles.count;
}

- (id<JXCategoryListContentViewDelegate>)listContainerView:(JXCategoryListContainerView *)listContainerView initListForIndex:(NSInteger)index{
    
    switch (index) {
        case 0:
        {
            userTaskCenterVc *list = [[userTaskCenterVc alloc] init];
            return list;
        }
            break;
        case 1:
        {
            anchorTaskCenterVc *list = [[anchorTaskCenterVc alloc] init];
            return list;
        }
            break;
        default:
        {
            userTaskCenterVc *list = [[userTaskCenterVc alloc] init];
            return list;
        }
            break;
    }
}


- (UIBarButtonItem *)rt_customBackItemWithTarget:(id)target action:(SEL)action{
    [BaseNavBarItem navBarBgClear:self foregroundColor:nil];
    return [[UIBarButtonItem alloc] initWithCustomView:[BaseNavBarItem navBackBtnImage:[UIImage imageNamed:@"main_navbar_back_black"] target:target action:action]];

}


@end
