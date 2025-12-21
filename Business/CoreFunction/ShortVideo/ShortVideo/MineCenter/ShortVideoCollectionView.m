//
//  ShortVideoCollectionView.m
//  MineCenter
//
//  Created by KLC on 2020/6/24.
//

#import "ShortVideoCollectionView.h"
#import "ShortVideoListCell.h"
#import <LibProjModel/HttpApiAppShortVideo.h>
#import <LibProjView/EmptyView.h>

static NSString *sv_cellIdentifier = @"sv_cellIdentifier";
@interface ShortVideoCollectionView()<
UICollectionViewDelegate,
UICollectionViewDataSource 
>
@property (nonatomic, copy) void(^scrollCallback)(UIScrollView *scrollView);
@property (nonatomic, strong) NSMutableDictionary *shortVideoCellDic;
@property (nonatomic, strong)NSMutableArray *dataArr;
@property (nonatomic, weak)EmptyView *weakEmptyV;

@property(nonatomic,assign)int page;
@property(nonatomic,assign)int pageSize;
@property(nonatomic,assign)BOOL isPush;//是否是push
@property(nonatomic,assign)BOOL isLoadingData;//是否在获取数据
@end
@implementation ShortVideoCollectionView
- (NSMutableDictionary *)shortVideoCellDic{
    if (!_shortVideoCellDic ) {
        _shortVideoCellDic = [NSMutableDictionary dictionary];
    }
    return _shortVideoCellDic;
}
 
 
- (NSMutableArray *)dataArr{
    if (!_dataArr) {
        _dataArr = [NSMutableArray array];
    }
    return _dataArr;
}
-(void)emptyView{
    EmptyView *empty = [[EmptyView alloc] init];
    empty.titleL.text = kLocalizationMsg(@"暂时没有内容");
    empty.titleL.textColor = empty.detailL.textColor;
    [empty showInView:self];
    empty.y = 60;
    _weakEmptyV = empty;
    
}
- (instancetype)initWithFrame:(CGRect)frame collectionViewLayout:(UICollectionViewLayout *)layout{
    self = [super initWithFrame:frame collectionViewLayout:layout];
    if (self) {
        [self createUI];
    }
    return self;
}
- (void)createUI{
    self.backgroundColor = [UIColor whiteColor];
    self.page = 0;
    self.delegate = self;
    self.dataSource = self;
    kWeakSelf(self);
    self.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        self.page ++;
        [weakself loadData:NO];
    }];
//    self.mj_footer.ignoredScrollViewContentInsetBottom = kISiPhoneXX ? 34 : 0;
    [self emptyView];
     
}
 
- (void)loadData:(BOOL)refresh{
    kWeakSelf(self);
    if (refresh) {
        [self.dataArr removeAllObjects];
    }
    int type = self.type+1;
    [HttpApiAppShortVideo getUserShortVideoPage:self.page pageSize:kPageSize toUid:-1 type:type callback:^(int code, NSString *strMsg, PageInfo *pageInfo, NSArray<ApiShortVideoDtoModel *> *arr) {
        [weakself.mj_header endRefreshing];
        [weakself.mj_footer endRefreshing];
        if (code == 1) {
            [weakself.dataArr addObjectsFromArray:arr];
            if (arr.count < kPageSize) {
                 [weakself.mj_footer endRefreshingWithNoMoreData];
            }
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [weakself reloadData];
                if (self.scrollDelegate && [self.scrollDelegate respondsToSelector:@selector(shortVideoCollectionView:scrollStatus:)]) {
                    [self.scrollDelegate shortVideoCollectionView:self scrollStatus:YES];
                }
            });
            weakself.weakEmptyV.hidden = arr.count;
        }else{
            [SVProgressHUD showInfoWithStatus:strMsg];
        }
    }];
     
    
}

 
#pragma mark - collectionview
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    if (collectionView.tag == self.tag) {
        return self.dataArr.count;
    }
    return 0;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    NSString *identifier = [self.shortVideoCellDic objectForKey:[NSString stringWithFormat:@"%@", indexPath]];
    if(identifier == nil){
        identifier = [NSString stringWithFormat:@"%@%@",[NSString getNowTimeTimestamp], [NSString stringWithFormat:@"%@",indexPath]];
        [self.shortVideoCellDic setObject:identifier forKey:[NSString  stringWithFormat:@"%@",indexPath]];
       [self registerClass:[ShortVideoListCell class] forCellWithReuseIdentifier:sv_cellIdentifier];
    }
    ApiShortVideoDtoModel *model;
    if (indexPath.row < self.dataArr.count) {
        model = self.dataArr[indexPath.row];
    }
    ShortVideoListCell *cell = (ShortVideoListCell *)[collectionView dequeueReusableCellWithReuseIdentifier:sv_cellIdentifier forIndexPath:indexPath];
    cell.backgroundColor = [UIColor whiteColor];
    if (model) {
        cell.model = model;
    }
    return cell;
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    if (self.scrollDelegate && [self.scrollDelegate respondsToSelector:@selector(shortVideoCollectionView:didSelected:type:)]) {
        [self.scrollDelegate shortVideoCollectionView:self didSelected:indexPath.row type:self.type+1];
     }
}
 
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    self.scrollCallback(scrollView);
}
#pragma mark - JXPagingViewListViewDelegate
- (void)listDidAppear{
    [self loadData:YES];
}
- (UIScrollView *)listScrollView {
    return self;
}

- (void)listViewDidScrollCallback:(void (^)(UIScrollView *))callback {
    self.scrollCallback = callback;
}
- (UIView *)listView {
    return self;
}
@end
