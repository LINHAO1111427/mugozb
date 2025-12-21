//
//  GamePrizeListView.m
//  klcProject
//
//  Created by klc_sl on 2020/7/17.
//  Copyright © 2020 KLC. All rights reserved.
//

#import "GamePrizeListView.h"
#import <Masonry/Masonry.h>
#import <SDWebImage/SDWebImage.h>
#import <LibProjModel/GameAwardsVOModel.h>
#import <LibTools/LibTools.h>
#import <LibProjBase/ProjConfig.h>

@interface GamePrizeShowCollVCell : UICollectionViewCell

@property (nonatomic, weak) UIImageView *imgV;
@property (nonatomic, weak) UILabel *titleL;

@end

@implementation GamePrizeShowCollVCell

- (void)layoutSubviews{
    [super layoutSubviews];
    
    self.layer.masksToBounds = YES;
    self.layer.cornerRadius = 4.0;
    self.backgroundColor = kRGBA_COLOR(@"#D8D8D8", 0.2);
}

- (UIImageView *)imgV{
    if (!_imgV) {
        UIImageView *imgV = [[UIImageView alloc] init];
        imgV.contentMode = UIViewContentModeScaleAspectFit;
        [self addSubview:imgV];
        _imgV = imgV;
        [imgV mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(self);
            make.size.mas_equalTo(CGSizeMake(37, 32));
            make.top.equalTo(self).offset(3);
        }];
    }
    return _imgV;
}


- (UILabel *)titleL{
    if (!_titleL) {
        UILabel *titlel = [[UILabel alloc] init];
        titlel.font = [UIFont systemFontOfSize:10];
        titlel.textAlignment = NSTextAlignmentCenter;
        titlel.textColor = [UIColor whiteColor];
        [self addSubview:titlel];
        _titleL = titlel;
        [titlel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.equalTo(self).offset(-3);
            make.left.right.equalTo(self);
            make.height.mas_equalTo(12);
        }];
    }
    return _titleL;
}

@end




@implementation GamePrizeListView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self createUI];
    }
    return self;
}

- (void)createUI{
    
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    layout.itemSize = CGSizeMake(45, 50);
    layout.minimumLineSpacing = 8;
    layout.minimumInteritemSpacing = 0;
    layout.sectionInset = UIEdgeInsetsMake(0, 0, 0, 0);
    layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    UICollectionView *collV = [[UICollectionView alloc] initWithFrame:self.bounds collectionViewLayout:layout];
    collV.delegate = self;
    collV.dataSource = self;
    collV.backgroundColor = [UIColor clearColor];
    collV.showsHorizontalScrollIndicator = NO;
    [collV registerClass:[GamePrizeShowCollVCell class] forCellWithReuseIdentifier:@"GamePrizeShowCollVCellIdentifer"];
    [self addSubview:collV];
    [collV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self);
    }];
    _collV = collV;
    
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return _items.count;
}
- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    GamePrizeShowCollVCell *cellV = [collectionView dequeueReusableCellWithReuseIdentifier:@"GamePrizeShowCollVCellIdentifer" forIndexPath:indexPath];
    GameAwardsVOModel *model = _items[indexPath.row];
    if (model.awardsType == 0) {
        cellV.imgV.image = [ProjConfig getCoinImage];
    }else{
        [cellV.imgV sd_setImageWithURL:[NSURL URLWithString:model.picture]];
    }
    cellV.titleL.attributedText = [[NSString stringWithFormat:@"%0.0lf",model.giftNeedcoin] attachmentForImage:[ProjConfig getCoinImage] bounds:CGRectMake(0, -1.5, 10, 10) before:YES];;
    return cellV;
}


- (void)setItems:(NSArray<GameAwardsVOModel *> *)items{
    _items = items;
    [self.collV reloadData];
    
}


@end
