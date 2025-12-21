//
//  OrderFormCrustVC.m
//  Shopping
//
//  Created by yww on 2020/8/3.
//  Copyright © 2020 klc. All rights reserved.
//

#import "OrderFormCrustVC.h"
#import "HostOrderListVC.h"
#import "HostOrderSourceSelectedView.h"
#import <LibProjModel/ShopOrderNumDTOModel.h>
#import <LibProjModel/HttpApiShopOrder.h>
 
@interface OrderFormCrustVC ()
<
JXCategoryViewDelegate,
JXCategoryListContainerViewDelegate,
JXCategoryTitleViewDataSource
>
@property (nonatomic, weak) JXCategoryNumberView *titleView;
@property(nonatomic,assign)NSInteger selectedIndex;
@property (nonatomic, strong) NSMutableArray *titles;
@property(nonatomic,strong)NSArray* typeArr;
@property (nonatomic, assign)NSInteger orderSource;//订单来源

@property (nonatomic, strong)ShopOrderNumDTOModel *dtoModel;
@property (nonatomic, assign)BOOL isScrolling;

@end

@implementation OrderFormCrustVC
 
- (void)dealloc
{
    _dtoModel = nil;
}

- (NSArray *)typeArr{
    if (!_typeArr) {
        _typeArr = @[
            @{@"title":kLocalizationMsg(@"全部"),@"status":@"0"},
            @{@"title":kLocalizationMsg(@"待付款"),@"status":@"1"},
            @{@"title":kLocalizationMsg(@"待发货"),@"status":@"2"},
            @{@"title":kLocalizationMsg(@"待收货"),@"status":@"3"},
            @{@"title":kLocalizationMsg(@"退货/退款"),@"status":@"4"}
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
    self.navigationItem.title = self.navTitle;
    self.orderSource = 0;
    [self addCategoryView];
    [self getOderNum];//获取订单分类数量
}

-(void)getOderNum{
    kWeakSelf(self);
    [HttpApiShopOrder getOrderNum:self.type == OrderTypeForCustomer?1:2 callback:^(int code, NSString *strMsg, ShopOrderNumDTOModel *model) {
        if (code == 1) {
            weakself.dtoModel = model;
            [weakself reloadTitleInfo];
        }else{
            [SVProgressHUD showInfoWithStatus:strMsg];
        }
    }];
}

- (void)reloadTitleInfo{
    if (!self.isScrolling) {
        NSArray *pointArr = @[@(0),@(self.dtoModel.toBePayNum),@(self.dtoModel.toBeDeliveredNum),@(self.dtoModel.toBeReceivedNum),@(self.dtoModel.cancelGoodsNum)];
        self.titleView.counts = pointArr;
        [self.titleView reloadDataWithoutListContainer];
    }
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

    
    JXCategoryNumberView *titleView = [[JXCategoryNumberView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kNavBarHeight-kStatusBarHeight)];
    titleView.delegate = self;
    titleView.titleDataSource = self;
    titleView.titles = self.titles;
    titleView.indicators = @[lineView];
    titleView.cellSpacing = 5;
    titleView.backgroundColor = kRGB_COLOR(@"#F4F4F4");
    titleView.titleFont = [UIFont systemFontOfSize:14];
    titleView.titleSelectedFont = [UIFont systemFontOfSize:14];
    titleView.titleColor = kRGB_COLOR(@"#2B2C2C");
    titleView.titleSelectedColor = kRGB_COLOR(@"#FF5500");
    titleView.shouldMakeRoundWhenSingleNumber = YES;
    titleView.numberBackgroundColor = [UIColor redColor];
    titleView.numberTitleColor = [UIColor whiteColor];
    titleView.numberLabelFont = [UIFont systemFontOfSize:8];
    titleView.numberLabelOffset = CGPointMake(5, 0);
    [titleView setDefaultSelectedIndex:self.selectedStatus];
    self.titleView = titleView;
    titleView.numberStringFormatterBlock = ^NSString *(NSInteger number) {
        if (number > 99) {
            return @"99+";
        }else{
            return kStringFormat(@"%zi",number);
        }
    };
    self.selectedIndex = self.selectedStatus;
    self.titleView.contentEdgeInsetLeft = self.titleView.contentEdgeInsetRight = 15;
    
    JXCategoryListContainerView *listContainerView = [[JXCategoryListContainerView alloc] initWithType:JXCategoryListContainerType_ScrollView delegate:self];
    listContainerView.frame = CGRectMake(0, titleView.maxY, kScreenWidth, kScreenHeight-kNavBarHeight-titleView.maxY);
    [self.view addSubview:listContainerView];
    self.titleView.listContainer = listContainerView;
    [self.view addSubview:self.titleView];
    
    [self.titleView reloadData];
}
  
    
///选择来源
- (void)orderModeBtnClick{
    kWeakSelf(self);
    [HostOrderSourceSelectedView showInSuperView:self.view callBack:^(BOOL success, NSInteger clickIndex, HostOrderSourceSelectedView * _Nonnull moreView) {
        moreView = nil;
        if (success) {
            weakself.orderSource = clickIndex;
            //进行筛选
        }
    }];
}
#pragma mark - JXCategoryViewDelegate
- (void)categoryView:(JXCategoryBaseView *)categoryView didClickSelectedItemAtIndex:(NSInteger)index {
    self.selectedIndex = index;
    self.isScrolling = YES;
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        self.isScrolling = NO;
    });
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
    int status = [dict[@"status"] intValue];
    HostOrderListVC *listVc = [[HostOrderListVC alloc] init];
    listVc.type = self.type;
    listVc.status = status;
    kWeakSelf(self);
    listVc.reloadNumBlick = ^{
        [weakself getOderNum];
    };
    return listVc;
}


- (NSInteger)numberOfListsInlistContainerView:(JXCategoryListContainerView *)listContainerView {
    return self.titles.count;
}


- (void)listContainerViewWillBeginDragging:(UIScrollView *)scrollView{
    self.isScrolling = YES;
}

- (void)listContainerViewWillBeginDecelerating:(UIScrollView *)scrollView{
    self.isScrolling = YES;
}

- (void)listContainerViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate{
    if (!decelerate) {
        self.isScrolling = NO;
    }
}

- (void)listContainerViewDidEndDecelerating:(UIScrollView *)scrollView{
    self.isScrolling = NO;
}


@end
