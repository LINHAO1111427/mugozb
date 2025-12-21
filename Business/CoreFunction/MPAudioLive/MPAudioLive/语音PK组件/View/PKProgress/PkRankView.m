//
//  PkRankView.m
//  MPVoiceLive
//
//  Created by CH on 2019/12/18.
//  Copyright © 2019 Orely. All rights reserved.
//

#import "PkRankView.h"
#import <Masonry/Masonry.h>
#import <LibTools/LibTools.h>
#import <SDWebImage/SDWebImage.h>
#import <LiveCommon/LiveManager.h>
#import <LibProjModel/PkGiftSenderModel.h>
#import <LibProjBase/LibProjBase.h>

@interface PkRankGiftCell : UICollectionViewCell

@property(nonatomic, weak) UIImageView *userIcon;

@property(nonatomic, weak) UILabel *rankLb;

@end


@implementation PkRankGiftCell

// MARK: - Lazy
- (UIImageView *)userIcon{
    if (_userIcon == nil) {
        UIImageView *userIcon = [[UIImageView alloc] init];
        userIcon.layer.cornerRadius = 36 / 2 ;
        userIcon.layer.masksToBounds = YES;
        userIcon.layer.borderWidth = 1;
        [self addSubview:userIcon];
        [self sendSubviewToBack:userIcon];
        _userIcon = userIcon;
        [userIcon mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.top.equalTo(self).offset(1);
            make.right.bottom.equalTo(self).offset(-1);
        }];
    }
    return _userIcon;
}

- (UILabel *)rankLb{
    if (_rankLb == nil) {
        
        UIImageView *bgImgV = [[UIImageView alloc] init];
        bgImgV.image = [UIImage imageNamed:@"live_pk_rank"];
        [self addSubview:bgImgV];
        [self bringSubviewToFront:bgImgV];
        [bgImgV mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.equalTo(self.userIcon).mas_offset(0);
            make.size.mas_equalTo(CGSizeMake(20, 10));
            make.centerX.equalTo(self.userIcon);
        }];

        UILabel *rankLb = [[UILabel alloc] init];
        rankLb.font = [UIFont systemFontOfSize:7];
        rankLb.textColor = [UIColor whiteColor];
        rankLb.text = @"1";
        rankLb.textAlignment = NSTextAlignmentCenter;
        [bgImgV addSubview:rankLb];
        _rankLb = rankLb;
        [rankLb mas_makeConstraints:^(MASConstraintMaker *make) {
            make.center.equalTo(bgImgV);
        }];
        
        [bgImgV layoutIfNeeded];
        bgImgV.layer.cornerRadius = 4.5;
        bgImgV.layer.masksToBounds = YES;
        
    }
    return _rankLb;
}

@end




#pragma mark  -- PkRankView --

@interface PkRankView() <UICollectionViewDelegate,UICollectionViewDataSource>

@property(nonatomic, weak) UICollectionView *myRankGiftView;
@property(nonatomic, weak) UICollectionView *enemyRankGiftView;

@property (nonatomic, copy)NSArray *ownItems;
@property (nonatomic, copy)NSArray *otherItems;

@end

@implementation PkRankView


- (instancetype)init
{
    self = [super init];
    if (self) {
        self.myRankGiftView.hidden = NO;
        self.enemyRankGiftView.hidden = NO;

        [_myRankGiftView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.top.bottom.equalTo(self);
            make.width.mas_equalTo(38 * 3 + 6 * 4);
        }];
        
        [_enemyRankGiftView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.top.bottom.equalTo(self);
            make.width.mas_equalTo(38 * 3 + 6 * 4);
        }];
        
        [_myRankGiftView reloadData];
        [_enemyRankGiftView reloadData];
    }
    return self;
}

// MARK: - Lazy
- (UICollectionView *)myRankGiftView{
    if (_myRankGiftView == nil) {
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
        layout.itemSize = CGSizeMake(38, 38);
        layout.minimumInteritemSpacing = 6;
        
        UICollectionView *myRankGiftView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:layout];
        myRankGiftView.delegate = self;
        myRankGiftView.dataSource = self;
        myRankGiftView.backgroundColor = [UIColor clearColor];
        [myRankGiftView registerClass:[PkRankGiftCell class] forCellWithReuseIdentifier:@"PkRankGiftCell"];
        [self addSubview:myRankGiftView];
        _myRankGiftView = myRankGiftView;
    }
    return _myRankGiftView;
}

- (UICollectionView *)enemyRankGiftView{
    if (_enemyRankGiftView == nil) {
        
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
        layout.itemSize = CGSizeMake(38, 38);
        layout.minimumInteritemSpacing = 6;

        UICollectionView *enemyRankGiftView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:layout];
        // 从右向左
        enemyRankGiftView.semanticContentAttribute = UISemanticContentAttributeForceRightToLeft;
        enemyRankGiftView.delegate = self;
        enemyRankGiftView.dataSource = self;
        enemyRankGiftView.backgroundColor = [UIColor clearColor];
        [enemyRankGiftView registerClass:[PkRankGiftCell class] forCellWithReuseIdentifier:@"PkRankGiftCell"];
        [self addSubview:enemyRankGiftView];
        _enemyRankGiftView = enemyRankGiftView;
    }
    return _enemyRankGiftView;
}

// MARK: - UICollectionDataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    if (collectionView == _myRankGiftView) {
        return 3;
    }
    else{
        return 3;
    }
}

- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    PkRankGiftCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"PkRankGiftCell" forIndexPath:indexPath];
    if (collectionView == _myRankGiftView) {
        cell.rankLb.text = [NSString stringWithFormat:@"%d",(indexPath.row + 1)];
        if (_ownItems.count > indexPath.row) {
            PkGiftSenderModel *giftModel = _ownItems[indexPath.row];
            [cell.userIcon sd_setImageWithURL:[NSURL URLWithString:giftModel.avatar] placeholderImage:[ProjConfig getDefaultImage]];
        }else{
            cell.userIcon.image = [UIImage imageNamed:@"live_pk_seat"];
        }
        cell.userIcon.layer.borderColor = kRGB_COLOR(@"#F2A9EB").CGColor;
    }
    else{
        cell.rankLb.text = [NSString stringWithFormat:@"%d", (indexPath.row + 1)];
        if (_otherItems.count > indexPath.row) {
            PkGiftSenderModel *giftModel = _otherItems[indexPath.row];
            [cell.userIcon sd_setImageWithURL:[NSURL URLWithString:giftModel.avatar] placeholderImage:[ProjConfig getDefaultImage]];
        }else{
            cell.userIcon.image = [UIImage imageNamed:@"live_pk_seat"];
        }
        cell.userIcon.layer.borderColor = kRGB_COLOR(@"#A0C8FA").CGColor;
    }
    
    return cell;
}

- (void)changeGiftRank:(NSArray *)ownItems other:(NSArray *)otherItems{
    _ownItems = ownItems;
    _otherItems = otherItems;
    
    [_myRankGiftView reloadData];
    [_enemyRankGiftView reloadData];
}


@end
