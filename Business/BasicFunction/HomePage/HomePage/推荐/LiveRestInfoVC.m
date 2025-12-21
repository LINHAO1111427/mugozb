//
//  LiveRestInfoVC.m
//  HomePage
//
//  Created by klc on 2020/6/5.
//  Copyright © 2020 klc. All rights reserved.
//

#import "LiveRestInfoVC.h"
#import <LibTools/LibTools.h>
#import <LibProjBase/LibProjBase.h>
#import "RestAnchorInfoView.h"
#import "HomeLiveVideoItemCell.h"
#import <LibProjView/CollectionWaterfallLayout.h>
#import <Masonry/Masonry.h>
#import <LibProjView/CheckRoomPermissions.h>

@interface LiveRestInfoVC ()<UICollectionViewDelegate, UICollectionViewDataSource, CollectionWaterfallLayoutDelegate>

@property (nonatomic, strong)RestAnchorInfoView *headerV;

@property (nonatomic, weak)UICollectionView *weakCollView;

@property (nonatomic, copy)NSArray *allArray;

@property (nonatomic, copy)CollectionWaterfallLayout *layout;

@end

@implementation LiveRestInfoVC

- (UIBarButtonItem *)rt_customBackItemWithTarget:(id)target action:(SEL)action{
    [BaseNavBarItem navBarBgClear:self foregroundColor:[UIColor whiteColor]];
    return [[UIBarButtonItem alloc] initWithCustomView:[BaseNavBarItem navBackBtnImage:[UIImage imageNamed:@"main_navbar_back"] target:target action:action]];
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationController.navigationBar.translucent = YES;
    
    [self.weakCollView reloadData];
    
    [self.view addSubview:_headerV];
    
    [self loadListData];
}

- (UICollectionView *)weakCollView{
    if (!_weakCollView) {
        CollectionWaterfallLayout *waterfallLayout = [[CollectionWaterfallLayout alloc] init];
        waterfallLayout.delegate = self;
        waterfallLayout.scrollDirection = UICollectionViewScrollDirectionVertical;
        waterfallLayout.headerReferenceSize = CGSizeMake(kScreenWidth,kScreenWidth);
        waterfallLayout.footerReferenceSize = CGSizeMake(0, 0);
        _layout = waterfallLayout;
        UICollectionView *collV = [[UICollectionView alloc] initWithFrame:CGRectMake(0, -kNavBarHeight, kScreenWidth, kScreenHeight+kNavBarHeight) collectionViewLayout:waterfallLayout];
        collV.dataSource = self;
        collV.delegate = self;
        collV.backgroundColor = [UIColor whiteColor];
        [collV registerClass:[RestAnchorInfoView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"RestAnchorInfoView"];
        [collV registerClass:[HomeLiveVideoItemCell class] forCellWithReuseIdentifier:@"HomeLiveVideoItemCell"];
        [self.view addSubview:collV];
        _weakCollView = collV;
    }
    return _weakCollView;
}

#pragma mark - 加载数据

- (void)loadListData{
    Home_getHomeDataList *list = [[Home_getHomeDataList alloc]init];
    list.pageIndex = 0;
    list.pageSize = 6;
    list.channelId = -1;
    list.hotSortId = -1;
    list.sex = -1;
    list.address = @"";
    list.tabIds = @"";
    list.liveType = [self.liveType intValue];
    list.isRecommend = -1;
    list.isLive = 1;
    kWeakSelf(self);
    [HttpApiHome getHomeDataList:list callback:^(int code, NSString *strMsg, NSArray<AppHomeHallDTOModel *> *arr) {
        if (code == 1) {
            weakself.allArray = arr;
            if (arr.count > 0) {
                weakself.layout.headerReferenceSize =  CGSizeMake(kScreenWidth,kScreenWidth+60);
            }
            [weakself.weakCollView reloadData];
        }else{
            [SVProgressHUD showInfoWithStatus:strMsg];
        }
    }];
}

//获取header的collection直播列表

#pragma mark - UICollectionViewDelegate dataSource
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.allArray.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    HomeLiveVideoItemCell *cell = (HomeLiveVideoItemCell *)[collectionView dequeueReusableCellWithReuseIdentifier:@"HomeLiveVideoItemCell" forIndexPath:indexPath];
    cell.model = (self.allArray.count > indexPath.item)?self.allArray[indexPath.row]:nil;
    return cell;
}


-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    [collectionView deselectItemAtIndexPath:indexPath animated:YES];
    if (self.allArray.count > indexPath.item) {
        AppHomeHallDTOModel *model = self.allArray[indexPath.row];
        kWeakSelf(self);
        [[CheckRoomPermissions share] joinRoom:model.roomId liveDataType:model.liveType joinRoom:^(AppJoinRoomVOModel * _Nonnull joinModel) {
            LiveRoomListReqParam *req = [[LiveRoomListReqParam alloc] init];
            req.joinPosition = 8;
            [[CheckRoomPermissions share] joinRoomForModel:joinModel currentVC:weakself otherInfo:req];
        } closeRoom:^(AppHomeHallDTOModel * _Nonnull dtoModel) {
            [[CheckRoomPermissions share] showDetail:dtoModel currentVC:weakself];
        } fail:nil];
    }
}


- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath{
    if (kind == UICollectionElementKindSectionHeader) {//直播首页
        if (!_headerV) {
            _headerV = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:@"RestAnchorInfoView" forIndexPath:indexPath];
            _headerV.layer.masksToBounds = YES;
            _headerV.dtoModel = self.dtoModel;
        }
        if (_allArray.count > 0) {
            self.headerV.noDataView.hidden = NO;
        }
        return self.headerV;
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
    return 10.0f;
}

/**
 * 每行之间的间距
 */
- (CGFloat)rowMarginInWaterFallLayout:(CollectionWaterfallLayout *)waterFallLayout{
    return 10.0f;
}

/**
 * 每个item的内边距
 */
- (UIEdgeInsets)edgeInsetdInWaterFallLayout:(CollectionWaterfallLayout *)waterFallLayout{
    return UIEdgeInsetsMake(0, 10, 0, 10);
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
}
- (void)listWillDisappear{
}


@end
