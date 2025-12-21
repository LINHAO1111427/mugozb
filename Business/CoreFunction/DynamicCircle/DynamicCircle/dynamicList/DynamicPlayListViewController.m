//
//  DynamicListViewController.m
//  DynamicCircle
//
//  Created by ssssssss on 2020/7/28.
//  Copyright © 2020 KLC. All rights reserved.
//

#import "DynamicPlayListViewController.h"
#import <AVFoundation/AVFoundation.h>
#import <LibProjModel/KLCUserInfo.h>
#import <LibProjModel/KLCAppConfig.h>
#import <LibProjModel/ApiUserVideoModel.h>
#import <LibProjModel/HttpApiDynamicController.h>
#import <LibProjBase/LibProjBase.h>
#import <LibTools/LibTools.h>
#import <MJRefresh/MJRefresh.h>
#import "DynamicItemPlayCell.h"

#import <LibProjView/CollectionWaterfallLayout.h>
#import <LibProjView/VideoGuideView.h>
#import <LibProjView/CustomPopUpAlert.h>
#import <LibProjView/MultiGestureCollectionView.h>
#import <LibProjView/EmptyView.h>

static NSString *dynamicCell = @"DynamicPlayCell";
@interface DynamicPlayListViewController ()<
UIGestureRecognizerDelegate,
UICollectionViewDelegate,
UICollectionViewDataSource,
CollectionWaterfallLayoutDelegate,
UIScrollViewDelegate,
DynamicItemPlayCellDelegate
>

@property (nonatomic, weak)EmptyView *weakEmptyV;

//滚动视图
@property (nonatomic, strong) UICollectionView *sv_collectionView;
@property (nonatomic, strong) NSMutableDictionary *shortVideoCellDic;
@property (nonatomic, assign) int selectedIndex;
@property (nonatomic, strong) UICollectionViewFlowLayout *waterfallLayout;
@property (nonatomic, strong) NSMutableArray *dataArr;
@property (nonatomic, strong) DynamicItemPlayCell *playCell;

@property(nonatomic,assign)BOOL isPush;//是否是push
@property(nonatomic,assign)BOOL isLoadingData;//是否在获取数据

@end

@implementation DynamicPlayListViewController

- (NSMutableDictionary *)shortVideoCellDic{
    if (!_shortVideoCellDic ) {
        _shortVideoCellDic = [NSMutableDictionary dictionary];
    }
    return _shortVideoCellDic;
}
- (UICollectionViewFlowLayout *)waterfallLayout{
    if (!_waterfallLayout) {
        _waterfallLayout = [[UICollectionViewFlowLayout alloc] init];
        _waterfallLayout.minimumLineSpacing = 0;
        _waterfallLayout.minimumInteritemSpacing = 0;
        _waterfallLayout.itemSize = CGSizeMake(kScreenWidth, kScreenHeight);
        _waterfallLayout.scrollDirection = UICollectionViewScrollDirectionVertical;
    }
    return _waterfallLayout;
}

- (NSMutableArray *)dataArr{
    if (!_dataArr) {
        _dataArr = [NSMutableArray array];
    }
    return _dataArr;
}
#pragma mark - 初始化

-(void)emptyView{
    EmptyView *empty = [[EmptyView alloc] init];
    empty.titleL.text = kLocalizationMsg(@"暂时没有动态内容");
    empty.titleL.textColor = empty.detailL.textColor;
    [empty showInView:self.sv_collectionView];
    _weakEmptyV = empty;
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    if (self.playCell) {
        [self.playCell stopPlayVideo];
        if (!self.isPush) {
            self.playCell = nil;
        }
    }
}

- (void)dealloc{
    
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIApplicationDidEnterBackgroundNotification object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIApplicationWillEnterForegroundNotification object:nil];
    
   // NSLog(@"过滤文字DynamicListViewController delloc"));
    if (self.playCell) {
        [self.playCell stopPlayVideo];
    }
}

- (void)viewDidDisappear:(BOOL)animated{
    [super viewDidDisappear:animated];
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    if (!self.isPush) {
        ///为什么要重新加载数据
        //        [self loadData:YES];
    }else{
        if (self.playCell) {
            if (self.playCell.isPausePlay) {
                [self.playCell resumeVideo];
            }else{
                [self.playCell startPlayVideo];
            }
        }
    }
}

- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
}

- (void)viewDidLoad {
    
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor blackColor];
    self.navigationController.navigationBarHidden = YES;
    
    CGRect frame = CGRectMake(0,0, kScreenWidth,  kScreenHeight);
    UICollectionView *collectionView = [[UICollectionView alloc]initWithFrame: frame collectionViewLayout:self.waterfallLayout];
    collectionView.showsVerticalScrollIndicator = NO;
    collectionView.delegate   = self;
    collectionView.dataSource = self;
    collectionView.pagingEnabled = YES;
    collectionView.decelerationRate = 0.8;//松手后的scroll速度（0～1之间）
    //    collectionView.pagingEnabled = YES;//这样会导致上拉刷新时候 collection跳动的问题
    collectionView.backgroundColor = [UIColor clearColor];
    self.sv_collectionView = collectionView;
    [self.view addSubview:self.sv_collectionView];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(applicationWillEnterForeground:) name:UIApplicationWillEnterForegroundNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(applicationDidEnterBackground:) name:UIApplicationDidEnterBackgroundNotification object:nil];
    if (kiOS11) {
        self.sv_collectionView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    }else{
        self.automaticallyAdjustsScrollViewInsets = NO;
    }
    self.edgesForExtendedLayout = UIRectEdgeAll;
    self.extendedLayoutIncludesOpaqueBars = YES;
    
    if ([_hasLoading intValue]) {
        self.sv_collectionView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
            [self loadData:YES];
        }];
        self.sv_collectionView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
            [self loadData:NO];
        }];
        
//        self.sv_collectionView.mj_footer.ignoredScrollViewContentInsetBottom = kISiPhoneXX ? 34 : 0;
        
        //引导页
        [VideoGuideView showIn:self.view type:videoGuideTypeDynamic];
    }
    
    [self emptyView];
    
    UIButton *backBtn = [[UIButton alloc]initWithFrame:CGRectMake(10, kStatusBarHeight+(kNavBarHeight-kStatusBarHeight)/2.0-18, 36, 36)];
    backBtn.backgroundColor = kRGBA_COLOR(@"#F0F4F9", 0.3);
    backBtn.layer.cornerRadius = 18;
    backBtn.clipsToBounds = YES;
    [backBtn setImage:[UIImage imageNamed:@"main_navbar_back"] forState:UIControlStateNormal];
    [backBtn addTarget:self action:@selector(backBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:backBtn];
    [self.view bringSubviewToFront:backBtn];
    
    /// 显示数据
    [self.dataArr addObjectsFromArray:self.models];
    if ([self.index integerValue] > 0) {
        if (self.dataArr.count>1 && [self.index integerValue] < self.dataArr.count) {
            [self scrollToItem:[NSIndexPath indexPathForRow:[self.index integerValue] inSection:0]];
        }
        self.index = @(0);
    }
}

- (void)backBtnClick:(UIButton *)btn{
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)applicationDidEnterBackground:(NSNotification *)notice{
    if (self.playCell) {
        [self.playCell pauseVideo];
    }
}
- (void)applicationWillEnterForeground:(NSNotification *)notice{
    if (self.playCell) {
        if(self.isViewLoaded && self.view.window){//正在显示
            if (self.playCell.isPausePlay) {
                [self.playCell resumeVideo];
            }else{
                [self.playCell startPlayVideo];
            }
        }
    }
}

#pragma mark - 数据拉取
- (void)loadData:(BOOL)isRefresh{
    if (isRefresh) {
        if (self.playCell) {
            [self.playCell stopPlayVideo];
            self.playCell = nil;
        }
    }
    self.isLoadingData = YES;
    
    int pageSize = kPageSize;
    int page = isRefresh?0:(int)self.dataArr.count/pageSize + (self.dataArr.count%pageSize?1:0);
    int64_t hotId = 0;
    if ([self.hotId longLongValue] > 0) {
        hotId = [self.hotId longLongValue];
    }
    [SVProgressHUD  showGifLoadingWithtatus:@""];
    kWeakSelf(self);
//    if (self.models.count) {//单个动态（评论）
//        [self dealWithData:YES dragDown:NO arr:self.models code:1 msg:nil];
//    }else{
        [HttpApiDynamicController getDynamicList:hotId page:page pageSize:pageSize touid:[self.touId longLongValue] type:[self.type intValue] callback:^(int code, NSString *strMsg, PageInfo *pageInfo, NSArray<ApiUserVideoModel *> *arr) {
            [weakself dealWithData:isRefresh arr:arr code:code msg:strMsg];
        }];
//    }
}

- (void)dealWithData:(BOOL)isRefresh arr:(NSArray<ApiUserVideoModel *>*)arr code:(int)code msg:(NSString *)strMsg{
    if (code == 1) {
        [self.sv_collectionView.mj_header endRefreshing];
        [self.sv_collectionView.mj_footer endRefreshing];
        [SVProgressHUD dismiss];
        
        if (isRefresh) {//下拉加载更多
            [self.dataArr removeAllObjects];
        }
        [self.dataArr addObjectsFromArray:arr];
        if (arr.count < kPageSize) {
            [self.sv_collectionView.mj_footer endRefreshingWithNoMoreData];
        }
        [self.sv_collectionView reloadData];
    }else{
        [self.sv_collectionView.mj_header endRefreshing];
        [self.sv_collectionView.mj_footer endRefreshing];
        [SVProgressHUD dismiss];
        [SVProgressHUD showInfoWithStatus:strMsg];
    }
    
    self.weakEmptyV.hidden = self.dataArr.count;
    self.isLoadingData = NO;
}


- (void)getVideoSize:(ApiUserVideoModel *)model{
    CGSize videoSize = CGSizeZero;
    if (model.type == 1 && model.width <= 0 && model.height <= 0 && model.href.length > 0) {
        NSURL *url = [NSURL URLWithString:model.href];
        AVAsset *asset = [AVAsset assetWithURL:url];
        NSArray *array = asset.tracks;
        for (AVAssetTrack *track in array) {
            if ([track.mediaType isEqualToString:AVMediaTypeVideo]) {
                videoSize = CGSizeApplyAffineTransform(track.naturalSize, track.preferredTransform);
                break;
            }
        }
    }
    model.width = videoSize.width;
    model.height = videoSize.height;
}


#pragma mark - scrollView
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    if (self.sv_collectionView == scrollView) {
        
    }
}

- (void)scrollToItem:(NSIndexPath *)indexPath{
    [self.sv_collectionView scrollToItemAtIndexPath:indexPath atScrollPosition:UICollectionViewScrollPositionCenteredVertically animated:NO];
    DynamicItemPlayCell *cell = (DynamicItemPlayCell *)[self.sv_collectionView cellForItemAtIndexPath:indexPath];
    if (self.playCell != cell || self.playCell == nil) {
        [self.playCell stopPlayVideo];
        self.playCell = cell;
        [self.playCell startPlayVideo];
    }
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    if (scrollView == self.sv_collectionView) {
        NSIndexPath *indexPathPlay;
        if (scrollView.contentOffset.y <= 0) {
            indexPathPlay = [NSIndexPath indexPathForItem:0 inSection:0];
        }else{
            indexPathPlay = [self.sv_collectionView indexPathForItemAtPoint:CGPointMake(0, scrollView.contentOffset.y + self.sv_collectionView.frame.size.height/2)];
        }
        [scrollView setContentOffset:CGPointMake(0, scrollView.frame.size.height*indexPathPlay.row) animated:YES];
        DynamicItemPlayCell *cell = (DynamicItemPlayCell *)[self.sv_collectionView cellForItemAtIndexPath:indexPathPlay];
        ApiUserVideoModel *model;
        if (indexPathPlay.row < self.dataArr.count) {
            model = self.dataArr[indexPathPlay.row];
        }
        if (self.playCell != cell) {
            [self.playCell stopPlayVideo];
            self.playCell = cell;
            [self.playCell startPlayVideo];
        }
    }
}

#pragma mark - collectionview
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.dataArr.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    NSString *identifier = [self.shortVideoCellDic objectForKey:[NSString stringWithFormat:@"%@", indexPath]];
    if(identifier == nil){
        identifier = [NSString stringWithFormat:@"%@%@%@",dynamicCell,[NSString getNowTimeTimestamp], [NSString stringWithFormat:@"%@",indexPath]];
        [self.shortVideoCellDic setObject:identifier forKey:[NSString  stringWithFormat:@"%@",indexPath]];
        [self.sv_collectionView registerClass:[DynamicItemPlayCell class] forCellWithReuseIdentifier:identifier];
    }
    DynamicItemPlayCell *cell = (DynamicItemPlayCell *)[collectionView dequeueReusableCellWithReuseIdentifier:identifier forIndexPath:indexPath];
    cell.clipsToBounds = YES;
    cell.indexPath = indexPath;
    cell.delegate = self;
    if (!self.playCell && !self.isLoadingData) {
        self.playCell = cell;
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [self.playCell startPlayVideo];
        });
    }
    ApiUserVideoModel *model;
    if (indexPath.row < self.dataArr.count) {
        model = self.dataArr[indexPath.row];
    }
    if (model) {
        cell.model = model;
    }
    return cell;
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    [collectionView deselectItemAtIndexPath:indexPath animated:YES];
    DynamicItemPlayCell *cell = (DynamicItemPlayCell *)[collectionView cellForItemAtIndexPath:indexPath];
    [cell changePlayStaus];
}

#pragma mark - CollectionWaterfallLayoutDelegate
- (CGFloat)waterFallLayout:(CollectionWaterfallLayout *)waterFallLayout heightForItemAtIndexPath:(NSInteger)indexPath itemWidth:(CGFloat)itemWidth{
    return kScreenHeight;
}
//列
- (NSUInteger)columnCountInWaterFallLayout:(CollectionWaterfallLayout *)waterFallLayout{
    return 1;
}
//列间距
- (CGFloat)columnMarginInWaterFallLayout:(CollectionWaterfallLayout *)waterFallLayout{
    return 0.0;
}
//行间距
- (CGFloat)rowMarginInWaterFallLayout:(CollectionWaterfallLayout *)waterFallLayout{
    return 0.0;
}
//内边距
- (UIEdgeInsets)edgeInsetdInWaterFallLayout:(CollectionWaterfallLayout *)waterFallLayout{
    return UIEdgeInsetsMake(0, 0, 0, 0);
}

#pragma mark - DynamicItemPlayCellDelegate
-(void)dynamicItemPlayCellAvaterBtnClick:(DynamicItemPlayCell *)cell model:(ApiUserVideoModel *)model{
    self.isPush = YES;
    [RouteManager routeForName:RN_user_userInfoVC currentC:self parameters:@{@"id":@(model.uid)}];
}
- (void)dynamicItemPlayCellCommentAvaterBtnClick:(DynamicItemPlayCell *)cell user_id:(int64_t)userId{
    self.isPush = YES;
    [RouteManager routeForName:RN_user_userInfoVC currentC:self parameters:@{@"id":@(userId)}];
}
- (void)dynamicItemPlayCellReportBtnClick:(DynamicItemPlayCell *)cell model:(ApiUserVideoModel *)model{
    self.isPush = YES;
    [RouteManager routeForName:RN_dynamic_dynamicReportVC currentC:self parameters:@{@"id":@(model.id_field)}];
}

- (void)dynamicItemPlayCell:(DynamicItemPlayCell *)cell didSelectDynamicImage:(ApiUserVideoModel *)model{
    [self.navigationController popViewControllerAnimated:YES];
}

@end
