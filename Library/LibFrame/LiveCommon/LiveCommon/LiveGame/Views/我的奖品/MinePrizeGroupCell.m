//
//  MinePrizeGroupCell.m
//  LibProjView
//
//  Created by klc_sl on 2020/7/17.
//  Copyright © 2020 . All rights reserved.
//

#import "MinePrizeGroupCell.h"
#import "GamePriceItemCell.h"
#import <SDWebImage/SDWebImage.h>
#import <LibProjModel/GamePrizeRecordModel.h>
#import <Masonry/Masonry.h>
#import <LibProjModel/KLCAppConfig.h>
#import <LibProjBase/LibProjBase.h>

@implementation MinePrizeGroupCell

- (void)awakeFromNib {
    [super awakeFromNib];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

- (UICollectionView *)collV{
    if (!_collV) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
        layout.itemSize = CGSizeMake(80, 120);
        layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        layout.sectionInset = UIEdgeInsetsMake(0, 12, 0, 12);
        layout.minimumLineSpacing = 5;
        layout.minimumInteritemSpacing = 5;
        UICollectionView *collV = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, 1, 1) collectionViewLayout:layout];
        collV.delegate = self;
        collV.dataSource = self;
        collV.backgroundColor = [UIColor clearColor];
        collV.showsHorizontalScrollIndicator = NO;
        [collV registerClass:[GamePriceItemCell class] forCellWithReuseIdentifier:@"GamePriceItemCellIdentifier"];
        [self.contentView addSubview:collV];
        [collV mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(self);
        }];
        _collV = collV;
    }
    return _collV;
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return _items.count;
}


- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    GamePriceItemCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"GamePriceItemCellIdentifier" forIndexPath:indexPath];
    GamePrizeRecordModel *model = _items[indexPath.row];

    if (model.awardsType == 0) {
        cell.imgV.image = [ProjConfig getCoinImage];
        cell.textL.text = [NSString stringWithFormat:@"%@x%0.0lf",[KLCAppConfig unitStr],model.awardsCoin];
    }else{
        [cell.imgV sd_setImageWithURL:[NSURL URLWithString:model.picture]];
        cell.textL.text = [NSString stringWithFormat:@"%@x%d",model.giftName,model.awardsNum];
    }
    return cell;
    
}


- (void)setItems:(NSArray<GamePrizeRecordModel *> *)items{
    _items = items;
    [self.collV reloadData];
}

@end
