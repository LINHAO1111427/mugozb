//
//  StoreHomeViewController.m
//  Shopping
//
//  Created by klc on 2020/7/22.
//  Copyright © 2020 klc. All rights reserved.
//

#import "StoreHomeViewController.h"
#import "StoreHomeHeaderView.h"
#import "StoreCommodityListTable.h"
#import "StoreDetailInfoTable.h"
#import <LibProjModel/HttpApiRestShop.h>
#import <LibProjView/PopView.h>
#import <LibProjView/PopTableListView.h>

@interface StoreHomeViewController ()<
UIScrollViewDelegate,
JXCategoryViewDelegate,
JXCategoryTitleViewDataSource,
JXPagerViewDelegate,
UITextFieldDelegate
>
@property (nonatomic, weak) JXCategoryTitleView *titleView;
@property (nonatomic, strong) JXPagerView *pagingView;
@property (nonatomic, strong) NSMutableArray *titles;
@property (nonatomic, strong) NSMutableArray *typeArr;
@property(nonatomic,assign)NSInteger selectedIndex;

@property (nonatomic, strong)StoreHomeHeaderView *storeHeader;

@property (nonatomic, strong)ShopBusinessModel *business;//商家信息
@property (nonatomic, assign)BOOL isOpenLive;
@property (nonatomic, strong)NSArray *goodsDTOList;//商品列表
@property (nonatomic, strong)UITextField *storeSearchTextF;
@property (nonatomic, strong)StoreCommodityListTable *storeList;
@end

@implementation StoreHomeViewController
#pragma mark - lazy load
- (NSArray *)goodsDTOList{
    if (!_goodsDTOList) {
        _goodsDTOList = [NSArray array];
    }
    return _goodsDTOList;
}
- (NSMutableArray *)titles{
    if (!_titles) {
        NSArray *arr = @[kLocalizationMsg(@"商品列表"),kLocalizationMsg(@"商家简介")];
        _titles =  [NSMutableArray arrayWithArray:arr];
    }
    return _titles;
}
- (NSMutableArray *)typeArr{
    if (!_typeArr) {
        _typeArr = [NSMutableArray array];
    }
    return _typeArr;
}
- (StoreHomeHeaderView *)storeHeader{
    if (!_storeHeader) {
        _storeHeader = [[StoreHomeHeaderView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 115)];
    }
    return _storeHeader;
}
- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    [self loadData:YES];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self addNavView];
    [self addCategoryView];
}
- (void)addNavView{
    CGFloat y = (kNavBarHeight-kStatusBarHeight-30)/2.0;
    CGFloat width = kScreenWidth -122-55;
    UIView *storeSearchV = [[UIView alloc]initWithFrame:CGRectMake(50, y, width, 30)];
    storeSearchV.layer.cornerRadius = 15;
    storeSearchV.clipsToBounds = YES;
    storeSearchV.backgroundColor = kRGB_COLOR(@"#EEEEEE");
    [self.navigationController.navigationBar addSubview:storeSearchV];
    
    UITextField *storeSearchTextF = [[UITextField alloc]initWithFrame:CGRectMake(10, 0, width-20, 30)];
    storeSearchTextF.textColor = kRGB_COLOR(@"#333333");
    storeSearchTextF.placeholder = kLocalizationMsg(@" 搜索店内宝贝");
    storeSearchTextF.clearButtonMode = UITextFieldViewModeWhileEditing;
    storeSearchTextF.delegate = self;
    storeSearchTextF.font = [UIFont systemFontOfSize:13];
    storeSearchTextF.textAlignment = NSTextAlignmentLeft;
    UIImageView *leftImageV = [[UIImageView alloc]initWithFrame:CGRectMake(10, 0, 20, 20)];
    leftImageV.image = [UIImage imageNamed:@"store_in_search"];
    storeSearchTextF.leftView = leftImageV;
    storeSearchTextF.leftViewMode = UITextFieldViewModeAlways;
    [storeSearchTextF addTarget:self action:@selector(textFieldDidChange) forControlEvents:UIControlEventEditingChanged];
    self.storeSearchTextF = storeSearchTextF;
    [storeSearchV addSubview:self.storeSearchTextF];
     
    
    for (int i = 0; i < 3; i++) {
        UIButton *btn = [[UIButton alloc]initWithFrame:CGRectMake(60+width+i*(35), 0, 30, 30)];
        btn.centerY = storeSearchTextF.centerY;
        [btn addTarget:self action:@selector(navBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        btn.backgroundColor = [UIColor clearColor];
        NSString *imageName;
        if (i == 0) {
            imageName = @"store_call";
        }else if (i == 1){
            imageName = @"store_seveer";
        }else if (i == 2){
            imageName = @"store_more_selecte";
        }
        btn.tag = i;
        [btn setImage:[UIImage imageNamed:imageName] forState:UIControlStateNormal];
        [self.navigationController.navigationBar addSubview:btn];
    }
    
}
- (void)navBtnClick:(UIButton *)btn{
    switch (btn.tag) {
        case 0://客服
            if (self.business.mobile.length > 0) {
                [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[NSString stringWithFormat:@"tel:%@",self.business.mobile]]];
            }
            break;
        case 1:{//聊天
            if ([ProjConfig userId] == self.business.anchorId) {
                [SVProgressHUD showInfoWithStatus:kLocalizationMsg(@"不能与自己聊天")];
                return;
            }
            [RouteManager routeForName:RN_Message_ConversationChatVC currentC:[ProjConfig currentVC] parameters:@{@"chatType":@"0",@"msgSendId":@(self.business.anchorId)}];
        }
            break;
        case 2://更多
            [self showMoreSelecteView:btn];
            break;
            
        default:
            break;
    }
}
- (void)moreBtnClick:(NSInteger)index{
    switch (index) {
        case 0://购物车
            [RouteManager routeForName:RN_Shopping_PurchaseCar_ListVC currentC:self parameters:nil];
            break;
        case 1://消息
            [RouteManager routeForName:RN_Message_MessageChatListVC currentC:self parameters:nil];
            break;
        case 2://订单
            [RouteManager routeForName:RN_Shopping_Order_ListVC  currentC:self parameters:@{@"title":kLocalizationMsg(@"购物订单"),@"type":@(0),@"status":@(0)}];
            break;
            
        default:
            break;
    }
}
 
- (void)showMoreSelecteView:(UIButton *)btn{
    kWeakSelf(self);
    PopTableListView *popListView = [[PopTableListView alloc] initWithTitles:@[kLocalizationMsg(@"购物车"),kLocalizationMsg(@"消息"),kLocalizationMsg(@"我的订单")] imgNames:@[@"store_my_shoppingcar",@"store_my_message",@"store_my_order"]];
    popListView.width = 120;
    popListView.backgroundColor = kRGB_COLOR(@"#F0F0F5");
    popListView.layer.cornerRadius = 5;
    popListView.seleBlock = ^(int64_t seleIndex) {
        [PopView hidenPopView];
        [weakself moreBtnClick:seleIndex];
    };
    [PopView popUpContentView:popListView direct:PopViewDirection_PopUpBottom onView:btn];
}

- (void)loadData:(BOOL)isRefresh{
    kWeakSelf(self);
    [HttpApiRestShop businessCenter:[self.shopId intValue] callback:^(int code, NSString *strMsg, ShopBusinessDTOModel *model) {
        [weakself.pagingView.mainTableView.mj_header endRefreshing];
        if (code == 1) {
            
            weakself.goodsDTOList = model.goodsDTOList;
            weakself.business = model.business;
            weakself.isOpenLive = model.status;
            weakself.storeHeader.dtoModel = model;
            
            dispatch_async(dispatch_get_main_queue(), ^{
                [weakself.titleView reloadData];
                [weakself.pagingView reloadData];
                [weakself.view addSubview:weakself.titleView];
            });
        }else{
            [SVProgressHUD showInfoWithStatus:strMsg];
        }
    }];
}
- (void)addCategoryView{
     for (int i = 0; i < self.titles.count; i++) {
           NSDictionary *dic;
           NSString *title = self.titles[i];
           if (i == 0) {
               dic = @{@"title":title,@"type":@0};
           }else if (i == 1){
               dic = @{@"title":title,@"type":@1};
           }
           [self.typeArr addObject:dic];
       }
    //线
    JXCategoryIndicatorLineView *lineView = [[JXCategoryIndicatorLineView alloc] init];
    lineView.indicatorColor = kRGB_COLOR(@"#FF5500");
    lineView.verticalMargin = 4;
    //    [lineView addGradientColorWith:@[(__bridge id)kRGB_COLOR(@"#FE73E1").CGColor,(__bridge id)kRGB_COLOR(@"#9A58FF").CGColor]
    //                        percentage:@[@0.3,@1.0]];
    lineView.indicatorWidth = 24;
    //标题
    CGFloat scale = 1.2,space = 5;
    JXCategoryTitleView *titleView = [[JXCategoryTitleView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 40)];
    titleView.delegate = self;
    titleView.titleDataSource = self;
    titleView.titles = self.titles;
    titleView.titleColorGradientEnabled = NO;
    titleView.titleLabelAnchorPointStyle = JXCategoryTitleLabelAnchorPointStyleBottom;
    titleView.averageCellSpacingEnabled = YES;
    titleView.cellWidthZoomEnabled = YES;
    titleView.cellWidthZoomScale = scale;
    titleView.indicators = @[lineView];
    titleView.backgroundColor = [UIColor whiteColor];
    titleView.titleFont = [UIFont systemFontOfSize:14];
    titleView.titleSelectedFont = [UIFont systemFontOfSize:14];
    titleView.cellSpacing = space;
    titleView.titleColor = kRGB_COLOR(@"#333333");
    titleView.titleSelectedColor = kRGB_COLOR(@"#FF5500");
    
    CGFloat totalWith = 0.0;
    for (int i = 0; i < self.titles.count; i++) {
        NSString *title = self.titles[i];
        CGSize size = [title boundingRectWithSize:CGSizeMake(kScreenWidth/3.0, 20) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:14]} context:nil].size;
        if ( size.width*scale+space < 80) {
            totalWith += 80;
        }else{
            totalWith += size.width*scale+space;
        }
    }
    CGFloat marginWidth = (kScreenWidth-totalWith)/3.0;
    if (marginWidth > 0) {
        titleView.contentEdgeInsetLeft = marginWidth;
        titleView.contentEdgeInsetRight = marginWidth;
    }else{
        titleView.contentEdgeInsetLeft =  0;
        titleView.contentEdgeInsetRight = 0;
    }
    self.titleView = titleView;
    [self.view addSubview:self.titleView];
    self.selectedIndex = 0;
    [self.titleView setDefaultSelectedIndex:self.selectedIndex];
    self.titleView.listContainer.contentScrollView.scrollEnabled  = YES;
    
    
    self.pagingView = [[JXPagerView alloc] initWithDelegate:self];
    self.pagingView.frame = CGRectMake(0, 0, kScreenWidth,kScreenHeight-kNavBarHeight);
    self.pagingView.listContainerView.backgroundColor = [UIColor whiteColor];
    self.pagingView.defaultSelectedIndex = self.selectedIndex;
    [self.view addSubview:self.pagingView];
    kWeakSelf(self);
    self.pagingView.mainTableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [weakself loadData:YES];
    }];
    self.titleView.listContainer = (id<JXCategoryViewListContainer>)self.pagingView.listContainerView;
}
 

#pragma mark - JXPagerViewDelegate
- (UIView *)tableHeaderViewInPagerView:(JXPagerView *)pagerView {
    return self.storeHeader;
}

- (NSUInteger)tableHeaderViewHeightInPagerView:(JXPagerView *)pagerView {
    return self.storeHeader.viewHeight;
}

- (NSUInteger)heightForPinSectionHeaderInPagerView:(JXPagerView *)pagerView {
    return 50;
}

- (UIView *)viewForPinSectionHeaderInPagerView:(JXPagerView *)pagerView {
     
    return self.titleView;
}

- (NSInteger)numberOfListsInPagerView:(JXPagerView *)pagerView {
     
    return self.titles.count;
}

- (id<JXPagerViewListViewDelegate>)pagerView:(JXPagerView *)pagerView initListAtIndex:(NSInteger)index {
    NSDictionary *dict = self.typeArr[index];
    int type = [dict[@"type"] intValue];
    if (type == 0) {//商品列表
        CGFloat scale = 162/360.0;
        CGFloat width = kScreenWidth*scale;
        CGFloat height = width+70;
        CGFloat margin = (kScreenWidth-2*width)/3.0;
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
        layout.scrollDirection = UICollectionViewScrollDirectionVertical;
        layout.minimumLineSpacing = margin;
        layout.minimumInteritemSpacing = margin;
        layout.sectionInset = UIEdgeInsetsMake(0, margin, 0, margin);
        layout.headerReferenceSize = CGSizeMake(kScreenWidth, 10);
        layout.itemSize = CGSizeMake(width, height);
        StoreCommodityListTable *storeList = [[StoreCommodityListTable alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 0) collectionViewLayout:layout];
        storeList.superVc = self;
        storeList.dataArray = self.goodsDTOList;
        storeList.showsVerticalScrollIndicator = NO;
        self.storeList = storeList;
        return storeList;
    }else{//商家简介
        StoreDetailInfoTable *detailInfo = [[StoreDetailInfoTable alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight-300)];
        detailInfo.separatorStyle = UITableViewCellSeparatorStyleNone;
        detailInfo.business = self.business;
        return detailInfo;
    }
    
}

#pragma mark - JXCategoryViewDelegate
- (void)categoryView:(JXCategoryBaseView *)categoryView didClickSelectedItemAtIndex:(NSInteger)index {
    self.selectedIndex = index;
}
- (void)categoryView:(JXCategoryBaseView *)categoryView didSelectedItemAtIndex:(NSInteger)index {
    self.navigationController.interactivePopGestureRecognizer.enabled = (index == 0);
    self.selectedIndex = index;
}

- (void)categoryView:(JXCategoryBaseView *)categoryView didScrollSelectedItemAtIndex:(NSInteger)index {
    self.selectedIndex = index;
}

- (void)categoryView:(JXCategoryBaseView *)categoryView scrollingFromLeftIndex:(NSInteger)leftIndex toRightIndex:(NSInteger)rightIndex ratio:(CGFloat)ratio {
    
}
#pragma mark - JXCategoryTitleViewDataSource
- (CGFloat)categoryTitleView:(JXCategoryTitleView *)titleView widthForTitle:(NSString *)title{
    CGSize size = [title boundingRectWithSize:CGSizeMake(kScreenWidth-70, 20) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:14]} context:nil].size;
    return size.width*1.0+3;
    
}

#pragma mark - 搜索
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
    return YES;
}

- (void)textFieldDidChange{
   // NSLog(@"过滤文字搜索"));
    if (self.storeSearchTextF.text.length == 0) {
        [self loadData:YES];
        return;
    }
    kWeakSelf(self);
    [HttpApiRestShop searchBusinessProduct:self.business.id_field productName:self.storeSearchTextF.text callback:^(int code, NSString *strMsg, ShopBusinessDTOModel *model) {
        if (code == 1) {
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                weakself.goodsDTOList = model.goodsDTOList;
                weakself.storeList.dataArray = model.goodsDTOList;
                [weakself.storeList reloadData];
            });
        }else{
            [SVProgressHUD showInfoWithStatus:strMsg];
        }
    }];
}

@end
