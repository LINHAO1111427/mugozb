//
//  CommodityReommendListCell.m
//  Shopping
//
//  Created by klc_sl on 2021/10/14.
//  Copyright © 2021 KLC. All rights reserved.
//

#import "CommodityReommendListCell.h"
#import <LibProjView/CommodityListCollectionCell.h>
#import <LibProjModel/ShopGoodsDTOModel.h>

@interface CommodityReommendListCell ()<UICollectionViewDelegate, UICollectionViewDataSource>

@property (nonatomic, weak)UICollectionView *weakCollView;

@end

@implementation CommodityReommendListCell


- (UICollectionView *)weakCollView{
    if (!_weakCollView) {

        CGSize cellItemSize = [CommodityReommendListCell getCellSize];
        CGFloat margin = (kScreenWidth-2*cellItemSize.width)/3.0;

        UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
        flowLayout.itemSize = cellItemSize;
        flowLayout.sectionInset = UIEdgeInsetsMake(0, margin, 0, margin);
        flowLayout.minimumLineSpacing = margin;
        flowLayout.minimumInteritemSpacing = margin;
        flowLayout.scrollDirection = UICollectionViewScrollDirectionVertical;
        UICollectionView *collV = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:flowLayout];
        collV.dataSource = self;
        collV.delegate = self;
        collV.scrollEnabled = NO;
        collV.bounces = NO;
        collV.backgroundColor = [UIColor whiteColor];
        [collV registerClass:[CommodityListCollectionCell class] forCellWithReuseIdentifier:@"CommodityListCollectionCellID"];
        [self addSubview:collV];
        _weakCollView = collV;
        [collV mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(self);
        }];
        [collV layoutIfNeeded];
    }
    return _weakCollView;
}


- (void)setItemArr:(NSArray<ShopGoodsDTOModel *> *)itemArr{
    _itemArr = itemArr;
    [self.weakCollView reloadData];
}


#pragma mark - UICollectionViewDelegate dataSource
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.itemArr.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    CommodityListCollectionCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"CommodityListCollectionCellID" forIndexPath:indexPath];
    cell.model = (self.itemArr.count > indexPath.item)?self.itemArr[indexPath.row]:nil;
    return cell;
}


-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    [collectionView deselectItemAtIndexPath:indexPath animated:YES];
    if (self.itemArr.count > 0) {
        ShopGoodsDTOModel *dtoModel = self.itemArr[indexPath.item];
        self.delegate?[self.delegate CommodityReommendListCell:self selectOneGoods:dtoModel]:nil;
    }
}


+ (CGFloat)viewHeight:(NSInteger)number{
    
    NSInteger lineNum = number/2+number%2;
    
    CGSize cellItemSize = [CommodityReommendListCell getCellSize];
    
    CGFloat margin = (kScreenWidth-2*cellItemSize.width)/3.0;
    
    CGFloat cellH = cellItemSize.height+margin;
    
    return lineNum * cellH;
}


+ (CGSize)getCellSize{
    CGFloat cellWidth = kScreenWidth*162/360.0;
    return  CGSizeMake(cellWidth, cellWidth + 70);
}


@end
