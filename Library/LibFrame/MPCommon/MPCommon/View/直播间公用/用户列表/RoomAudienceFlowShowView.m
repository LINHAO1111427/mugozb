//
//  RoomAudienceFlowShowView.m
//  LiveCommon
//
//  Created by admin on 2020/1/15.
//  Copyright © 2020 . All rights reserved.
//

#import "RoomAudienceFlowShowView.h"
#import <LibProjModel/ApiUserBasicInfoModel.h>
#import <LibTools/LibTools.h>
#import <LiveCommon/LiveComponentMsgListener.h>
#import <LiveCommon/LiveComponentMsgMgr.h>
#import <LiveCommon/LiveManager.h>
#import <Masonry/Masonry.h>
#import <SDWebImage/SDWebImage.h>
#import <LibProjBase/LibProjBase.h>
#import <LibProjModel/KLCUserInfo.h>
#import <MPCommon/LiveUserListView.h>
#import <LibProjView/KlcAvatarView.h>

@interface LiveRoomUserItemCell : UICollectionViewCell
@property (nonatomic, weak)KlcAvatarView *userIcon;
@end

@implementation LiveRoomUserItemCell
- (KlcAvatarView *)userIcon{
    if (!_userIcon) {
        KlcAvatarView *userIcon = [[KlcAvatarView alloc] init];
        [self.contentView addSubview:userIcon];
        _userIcon = userIcon;
        [userIcon mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(self);
        }];
    }
    return _userIcon;
}
@end


@interface RoomAudienceFlowShowView ()<UICollectionViewDelegate,UICollectionViewDataSource>

@property (nonatomic, weak)UICollectionView *collV;
@property (nonatomic, weak)UIButton *numBtn;
@property (nonatomic, copy)NSArray *userItems;

@property (nonatomic, assign)CGFloat maxWidth;

@end

@implementation RoomAudienceFlowShowView

- (instancetype)init
{
    self = [super init];
    if (self) {
        _maxWidth = kScreenWidth-liveHeaderBannerW-150;
    }
    return self;
}

- (void)showUserInfo:(NSArray<ApiUserBasicInfoModel *> *)listModel userWatchNumber:(int)userWatchNumber {
    _userItems = listModel;
    
    [self.numBtn setTitle:[NSString stringWithFormat:@"%d", userWatchNumber] forState:UIControlStateNormal];
    [self.collV reloadData];
    
    NSInteger numUser = _userItems.count>3?3:_userItems.count;
    [_collV mas_updateConstraints:^(MASConstraintMaker *make) {
        CGFloat minW = MIN(numUser * 35, self.maxWidth);
        make.width.mas_equalTo(minW);
    }];
    [_collV layoutIfNeeded];
}

- (UICollectionView *)collV{
    if (!_collV) {
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
        layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        layout.minimumInteritemSpacing = 0;
        layout.minimumLineSpacing = 5;
        layout.itemSize = CGSizeMake(30, 30);
        layout.sectionInset = UIEdgeInsetsMake(0, 2, 0, 2);
        layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        UICollectionView *collectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 0,100, self.height) collectionViewLayout:layout];
        collectionView.delegate = self;
        collectionView.dataSource = self;
        collectionView.backgroundColor = [UIColor clearColor];
        collectionView.showsHorizontalScrollIndicator = NO;
        [collectionView registerClass:[LiveRoomUserItemCell class] forCellWithReuseIdentifier:@"LiveRoomUserItemCellIdentifier"];
        [self addSubview:collectionView];
        [collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self);
            make.width.mas_equalTo(30);
//            make.top.bottom.equalTo(self);
            make.height.mas_equalTo(40);
            make.left.equalTo(self).mas_offset(0);
        }];
        _collV = collectionView;
    }
    return _collV;
}

- (UIButton *)numBtn{
    if (!_numBtn) {
        ///直播间人数
        UIButton *numBtn = [UIButton buttonWithType:0];
        numBtn.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.4];
        numBtn.layer.cornerRadius = YES;
        [numBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        numBtn.titleLabel.font = [UIFont systemFontOfSize:10];
        [numBtn addTarget:self action:@selector(userListShow) forControlEvents:UIControlEventTouchUpInside];
        numBtn.contentEdgeInsets = UIEdgeInsetsMake(0, 15, 0, 15);
        [self addSubview:numBtn];
        [numBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.mas_equalTo(30);
            make.right.equalTo(self).mas_offset(-2);
            make.left.equalTo(self.collV.mas_right).mas_offset(5);
            make.centerY.equalTo(self);
        }];
        [numBtn layoutIfNeeded];
        numBtn.layer.cornerRadius = numBtn.height/2.0;
        _numBtn = numBtn;
    }
    return _numBtn;
}

- (void)userListShow{
    [LiveUserListView showUserListView];
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return _userItems.count>3?3:_userItems.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    ApiUserBasicInfoModel *infoModel = _userItems[indexPath.item];
    LiveRoomUserItemCell *itemCell = [collectionView dequeueReusableCellWithReuseIdentifier:@"LiveRoomUserItemCellIdentifier" forIndexPath:indexPath];
    [itemCell.userIcon showUserIconUrl:infoModel.avatar vipBorderUrl:infoModel.nobleAvatarFrame];
    kWeakSelf(indexPath);
    kWeakSelf(self);
    [itemCell.userIcon klc_whenTapped:^{
        ApiUserBasicInfoModel *infoModel = weakself.userItems[weakindexPath.item];
        [LiveComponentMsgMgr sendMsg:LM_ShowUserInfo msgDic:@{@"userID":@(infoModel.uid)}];
    }];
    return itemCell;
}


@end
