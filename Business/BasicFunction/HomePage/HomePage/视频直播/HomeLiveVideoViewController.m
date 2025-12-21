//
//  HomeLiveVideoViewController.m
//  HomePage
//
//  Created by klc on 2020/6/5.
//  Copyright © 2020 klc. All rights reserved.
//

#import "HomeLiveVideoViewController.h"
#import <LibProjModel/HttpApiAppLogin.h>
#import <LibProjModel/AdminLiveConfigModel.h>
#import <LibProjModel/AppAdsModel.h>
#import <LibProjModel/HttpApiHome.h>
#import <MJRefresh/MJRefresh.h>
#import <LibProjBase/AppRouteName.h>
#import <LibProjBase/RouteManager.h>
#import <LibProjView/CheckRoomPermissions.h>
#import <LibProjView/CollectionWaterfallLayout.h>
#import <LibProjView/CheckRoomPermissions.h>
#import "HomeSquareHeaderView.h"
#import <libProjView/LiveVideoCollectionViewCell.h>
#import "HomeLiveVideoItemCell.h"
#import <HomePage/HotSortListViewController.h>
#import <LibProjView/EmptyView.h>
#import <LibProjView/PublicMethodObj.h>

@interface HomeLiveVideoViewController ()<UICollectionViewDelegate, UICollectionViewDataSource, CollectionWaterfallLayoutDelegate, HomeSquareHeaderViewDelegate>

@property (nonatomic, strong)HomeSquareHeaderView *headerV;

@property (nonatomic, weak)CollectionWaterfallLayout *layout;

@property (nonatomic, weak)UICollectionView *weakCollView;

@property (nonatomic, strong)NSMutableArray *allMuArray;

@property (nonatomic, assign)CGFloat headerHeight;

@property (nonatomic,assign)int64_t channelId;

@property (nonatomic, weak)EmptyView *weakEmptyV;

@end

@implementation HomeLiveVideoViewController

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
}

- (EmptyView *)weakEmptyV{
    if (!_weakEmptyV) {
        EmptyView *emptyV = [[EmptyView alloc] init];
        emptyV.iconImgV.image = [UIImage imageNamed:@"home_guangchang_meiyouzhubo"];
        emptyV.titleL.text = kLocalizationMsg(@"此分类没有主播上线哦，去其他分类找找吧～");
        emptyV.hidden = YES;
        [self.weakCollView addSubview:emptyV];
        _weakEmptyV = emptyV;
        [emptyV mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(self.weakCollView);
            make.centerY.equalTo(self.weakCollView).offset(self.headerHeight*0.75);
            make.size.mas_equalTo(CGSizeMake(200, 200));
        }];
        [emptyV layoutIfNeeded];
    }
    return _weakEmptyV;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.weakCollView.delegate = self;
    self.weakCollView.dataSource = self;
    kWeakSelf(self);
    self.weakCollView .mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [weakself loadListData:YES];
    }];
    self.weakCollView .mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        [weakself loadListData:NO];
    }];
    
    [self loadChannelData];
}

///获取频道信息
- (void)loadChannelData{
    kWeakSelf(self);
    ///type 类型 1:直播 2:语音 3:1v1 4:电台 5:派对 6:短视频 7:动态
    [HttpApiHome getHomeSquareLiveHeader:self.liveType callback:^(int code, NSString *strMsg, HomeDtoModel *model) {
        if (code == 1) {
            weakself.headerV.dtoModel = model;
            [weakself.weakCollView reloadData];
        }else{
            weakself.weakEmptyV.hidden = NO;
            weakself.weakEmptyV.detailL.text = strMsg;
        }
    }];
}

- (UICollectionView *)weakCollView{
    if (!_weakCollView) {
        CollectionWaterfallLayout *waterfallLayout = [[CollectionWaterfallLayout alloc] init];
        waterfallLayout.delegate = self;
        waterfallLayout.scrollDirection = UICollectionViewScrollDirectionVertical;
        waterfallLayout.headerReferenceSize = CGSizeMake(kScreenWidth,_headerHeight);
        waterfallLayout.footerReferenceSize = CGSizeMake(0, 0);
        _layout = waterfallLayout;
        UICollectionView *collV = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:waterfallLayout];
        collV.dataSource = self;
        collV.delegate = self;
        collV.backgroundColor = [UIColor whiteColor];
        [collV registerClass:[HomeSquareHeaderView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"HomeSquareHeaderView"];
        [collV registerClass:[LiveVideoCollectionViewCell class] forCellWithReuseIdentifier:@"LiveVideoCollectionViewCell"];
        [collV registerClass:[HomeLiveVideoItemCell class] forCellWithReuseIdentifier:@"HomeLiveVideoItemCell"];
        [self.view addSubview:collV];
        _weakCollView = collV;
        [collV mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(self.view);
            make.top.left.right.equalTo(self.view);
            make.bottom.equalTo(self.view).mas_offset(-kNavBarHeight-kTabBarHeight);
        }];
        [collV layoutIfNeeded];
    }
    return _weakCollView;
}

- (NSMutableArray *)allMuArray{
    if (!_allMuArray) {
        _allMuArray = [[NSMutableArray alloc] init];
    }
    return _allMuArray;
}

#pragma mark - 加载数据
- (void)loadListData:(BOOL)isRefresh{
    if (self.channelId == 0) {
        [self loadChannelData];
        [_weakCollView.mj_header endRefreshing];
        [_weakCollView.mj_footer endRefreshing];
        return;
    }
    [_headerV reloadAdData];
    
    Home_getHomeDataList *list = [[Home_getHomeDataList alloc]init];
    list.pageSize = kPageSize;
    list.pageIndex = isRefresh?0:(int)self.allMuArray.count/kPageSize  + (self.allMuArray.count%kPageSize?1:0);;
    list.channelId = self.channelId;
    list.hotSortId = -1;
    list.sex = -1;
    list.address = @"";
    list.tabIds = @"";
    list.liveType = self.liveType;
    list.isRecommend = -1;
    list.isLive = -1;
    kWeakSelf(self);
    [HttpApiHome getHomeDataList:list callback:^(int code, NSString *strMsg, NSArray<AppHomeHallDTOModel *> *arr) {
        [weakself.weakCollView.mj_header endRefreshing];
        [weakself.weakCollView.mj_footer endRefreshing];
        if (code == 1) {
            if (isRefresh) {
                [weakself.allMuArray removeAllObjects];
            }
            if (arr.count < 20) {
                [weakself.weakCollView.mj_footer endRefreshingWithNoMoreData];
            }
            if (arr.count > 0) {
                [weakself.allMuArray addObjectsFromArray:arr];
            }
        }else{
            [weakself.weakCollView.mj_header endRefreshing];
            [weakself.weakCollView.mj_footer endRefreshing];
            [SVProgressHUD showInfoWithStatus:strMsg];
            
        }
        [weakself.weakCollView reloadData];
        weakself.weakEmptyV.hidden = weakself.allMuArray.count;
    }];
}

//获取header的collection直播列表

#pragma mark - UICollectionViewDelegate dataSource
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    if (self.allMuArray.count == 0) {
        return 4;
    }else{
        return self.allMuArray.count;
    }
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    LiveVideoCollectionViewCell *cell = (LiveVideoCollectionViewCell *)[collectionView dequeueReusableCellWithReuseIdentifier:@"LiveVideoCollectionViewCell" forIndexPath:indexPath];
    if (self.allMuArray.count == 0) {
        cell.contentView.hidden = YES;
    }else{
        cell.contentView.hidden = NO;
        cell.model = (self.allMuArray.count > indexPath.item)?self.allMuArray[indexPath.row]:nil;
    }
    return cell;
}


-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    [collectionView deselectItemAtIndexPath:indexPath animated:YES];
    if (self.allMuArray.count > indexPath.item) {
        AppHomeHallDTOModel *model = self.allMuArray[indexPath.row];
        kWeakSelf(self);
        [[CheckRoomPermissions share] joinRoom:model.roomId liveDataType:model.liveType joinRoom:^(AppJoinRoomVOModel * _Nonnull joinModel) {
            LiveRoomListReqParam *req = [[LiveRoomListReqParam alloc] init];
            req.dataIndex = indexPath.item;
            req.channelId = self.channelId;
            req.joinPosition = (self.liveType==1)?2:3;
            [[CheckRoomPermissions share] joinRoomForModel:joinModel currentVC:weakself otherInfo:req];
        } closeRoom:^(AppHomeHallDTOModel * _Nonnull dtoModel) {
            [[CheckRoomPermissions share] showDetail:dtoModel currentVC:weakself];
        } fail:nil];
    }
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath{
    if (kind == UICollectionElementKindSectionHeader) {//直播首页
        HomeSquareHeaderView *headerV = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:@"HomeSquareHeaderView" forIndexPath:indexPath];
        headerV.delegate = self;
        headerV.liveType = self.liveType;
        _headerV = headerV;
        return headerV;
    }
    return nil;
}

#pragma mark - CollectionWaterfallLayoutDelegate
- (CGFloat)waterFallLayout:(CollectionWaterfallLayout *)waterFallLayout heightForItemAtIndexPath:(NSInteger)indexPath itemWidth:(CGFloat)itemWidth{
    return [self getCellHeight];
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
    return 5.0f;
}

/**
 * 每行之间的间距
 */
- (CGFloat)rowMarginInWaterFallLayout:(CollectionWaterfallLayout *)waterFallLayout{
    return 5.0f;
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
    CGFloat scale = 1.0f;
    return scale*width;
}
#pragma mark - JXCategoryListContentViewDelegate
- (UIView *)listView {
    return self.view;
}

- (void)listWillAppear{
    
}

- (void)listDidAppear{
    [_headerV startTimer];
}
- (void)listWillDisappear{
    [_headerV stopTimer];
}
#pragma mark - QYLiveMainHeaderViewDelegate

///视图高度
- (void)changeHeaderViewHeight:(CGFloat)height{
    if (_headerHeight != height) {
        _headerHeight = height;
        _layout.headerReferenceSize = CGSizeMake(kScreenWidth,height);
        [self.weakEmptyV mas_updateConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self.weakCollView).offset(height*0.75);
        }];
        [self.weakEmptyV layoutIfNeeded];
    }
}

///选择某一个频道
- (void)LiveMainHeaderSelectType:(int64_t)channelId{
    _channelId = channelId;
    [_weakEmptyV removeFromSuperview];
    [_weakCollView.mj_header endRefreshing];
    [_weakCollView.mj_footer endRefreshing];
    [self loadListData:YES];
}

///点击第几个广告
- (void)clickAdvertising:(NSString *)adverUrl {
    if (adverUrl.length != 0 && adverUrl != nil && adverUrl != NULL ) {
        [PublicMethodObj showUrl:adverUrl];
    }
}


- (void)hotSortSelectedIndex:(NSInteger)index hotSortModel:(AppHotSortModel *)model{
    HotSortListViewController *listVc = [[HotSortListViewController alloc]init];
    listVc.model = model;
    [self.navigationController pushViewController:listVc animated:YES];
}


@end
