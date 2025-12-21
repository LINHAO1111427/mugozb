//
//  DynamicListViewController.m
//  DynamicCircle
//
//  Created by tctd on 2020/7/28.
//  Copyright © 2020 KLC. All rights reserved.
//

#import "B_DynamicListViewController.h"
#import <AVFoundation/AVFoundation.h>
#import <LibProjModel/KLCUserInfo.h>
#import <LibProjModel/KLCAppConfig.h>
#import <LibProjModel/ApiUserVideoModel.h>
#import <LibProjModel/HttpApiAppVideo.h>
#import <LibProjModel/AppVideo_getVideoList.h>
#import <LibProjBase/KLCTabBarControl.h>
#import <LibProjBase/LibProjBase.h>
#import <LibTools/LibTools.h>
#import <MJRefresh/MJRefresh.h>
#import "B_DynamicPlayCell.h"
 
#import <LibProjView/SV_guideView.h>
#import <LibProjView/VideoPlayListPageCollectionLayout.h>
#import <LibProjView/CustomPopUpAlert.h>
#import <LibProjView/RechargePopupView.h>
#import <LibProjView/MultiGestureCollectionView.h>
 

static NSString *dynamicCell = @"DynamicPlayCell";
@interface B_DynamicListViewController ()<
UIGestureRecognizerDelegate,
UICollectionViewDelegate,
UICollectionViewDataSource,
CollectionWaterfallLayoutDeleagete,
UIScrollViewDelegate,
B_DynamicPlayCellDelegate
>
 
@property (nonatomic, weak)UIView<EmptyViewInterface> *weakEmptyV;
//滚动视图
@property (nonatomic, strong)UICollectionView *sv_collectionView;
@property (nonatomic, strong) NSMutableDictionary *shortVideoCellDic;
@property (nonatomic, assign)int selectedIndex;
@property (nonatomic, strong) UICollectionViewFlowLayout *waterfallLayout;
@property (nonatomic, strong)NSMutableArray *dataArr;
@property (nonatomic, strong)B_DynamicPlayCell *playCell;


@property(nonatomic,assign)int page;
@property(nonatomic,assign)int pageSize;
@property(nonatomic,assign)BOOL isPush;//是否是push
@property(nonatomic,assign)BOOL isLoadingData;//是否在获取数据
 
@end

@implementation B_DynamicListViewController

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
    Class cls = [ProjConfig getEmptyView];
    UIView<EmptyViewInterface> *empty = [[cls alloc] init];
    empty.titleL.text = kKLC_Msg(@"暂时没有动态内容");
    empty.titleL.textColor = empty.detailL.textColor;
    [empty showInView:self.sv_collectionView];
    _weakEmptyV = empty;
}
- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    self.navigationController.navigationBar.hidden = NO;
    [self navBarBgTranslucent:NO];
    [self tabBarBgTranslucent:NO];
    if (self.playCell) {
        [self.playCell stopPlayVideo];
        if (!self.isPush) {
            self.playCell = nil;
        }
    }
}
- (void)dealloc{
    NSLog(@"DynamicListViewController delloc");
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
        [self loadData:YES dragDown:YES];
   }else{
       if (self.playCell) {
           [self.playCell startPlayVideo];
       }
   }
}
- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    [self navBarBgTranslucent:YES];
    [self tabBarBgTranslucent:YES]; 
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor blackColor];
    self.navigationController.navigationBar.hidden = YES;
    self.pageSize = 30;
    self.page = 0;
    if (self.index > 0) {
        self.page = self.index/self.pageSize;
//        self.index = self.index%self.pageSize;
    }
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
    
    if (kiOS11) {
        self.sv_collectionView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    }else{
        self.automaticallyAdjustsScrollViewInsets = NO;
    }
    self.edgesForExtendedLayout = UIRectEdgeAll;
    self.extendedLayoutIncludesOpaqueBars = YES;
    
    kWeakSelf(self);
    self.sv_collectionView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        if (self.index > 0 && self.page > 0) {
            weakself.page --;
            [weakself loadData:NO dragDown:YES];
        } else{
            weakself.page = 0;
            [weakself loadData:YES dragDown:YES];
        }
    }];
    self.sv_collectionView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        self.page ++;
        [weakself loadData:NO dragDown:NO];
    }];
    self.sv_collectionView.mj_footer.ignoredScrollViewContentInsetBottom = kISiPhoneXX ? 34 : 0;
    
    BOOL notFirstIn = [[NSUserDefaults standardUserDefaults]boolForKey:@"shortVdieoFirstInComplete"];
    if (!notFirstIn) {
        [SV_guideView showIn:self.view];
    }
    [self emptyView];
    
    UIButton *backBtn = [[UIButton alloc]initWithFrame:CGRectMake(10, kStatusBarHeight+(kNavBarHeight-kStatusBarHeight)/2.0-18, 36, 36)];
    backBtn.backgroundColor = kRGB_COLOR(@"#F0F4F9", 0.3);
    backBtn.layer.cornerRadius = 18;
    backBtn.clipsToBounds = YES;
//    [backBtn setImage:[UIImage imageNamed:@"main-navbar-back"] forState:UIControlStateNormal];
    [backBtn addTarget:self action:@selector(backBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:backBtn];
    [self.view bringSubviewToFront:backBtn];
}
 
- (void)backBtnClick:(UIButton *)btn{
    [self.navigationController popViewControllerAnimated:YES];
}
#pragma mark - 数据拉取
 
- (void)loadData:(BOOL)isRefresh dragDown:(BOOL)dragDown{
    if (isRefresh) {
        if (self.playCell) {
            [self.playCell stopPlayVideo];
            self.playCell = nil;
        }
    }
    self.isLoadingData = YES;
    AppVideo_getVideoList *list = [[AppVideo_getVideoList alloc] init];
    list.pageSize = 30;
    list.page = self.page;
    list.touid = self.touId;
    list.type = self.type;
    kWeakSelf(self);
    if (self.models.count) {//单个动态（评论）
        
        [self dealWithData:NO dragDown:NO arr:self.models code:1 msg:nil];
    }else{
        
        [HttpApiAppVideo getVideoList:list callback:^(int code, NSString *strMsg, PageInfo *pageInfo, NSArray<ApiUserVideoModel *> *arr) {
            weakself.page = pageInfo.pageIndex;
            [weakself dealWithData:isRefresh dragDown:dragDown arr:arr code:code msg:strMsg];
        }];
    }
}

- (void)dealWithData:(BOOL)isRefresh dragDown:(BOOL)dragDown arr:(NSArray<ApiUserVideoModel *>*)arr code:(int)code msg:(NSString *)strMsg{
    if (code == 1) {
        kWeakSelf(self);
        [self.sv_collectionView.mj_header endRefreshing];
        [self.sv_collectionView.mj_footer endRefreshing];
        if (isRefresh) {//刷新数据
            [self.dataArr removeAllObjects];
            [self.dataArr addObjectsFromArray:arr];
            if (arr.count < self.pageSize) {
                [self.sv_collectionView.mj_footer endRefreshingWithNoMoreData];
            }
        }else{
            if (dragDown) {//下拉加载更多
                [self.dataArr insertObjects:arr atIndexes:[NSIndexSet indexSetWithIndex:0]];
            }else{//上拉加载更多
                [self.dataArr addObjectsFromArray:arr];
                if (arr.count < self.pageSize) {
                    [self.sv_collectionView.mj_footer endRefreshingWithNoMoreData];
                }
            }
            
        }
    
        [self.sv_collectionView reloadData];
        if (self.index > 0) {
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                if (self.dataArr.count>1) {
                
                    [self scrollToItem:[NSIndexPath indexPathForRow:weakself.index inSection:0]];
                }

            });
        }
    }else{
        [self.sv_collectionView.mj_header endRefreshing];
        [self.sv_collectionView.mj_footer endRefreshing];
        [SVProgressHUD showErrorWithStatus:strMsg];
    }
    
    if (isRefresh) {
        [[NSNotificationCenter defaultCenter] postNotificationName:@"SV_canLRScroll" object:@(1)];
    }
    self.weakEmptyV.hidden = self.dataArr.count;
    self.isLoadingData = NO;
}
 
//计算短视频尺寸
/*
 - (void)setVideoSizeWith:(NSArray *)arr back:(void (^)(BOOL success,NSMutableArray *datas))callBack{
 NSMutableArray *arrys = [NSMutableArray array];
 int i = 0;
 for (ApiShortVideoDtoModel *model in arr) {
 i ++;
 if (model.type == 1) {
 AVPlayerItem *item = [AVPlayerItem playerItemWithURL:[NSURL URLWithString:model.videoUrl]];
 NSArray *array = item.asset.tracks;
 CGSize videoSize = CGSizeZero;
 for (AVAssetTrack *track in array) {
 if ([track.mediaType isEqualToString:AVMediaTypeVideo]) {
 CGSize realSize = CGSizeApplyAffineTransform(track.naturalSize, track.preferredTransform);
 videoSize = CGSizeMake(fabs(realSize.width), fabs(realSize.height));
 model.width = videoSize.width;
 model.height = videoSize.height;
 item  = nil;
 break;
 }
 }
 
 }
 [arrys addObject:model];
 }
 if (i == arr.count) {
 callBack(YES,arrys);
 }
 
 }
 */
 
#pragma mark - scrollView
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    if (self.sv_collectionView == scrollView) {
        
    }
}

- (void)scrollToItem:(NSIndexPath *)indexPath{
    [self.sv_collectionView scrollToItemAtIndexPath:indexPath atScrollPosition:UICollectionViewScrollPositionCenteredVertically animated:NO];
    B_DynamicPlayCell *cell = (B_DynamicPlayCell *)[self.sv_collectionView cellForItemAtIndexPath:indexPath];
    ApiUserVideoModel *model;
    if (indexPath.row < self.dataArr.count) {
        model = self.dataArr[indexPath.row];
    }
    if (self.playCell != cell || self.playCell == nil) {
        [[NSNotificationCenter defaultCenter] postNotificationName:@"SV_canLRScroll" object:@(1)];
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
        B_DynamicPlayCell *cell = (B_DynamicPlayCell *)[self.sv_collectionView cellForItemAtIndexPath:indexPathPlay];
        ApiUserVideoModel *model;
        if (indexPathPlay.row < self.dataArr.count) {
            model = self.dataArr[indexPathPlay.row];
        }
        if (model.type != 2) {
            [[NSNotificationCenter defaultCenter] postNotificationName:@"SV_canLRScroll" object:@(1)];
        }
        if (self.playCell != cell) {
            [[NSNotificationCenter defaultCenter] postNotificationName:@"SV_canLRScroll" object:@(1)];
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
        [self.sv_collectionView registerClass:[B_DynamicPlayCell class] forCellWithReuseIdentifier:identifier];
    }
    B_DynamicPlayCell *cell = (B_DynamicPlayCell *)[collectionView dequeueReusableCellWithReuseIdentifier:identifier forIndexPath:indexPath];
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
    cell.model = model;
    
    
    return cell;
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    [collectionView deselectItemAtIndexPath:indexPath animated:YES];
    B_DynamicPlayCell *cell = (B_DynamicPlayCell *)[collectionView cellForItemAtIndexPath:indexPath];
    [cell changePlayStaus];
}

#pragma mark - CollectionWaterfallLayoutDeleagete
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
/*
#pragma mark - JXCategoryListContentViewDelegate
- (UIView *)listView{
    [self navBarBgTranslucent:YES];
     [self tabBarBgTranslucent:YES];
    return self.view;
}
- (void)listWillDisappear{
    if (self.playCell) {
        [self.playCell stopPlayVideo];
    }
}
- (void)listWillAppear{
    if (!self.isPush) {
        self.playCell = nil;
        self.page = 0;
        self.index = 0;
      [self loadData:YES dragDown:YES];
    }
    if (self.playCell) {
        [self.playCell startPlayVideo];
    }
    self.isPush = NO;
   self.isScrollOwn = NO;
}
*/
  
 

- (void)navBarBgTranslucent:(BOOL)translucent{
    UINavigationBar *navBar = self.navigationController.navigationBar;
    UIImage *naviBgImage;
    navBar.hidden = NO;
    navBar.contentMode = UIViewContentModeScaleAspectFill;
    navBar.translucent = translucent;
    //导航栏恢复
    if (translucent) {
        naviBgImage = [UIImage imageWithColor:[UIColor clearColor]];
        naviBgImage = [naviBgImage resizableImageWithCapInsets:UIEdgeInsetsZero resizingMode:UIImageResizingModeStretch];
        navBar.backIndicatorImage = [UIImage imageWithColor:[UIColor clearColor]];
        navBar.backIndicatorTransitionMaskImage = [UIImage imageWithColor:[UIColor clearColor]];
        navBar.shadowImage = [UIImage imageWithColor:[UIColor clearColor]];
    }else{
        naviBgImage = [UIImage imageNamed:@"main-navibar"];
        naviBgImage = [naviBgImage resizableImageWithCapInsets:UIEdgeInsetsZero resizingMode:UIImageResizingModeStretch];
        navBar.backIndicatorImage = [UIImage new] ;
        navBar.backIndicatorTransitionMaskImage =  [UIImage new] ;
        navBar.shadowImage = [UIImage new];
    }
    [navBar setBackgroundImage:naviBgImage forBarMetrics:UIBarMetricsDefault];
}
- (void)tabBarBgTranslucent:(BOOL)translucent{
    KLCTabBarControl *tabBarC = [KLCTabBarControl share];
    for (UIView *subV in [tabBarC getTabBarC].tabBar.subviews){
        NSString * classname = NSStringFromClass([subV class]);
        if ([classname isEqualToString:@"_UIBarBackground"]) {
            for (UIView *desV in subV.subviews) {
                NSString *viName = NSStringFromClass([desV class]);
                if ([viName isEqualToString:@"UIImageView"]) {
                    desV.hidden = translucent;
                    break;
                }
            }
        }
    }
     
    tabBarC.translucent_tabbar = translucent;
    [tabBarC getTabBarC].tabBar.translucent = translucent;
    [self.tabBarController.tabBar setBackgroundImage:[UIImage imageWithColor:[UIColor clearColor]]];
    [[UITabBar appearance] setTranslucent:translucent];
}
#pragma mark - B_DynamicPlayCellDelegate
-(void)B_DynamicPlayCellAvaterBtnClick:(B_DynamicPlayCell *)cell model:(ApiUserVideoModel *)model{
    self.isPush = YES;
    [RouteManager routeForName:RN_user_anchorInfoVC currentC:self parameters:@{@"id":@(model.uid)}];
}
- (void)B_DynamicPlayCellCommentAvaterBtnClick:(B_DynamicPlayCell *)cell user_id:(int64_t)userId{
    self.isPush = YES;
    [RouteManager routeForName:RN_user_anchorInfoVC currentC:self parameters:@{@"id":@(userId)}];
}
@end
