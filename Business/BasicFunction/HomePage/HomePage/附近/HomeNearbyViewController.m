//
//  HomeNearbyViewController.m
//  HomePage
//
//  Created by klc on 2020/6/5.
//  Copyright © 2020 klc. All rights reserved.
//

#import "HomeNearbyViewController.h"

#import <LibProjModel/KLCAppConfig.h>
#import <LibProjModel/HttpApiAppLogin.h>
#import <LibProjModel/APPConfigModel.h>
#import <LibProjModel/HttpApiHome.h>
#import <LibProjModel/AdminLiveConfigModel.h>
#import <LibProjModel/AppHomeHallDTOModel.h>

#import <LibProjView/HomeCarouselHeaderView.h>
#import <LibProjView/CollectionWaterfallLayout.h>
#import <LibProjView/LiveVideoCollectionViewCell.h>
#import <LibProjView/HomeOneByCollectionViewCell.h>

#import <LibTools/LibTools.h>
#import <LibProjBase/LibProjBase.h>
#import <LibProjView/EmptyView.h>
#import <LibProjView/CheckRoomPermissions.h>

#import <MJRefresh/MJRefresh.h>
#import <LibProjView/PublicMethodObj.h>
#import "JXCategoryView.h"


@interface HomeNearbyViewController ()<UICollectionViewDelegate,UICollectionViewDataSource,HomeCarouselHeaderViewDelegate,UIScrollViewDelegate,CollectionWaterfallLayoutDelegate>

@property (nonatomic, strong) CollectionWaterfallLayout *waterfallLayout;
@property(nonatomic,weak)UICollectionView *weakCollView;
@property (nonatomic, weak)EmptyView *weakEmptyV;

@property(nonatomic,assign)BOOL isPush;//是否是push
@property(nonatomic,assign)int page;

@property(nonatomic,strong)NSMutableArray *infoMuArray;
@property(nonatomic,strong)NSMutableArray *sliderArray;

@end

@implementation HomeNearbyViewController
#pragma mark - 懒加载
- (CollectionWaterfallLayout *)waterfallLayout{
    if (!_waterfallLayout) {
        _waterfallLayout = [[CollectionWaterfallLayout alloc] init];
        _waterfallLayout.delegate = self;
    }
    return _waterfallLayout;
}
- (NSMutableArray *)sliderArray{
    if (!_sliderArray) {
        _sliderArray = [NSMutableArray array];
    }
    return _sliderArray;
}
- (NSMutableArray *)infoMuArray{
    if (!_infoMuArray) {
        _infoMuArray = [NSMutableArray array];
    }
    return _infoMuArray;
}
 
-(void)emptyView{
    EmptyView *empty = [[EmptyView alloc] init];
    empty.iconImgV.image = [UIImage imageNamed:@"home_guangchang_meiyouzhubo"];
    empty.titleL.text = kLocalizationMsg(@"暂时没有内容");
    [empty showInView:self.weakCollView];
    self.weakEmptyV = empty;
}
 
#pragma mark - 初始化
- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
}
 
- (void)dealloc{
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    _waterfallLayout = [[CollectionWaterfallLayout alloc] init];
    _waterfallLayout.delegate = self;
    _waterfallLayout.headerReferenceSize = CGSizeMake(kScreenWidth, [HomeCarouselHeaderView viewHeight]);
    
    UICollectionView *collectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(0,0, kScreenWidth,  kScreenHeight-kNavBarHeight-kTabBarHeight) collectionViewLayout:self.waterfallLayout];
    collectionView.backgroundColor = [UIColor whiteColor];
    collectionView.delegate = self;
    collectionView.dataSource = self;
    [collectionView registerClass:[HomeOneByCollectionViewCell class] forCellWithReuseIdentifier:@"HomeOneByCollectionViewCell"];
    [collectionView registerClass:[LiveVideoCollectionViewCell class] forCellWithReuseIdentifier:@"LiveVideoCollectionViewCell"];
    [collectionView registerClass:[HomeCarouselHeaderView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"carouselId"];
    [self.view addSubview:collectionView];
    _weakCollView = collectionView;

    [self emptyView];
    if (kiOS11) {
        _weakCollView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    } else {
        self.automaticallyAdjustsScrollViewInsets = NO;
    }
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
    //0 启动 1直播 2 推荐 3附近
    [self loadSliderData:3 callBack:^(BOOL success) {
         [weakself loadListData:isRefresh];
     }];
}
//logicType：业务类型 -1:所有/推荐 0:直播 1：语音直播  2：一对一  3：动态
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
    list.sex =  -1;
    list.address = self.address.length > 0?self.address:@"";
    list.tabIds =  @"";
    list.liveType = -1;
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
- (void)loadSliderData:(int)type callBack:(void(^)(BOOL success))callback{
    kWeakSelf(self);
    [HttpApiAppLogin adslist:4 type:13 callback:^(int code, NSString *strMsg, NSArray<AppAdsModel *> *arr) {
        [weakself.sliderArray removeAllObjects];
        if (code == 1) {
            if (arr.count > 0) {
                self.waterfallLayout.headerReferenceSize = CGSizeMake(kScreenWidth, [HomeCarouselHeaderView viewHeight]);
            }else{
                self.waterfallLayout.headerReferenceSize = CGSizeMake(kScreenWidth, 0);
            }
            weakself.sliderArray = [NSMutableArray arrayWithArray:arr];
            callback(YES);
        }else{
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
    if (self.infoMuArray.count > indexPath.row) {
        ///类型 1:直播 2:语音 3:1v1 4:电台 5:派对 6:短视频 7:动态
        AppHomeHallDTOModel *model = self.infoMuArray[indexPath.row];
        switch (model.liveType) {
            case 1: //视频
            case 2: //语音
            {
                LiveVideoCollectionViewCell *cell = (LiveVideoCollectionViewCell *)[collectionView dequeueReusableCellWithReuseIdentifier:@"LiveVideoCollectionViewCell" forIndexPath:indexPath];
                cell.model = model;
                return cell;
            }
                break;
            case 3: ///一对一
            default: ///一对一
            {
                HomeOneByCollectionViewCell *cell = (HomeOneByCollectionViewCell *)[collectionView dequeueReusableCellWithReuseIdentifier:@"HomeOneByCollectionViewCell" forIndexPath:indexPath];
                cell.model = model;
                return cell;
            }
                break;
        }
        
        
    }else{
        ///无值默认显示用户信息
        HomeOneByCollectionViewCell *cell = (HomeOneByCollectionViewCell *)[collectionView dequeueReusableCellWithReuseIdentifier:@"HomeOneByCollectionViewCell" forIndexPath:indexPath];
        cell.model = (self.infoMuArray.count > indexPath.row)?self.infoMuArray[indexPath.row]:nil;
        return cell;
    }
}
 
 
- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath{
    if (kind == UICollectionElementKindSectionHeader) {
        HomeCarouselHeaderView*headerView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"carouselId" forIndexPath:indexPath];
        headerView.sliderArray = self.sliderArray;
        headerView.delegate = self;
       // NSLog(@"过滤文字UICollectionReusableView header 轮播"));
        return headerView;
    }
    return nil;
}
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    [collectionView deselectItemAtIndexPath:indexPath animated:YES];

    if (self.infoMuArray.count > indexPath.row) {
        AppHomeHallDTOModel *model = self.infoMuArray[indexPath.row];;
        self.isPush = YES;
        switch (model.liveType) {
            case 1: //视频
            case 2: //语音
            {
                [self liveRoomJump:model index:indexPath.row];
            }
                break;
            case 6: ///短视频
            {
                NSDictionary *prams = @{
                    @"dataType":@(5),
                    @"index":@(0),
                    @"shortVideoId":model.showid
                };
                [RouteManager routeForName:RN_shortVideo_play_List currentC:self parameters:prams];
            }
                break;
            default: ///一对一
            {
                [RouteManager routeForName:RN_user_userInfoVC currentC:self parameters:@{@"id":@(model.userId)}];
            }
                break;
        }
    }
}
 

#pragma mark - HomeCarouselHeaderView 轮播图
- (void)HomeCarouselHeaderView:(HomeCarouselHeaderView *)headerviewView withModel:(AppAdsModel *)model{
    if (model.url.length != 0 && model.url != nil && model.url != NULL ) {
        self.isPush = YES;
        [PublicMethodObj showUrl:model.url];
    }
}
 
- (NSInteger)getLiveType:(NSIndexPath *)indexPath{
    NSInteger liveType;
    id typeModel = self.infoMuArray[indexPath.row];
    if ([typeModel isKindOfClass:[HomeO2ODataModel class]]) {//一对一大图
        HomeO2ODataModel *OTOBigModel = (HomeO2ODataModel *)typeModel;
        liveType = OTOBigModel.liveType;
    }else{
        AppHomeHallDTOModel *mod = (AppHomeHallDTOModel *)typeModel;
        liveType = mod.liveType;
    }
    if (liveType == 0) {
        liveType = 3;
    }
    return liveType;
}

- (void)liveRoomJump:(AppHomeHallDTOModel*)model index:(NSInteger)index{
    kWeakSelf(self);
    [[CheckRoomPermissions share] joinRoom:model.roomId liveDataType:model.liveType joinRoom:^(AppJoinRoomVOModel * _Nonnull joinModel) {
        LiveRoomListReqParam *req = [[LiveRoomListReqParam alloc] init];
        req.dataIndex = index;
        req.joinPosition = 6;
        req.address = weakself.address;
        [[CheckRoomPermissions share] joinRoomForModel:joinModel currentVC:weakself otherInfo:req];
    } closeRoom:^(AppHomeHallDTOModel * _Nonnull dtoModel) {
        [[CheckRoomPermissions share] showDetail:dtoModel currentVC:weakself];
    } fail:nil];
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
    int liveType = 3;//默认一对一
    CGFloat height = 0.0f;
    if (path.row < self.infoMuArray.count) {
        liveType = (int)[self getLiveType:path];
        height = [self getCellHeightForLiveType:liveType isO2OBig:NO];
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

- (CGFloat)getCellHeightForLiveType:(int)liveType isO2OBig:(BOOL)isOTOBig{
    CGFloat screenW = [UIScreen mainScreen].bounds.size.width;
    CGFloat width = (screenW-4)/2.0;//一行两个cell
    CGFloat scale = 1.0f;//   高度/宽度 的比例
    if (liveType == 1) {//直播
        scale = 1.0;
    }else if(liveType == 2){//语音直播
        scale = 1.0;
    }else if(liveType == 3){//1v1
        if (isOTOBig) {//大图
            return screenW;
        }else{//小图
            scale = 1.0;
        }
    }else if(liveType == 6){//短视频
        scale = 290/178.0;
    }
    return scale*width;
}
 
@end
