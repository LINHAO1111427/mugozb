//
//  MineLikeShortVideoVC.m
//  UserInfo
//
//  Created by ssssssss on 2020/12/17.
//  Copyright © 2020 KLC. All rights reserved.
//

#import "MineLikeShortVideoVC.h"
#import <LibProjView/CollectionWaterfallLayout.h>
#import <LibProjView/SVSortCollectionViewCell.h>
#import <LibProjModel/HttpApiAppShortVideo.h>
#import <LibProjView/EmptyView.h>

static NSString *shortVideoUserTableCell = @"shortVideoUserTableCell";

@interface MineLikeShortVideoVC ()<UICollectionViewDelegate,UICollectionViewDataSource,CollectionWaterfallLayoutDelegate>

@property (nonatomic, copy) void(^scrollCallback)(UIScrollView *scrollView);
 
@property (nonatomic, weak) EmptyView *weakEmptyV;
@property(nonatomic,strong) NSMutableArray *infoMuArray;

@property (nonatomic, strong) UICollectionView *svCollectionView;
@property (nonatomic, strong) CollectionWaterfallLayout *waterfallLayout;

@property(nonatomic,assign)BOOL isPush;//是否是push
@property(nonatomic,assign)BOOL isLoadingData;//是否在获取数据

@end

@implementation MineLikeShortVideoVC

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
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    UICollectionView *svCollectionView = [[UICollectionView alloc]initWithFrame:CGRectZero collectionViewLayout:self.waterfallLayout];
    svCollectionView.delegate = self;
    svCollectionView.backgroundColor = [UIColor whiteColor];
    svCollectionView.dataSource = self;
    [svCollectionView registerClass:[SVSortCollectionViewCell class] forCellWithReuseIdentifier:@"SVSortCollectionViewCell"];
    [self.view addSubview:svCollectionView];
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    if (kiOS(11.0)) {
        svCollectionView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    } else
    if (kiOS(13.0)) {
        svCollectionView.automaticallyAdjustsScrollIndicatorInsets = YES;
    }
    
    self.svCollectionView = svCollectionView;
    [svCollectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];

    kWeakSelf(self);
    self.svCollectionView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [weakself loadData:YES];
    }];
    self.svCollectionView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        [weakself loadData:NO];
    }];
    self.svCollectionView.mj_footer.ignoredScrollViewContentInsetBottom = kISiPhoneXX ? 34 : 0;

    [self emptyView];
    [self loadData:YES];
}


-(void)emptyView{
    EmptyView *empty = [[EmptyView alloc] init];
    empty.iconImgV.image = [UIImage imageNamed:@"default_emtpy_content"];
    empty.detailL.text = kLocalizationMsg(@"暂无数据，去其他页面看看吧～");
    [self.view addSubview:empty];
    [empty mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(300, 300));
        make.center.equalTo(self.view);
    }];
    _weakEmptyV = empty;
}


- (void)loadData:(BOOL)refresh{
    kWeakSelf(self);
    int pageSize = kPageSize;
    int page = refresh?0:(int)self.infoMuArray.count/pageSize  + (self.infoMuArray.count%pageSize?1:0);
    [HttpApiAppShortVideo getUserShortVideoPage:page pageSize:pageSize toUid:-1 type:2 callback:^(int code, NSString *strMsg, PageInfo *pageInfo, NSArray<ApiShortVideoDtoModel *> *arr) {
        [weakself.svCollectionView.mj_header endRefreshing];
        [weakself.svCollectionView.mj_footer endRefreshing];
        if (code == 1) {
            if (refresh) {
                [weakself.infoMuArray removeAllObjects];
            }
            [weakself.infoMuArray addObjectsFromArray:arr];
            if (arr.count < kPageSize) {
                [weakself.svCollectionView.mj_footer endRefreshingWithNoMoreData];
            }
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [weakself.svCollectionView reloadData];
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
    SVSortCollectionViewCell *cell = (SVSortCollectionViewCell *)[collectionView dequeueReusableCellWithReuseIdentifier:@"SVSortCollectionViewCell" forIndexPath:indexPath];
    cell.model = (indexPath.row < self.infoMuArray.count)?self.infoMuArray[indexPath.row]:nil;
    return cell;
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    [collectionView deselectItemAtIndexPath:indexPath animated:YES];
    NSDictionary *prams = @{
        @"dataType":@(2),
        @"type":@(2),
        @"userid":@([ProjConfig userId]),
        @"index":@(indexPath.row)
    };
    self.isPush = YES;
    [RouteManager routeForName:RN_shortVideo_play_List currentC:self parameters:prams];
}


#pragma mark - CollectionWaterfallLayoutDelegate
- (CGFloat)waterFallLayout:(CollectionWaterfallLayout *)waterFallLayout heightForItemAtIndexPath:(NSInteger)indexPath itemWidth:(CGFloat)itemWidth{
    CGFloat width = (kScreenWidth-4)/2.0;
    CGFloat scale = 225/178.0;
    return width*scale+40;
}

 
#pragma mark - JXPagerViewListViewDelegate
- (UIView *)listView{
    return self.view;
}

@end
