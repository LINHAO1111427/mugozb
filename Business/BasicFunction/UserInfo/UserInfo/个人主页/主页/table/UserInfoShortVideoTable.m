//
//  UserInfoShortVideoVc.m
//  UserInfo
//
//  Created by ssssssss on 2020/12/17.
//  Copyright © 2020 KLC. All rights reserved.
//

#import "UserInfoShortVideoTable.h"
#import <LibProjView/CollectionWaterfallLayout.h>
#import <LibProjView/SVSortCollectionViewCell.h>
#import <LibProjModel/HttpApiAppShortVideo.h>
#import <LibProjView/EmptyView.h>

static NSString *shortVideoUserTableCell = @"shortVideoUserTableCell";
@interface UserInfoShortVideoTable ()<UICollectionViewDelegate,UICollectionViewDataSource,CollectionWaterfallLayoutDelegate>
@property (nonatomic, copy) void(^scrollCallback)(UIScrollView *scrollView);
@property (nonatomic, strong)UICollectionView *sv_collectionView;
@property (nonatomic, strong)UIView *headerView;
@property (nonatomic, weak)EmptyView *weakEmptyV;
@property (nonatomic, strong) CollectionWaterfallLayout *waterfallLayout;
@property (nonatomic, strong) NSMutableDictionary *shortVideoCellDic;
@property(nonatomic,strong)NSMutableArray *infoMuArray;

@property (nonatomic, strong)UIButton *productBtn;//作品
@property (nonatomic, strong)UIButton *likeBtn;//喜欢
@property (nonatomic, strong)UIButton *buyBtn;//购买
 

@property(nonatomic,assign)int page;
@property(nonatomic,assign)BOOL isPush;//是否是push
@property(nonatomic,assign)BOOL isLoadingData;//是否在获取数据
@property (nonatomic, assign)int type;
@end

@implementation UserInfoShortVideoTable

- (UICollectionView *)sv_collectionView{
    if (!_sv_collectionView) {
        _sv_collectionView = [[UICollectionView alloc]initWithFrame:CGRectZero collectionViewLayout:self.waterfallLayout];
        _sv_collectionView.delegate = self;
        _sv_collectionView.backgroundColor = [UIColor whiteColor];
        _sv_collectionView.dataSource = self;
    }
    return _sv_collectionView;
}
- (NSMutableDictionary *)shortVideoCellDic{
    if (!_shortVideoCellDic ) {
        _shortVideoCellDic = [NSMutableDictionary dictionary];
    }
    return _shortVideoCellDic;
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
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self addHeaderView];
    [self.view addSubview:self.sv_collectionView];
    [self.sv_collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.headerView.mas_bottom);
        make.left.right.bottom.equalTo(self.view);
    }];
    self.page = 0;
    self.type = 0;
     
    kWeakSelf(self);
    self.sv_collectionView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        self.page = 0;
        [weakself loadShortVideoData:YES];
    }];
    self.sv_collectionView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        self.page ++;
        [weakself loadShortVideoData:NO];
    }];
    self.sv_collectionView.mj_footer.ignoredScrollViewContentInsetBottom = kISiPhoneXX ? 34 : 0;
    
    [self emptyView];
}
 
- (void)addHeaderView{
    UIView *headerView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 36)];
    headerView.backgroundColor = [UIColor whiteColor];
    CGFloat width = 80;
    CGFloat margin = 15;
    for (int i = 0; i < 3; i++) {
        UIButton *btn = [[UIButton  alloc]initWithFrame:CGRectMake(15+(margin+width)*i, 3, width, 30)];
        NSString *title;
        if (i == 0) {
            btn.selected  = YES;
            self.productBtn = btn;
            title = kLocalizationMsg(@"作品 0");
        }else if (i == 1){
            title = kLocalizationMsg(@"喜欢 0");
            self.likeBtn = btn;
        }else if (i == 2){
            title = kLocalizationMsg(@"购买 0");
            self.buyBtn = btn;
        }
        btn.tag = i;
        [btn setTitle:title forState:UIControlStateNormal];
        btn.titleLabel.font = [UIFont systemFontOfSize:14];
        btn.layer.cornerRadius = 15;
        btn.clipsToBounds = YES;
        [btn setBackgroundImage:[UIImage imageWithColor:[UIColor clearColor]] forState:UIControlStateNormal];
        [btn setBackgroundImage:[UIImage imageWithColor:kRGB_COLOR(@"#FFF3FF")] forState:UIControlStateNormal];
        [btn setTitleColor:kRGB_COLOR(@"#999999") forState:UIControlStateNormal];
        [btn setTitleColor:[ProjConfig normalColors] forState:UIControlStateSelected];
        [btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
        [headerView addSubview:btn];
    
    }
    self.headerView = headerView;
    [self.view addSubview:self.headerView];
}
 
 
-(void)emptyView{
    EmptyView *empty = [[EmptyView alloc] init];
    empty.titleL.text = kLocalizationMsg(@"暂时没有内容");
    [empty showInView:self.sv_collectionView];
    _weakEmptyV = empty;
}
- (void)btnClick:(UIButton *)btn{
    self.type = (int)btn.tag;
    for (UIView *subV in self.headerView.subviews) {
        if ([subV isKindOfClass:[UIButton class]]) {
            UIButton *btnS = (UIButton *)subV;
            if (btnS.tag == self.type) {
                btnS.selected = YES;
            }else{
                btnS.selected = NO;
            }
        }else{
            if (subV.height == 4) {
                if (subV.tag == self.type) {
                    subV.hidden = NO;
                }else{
                    subV.hidden = YES;
                }
            }
        }
        
    }
    [self loadShortVideoData:YES];
}
- (void)loadShortVideoData:(BOOL)refresh{
    kWeakSelf(self);
    [HttpApiAppShortVideo getUserShortVideoList:1 toUid:self.userModel.userId callback:^(int code, NSString *strMsg, ApiMyShortVideoModel *model) {
        if (code == 1) {
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                for (int i = 0; i < 3; i++) {
                    NSString *title;
                    if (i == 0) {
                        title = [NSString stringWithFormat:kLocalizationMsg(@"作品 %d"),model.myNumber];
                        [self.productBtn setTitle:title forState:UIControlStateNormal];
                        
                    }else if (i == 1){
                        title = [NSString stringWithFormat:kLocalizationMsg(@"喜欢 %d"),model.likeNumber];
                        [self.likeBtn setTitle:title forState:UIControlStateNormal];
                        
                    }else if (i == 2){
                        title = [NSString stringWithFormat:kLocalizationMsg(@"购买 %d"),model.buyNumber];
                        [self.buyBtn setTitle:title forState:UIControlStateNormal];
                    }

                }
            });
            [weakself loadData:refresh];
        }
    }];
}
- (void)loadData:(BOOL)refresh{
    kWeakSelf(self);
    if (refresh) {
        [self.infoMuArray removeAllObjects];
    }
    int type = self.type+1;
    [HttpApiAppShortVideo getUserShortVideoPage:self.page pageSize:kPageSize toUid:self.userModel.userId type:type callback:^(int code, NSString *strMsg, PageInfo *pageInfo, NSArray<ApiShortVideoDtoModel *> *arr) {
        [weakself.sv_collectionView.mj_header endRefreshing];
        [weakself.sv_collectionView.mj_footer endRefreshing];
        if (code == 1) {
            if (refresh) {
                [self.infoMuArray removeAllObjects];
            }
            [weakself.infoMuArray addObjectsFromArray:arr];
            if (arr.count < kPageSize) {
                [weakself.sv_collectionView.mj_footer endRefreshingWithNoMoreData];
            }
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [weakself.sv_collectionView reloadData];
            });
            weakself.weakEmptyV.hidden = arr.count;
        }else{
            [SVProgressHUD showInfoWithStatus:strMsg];
        }
    }];
     
    
}
 
#pragma mark - collectionview
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.infoMuArray.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    NSString *identifier = [self.shortVideoCellDic objectForKey:[NSString stringWithFormat:@"%@", indexPath]];
    if(identifier == nil){
        identifier = [NSString stringWithFormat:@"%@%@",shortVideoUserTableCell, [NSString stringWithFormat:@"%@",indexPath]];
        [self.shortVideoCellDic setObject:identifier forKey:[NSString  stringWithFormat:@"%@",indexPath]];
        [self.sv_collectionView registerClass:[SVSortCollectionViewCell class] forCellWithReuseIdentifier:identifier];
    }
    ApiShortVideoDtoModel *model;
    if (indexPath.row < self.infoMuArray.count) {
        model = self.infoMuArray[indexPath.row];
    }
    SVSortCollectionViewCell *cell = (SVSortCollectionViewCell *)[collectionView dequeueReusableCellWithReuseIdentifier:identifier forIndexPath:indexPath];
    if (model) {
        cell.model = model;
    }
    return cell;
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    [collectionView deselectItemAtIndexPath:indexPath animated:YES];
    int dataType = [ProjConfig userId] == self.userModel.userId?2:3;
    NSDictionary *prams = @{
        @"dataType":@(dataType),
        @"type":@(self.type+1),
        @"userid":@(self.userModel.userId),
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
    [self loadShortVideoData:YES];
    return self.view;
}
- (UIScrollView *)listScrollView {
    return self.sv_collectionView;
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    self.scrollCallback(scrollView);
}

- (void)listViewDidScrollCallback:(void (^)(UIScrollView *))callback {
    self.scrollCallback = callback;
}
- (void)listScrollViewWillResetContentOffset{
}
- (void)listDidAppear{
    
}
- (void)listDidDisappear{
    
}
@end
