//
//  SVSortListViewController.m
//  ShortVideo
//
//  Created by ssssssss on 2020/6/17.
//  Copyright © 2020 KLC. All rights reserved.
//

#import "SVSortListViewController.h"
#import <LibProjView/CollectionWaterfallLayout.h>
#import <LibProjView/SVSortCollectionViewCell.h>
#import <LibProjModel/HttpApiAppShortVideo.h>
#import <LibProjModel/ApiShortVideoDtoModel.h>
#import <LibProjView/EmptyView.h>


@interface SVSortListViewController ()<
UICollectionViewDelegate,
UICollectionViewDataSource,
CollectionWaterfallLayoutDelegate
>
@property(nonatomic,strong)NSMutableArray *infoMuArray;
@property(nonatomic,strong)UICollectionView *collectionView;
@property (nonatomic, weak)EmptyView *weakEmptyV;
@property(nonatomic,assign)int page;
@property (nonatomic, strong) CollectionWaterfallLayout *waterfallLayout;
@end

@implementation SVSortListViewController


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
    self.page = 0;
    self.navigationItem.title = self.titleName;
    self.navigationController.navigationBar.shadowImage = nil;
    self.navigationController.navigationBar.translucent = NO;
    self.view.backgroundColor = [UIColor whiteColor];
    UICollectionView *collectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(0,0, kScreenWidth,  kScreenHeight-kNavBarHeight) collectionViewLayout:self.waterfallLayout];
    collectionView.delegate   = self;
    collectionView.dataSource = self;
    collectionView.backgroundColor = [UIColor whiteColor];
    [collectionView registerClass:[SVSortCollectionViewCell class] forCellWithReuseIdentifier:@"shortVideoSortCell"];
    _collectionView = collectionView;
    [self.view addSubview:_collectionView];
    
    kWeakSelf(self);
    _collectionView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        self.page = 0;
        [weakself loadData:YES];
    }];
    _collectionView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        self.page ++;
        [weakself loadData:NO];
    }];
    _collectionView.mj_footer.ignoredScrollViewContentInsetBottom = kISiPhoneXX ? 34 : 0;
    
    [self emptyView];
}

-(void)emptyView{
    EmptyView *empty = [[EmptyView alloc] init];;
    empty.titleL.text = kLocalizationMsg(@"暂时没有内容");
    if (self.classifyId > 0) {
        empty.detailL.text = kLocalizationMsg(@"请到其他分类看看");
    }else{
        empty.detailL.text = kLocalizationMsg(@"请到其他地方看看");
    }
    
    [empty showInView:self.collectionView];
    _weakEmptyV = empty;
}

- (void)loadData:(BOOL)refresh{
    if (refresh) {
        [self.infoMuArray removeAllObjects];
    }
    kWeakSelf(self);
    [HttpApiAppShortVideo getShortVideoList:-1 classifyId:[self.classifyId longLongValue] page:self.page pageSize:kPageSize sort:[self.sort intValue] type:-1 callback:^(int code, NSString *strMsg, PageInfo *pageInfo, NSArray<ApiShortVideoDtoModel *> *arr) {
         [weakself.collectionView.mj_header endRefreshing];
         [weakself.collectionView.mj_footer endRefreshing];
         if (code == 1) {
             [self.infoMuArray addObjectsFromArray:arr];
             if (arr.count < 20) {
                 [weakself.collectionView.mj_footer endRefreshingWithNoMoreData];
             }
             dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                 [weakself.collectionView reloadData];
             });
         }else{
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
    ApiShortVideoDtoModel *model;
    if (indexPath.row < self.infoMuArray.count) {
        model = self.infoMuArray[indexPath.row];
    }
    SVSortCollectionViewCell *cell = (SVSortCollectionViewCell *)[collectionView dequeueReusableCellWithReuseIdentifier:@"shortVideoSortCell" forIndexPath:indexPath];
    if (model) {
        cell.model = model;
    }
    return cell;
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    [collectionView deselectItemAtIndexPath:indexPath animated:YES];
    NSDictionary *prams = @{
        @"dataType":@(1),
        @"sort":self.sort,
        @"classifyId":self.classifyId,
        @"index":@(indexPath.row)
    };
    [RouteManager routeForName:RN_shortVideo_play_List currentC:self parameters:prams];
}
#pragma mark - CollectionWaterfallLayoutDelegate
- (CGFloat)waterFallLayout:(CollectionWaterfallLayout *)waterFallLayout heightForItemAtIndexPath:(NSInteger)indexPath itemWidth:(CGFloat)itemWidth{
    CGFloat width = (kScreenWidth-4)/2.0;
    CGFloat scale = 225/178.0;
    return width*scale+40;
}
@end
