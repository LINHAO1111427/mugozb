//
//  myGuardVc.m
//  MineCenter
//
//  Created by ssssssss on 2020/12/15.
//  Copyright © 2020 KLC. All rights reserved.
//

#import "myGuardCenterVc.h"
#import "guardListVc.h"

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
    self.navigationItem.title = kLocalizationMsg(@"守护中心");
    [self createUI];
}
- (void)createUI{
    _titles = @[kLocalizationMsg(@"我守护的"),kLocalizationMsg(@"守护我的")];
    
    JXCategoryIndicatorLineView *lineView = [[JXCategoryIndicatorLineView alloc] init];
    lineView.indicatorColor = [ProjConfig normalColors];
    lineView.indicatorWidth = 10.0;
    
    CGFloat titleH = kNavBarHeight-kStatusBarHeight-10;
    JXCategoryTitleView *titleView = [[JXCategoryTitleView alloc] initWithFrame:CGRectMake((kScreenWidth-250)/2.0, 0, 250, titleH)];
    titleView.delegate = self;
    titleView.titles = _titles;
    titleView.backgroundColor = [UIColor clearColor];
    titleView.averageCellSpacingEnabled = YES;
    titleView.indicators = @[lineView];
    titleView.defaultSelectedIndex = [self.type intValue] == 1?0:1;
    titleView.titleFont = [UIFont systemFontOfSize:15];
    titleView.titleSelectedFont = [UIFont systemFontOfSize:15];
    titleView.titleColor = kRGB_COLOR(@"#666666");
    titleView.titleSelectedColor = [ProjConfig normalColors];
    _titleView = titleView;
    [self.view addSubview:titleView];
    
    JXCategoryListContainerView *listContainerView = [[JXCategoryListContainerView alloc] initWithType:JXCategoryListContainerType_ScrollView delegate:self];
    listContainerView.frame = CGRectMake(0,titleH, kScreenWidth, kScreenHeight-kNavBarHeight-titleH);
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
            guardListVc *guard = [[guardListVc alloc] initWithType:0 userId:[self.userId longLongValue]];
            return guard;
        }
            break;
        case 1:
        {
            guardListVc *guard = [[guardListVc alloc] initWithType:1 userId:[self.userId longLongValue]];
            return guard;
        }
            break;
        default:
        {
            guardListVc *guard = [[guardListVc alloc] initWithType:0 userId:[self.userId longLongValue]];
            return guard;
        }
            break;
    }
}

@end
