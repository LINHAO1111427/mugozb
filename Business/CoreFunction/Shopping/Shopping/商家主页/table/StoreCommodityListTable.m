//
//  StoreCommodityListTable.m
//  Shopping
//
//  Created by klc on 2020/7/22.
//  Copyright © 2020 klc. All rights reserved.
//

#import "StoreCommodityListTable.h"
#import <LibProjView/CommodityListCollectionCell.h>
@interface StoreCommodityListTable()<
UICollectionViewDelegate,
UICollectionViewDataSource
>
@property (nonatomic, copy) void(^scrollCallback)(UIScrollView *scrollView);
@end

@implementation StoreCommodityListTable
- (NSArray<ShopGoodsDTOModel *> *)dataArray{
    if (!_dataArray) {
        _dataArray = [NSArray array];
    }
    return _dataArray;
}
- (instancetype)initWithFrame:(CGRect)frame collectionViewLayout:(UICollectionViewLayout *)layout{
    self = [super initWithFrame:frame collectionViewLayout:layout];
    if (self) {
        self.delegate = self;
        self.dataSource = self;
        self.backgroundColor = kRGB_COLOR(@"#F4F4F4");
        [self registerClass:[CommodityListCollectionCell class] forCellWithReuseIdentifier:@"storeCommodityCell"];
        [self registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"storeCommoditySectionheader"];
    }
    return self;
}
 
#pragma mark - UICollectionViewDataSource, UICollectionViewDelegate
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

- (nonnull __kindof UICollectionViewCell *)collectionView:(nonnull UICollectionView *)collectionView cellForItemAtIndexPath:(nonnull NSIndexPath *)indexPath {
    ShopGoodsDTOModel *model;
    if (indexPath.row < self.dataArray.count) {
        model = self.dataArray[indexPath.row];
    }
    CommodityListCollectionCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"storeCommodityCell" forIndexPath:indexPath];
    if (model) {
        cell.model = model;
    }
    return cell;
}

- (NSInteger)collectionView:(nonnull UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.dataArray.count;
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath {
    UICollectionReusableView *reusableview = nil;
    if (kind == UICollectionElementKindSectionHeader) {
        if (indexPath.section == 0) {
            UICollectionReusableView *headerView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"storeCommoditySectionheader" forIndexPath:indexPath];
            [headerView removeAllSubViews];
            headerView.backgroundColor = [UIColor clearColor];
            reusableview = headerView;
        }else{
            UICollectionReusableView *headerView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"defaultSectionHeader" forIndexPath:indexPath];
            reusableview = headerView;
        }
    }
    return reusableview;
    
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    ShopGoodsDTOModel *model;
    if (indexPath.row < self.dataArray.count) {
        model = self.dataArray[indexPath.row];
    }
    if (model) {
        if (model.channelId == 1) {
            NSDictionary *params = @{@"goodId":@(model.goodsId)};
            [RouteManager routeForName:RN_Shopping_Commodity_DetailVC currentC:self.superVc parameters:params];
        }else{
            if ([[UIApplication sharedApplication]canOpenURL:[NSURL URLWithString:model.productLinks]]) {
                [[UIApplication sharedApplication] openURL:[NSURL URLWithString:model.productLinks]];
            }
        }
    }
}
#pragma mark - JXPagingViewListViewDelegate
- (void)listDidAppear{
    [self reloadData];
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
