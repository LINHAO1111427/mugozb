//
//  AttentOrFansListVC.m
//  Fans
//
//  Created by ssssssss on 2020/1/8.
//

#import "AttentOrFansListVC.h"
#import "myAttentTable.h"
#import "myFansTable.h"
 
#import <LibProjBase/LibProjBase.h>

@interface AttentOrFansListVC ()<
JXCategoryViewDelegate,
JXCategoryTitleViewDataSource,
JXCategoryListContainerViewDelegate>

@property (nonatomic, weak) JXCategoryTitleView *titleView;
@property (nonatomic, strong)JXCategoryIndicatorLineView *lineView;
@property (nonatomic, strong) NSArray *titles;
@property(nonatomic,assign)NSInteger selectedIndex;
@end

@implementation AttentOrFansListVC
 
- (NSArray *)titles{
    if (!_titles) {
        _titles =  @[kLocalizationMsg(@"关注"),kLocalizationMsg(@"粉丝")];
    }
    return _titles;
}
 
- (void)viewDidLoad {
    [super viewDidLoad];
    self.selectedIndex = 0;
    self.view.backgroundColor = [UIColor whiteColor];
    [self addCategoryView];
}
 
- (void)addCategoryView{
    
    [self.titleView removeAllSubViews];
    [self.titleView removeFromSuperview];
 
    self.titleView = nil;
    JXCategoryIndicatorLineView *lineView = [[JXCategoryIndicatorLineView alloc] init];
    lineView.indicatorColor = [ProjConfig normalColors];
    lineView.indicatorWidth = 16.0;
    self.lineView = lineView;
    
    CGFloat lefttWith = 70;
    CGFloat scale = 1.2,space = 5;
    JXCategoryTitleView *titleView = [[JXCategoryTitleView alloc] initWithFrame:CGRectMake(lefttWith, 0, kScreenWidth-lefttWith, kNavBarHeight-kStatusBarHeight-5)];
    titleView.delegate = self;
    titleView.titleDataSource = self;
    titleView.titles = self.titles;
    titleView.titleColorGradientEnabled = NO;
    titleView.titleLabelAnchorPointStyle = JXCategoryTitleLabelAnchorPointStyleBottom;
    titleView.averageCellSpacingEnabled = YES;
    titleView.titleLabelMaskEnabled = YES;
    titleView.titleLabelZoomScale = scale;
    titleView.indicators = @[lineView];
    titleView.backgroundColor = [UIColor clearColor];
    titleView.titleFont = [UIFont systemFontOfSize:15];
    titleView.titleSelectedFont = [UIFont boldSystemFontOfSize:18];
    titleView.cellSpacing = space;
    titleView.titleColor = kRGB_COLOR(@"#666666");
    titleView.titleSelectedColor = [ProjConfig normalColors];
    
    CGFloat totalWith = 0.0;
    for (int i = 0; i < self.titles.count; i++) {
        NSString *title = self.titles[i];
        CGSize size = [title boundingRectWithSize:CGSizeMake(kScreenWidth-70, 20) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:15]} context:nil].size;
        totalWith += size.width*scale+space;
    }
    CGFloat maginWidth = (kScreenWidth-lefttWith-totalWith-(self.titles.count-1)*space);
    if (maginWidth > 0) {
        if (maginWidth >= lefttWith) {
            titleView.contentEdgeInsetLeft = (maginWidth-lefttWith)/2.0;
            titleView.contentEdgeInsetRight = (maginWidth-lefttWith)/2.0+lefttWith;
        }else{
            titleView.contentEdgeInsetLeft =  0;
            titleView.contentEdgeInsetRight = maginWidth;
        }
    }else{
        titleView.contentEdgeInsetLeft =  0;
        titleView.contentEdgeInsetRight = 0;
    }
    
    self.selectedIndex = [self.contentType integerValue];
    [titleView setDefaultSelectedIndex:self.selectedIndex];
    self.titleView = titleView;
    
    JXCategoryListContainerView *listContainerView = [[JXCategoryListContainerView alloc] initWithType:JXCategoryListContainerType_ScrollView delegate:self];
    listContainerView.contentScrollView.scrollEnabled = NO;
    listContainerView.contentScrollView.backgroundColor = [UIColor whiteColor];
    listContainerView.frame = CGRectMake(0, 0, kScreenWidth, kScreenHeight);
    [self.view addSubview:listContainerView];
    self.titleView.listContainer = listContainerView;
    titleView.listContainer.contentScrollView.scrollEnabled  = YES;
    [self.navigationController.navigationBar addSubview:self.titleView];
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
    if (index == 0) {// 关注
        myAttentTable *attentTable = [[myAttentTable alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight - kNavBarHeight) type:0];
        attentTable.backgroundColor = [UIColor whiteColor];
        attentTable.superVc = self;
        attentTable.separatorStyle = UITableViewCellSeparatorStyleNone;
        return attentTable;
    }else{
        myFansTable *fansTable = [[myFansTable alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight - kNavBarHeight) type:1];
        fansTable.backgroundColor = [UIColor whiteColor];
        fansTable.superVc = self;
        fansTable.separatorStyle = UITableViewCellSeparatorStyleNone;
        return fansTable;
    }
    
}

- (NSInteger)numberOfListsInlistContainerView:(JXCategoryListContainerView *)listContainerView {
    return self.titles.count;
}
@end
