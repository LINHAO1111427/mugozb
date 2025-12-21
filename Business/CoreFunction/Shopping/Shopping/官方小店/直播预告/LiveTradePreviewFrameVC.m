//
//  5000 LivePreviewFrameVC.m
//  Shopping
//
//  Created by klc_02 on 2020/8/8.
//  Copyright © 2020 klc. All rights reserved.
//

#import "LiveTradePreviewFrameVC.h"
#import "LiveTradePreviewTable.h"
 
@interface LiveTradePreviewFrameVC ()<
JXCategoryViewDelegate,
JXCategoryListContainerViewDelegate,
JXCategoryTitleViewDataSource
>
@property (nonatomic, weak) JXCategoryTitleView *titleView;
@property(nonatomic,assign)NSInteger selectedIndex;
@property (nonatomic, strong) NSMutableArray *titles;
@property(nonatomic,strong)NSArray* typeArr;
@end

@implementation LiveTradePreviewFrameVC
- (NSArray *)typeArr{
    if (!_typeArr) {
        _typeArr = @[
            @{@"title":kLocalizationMsg(@"直播预告"),@"type":@"0"}
//            @{@"title":kLocalizationMsg(@"直播订单"),@"type":@"1"}
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
    self.navigationItem.title = kLocalizationMsg(@"直播预告");
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
    CGFloat scale = 1.0,space = 5;
    JXCategoryTitleView *titleView = [[JXCategoryTitleView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth,0)];
    titleView.delegate = self;
    titleView.titleDataSource = self;
    titleView.titles = self.titles;
    titleView.titleColorGradientEnabled = NO;
    titleView.titleLabelAnchorPointStyle = JXCategoryTitleLabelAnchorPointStyleBottom;
    titleView.averageCellSpacingEnabled = YES;
    titleView.cellWidthZoomEnabled = YES;
    titleView.cellWidthZoomScale = scale;
//    titleView.indicators = @[lineView];
    titleView.backgroundColor = kRGB_COLOR(@"#F4F4F4");
    titleView.titleFont = [UIFont systemFontOfSize:13];
    titleView.titleSelectedFont = [UIFont systemFontOfSize:13];
    titleView.cellSpacing = space;
    titleView.titleColor = kRGB_COLOR(@"#2B2C2C");
    titleView.titleSelectedColor = kRGB_COLOR(@"#FF5500");
    [titleView setDefaultSelectedIndex:0];
    self.titleView = titleView;
    self.selectedIndex = 0;
    
    CGFloat totalWith = 0.0;
    for (int i = 0; i < self.typeArr.count; i++) {
        NSDictionary *dict = self.typeArr[i];
        NSString *title = dict[@"title"];
        CGSize size = [title boundingRectWithSize:CGSizeMake(kScreenWidth, 20) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:13]} context:nil].size;
        totalWith += size.width*scale+space;
    }
    CGFloat margin =  (kScreenWidth-totalWith)/(self.titles.count +1.0);
    self.titleView.contentEdgeInsetLeft =  margin;
    self.titleView.contentEdgeInsetRight = margin;
    
    
    
    JXCategoryListContainerView *listContainerView = [[JXCategoryListContainerView alloc] initWithType:JXCategoryListContainerType_ScrollView delegate:self];
    listContainerView.frame = CGRectMake(0, 0, kScreenWidth, kScreenHeight-kNavBarHeight);
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


#pragma mark - JXCategoryTitleViewDataSource
- (CGFloat)categoryTitleView:(JXCategoryTitleView *)titleView widthForTitle:(NSString *)title{
    CGSize size = [title boundingRectWithSize:CGSizeMake(kScreenWidth-70, 20) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:15]} context:nil].size;
    return size.width*1.2+3;
}
#pragma mark - JXCategoryListContainerViewDelegate
- (id<JXCategoryListContentViewDelegate>)listContainerView:(JXCategoryListContainerView *)listContainerView initListForIndex:(NSInteger)index {
    NSDictionary *dict = self.typeArr[index];
    int type = [dict[@"type"] intValue];
    LiveTradePreviewTable *listVc = [[LiveTradePreviewTable alloc]init];
    listVc.type = type;
    return listVc;
}

- (NSInteger)numberOfListsInlistContainerView:(JXCategoryListContainerView *)listContainerView {
    return self.titles.count;
}

@end
