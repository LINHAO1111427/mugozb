//
//  HomeLiveShoppingViewController.m
//  HomePage
//
//  Created by yww on 2020/8/10.
//  Copyright © 2020 KLC. All rights reserved.
//

#import "HomeLiveShoppingViewController.h"

#import <LibProjModel/HttpApiHome.h>
#import <LibProjModel/HttpApiShopBusiness.h>
#import <LibProjModel/ShopLiveAnnouncementDetailDTOModel.h>
#import <LibProjModel/AppHomeHallDTOModel.h>

#import <LibProjView/LiveVideoCollectionViewCell.h>
#import "HomeLiveShoppingHeader.h"
#import <LibProjView/CheckRoomPermissions.h>
#import <LibProjView/CollectionWaterfallLayout.h>

#import <LibProjView/CheckRoomPermissions.h>
#import <LibProjView/EmptyView.h>


@interface HomeLiveShoppingViewController ()<UICollectionViewDelegate,UICollectionViewDataSource,UIScrollViewDelegate,HomeLiveShoppingHeaderDelegate,CollectionWaterfallLayoutDelegate>


@property (nonatomic, strong)HomeLiveShoppingHeader *header;
@property (nonatomic, strong)CollectionWaterfallLayout *waterfallLayout;
@property (nonatomic, weak)UICollectionView *weakCollView;
@property (nonatomic, weak) EmptyView *weakEmptyV;

@property(nonatomic,assign)BOOL isPush;//是否是push
@property(nonatomic,assign)int page;

@property(nonatomic,strong)NSMutableArray *infoMuArray;

@end


@implementation HomeLiveShoppingViewController

- (NSMutableArray *)infoMuArray{
    if (!_infoMuArray) {
        _infoMuArray = [NSMutableArray array];
    }
    return _infoMuArray;
}

-(void)createEmptyView{
    EmptyView *empty = [[EmptyView alloc] initWithFrame:CGRectMake(0, (kScreenHeight-200)/2.0, kScreenWidth, 200)];
    empty.iconImgV.image = [UIImage imageNamed:@"home_guangchang_meiyouzhubo"];
    empty.titleL.text = kLocalizationMsg(@"暂时没有内容");
    [self.weakCollView addSubview:empty];
    empty.hidden = YES;
    self.weakEmptyV = empty;
}

- (CollectionWaterfallLayout *)waterfallLayout{
    if (!_waterfallLayout) {
        _waterfallLayout = [[CollectionWaterfallLayout alloc] init];
        _waterfallLayout.delegate = self;
    }
    return _waterfallLayout;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    UICollectionView *collectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(0,0, kScreenWidth,  kScreenHeight-kNavBarHeight-kTabBarHeight) collectionViewLayout:self.waterfallLayout];
    collectionView.backgroundColor = [UIColor whiteColor];
    [collectionView registerClass:[LiveVideoCollectionViewCell class] forCellWithReuseIdentifier:@"LiveVideoCollectionViewCell"];
    _weakCollView = collectionView;
    [self.view addSubview:_weakCollView];
    
    [self createEmptyView];
    
    if (kiOS11) {
        _weakCollView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    } else {
        self.automaticallyAdjustsScrollViewInsets = NO;
    }
    
    self.weakCollView.delegate = self;
    self.weakCollView.dataSource = self;
    
    [self.weakCollView registerClass:[HomeLiveShoppingHeader class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"HomeLiveShoppingHeaderId"];
    CGFloat scale = 244/360.0;
    CGFloat height = kScreenWidth *scale;
    self.waterfallLayout.headerReferenceSize = CGSizeMake(kScreenWidth, height);
    
    kWeakSelf(self);
    self.weakCollView .mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [weakself loadData:YES];
    }];
    self.weakCollView .mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        [weakself loadData:NO];
    }];

}


#pragma mark - 请求数据
- (void)loadData:(BOOL)isRefresh{
    kWeakSelf(self);
    [self loadLiveAnnounceDataCallBack:^(BOOL success) {
        [weakself loadListData:isRefresh];
    }];
}


- (void)loadListData:(BOOL)isRefresh{
    if (isRefresh) {
        self.page = 0;
    }else{
        self.page ++;
    }
    Home_getHomeDataList *list = [[Home_getHomeDataList alloc]init];
    list.pageIndex = self.page;
    list.pageSize = kPageSize;
    list.channelId = -1;
    list.hotSortId = -1;
    list.liveFunction = 1;
    list.sex =  0;
    list.address = @"";
    list.tabIds =  @"";
    list.liveType = 1;
    list.isRecommend = -1;
    list.isLive = -1;
    kWeakSelf(self);
    [HttpApiHome getHomeDataList:list callback:^(int code, NSString *strMsg, NSArray<AppHomeHallDTOModel *> *arr) {
        if (code == 1) {
            [weakself.weakCollView.mj_header endRefreshing];
            [weakself.weakCollView.mj_footer endRefreshing];
            if (isRefresh) {
                [weakself.infoMuArray removeAllObjects];
            }
            if (arr.count < 20) {
                [weakself.weakCollView.mj_footer endRefreshingWithNoMoreData];
            }
            if (arr.count > 0) {
                [weakself.infoMuArray addObjectsFromArray:arr];
            }
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [self.weakCollView reloadData];
            });
        }else{
            [weakself.weakCollView.mj_header endRefreshing];
            [weakself.weakCollView.mj_footer endRefreshing];
            [SVProgressHUD showInfoWithStatus:strMsg];
        }
        weakself.weakEmptyV.hidden = weakself.infoMuArray.count;
    }];
}
- (void)loadLiveAnnounceDataCallBack:(void(^)(BOOL success))callback{
    kWeakSelf(self);
    [HttpApiShopBusiness getLiveAnnouncementList:^(int code, NSString *strMsg, NSArray<ShopLiveAnnouncementDetailDTOModel *> *arr) {
        if (code == 1 && arr.count > 0) {
            CGFloat scale = 244/360.0;
            CGFloat height = kScreenWidth *scale;
            weakself.waterfallLayout.headerReferenceSize = CGSizeMake(kScreenWidth,height);
            weakself.header.arr = arr;
            weakself.weakEmptyV.y = height+20;
            callback(YES);
            
        }else{
            weakself.header.arr = @[];
            weakself.weakEmptyV.y = (kScreenHeight-200)/2.0;
            weakself.waterfallLayout.headerReferenceSize = CGSizeMake(kScreenWidth,0);
            callback(NO);
        }
    }];
    
}
#pragma mark - UICollectionViewDelegate dataSource
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.infoMuArray.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    LiveVideoCollectionViewCell *cell = (LiveVideoCollectionViewCell *)[collectionView dequeueReusableCellWithReuseIdentifier:@"LiveVideoCollectionViewCell" forIndexPath:indexPath];
    cell.model = (indexPath.row < self.infoMuArray.count)?self.infoMuArray[indexPath.row]:nil;
    return cell;
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath{
    if (kind == UICollectionElementKindSectionHeader) {//直播首页
        HomeLiveShoppingHeader*headerView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"HomeLiveShoppingHeaderId" forIndexPath:indexPath ];
        self.header = headerView;
        headerView.delegate = self;
        return headerView;
    }
    return nil;
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    if (self.infoMuArray.count > indexPath.row) {
        [collectionView deselectItemAtIndexPath:indexPath animated:YES];
        AppHomeHallDTOModel *model = self.infoMuArray[indexPath.row];
        self.isPush = YES;
        [self videoLiveRoomJump:model];
    }
}

///进入直播间
- (void)videoLiveRoomJump:(AppHomeHallDTOModel*)model{
    kWeakSelf(self);
    [[CheckRoomPermissions share] joinRoom:model.roomId liveDataType:model.liveType joinRoom:^(AppJoinRoomVOModel * _Nonnull joinModel) {
        [[CheckRoomPermissions share] joinRoomForModel:joinModel currentVC:[ProjConfig currentVC] otherInfo:nil];
    } closeRoom:^(AppHomeHallDTOModel * _Nonnull dtoModel) {
        [[CheckRoomPermissions share] showDetail:dtoModel currentVC:weakself];
    } fail:nil];
}


#pragma mark - HomeLiveShoppingHeaderDelegate
- (void)HomeLiveShoppingHeader:(HomeLiveShoppingHeader *)header itemClick:(ShopLiveAnnouncementDetailDTOModel *)model{
    kWeakSelf(self);
    if (model.roomId > 0) {
        [[CheckRoomPermissions share] joinRoom:model.roomId liveDataType:LiveTypeForMPVideo joinRoom:^(AppJoinRoomVOModel * _Nonnull joinModel) {
            [[CheckRoomPermissions share] joinRoomForModel:joinModel currentVC:[ProjConfig currentVC] otherInfo:nil];
        } closeRoom:^(AppHomeHallDTOModel * _Nonnull dtoModel) {
            [[CheckRoomPermissions share] showDetail:dtoModel currentVC:weakself];
        } fail:nil];
    }else{
        [RouteManager routeForName:RN_user_userInfoVC currentC:self parameters:@{@"id":@(model.anchorId)}];
    }
}

#pragma mark - JXCategoryListContentViewDelegate
- (UIView *)listView {
    return self.view;
}
- (void)listWillAppear{
    if (!self.isPush) {
        [self loadData:YES];
    }
    self.isPush = NO;
}


#pragma mark - CollectionWaterfallLayoutDelegate

- (CGFloat)waterFallLayout:(CollectionWaterfallLayout *)waterFallLayout heightForItemAtIndexPath:(NSInteger)indexPath itemWidth:(CGFloat)itemWidth{
    NSIndexPath *path = [NSIndexPath indexPathForRow:indexPath inSection:0];
    CGFloat height = 0.0f;
    if (path.row < self.infoMuArray.count) {
        height = [self getCellHeight];
    }
    return height;
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
    return 5.0;
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
    return UIEdgeInsetsMake(0, 5, 0, 5);
}


- (CGFloat)getCellHeight{
    CGFloat screenW = [UIScreen mainScreen].bounds.size.width;
    CGFloat width = (screenW-4)/2.0;//一行两个cell
    CGFloat scale = 1.0f;//   高度/宽度 的比例
    return scale*width;
}

@end
