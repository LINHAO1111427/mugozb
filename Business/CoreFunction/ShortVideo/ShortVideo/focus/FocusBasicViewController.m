//
//  FocusBasicViewController.m
//  HomePage
//
//  Created by KLC on 2020/6/16.
//  Copyright © 2020 KLC. All rights reserved.
//

#import "FocusBasicViewController.h"

#import <LibProjModel/HttpApiPublicLive.h>
#import <LibProjModel/ApiShortVideoModel.h>
#import <LibProjModel/HttpApiAppShortVideo.h>
#import <LibProjModel/ApiShortVideoDtoModel.h>
#import <LibProjModel/AppHotSortModel.h>
#import <LibProjModel/AppAdsModel.h>
#import <LibProjModel/APPConfigModel.h>
#import <LibProjModel/AdminLiveConfigModel.h>

#import <LibProjView/CollectionWaterfallLayout.h>

#import "FocusVideoCollectionViewCell.h"
#import "FocusHeaderView.h"
#import <LibProjView/PublicMethodObj.h>


@interface FocusBasicViewController ()<CollectionWaterfallLayoutDelegate,UICollectionViewDelegate,UICollectionViewDataSource,UIScrollViewDelegate,FocusHeaderViewDelegate>

@property (nonatomic, strong) CollectionWaterfallLayout *waterfallLayout;
@property(nonatomic,weak)UICollectionView *weakCollView;
@property(nonatomic,strong)FocusHeaderView *headerView;
@property(nonatomic,strong)NSMutableArray *infoMuArray;
@property(nonatomic,assign)BOOL isLoadingData;//正在请求数据
@property(nonatomic,assign)int page;
@property (nonatomic, strong)ApiShortVideoModel *dataModel;
@property (nonatomic, strong) NSMutableArray  *weekList;//本周必看
@property (nonatomic, strong) NSMutableArray *dataList;//热门分类
@property (nonatomic, strong) NSMutableArray *adsList;//广告图
@property(nonatomic,assign)BOOL isPush;

@property (nonatomic, copy)NSArray *lookPointFunArr;

@end

@implementation FocusBasicViewController

- (NSMutableArray *)weekList{
    if (!_weekList) {
        _weekList = [NSMutableArray array];
    }
    return _weekList;;
}
- (NSMutableArray *)dataList{
    if (!_dataList) {
        _dataList = [NSMutableArray array];
    }
    return _dataList;;
}
- (NSMutableArray *)adsList{
    if (!_adsList) {
        _adsList = [NSMutableArray array];
    }
    return _adsList;;
}

- (CollectionWaterfallLayout *)waterfallLayout{
    if (!_waterfallLayout) {
        _waterfallLayout = [[CollectionWaterfallLayout alloc] init];
        _waterfallLayout.delegate = self;
    }
    return _waterfallLayout;
}

- (NSMutableArray *)infoMuArray{
    if (!_infoMuArray) {
        _infoMuArray = [NSMutableArray array];
    }
    return _infoMuArray;
}
#pragma mark - 初始化
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [_headerView adBannerisScroll:YES];
}

- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    
}
- (void)viewDidDisappear:(BOOL)animated{
    [super viewDidDisappear:animated];
    [_headerView adBannerisScroll:NO];
}

- (void)dealloc{
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationItem.title = kLocalizationMsg(@"看点");
    
    self.lookPointFunArr = [[ProjConfig shareInstence].businessConfig getShortVideoLookPointArray];
    
    UICollectionView *collectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(0,kNavBarHeight, kScreenWidth,  kScreenHeight-kNavBarHeight-kTabBarHeight) collectionViewLayout:self.waterfallLayout];
    collectionView.backgroundColor = [UIColor whiteColor];
    self.waterfallLayout.headerReferenceSize = CGSizeMake(kScreenWidth, 144);
    _weakCollView = collectionView;
    [self.view addSubview:_weakCollView];
    
    if (kiOS11) {
        _weakCollView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    } else {
        self.automaticallyAdjustsScrollViewInsets = NO;
    }
    self.weakCollView.delegate = self;
    self.weakCollView.dataSource = self;
    [self.weakCollView registerClass:[FocusHeaderView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"focusHeaderId"];
    [self.weakCollView registerClass:[FocusVideoCollectionViewCell class] forCellWithReuseIdentifier:@"FocusVideoCellID"];
    
    kWeakSelf(self);
    self.weakCollView .mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        weakself.page = 0;
        [weakself loadData:YES];
    }];
    self.weakCollView .mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        weakself.page ++;
        [weakself loadData:NO];
    }];
    
}

- (void)loadData:(BOOL)isRefresh{
    if (isRefresh) {
        [self.dataList removeAllObjects];
        [self.headerView reloadAdData];
    }
    self.isLoadingData = YES;
    kWeakSelf(self);
    [HttpApiAppShortVideo getHighlights:self.page pageSize:kPageSize callback:^(int code, NSString *strMsg, ApiShortVideoModel *model) {
        weakself.isLoadingData = NO;
        [weakself.weakCollView.mj_header endRefreshing];
        [weakself.weakCollView.mj_footer endRefreshing];
        if (code == 1) {
            weakself.weekList = model.weekList;
            weakself.adsList = model.adsList;
            weakself.dataList = model.classifyList;
            if (model.classifyList.count < kPageSize) {
                [weakself.weakCollView.mj_footer endRefreshingWithNoMoreData];
            }
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [weakself.weakCollView reloadData];
            });
        }else{
            [SVProgressHUD showInfoWithStatus:strMsg];
        }
    }];
}


#pragma mark - UICollectionViewDelegate dataSource
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.dataList.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    FocusVideoCollectionViewCell *cell = (FocusVideoCollectionViewCell *)[collectionView dequeueReusableCellWithReuseIdentifier:@"FocusVideoCellID" forIndexPath:indexPath];
    cell.model = (indexPath.row < self.dataList.count)?self.dataList[indexPath.row]:nil;
    return cell;
    
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath{
    if (kind == UICollectionElementKindSectionHeader) {//直播首页
        if (!self.headerView) {
            FocusHeaderView *headerView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"focusHeaderId" forIndexPath:indexPath];
            headerView.delegate = self;
            headerView.funcArr = self.lookPointFunArr;
            self.headerView = headerView;
        }
        self.headerView.adList = self.adsList;
        self.headerView.weekList = self.weekList;
        return self.headerView;
    }
    return [[UICollectionReusableView alloc]initWithFrame:CGRectZero];
}
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    if (self.isLoadingData) {
        return;
    }
    [collectionView deselectItemAtIndexPath:indexPath animated:YES];
    AppHotSortModel *model;
    if (indexPath.row < self.dataList.count) {
        model = self.dataList[indexPath.row];
    }
    self.isPush = YES;
    if (model) {
        [RouteManager routeForName:RN_shortVideo_sort_List currentC:self parameters:@{@"title":model.name,@"classfyId":@(model.id_field),@"sort":@(-1)}];
    }
}
#pragma mark - FocusHeaderViewDelegate
- (void)FocusHeaderView:(FocusHeaderView *)headerView heightForView:(CGFloat)viewHeight{
    self.waterfallLayout.headerReferenceSize = CGSizeMake(kScreenWidth, viewHeight);
}

- (void)FocusHeaderView:(FocusHeaderView *)headerView adItemClick:(NSString *)adUrl {
    if (adUrl.length != 0 && adUrl != nil && adUrl != NULL ) {
        self.isPush = YES;
        [PublicMethodObj showUrl:adUrl];
    }
}

- (void)FocusHeaderView:(FocusHeaderView *)headerView weekMustBtnClick:(ApiShortVideoDtoModel *)model{
    self.isPush = YES;
    NSDictionary *prams = @{
        @"dataType":@(5),
        @"index":@(0),
        @"shortVideoId":@(model.id_field)
    };
    [RouteManager routeForName:RN_shortVideo_play_List currentC:self parameters:prams];
}

- (void)FocusHeaderView:(FocusHeaderView *)headerView mostBtnClick:(NSInteger)index{
    self.isPush = YES;
    switch (index) {
        case 1://最多观看
            [RouteManager routeForName:RN_shortVideo_sort_List currentC:self parameters:@{@"title":kLocalizationMsg(@"最多观看"),@"classfyId":@(-1),@"sort":@(1)}];
            break;
        case 2://最多评论
            [RouteManager routeForName:RN_shortVideo_sort_List currentC:self parameters:@{@"title":kLocalizationMsg(@"最多评论"),@"classfyId":@(-1),@"sort":@(2)}];
            break;
        case 3://最多点赞
            [RouteManager routeForName:RN_shortVideo_sort_List currentC:self parameters:@{@"title":kLocalizationMsg(@"最多点赞"),@"classfyId":@(-1),@"sort":@(3)}];
            break;
        case 4://最多付费
            [RouteManager routeForName:RN_shortVideo_sort_List currentC:self parameters:@{@"title":kLocalizationMsg(@"最多付费"),@"classfyId":@(-1),@"sort":@(4)}];
            break;
        default:
            break;
    }
}

#pragma mark - CollectionWaterfallLayoutDelegate
- (CGFloat)waterFallLayout:(CollectionWaterfallLayout *)waterFallLayout heightForItemAtIndexPath:(NSInteger)indexPath itemWidth:(CGFloat)itemWidth{
    CGFloat width = (kScreenWidth-4)/2.0;
    CGFloat scale = 1.0;
    return width*scale;
}

/**
 * 有多少列
 */
- (NSUInteger)columnCountInWaterFallLayout:(CollectionWaterfallLayout *)waterFallLayout{
    return 2;
}

/**
 * 每列之间的间距
 */
- (CGFloat)columnMarginInWaterFallLayout:(CollectionWaterfallLayout *)waterFallLayout{
    return 4.0;
}

/**
 * 每行之间的间距
 */
- (CGFloat)rowMarginInWaterFallLayout:(CollectionWaterfallLayout *)waterFallLayout{
    return 5.0;
}

/**
 * 每个item的内边距
 */
- (UIEdgeInsets)edgeInsetdInWaterFallLayout:(CollectionWaterfallLayout *)waterFallLayout{
    return UIEdgeInsetsMake(0, 0, 0, 0);
}

#pragma mark - JXCategoryListContentViewDelegate
- (UIView *)listView{
    return self.view;
}

- (void)listWillAppear{
    if (!self.isPush) {
        [self loadData:YES];
        self.isPush = NO;
    }
}


@end
