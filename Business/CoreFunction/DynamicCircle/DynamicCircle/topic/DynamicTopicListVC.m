//
//  DynamicTopicListVC.m
//  klcProject
//
//  Created by ssssssssssss on 2020/7/29.
//  Copyright © 2020 KLC. All rights reserved.
//

#import "DynamicTopicListVC.h"
#import <MJRefresh/MJRefresh.h>

#import <LibProjView/CollectionWaterfallLayout.h>
#import "DynamicTopicItemCell.h"
 
#import <LibProjModel/HttpApiDynamicController.h>
#import <LibProjModel/ApiUserVideoModel.h>

#import <LibProjView/EmptyView.h>

@interface DynamicTopicListVC ()
<
UICollectionViewDelegate,
UICollectionViewDataSource,
CollectionWaterfallLayoutDelegate
>
@property (nonatomic, strong)UICollectionView *collectionView;
@property (nonatomic, strong)NSMutableArray *dataArray;
@property (nonatomic, strong)NSMutableDictionary *dynamicDic;
@property (nonatomic, assign)BOOL isLoadingData;
@property (nonatomic, weak)EmptyView *weakEmptyV;
@property (nonatomic, strong)CollectionWaterfallLayout *layout;
@property (nonatomic, assign)BOOL isPush;
@end
 
@implementation DynamicTopicListVC
- (CollectionWaterfallLayout *)layout{
    if (!_layout) {
        _layout = [[CollectionWaterfallLayout alloc]init];
        _layout.scrollDirection = UICollectionViewScrollDirectionVertical;
        _layout.delegate = self;
        _layout.headerReferenceSize = CGSizeMake(kScreenWidth, 5);
    }
    return _layout;
}
- (UICollectionView *)collectionView{
    if (!_collectionView) {
        _collectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight-kNavBarHeight) collectionViewLayout:self.layout];
        _collectionView.backgroundColor = kRGB_COLOR(@"#F2F2F2");
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        if (kiOS11) {
            _collectionView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
        }
    }
    return _collectionView;
}
- (NSMutableDictionary *)dynamicDic{
    if (!_dynamicDic) {
        _dynamicDic = [NSMutableDictionary dictionary];
    }
    return _dynamicDic;
}
- (NSMutableArray *)dataArray{
    if (!_dataArray) {
        _dataArray = [NSMutableArray array];
    }
    return _dataArray;
}
-(void)emptyView{
    EmptyView *empty = [[EmptyView alloc] init];
    empty.titleL.text = kLocalizationMsg(@"暂时没有内容");
    empty.detailL.text = kLocalizationMsg(@"换个类型看看吧～");
    [empty showInView:self.collectionView];
    _weakEmptyV = empty;
}
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    if (!self.isPush) {
        [self loadData:YES];
    }
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.collectionView];
    self.navigationItem.title = self.topicName;
    kWeakSelf(self);
    self.collectionView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [weakself loadData:YES];
    }];
    self.collectionView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        [weakself loadData:NO];
    }];
    [self emptyView];
    
}
- (void)loadData:(BOOL)isRefresh{
    if (isRefresh) {
        [self.dataArray removeAllObjects];
    }
    //请求数据
    int pageSize = kPageSize;
    int page =isRefresh?0:(int)self.dataArray.count/pageSize  + (self.dataArray.count%pageSize?1:0);
    kWeakSelf(self);
    [HttpApiDynamicController getDynamicList:[self.topic_id longLongValue] page:page pageSize:pageSize touid:0 type:0 callback:^(int code, NSString *strMsg, PageInfo *pageInfo, NSArray<ApiUserVideoModel *> *arr) {
        if (code == 1) {
            [weakself.collectionView.mj_header endRefreshing];
            [self.collectionView.mj_footer endRefreshing];
            if (arr.count > 0) {
                if (isRefresh) {
                    [weakself.dataArray removeAllObjects];
                }
                [weakself.dataArray addObjectsFromArray:arr];
            }else{
                [self.collectionView.mj_footer endRefreshingWithNoMoreData];
            }
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [weakself.collectionView reloadData];
            });
        }else{
            [self.collectionView.mj_header endRefreshing];
            [self.collectionView.mj_footer endRefreshing];
            [SVProgressHUD showInfoWithStatus:strMsg];
        }
        weakself.weakEmptyV.hidden = weakself.dataArray.count;
    }];
}
#pragma mark - collection
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    
    return self.dataArray.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    NSString *identifier = [self.dynamicDic objectForKey:[NSString stringWithFormat:@"%@", indexPath]];
    if(identifier == nil){
        identifier = [NSString stringWithFormat:@"%@%@",[NSString getNowTimeTimestamp], [NSString stringWithFormat:@"%@",indexPath]];
        [self.dynamicDic setObject:identifier forKey:[NSString  stringWithFormat:@"%@",indexPath]];
        [collectionView registerClass:[DynamicTopicItemCell class] forCellWithReuseIdentifier:identifier];
        
    }
    ApiUserVideoModel *model;
    if (indexPath.row < self.dataArray.count) {
        model = self.dataArray[indexPath.row];
    }
    DynamicTopicItemCell *cell = (DynamicTopicItemCell *)[collectionView dequeueReusableCellWithReuseIdentifier:identifier forIndexPath:indexPath];
    if (model) {
        cell.model = model;
    }
    return cell;
}


-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    if (self.isLoadingData) {
        return;
    }
    [collectionView deselectItemAtIndexPath:indexPath animated:YES];
    ApiUserVideoModel *model;
    if (indexPath.row < self.dataArray.count) {
        model = self.dataArray[indexPath.row];
    }
    self.isPush = YES;
    [RouteManager routeForName:RN_dynamic_playVideoVC currentC:self parameters:@{@"userId":@(model.uid),@"index":@(indexPath.row),@"hotId":self.topic_id,@"models":self.dataArray,@"hasLoading":@(YES)}];
}
#pragma mark - waterFollow
/**
 * 每个item的高度e
 */
- (CGFloat)waterFallLayout:(CollectionWaterfallLayout *)waterFallLayout heightForItemAtIndexPath:(NSInteger)indexPath itemWidth:(CGFloat)itemWidth{
    ApiUserVideoModel *model;
    if (indexPath < self.dataArray.count) {
        model = self.dataArray[indexPath];
    }
    CGFloat scale = 164/360.0;
    CGFloat width = kScreenWidth*scale;
    CGFloat height;
    if (model.title.length > 0 || model.topicName.length > 0) {
        height = width +84;
    }else{
        height = width +44;
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
    CGFloat scale = 164/360.0;
    CGFloat width = kScreenWidth*scale;
    CGFloat margin = (kScreenWidth-2*width)/3.0;
    return margin;
}

/**
 * 每行之间的间距
 */
- (CGFloat)rowMarginInWaterFallLayout:(CollectionWaterfallLayout *)waterFallLayout{
    CGFloat scale = 164/360.0;
    CGFloat width = kScreenWidth*scale;
    CGFloat margin = (kScreenWidth-2*width)/3.0;
    return margin;
}

/**
 * 每个item的内边距
 */
- (UIEdgeInsets)edgeInsetdInWaterFallLayout:(CollectionWaterfallLayout *)waterFallLayout{
    CGFloat scale = 164/360.0;
    CGFloat width = kScreenWidth*scale;
    CGFloat margin = (kScreenWidth-2*width)/3.0;
    return UIEdgeInsetsMake(0, margin, 0, margin);
}


@end
