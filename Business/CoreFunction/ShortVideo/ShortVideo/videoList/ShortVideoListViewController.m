//
//  ShortVideoRecommendViewController.m
//  HomePage
//
//  Created by KLC on 2020/6/11.
//  Copyright © 2020 KLC. All rights reserved.
//

#import "ShortVideoListViewController.h"
#import <AVFoundation/AVFoundation.h>
#import <LibProjModel/KLCUserInfo.h>
#import <LibProjModel/KLCAppConfig.h>
#import <LibProjModel/HttpApiAppShortVideo.h>
#import <LibProjModel/ApiShortVideoDtoModel.h>
#import <LibProjModel/AdminLiveConfigModel.h>
#import <LibProjView/EmptyView.h>
#import <MJRefresh.h>
#import <LibProjModel/UserSimpleInfoModel.h>
#import <LibProjView/VideoGuideView.h>
#import <LibProjView/CustomPopUpAlert.h>
#import "SVPlayCollectionViewCell.h"
#import <LibProjView/MultiGestureCollectionView.h>
#import <LibProjBase/KLCTabBarControl.h>
#import <LibProjView/EmptyView.h>
#import <RTRootNavigationController/RTRootNavigationController.h>
#import "VideoPlayListPageCollectionLayout.h"
#import <LibProjView/PublicMethodObj.h>
#import "ShortVideoIdSaveObj.h"
#import <LibProjView/ForceAlertController.h>

@interface ShortVideoListViewController ()<UIGestureRecognizerDelegate,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout,UICollectionViewDataSource,UIScrollViewDelegate,SVPlayCollectionViewCellDelegate>

@property (nonatomic, weak)EmptyView *weakEmptyV;
//滚动视图
@property (nonatomic, weak) UICollectionView *svCollectionView;
@property (nonatomic, strong) NSMutableDictionary *shortVideoCellDic;
@property (nonatomic, assign)int selectedIndex;
@property (nonatomic, strong)NSMutableArray<ApiShortVideoDtoModel *> *dataArr;
@property (nonatomic, weak)SVPlayCollectionViewCell *playCell;

@property(nonatomic,assign)int page;
@property(nonatomic,assign)int pageSize;
@property(nonatomic,assign)int64_t adsId;//记录广告id
@property(nonatomic,assign)BOOL isPush;//是否是push
@property(nonatomic, assign)BOOL hasLoad;//已经加载
@property(nonatomic,assign)BOOL isLoadingData;//是否在获取数据

@end

@implementation ShortVideoListViewController

- (void)dealloc
{
    [_svCollectionView removeFromSuperview];
    _svCollectionView = nil;
   // NSLog(@"过滤文字%s"),__func__);
    [self removeAllData];
}

- (UIBarButtonItem *)rt_customBackItemWithTarget:(id)target action:(SEL)action{
    ///禁止侧滑
    self.rt_disableInteractivePop = YES;
    [BaseNavBarItem navBarBgClear:self foregroundColor:[UIColor blackColor]];
    return [[UIBarButtonItem alloc] initWithCustomView:[BaseNavBarItem navBackBtnImage:[UIImage imageNamed:@"main_navbar_back"] target:self action:@selector(popVC)]];
}

- (void)removeAllData{
    
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIApplicationDidEnterBackgroundNotification object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIApplicationWillEnterForegroundNotification object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"updateUserSimpleInfo" object:nil];
    [_shortVideoCellDic removeAllObjects];
    _shortVideoCellDic = nil;
    if (_playCell) {
        [_playCell stopPlayVideo];
        _playCell = nil;
    }
    [_weakEmptyV removeFromSuperview];
    _playCell = nil;
    [_dataArr removeAllObjects];
    _dataArr = nil;
    
}

- (void)popVC{
    [self.navigationController popViewControllerAnimated:YES];
    [self removeAllData];
}

- (NSMutableDictionary *)shortVideoCellDic{
    if (!_shortVideoCellDic) {
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

#pragma mark - 初始化
- (instancetype)init{
    self = [super init];
    if (self) {
    }
    return self;
}

-(void)emptyView{
    EmptyView *empty = [[EmptyView alloc] init];
    empty.titleL.text = kLocalizationMsg(@"暂时没有内容");
    empty.titleL.textColor = empty.detailL.textColor;
    if (self.type == 0) {
        empty.detailL.text = kLocalizationMsg(@"您可以发个短视频后再尝试哦～");
    }else{
        empty.detailL.text = kLocalizationMsg(@"没有发现关注的短视频哦～");
    }
    empty.hidden = YES;
    [self.svCollectionView addSubview:empty];
    [empty mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self.svCollectionView);
        make.size.mas_equalTo(CGSizeMake(kScreenWidth, 300));
    }];
    _weakEmptyV = empty;
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    if (self.playCell) {
        [self.playCell pauseVideo];
    }
}
- (void)viewDidDisappear:(BOOL)animated{
    [super viewDidDisappear:animated];
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    if (self.dataType > 0) {
        if (!self.isPush) {
            [self loadData:YES dragDown:YES];
        }else{
            if (self.playCell) {
                if (self.playCell.isPausePlay) {
                    [self.playCell resumeVideo];
                }else{
                    [self.playCell startPlayVideo];
                }
            }
        }
    }
}
- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    self.hasLoad = YES;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor blackColor];
    self.navigationController.navigationBar.translucent = YES;
    
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(applicationWillEnterForeground:) name: UIApplicationWillEnterForegroundNotification object:nil];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(applicationDidEnterBackground:) name: UIApplicationDidEnterBackgroundNotification object:nil];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(updateUserSimpleInfo:) name:@"updateUserSimpleInfo" object:nil];
    
    [self getFreeVideoNum];//获取免费次数
    self.pageSize = kPageSize;
    self.page = 0;
    self.adsId = -1;
    
    if (self.index > 0) {
        self.page = self.index/self.pageSize;
        self.index = self.index%self.pageSize;
    }

    
    UICollectionViewFlowLayout *collectionfallLayout = [[UICollectionViewFlowLayout alloc]init];
    collectionfallLayout.minimumLineSpacing = 0;
    collectionfallLayout.minimumInteritemSpacing = 0;
    collectionfallLayout.sectionInset = UIEdgeInsetsMake(0, 0, 0, 0);
    collectionfallLayout.scrollDirection = UICollectionViewScrollDirectionVertical;
    
    UICollectionView *collectionView = [[UICollectionView alloc]initWithFrame:CGRectZero collectionViewLayout:collectionfallLayout];
    collectionView.pagingEnabled = YES;
    collectionView.showsVerticalScrollIndicator = NO;
    collectionView.delegate   = self;
    collectionView.dataSource = self;
    collectionView.alwaysBounceHorizontal = NO;
    collectionView.decelerationRate = 0.8;//松手后的scroll速度（0～1之间）
    collectionView.backgroundColor = [UIColor clearColor];
    [self.view addSubview:collectionView];
    [collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
    self.svCollectionView = collectionView;
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    if (kiOS(11.0)) {
        self.svCollectionView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    } else
    if (kiOS(13.0)) {
        self.svCollectionView.automaticallyAdjustsScrollIndicatorInsets = YES;
    }
    
    self.edgesForExtendedLayout = UIRectEdgeAll;
    self.extendedLayoutIncludesOpaqueBars = YES;
    
    kWeakSelf(self);
    self.svCollectionView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        if (weakself.index > 0 && weakself.page > 0) {
            weakself.page --;
            [weakself loadData:NO dragDown:YES];
        } else{
            weakself.page = 0;
            [weakself loadData:YES dragDown:YES];
        }
    }];
    self.svCollectionView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        weakself.page ++;
        [weakself loadData:NO dragDown:NO];
    }];
    
//    self.svCollectionView.mj_footer.ignoredScrollViewContentInsetBottom = kISiPhoneXX ? 34 : 0;
    
    [VideoGuideView showIn:self.view type:videoGuideTypeShortVideo];//引导页
    [self emptyView];
}

- (void)updateUserSimpleInfo:(NSNotification *)notice{
    UserSimpleInfoModel *infoModel = notice.userInfo[@"model"];
    if (infoModel.CksmtTPrivilege == 1) {
        [self.dataArr enumerateObjectsUsingBlock:^(ApiShortVideoDtoModel * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            obj.isPay = 1;
        }];
    }
}

- (void)applicationDidEnterBackground:(NSNotification *)notice{
    if (self.playCell) {
        [self.playCell pauseVideo];
    }
}

- (void)applicationWillEnterForeground:(NSNotification *)notice{
    if (self.playCell) {
        [self.playCell pauseVideo];
        if([self isDisplayedInScreen:self.playCell] && self.isViewLoaded && self.view.window){//正在显示
           // NSLog(@"过滤文字cell === %@"),self.playCell);
            if (self.playCell.isPausePlay) {
                [self.playCell resumeVideo];
            }else{
                [self.playCell startPlayVideo];
            }
        }
    }
}

- (BOOL)isDisplayedInScreen:(UIView *)view{
    // view不存在 或未添加到superview
    if (view == nil || view.superview == nil) {
        return NO;
    }
    // view 隐藏
    if (view.hidden) {
        return NO;
    }
    // 转换view对应window的Rect
    CGRect rect = [view convertRect:view.frame toView:nil];
    //如果可以滚动，清除偏移量
    if ([[view class] isSubclassOfClass:[UIScrollView class]]) {
        UIScrollView * scorll = (UIScrollView *)view;
        rect.origin.x += scorll.contentOffset.x;
        rect.origin.y += scorll.contentOffset.y;
    }
    
    // 若size为CGrectZero
    if (CGRectIsEmpty(rect) ||
        CGRectIsNull(rect)  ||
        CGSizeEqualToSize(rect.size, CGSizeZero)) {
        return NO;
    }
    
    // 获取 该view与window 交叉的 Rect
    CGRect screenRect = [UIScreen mainScreen].bounds;
    CGRect intersectionRect = CGRectIntersection(rect, screenRect);
    if (CGRectIsEmpty(intersectionRect) || CGRectIsNull(intersectionRect)) {
        return NO;
    }
    return YES;
}

- (void)setParameters:(NSDictionary *)parameters{
    _parameters = parameters;
    
    self.userId = [parameters[@"userid"] intValue];
    self.dataType = [parameters[@"dataType"] intValue];
    self.shortVideoId = [parameters[@"shortVideoId"]intValue];
    self.checkType = [parameters[@"checkType"] intValue];
    self.type = [parameters[@"type"] intValue];
    self.sort = [parameters[@"sort"] intValue];
    self.classifyId =  [parameters[@"classifyId"] intValue];
    self.index = [parameters[@"index"] intValue];
    self.subClassifyId = [parameters[@"subClassifyId"] intValue];
    
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
    [SVProgressHUD  showGifLoadingWithtatus:@""];
    if (self.dataType == SVDateTypeHome || self.dataType == SVDateTypeSortList) {///首页 or 分类
        [self loadHomeOrSortData:isRefresh dragDown:dragDown];
    }else if(self.dataType == SVDateTypeMy){///我的
        [self loadMyVideoData:isRefresh dragDown:dragDown];
    }else if(self.dataType == SVDateTypeUser){///个人主页
        [self loadUserVideoData:isRefresh dragDown:dragDown];
    }else if(self.dataType == SVDataTypeSingle || self.dataType == SVSVDataTypeSingleComment){///单独的视频
        [self loadSingleVideoData:isRefresh dragDown:dragDown];
    }else if (self.dataType == SVDataTypeLongSV){///长视频
        [self loadLongSVideoData:isRefresh dragDown:dragDown];
    }
}

///加载首页和分类数据
- (void)loadHomeOrSortData:(BOOL)isRefresh dragDown:(BOOL)dragDown{
    kWeakSelf(self);
    [HttpApiAppShortVideo getShortVideoList:self.adsId classifyId:self.classifyId page:self.page pageSize:self.pageSize sort:self.sort type:self.type callback:^(int code, NSString *strMsg, PageInfo *pageInfo, NSArray<ApiShortVideoDtoModel *> *arr) {
        [weakself dealWithData:isRefresh dragDown:dragDown arr:arr code:code msg:strMsg];
    }];
}
///我的
- (void)loadMyVideoData:(BOOL)isRefresh dragDown:(BOOL)dragDown{
    kWeakSelf(self);
    [HttpApiAppShortVideo getUserShortVideoPage:self.page pageSize:self.pageSize toUid:-1 type:self.type callback:^(int code, NSString *strMsg, PageInfo *pageInfo, NSArray<ApiShortVideoDtoModel *> *arr) {
        [weakself dealWithData:isRefresh dragDown:dragDown arr:arr code:code msg:strMsg];
    }];
}
///个人主页
- (void)loadUserVideoData:(BOOL)isRefresh dragDown:(BOOL)dragDown{
    kWeakSelf(self);
    [HttpApiAppShortVideo getUserShortVideoPage:self.page pageSize:self.pageSize toUid:self.userId type:self.type callback:^(int code, NSString *strMsg, PageInfo *pageInfo, NSArray<ApiShortVideoDtoModel *> *arr) {
        [weakself dealWithData:isRefresh dragDown:dragDown arr:arr code:code msg:strMsg];
    }];
}
///单个短视频
- (void)loadSingleVideoData:(BOOL)isRefresh dragDown:(BOOL)dragDown{
    kWeakSelf(self);
    int type = 0;
    int commentId = 0;
    if (self.dataType == SVSVDataTypeSingleComment) {
        type = self.checkType;
        commentId = self.commentId;
    }
    [HttpApiAppShortVideo getShortVideoInfoList:commentId shortVideoId:self.shortVideoId type:type callback:^(int code, NSString *strMsg, PageInfo *pageInfo, NSArray<ApiShortVideoDtoModel *> *arr) {
        [weakself dealWithData:isRefresh dragDown:dragDown arr:arr code:code msg:strMsg];
    }];
}
///长视频
- (void)loadLongSVideoData:(BOOL)isRefresh dragDown:(BOOL)dragDown{
    kWeakSelf(self);
    [HttpApiAppShortVideo getLongVideoList:-1 oneClassifyId:self.classifyId page:self.page pageSize:self.pageSize twoClassifyId:self.subClassifyId callback:^(int code, NSString *strMsg, NSArray<ApiShortVideoDtoModel *> *arr) {
        [weakself dealWithData:isRefresh dragDown:dragDown arr:arr code:code msg:strMsg];
    }];
}
 
- (void)dealWithData:(BOOL)isRefresh dragDown:(BOOL)dragDown arr:(NSArray<ApiShortVideoDtoModel *>*)arr code:(int)code msg:(NSString *)strMsg{
//   // NSLog(@"过滤文字code == %d strmsg == %@"),code,strMsg);
    if (code == 1) {
        kWeakSelf(self);
        [self.svCollectionView.mj_header endRefreshing];
        [self.svCollectionView.mj_footer endRefreshing];
        NSMutableArray *mutArr = [NSMutableArray array];
        if (arr.count > 0) {
            for (ApiShortVideoDtoModel *mod in arr) {
                ShortVideoIdSaveObj *obj = [ShortVideoIdSaveObj unArchiveShortVideoWith:mod.id_field];
                if (obj && obj.shortVideoId == mod.id_field) {
                    mod.isPay = 1;
                }
                [mutArr addObject:mod];
            }
        }
        [SVProgressHUD dismiss];
        if (isRefresh) {//刷新数据
            [self.dataArr removeAllObjects];
            [self.dataArr addObjectsFromArray:mutArr];
            if (arr.count < self.pageSize) {
                [self.svCollectionView.mj_footer endRefreshingWithNoMoreData];
            }
        }else{
            if (dragDown) {//下拉加载更多
                [self.dataArr insertObjects:mutArr atIndexes:[NSIndexSet indexSetWithIndex:0]];
            }else{//上拉加载更多
                [self.dataArr addObjectsFromArray:mutArr];
                if (arr.count < self.pageSize) {
                    [self.svCollectionView.mj_footer endRefreshingWithNoMoreData];
                }
            }
        }
        
        [self saveAdidFor:arr];//保存广告位置
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
           [weakself.svCollectionView reloadData];
            if (weakself.index > 0) {
                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.01 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                    [weakself scrollToItem:[NSIndexPath indexPathForRow:weakself.index inSection:0]];
                    weakself.index = 0;
                });
                
            }
        });
        
    }else{
        [self.svCollectionView.mj_header endRefreshing];
        [self.svCollectionView.mj_footer endRefreshing];
        [SVProgressHUD dismiss];
        [SVProgressHUD showInfoWithStatus:strMsg];
    }
    
    if (isRefresh) {
        [[NSNotificationCenter defaultCenter] postNotificationName:@"shortViewCanScroll" object:@(1)];
    }
    self.weakEmptyV.hidden = self.dataArr.count;
    self.isLoadingData = NO;
}


- (void)getVideoSize:(ApiShortVideoDtoModel *)model{
    CGSize videoSize = CGSizeZero;
    if (model.type == 1 && model.width <= 0 && model.height <= 0 && model.videoUrl.length > 0) {
        NSURL *url = [NSURL URLWithString:model.videoUrl];
        AVAsset *asset = [AVAsset assetWithURL:url];
        NSArray *array = asset.tracks;
        for (AVAssetTrack *track in array) {
            if ([track.mediaType isEqualToString:AVMediaTypeVideo]) {
                videoSize = CGSizeApplyAffineTransform(track.naturalSize, track.preferredTransform);
           
                break;
            }
        }
    }
    model.width = videoSize.width;
    model.height = videoSize.height;
}
 
- (void)saveAdidFor:(NSArray *)arr{
    self.adsId = -1;
    for (ApiShortVideoDtoModel *model in arr) {
        if (model.adsType > 0) {
            self.adsId = model.id_field;
        }
    }
}

#pragma mark - UICollectionViewDelegateFlowLayout
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    return collectionView.frame.size;
}

#pragma mark - scrollView
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    if (self.svCollectionView == scrollView) {
    }
}

- (void)scrollToItem:(NSIndexPath *)indexPath{
//    [self.svCollectionView setContentOffset:CGPointMake(0, indexPath.row*kScreenHeight) animated:NO];
    VideoPlayListPageCollectionLayout *layout =  (VideoPlayListPageCollectionLayout *)self.svCollectionView.collectionViewLayout;
    if([layout layoutAttributesForItemAtIndexPath:indexPath] != nil){
        [self.svCollectionView scrollToItemAtIndexPath:indexPath atScrollPosition:UICollectionViewScrollPositionCenteredVertically animated:NO];
    }
    SVPlayCollectionViewCell *cell = (SVPlayCollectionViewCell *)[self.svCollectionView cellForItemAtIndexPath:indexPath];
    if (self.playCell != cell || self.playCell == nil) {
        [[NSNotificationCenter defaultCenter] postNotificationName:@"shortViewCanScroll" object:@(1)];
        [self.playCell stopPlayVideo];
        self.playCell = cell;
        [self.playCell startPlayVideo];
    }
}
 
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    if (scrollView == self.svCollectionView) {
        NSIndexPath *indexPathPlay;
        
        if (scrollView.contentOffset.y <= 0) {
            indexPathPlay = [NSIndexPath indexPathForItem:0 inSection:0];
        }else{
            indexPathPlay = [self.svCollectionView indexPathForItemAtPoint:CGPointMake(0, scrollView.contentOffset.y + self.svCollectionView.frame.size.height/2)];
        }
        
        ///矫正器
        [self.svCollectionView setContentOffset:CGPointMake(0, indexPathPlay.item*scrollView.frame.size.height) animated:NO];
        
        SVPlayCollectionViewCell *cell = (SVPlayCollectionViewCell *)[self.svCollectionView cellForItemAtIndexPath:indexPathPlay];
        ApiShortVideoDtoModel *model;
        if (indexPathPlay.row < self.dataArr.count) {
            model = self.dataArr[indexPathPlay.row];
        }
        if (model.type != 2) {
            [[NSNotificationCenter defaultCenter] postNotificationName:@"shortViewCanScroll" object:@(1)];
        }
        if (self.playCell != cell  || self.playCell == nil) {
            [[NSNotificationCenter defaultCenter] postNotificationName:@"shortViewCanScroll" object:@(1)];
            [self.playCell stopPlayVideo];
            self.playCell = cell;
            [self.playCell startPlayVideo];
        }
    }
}

#pragma mark - collectionview
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.dataArr.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{

    NSString *svCellId = [NSString stringWithFormat:@"%zi", indexPath.row%3];
    NSString *identifier = [self.shortVideoCellDic objectForKey:svCellId];
    
    if(identifier == nil){
        identifier = [NSString stringWithFormat:@"shortVideoListCellId%@",svCellId];
        [self.shortVideoCellDic setObject:identifier forKey:svCellId];
        [self.svCollectionView registerClass:[SVPlayCollectionViewCell class] forCellWithReuseIdentifier:identifier];
    }
    
    SVPlayCollectionViewCell *cell = (SVPlayCollectionViewCell *)[collectionView dequeueReusableCellWithReuseIdentifier:identifier forIndexPath:indexPath];
    cell.delegate = self;
    cell.dataType = self.dataType;
    cell.superVc = self;
    cell.indexPath = indexPath;
    
    kWeakSelf(self);
    if (!self.playCell && !self.isLoadingData) {
        self.playCell = cell;
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [weakself.playCell startPlayVideo];
        });
    }
    ApiShortVideoDtoModel *model;
    if (indexPath.row < self.dataArr.count) {
        model = self.dataArr[indexPath.row];
    }
    if (model) {
        cell.model = model;
    }
    
    return cell;
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    [collectionView deselectItemAtIndexPath:indexPath animated:YES];
    SVPlayCollectionViewCell *cell = (SVPlayCollectionViewCell *)[collectionView cellForItemAtIndexPath:indexPath];
    [cell changePlayStaus];
}


#pragma mark - JXCategoryListContentViewDelegate
- (UIView *)listView{
    self.page = 0;
    self.adsId = -1;
    return self.view;
}

- (void)listWillDisappear{
    [self.playCell pauseVideo];
}

- (void)listWillAppear{
    if (!self.isPush && !self.hasLoad) {
        self.playCell = nil;
        self.page = 0;
        self.index = 0;
        [self loadData:YES dragDown:YES];
    }
    if (self.playCell) {
        if (self.playCell.isPausePlay) {
            [self.playCell resumeVideo];
        }else{
            [self.playCell startPlayVideo];
        }
    }
    self.isPush = NO;
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

- (void)getFreeVideoNum{
    [HttpApiAppShortVideo isReadShortVideoNumber:^(int code, NSString *strMsg, HttpNoneModel *model) {
        if (code == 1) {
           // NSLog(@"过滤文字###################短视频免费次数 %@次###################"),model.no_use);
            [[NSUserDefaults standardUserDefaults] setInteger:[[model no_use] integerValue] forKey:@"short_video_free_num"];
        }else{
            [[NSUserDefaults standardUserDefaults] setInteger:0 forKey:@"short_video_free_num"];
        }
    }];
}


#pragma mark -SVPlayCollectionViewCellDelegate-

///显示用户信息
- (void)playCell:(SVPlayCollectionViewCell *)playCell showUserInfo:(int64_t)userId{
    self.isPush = YES;
    [RouteManager routeForName:RN_user_userInfoVC currentC:self parameters:@{@"id":@(userId)}];
}

///点击短视频标签
- (void)playCell:(SVPlayCollectionViewCell *)playCell shortVideoTagId:(NSInteger)tagId tagLabel:(NSString *)tagLabel{
    self.isPush = YES;
    [RouteManager routeForName:RN_shortVideo_sort_List currentC:self parameters:@{@"title":tagLabel,@"classfyId":@(tagId),@"sort":@(-1)}];
}

///展示直播购商品
- (void)playCell:(SVPlayCollectionViewCell *)playCell showGoods:(int64_t)goodsId{
    self.isPush = YES;
    [RouteManager routeForName:RN_Shopping_Commodity_DetailVC currentC:self parameters:@{@"goodId":@(goodsId)}];
}

///一对一打电话
- (void)playCell:(SVPlayCollectionViewCell *)playCell otoVideoCall:(ApiShortVideoDtoModel *)model{
    self.isPush = YES;
    NSMutableDictionary *muDict = [[NSMutableDictionary alloc] initWithCapacity:1];
    [muDict setObject:@(model.userId) forKey:@"userId"];
    [muDict setObject:@(YES) forKey:@"isVideo"];
    if([KLCUserInfo getRole] == 1 && model.role == 1){
        if ([KLCAppConfig showOtmCoin]) {
            [self AnchorAndAnchorAlert:muDict];
        }else{
            self.isPush = YES;
            [RouteManager routeForName:RN_live_LaunchOneLive currentC:self parameters:muDict];
        }
    }else{
        self.isPush = YES;
        [RouteManager routeForName:RN_live_LaunchOneLive currentC:self parameters:muDict];
    }
}

///广告展示
- (void)playCell:(SVPlayCollectionViewCell *)playCell adsUrl:(NSString *)adsUrl{
    if (adsUrl.length != 0 && adsUrl != nil && adsUrl != NULL ) {
        self.isPush = YES;
        [PublicMethodObj showUrl:adsUrl];
    }
}


//主播对主播 弹框提示
-(void)AnchorAndAnchorAlert:(NSMutableDictionary *)muDict{
    //主播与主播
    kWeakSelf(self);
    CustomPopUpAlert *customAlert = [CustomPopUpAlert alertTitle:kLocalizationMsg(@"你当前通话的对象为主播") message:kStringFormat(kLocalizationMsg(@"接通后会扣除你的%@哦~"),kUnitStr) liveType:LiveTypeForAnchorAndAnchor];
    customAlert.clickCancelBlock = ^{
        
    };
    customAlert.clickSureBlock = ^(NSString * _Nonnull passwordStr) {
        weakself.isPush = YES;
        [RouteManager routeForName:RN_live_LaunchOneLive currentC:self parameters:muDict];
    };
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
         [weakself presentViewController:customAlert animated:YES completion:nil];
    });
}

///删除当前视频
- (void)playCell:(SVPlayCollectionViewCell *)playCell removeVideoId:(int64_t)videoId{
    
    kWeakSelf(self);
    ForceAlertController *alertVC = [ForceAlertController alertTitle:kLocalizationMsg(@"提示") message:kLocalizationMsg(@"确定删除这条短视频？")];
    [alertVC addOptions:kLocalizationMsg(@"取消") textColor:ForceAlert_BlackColor clickHandle:nil];
    [alertVC addOptions:kLocalizationMsg(@"删除") textColor:ForceAlert_NormalColor clickHandle:^{
        [HttpApiAppShortVideo delShortVideo:videoId callback:^(int code, NSString *strMsg, HttpNoneModel *model) {
            
            if (code == 1) {
                [SVProgressHUD showInfoWithStatus:kLocalizationMsg(@"删除成功")];
                if ([ProjConfig currentNVCList].count > 1) {
                    [[ProjConfig currentVC].navigationController popViewControllerAnimated:YES];
                }else{
                    ///如果当前页面是首页
                    [weakself.dataArr enumerateObjectsUsingBlock:^(ApiShortVideoDtoModel * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                        if (obj.id_field == videoId) {
                            if (self.playCell.model.id_field == videoId) {
                                [self.playCell stopPlayVideo];
                                self.playCell = nil;
                            }
                            [weakself.dataArr removeObjectAtIndex:idx];
                            [weakself.svCollectionView reloadData];
                            *stop = YES;
                        }
                    }];
                }
            }else{
                [SVProgressHUD showInfoWithStatus:strMsg];
            }
        }];
    }];
    [[ProjConfig currentVC] presentViewController:alertVC animated:YES completion:nil];
    
}

@end
