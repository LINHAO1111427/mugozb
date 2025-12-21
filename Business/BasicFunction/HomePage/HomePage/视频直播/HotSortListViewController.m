//
//  HotSortListViewController.m
//  MPVideoLive
//
//  Created by ssssssss on 2020/1/10.
//  Copyright © 2020 Orely. All rights reserved.
//

#import "HotSortListViewController.h"
 
#import <LibProjModel/AppHotSortModel.h>
#import <LibProjView/CheckRoomPermissions.h>
#import <LibProjView/CollectionWaterfallLayout.h>
#import <LibProjView/LiveVideoCollectionViewCell.h>
#import <LibProjView/EmptyView.h>

static NSString *homeCell = @"homeCell";
static NSString *onebyCell = @"onebyCell";
static NSString *dynamicCell = @"dynamicCell";
@interface HotSortListViewController ()<
UICollectionViewDelegate,
UICollectionViewDataSource,
CollectionWaterfallLayoutDelegate
>
@property (nonatomic, strong) NSMutableDictionary *homeCellDic;//重用标示
@property(nonatomic,strong)NSMutableArray *infoMuArray;
@property(nonatomic,strong)UICollectionView *collectionView;
@property (nonatomic, weak)EmptyView *weakEmptyV;
@property(nonatomic,assign)int page;
@property (nonatomic, strong) CollectionWaterfallLayout *waterfallLayout;
@end

@implementation HotSortListViewController
- (NSMutableDictionary *)homeCellDic{
    if (!_homeCellDic) {
        _homeCellDic = [NSMutableDictionary dictionary];
    }
    return _homeCellDic;
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
- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    [self loadData:YES];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = self.model.name;
    self.navigationController.navigationBar.shadowImage = nil;
    self.view.backgroundColor = [UIColor whiteColor];
    UICollectionView *collectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(0,0, kScreenWidth,  kScreenHeight-kNavBarHeight) collectionViewLayout:self.waterfallLayout];
    collectionView.delegate   = self;
    collectionView.dataSource = self;
    collectionView.backgroundColor = [UIColor whiteColor];
    _collectionView = collectionView;
    [self.view addSubview:_collectionView];
    
    kWeakSelf(self);
    _collectionView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [weakself loadData:YES];
    }];
    _collectionView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        [weakself loadData:NO];
    }];
    _collectionView.mj_footer.ignoredScrollViewContentInsetBottom = kISiPhoneXX ? 34 : 0;
    
    [self emptyView];
}

-(void)emptyView{
    EmptyView *empty = [[EmptyView alloc] init];
    empty.titleL.text = kLocalizationMsg(@"暂时没有内容");
    empty.detailL.text = kLocalizationMsg(@"请到其他分类看看");
    [empty showInView:self.collectionView];
    _weakEmptyV = empty;
}

- (void)loadData:(BOOL)isRefresh{
    if (isRefresh) {
        self.page = 0;
    }else{
        self.page ++;
    }
    Home_getHomeDataList *list = [[Home_getHomeDataList alloc]init];
    list.pageIndex = self.page;
    list.pageSize = kPageSize;
    list.channelId = -1;
    list.hotSortId = self.model.id_field;
    list.sex = -1;
    list.address =@"";
    list.tabIds = @"";
    list.liveType = 1;
    list.isRecommend = -1;
    list.isLive = -1;
    kWeakSelf(self);
    [HttpApiHome getHomeDataList:list callback:^(int code, NSString *strMsg, NSArray<AppHomeHallDTOModel *> *arr) {
        if (code == 1) {
            [weakself.collectionView.mj_header endRefreshing];
            [weakself.collectionView.mj_footer endRefreshing];
            if (isRefresh) {
                [weakself.infoMuArray removeAllObjects];
            }
            if (arr.count < 20) {
                 [weakself.collectionView.mj_footer endRefreshingWithNoMoreData];
            }
            if (arr.count > 0) {
                [weakself.infoMuArray addObjectsFromArray:arr];
            }
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [self.collectionView reloadData];
            });
        }else{
            [weakself.collectionView.mj_header endRefreshing];
            [weakself.collectionView.mj_footer endRefreshing];
            [SVProgressHUD showInfoWithStatus:strMsg];
        }
        weakself.weakEmptyV.hidden = weakself.infoMuArray.count;
    }];
    
}
#pragma mark - collectionview
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.infoMuArray.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    AppHomeHallDTOModel *model = self.infoMuArray[indexPath.row];
    NSString *identifier = [self.homeCellDic objectForKey:[NSString stringWithFormat:@"%@", indexPath]];
    if(identifier == nil){
        identifier = [NSString stringWithFormat:@"%@%@",homeCell, [NSString stringWithFormat:@"%@",indexPath]];
        [self.homeCellDic setObject:identifier forKey:[NSString  stringWithFormat:@"%@",indexPath]];
       [self.collectionView registerClass:[LiveVideoCollectionViewCell class] forCellWithReuseIdentifier:identifier];
    }
    LiveVideoCollectionViewCell *cell = (LiveVideoCollectionViewCell *)[collectionView dequeueReusableCellWithReuseIdentifier:identifier forIndexPath:indexPath];
    cell.model = model;
    return cell;
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    [collectionView deselectItemAtIndexPath:indexPath animated:YES];
    AppHomeHallDTOModel *model = self.infoMuArray[indexPath.row];
    //检查房间
    kWeakSelf(self);
    //检查房间 加入直播间
    [[CheckRoomPermissions share] joinRoom:model.roomId liveDataType:model.liveType joinRoom:^(AppJoinRoomVOModel * _Nonnull joinModel) {
        LiveRoomListReqParam *req = [[LiveRoomListReqParam alloc] init];
        req.dataIndex = indexPath.row;
        req.joinPosition = 2;
        req.hotSortId = weakself.model.id_field;
        [[CheckRoomPermissions share] joinRoomForModel:joinModel currentVC:weakself otherInfo:req];
    } closeRoom:^(AppHomeHallDTOModel * _Nonnull dtoModel) {
        [[CheckRoomPermissions share] showDetail:dtoModel currentVC:weakself];
    } fail:nil];
}

#pragma mark - CollectionWaterfallLayoutDelegate
- (CGFloat)waterFallLayout:(CollectionWaterfallLayout *)waterFallLayout heightForItemAtIndexPath:(NSInteger)indexPath itemWidth:(CGFloat)itemWidth{
    CGFloat height = [self getCellHeight];
    return height;
}
- (CGFloat)getCellHeight{
    CGFloat screenW = [UIScreen mainScreen].bounds.size.width;
    CGFloat width = (screenW-4)/2.0;//一行两个cell
    CGFloat scale = 1.0f;
    return scale*width;
}
@end
