//
//  GuardUserShowView.m
//  LiveCommon
//
//  Created by klc_sl on 2020/3/21.
//  Copyright © 2020 . All rights reserved.
//

#import "GuardUserShowView.h"
#import <LibTools/LibTools.h>
#import <LibProjBase/LibProjBase.h>
#import <Masonry/Masonry.h>
#import <SDWebImage/SDWebImage.h>
#import <LibProjModel/GuardUserVOModel.h>
#import <LiveCommon/LiveComponentMsgListener.h>
#import <LiveCommon/LiveComponentMsgMgr.h>
#import <LiveCommon/LiveManager.h>
#import <LibProjModel/HttpApiUserController.h>
#import <LibProjModel/HttpApiGuard.h>
 
@interface GuardUserItemCell : UICollectionViewCell
@property (nonatomic, weak)UIButton *userIcon;
@end

@implementation GuardUserItemCell
- (UIButton *)userIcon{
    if (!_userIcon) {
        UIButton *userIcon = [UIButton buttonWithType:0];
        userIcon.imageView.contentMode = UIViewContentModeScaleToFill;
        userIcon.layer.masksToBounds = YES;
        [self.contentView addSubview:userIcon];
        _userIcon = userIcon;
        [userIcon mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(self);
        }];
        [userIcon layoutIfNeeded];
        userIcon.layer.cornerRadius = userIcon.frame.size.height/2.0;
    }
    return _userIcon;
}
@end

@interface GuardUserShowView () <UICollectionViewDelegate,UICollectionViewDataSource>

@property (nonatomic, weak)UIButton *guardBtn;
@property (nonatomic, weak)UICollectionView *collV;
@property (nonatomic, copy)NSArray<GuardUserVOModel *> *userItems;

@end

@implementation GuardUserShowView

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self createView];
        [self reloadData];
    }
    return self;
}

- (void)showGuardUser:(NSArray<GuardUserVOModel *> *)arr {
    _userItems = arr;
    [self.collV reloadData];
    NSInteger numUser = _userItems.count>2?2:_userItems.count;
    [_collV mas_updateConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(numUser*30);
    }];
    [_collV layoutIfNeeded];
}

- (void)createView{
    
    UIButton *guardBgView = [UIButton buttonWithType:0];
    guardBgView.layer.masksToBounds = YES;
    [self addSubview:guardBgView];
    [guardBgView addTarget:self action:@selector(guardBtnClick) forControlEvents:UIControlEventTouchUpInside];
    _guardBtn = guardBgView;
    
    UIView *coverV = [[UIView alloc] init];
    coverV.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.2];
    coverV.userInteractionEnabled = NO;
    [guardBgView addSubview:coverV];
    
    UIImageView *imgV = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"live_shouhu_pink"]];
    [guardBgView addSubview:imgV];
    
    UILabel *textL = [[UILabel alloc] init];
    textL.text = kLocalizationMsg(@"守护主播");
    textL.font = [UIFont systemFontOfSize:12];
    textL.textAlignment = NSTextAlignmentCenter;
    textL.userInteractionEnabled = NO;
    textL.textColor = [UIColor whiteColor];
    [guardBgView addSubview:textL];
    
    [guardBgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(80, 20));
        make.centerY.equalTo(self);
        make.right.equalTo(self);
    }];
    [coverV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(guardBgView);
    }];
    [imgV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(20, 20));
        make.centerY.equalTo(guardBgView);
        make.left.equalTo(guardBgView);
        make.right.equalTo(textL.mas_left).mas_offset(4);
    }];
    [textL mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(guardBgView);
        make.right.equalTo(guardBgView);
    }];
    
    [guardBgView layoutIfNeeded];
    guardBgView.layer.cornerRadius = guardBgView.height/2.0;
    
}

- (UICollectionView *)collV{
    if (!_collV) {
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
        layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        layout.minimumInteritemSpacing = 0;
        layout.minimumLineSpacing = 10;
        layout.itemSize = CGSizeMake(20, 20);
        layout.sectionInset = UIEdgeInsetsMake(0, 5, 0, 5);
        layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        UICollectionView *collectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 0,100, self.height) collectionViewLayout:layout];
        collectionView.delegate = self;
        collectionView.dataSource = self;
        collectionView.backgroundColor = [UIColor clearColor];
        [collectionView registerClass:[GuardUserItemCell class] forCellWithReuseIdentifier:@"GuardUserItemCell"];
        [self addSubview:collectionView];
        [collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self);
            make.width.mas_equalTo(30);
            make.top.bottom.equalTo(self);
            make.right.equalTo(_guardBtn.mas_left).mas_offset(-5);
        }];
        _collV = collectionView;
    }
    return _collV;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return _userItems.count>2?2:_userItems.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    GuardUserVOModel *guardModel = _userItems[indexPath.item];
    GuardUserItemCell *itemCell = [collectionView dequeueReusableCellWithReuseIdentifier:@"GuardUserItemCell" forIndexPath:indexPath];
    [itemCell.userIcon sd_setImageWithURL:[NSURL URLWithString:guardModel.userHeadImg] forState:UIControlStateNormal placeholderImage:[ProjConfig getDefaultImage]];
    kWeakSelf(indexPath);
    kWeakSelf(self);
    [itemCell.userIcon klc_whenTapped:^{
        GuardUserVOModel *guard = weakself.userItems[weakindexPath.item];
        [LiveComponentMsgMgr sendMsg:LM_ShowUserInfo msgDic:@{@"userID":@(guard.userId)}];
    }];
    return itemCell;
}

- (void)guardBtnClick{
    [LiveComponentMsgMgr sendMsg:LM_GuardInfo msgDic:nil];
}


-(void)reloadData{
    kWeakSelf(self);
    [HttpApiGuard getMyGuardList:0 pageSize:10 queryType:1 type:2 userId:[LiveManager liveInfo].anchorId callback:^(int code, NSString *strMsg, NSArray<GuardUserVOModel *> *arr) {
        if (code == 1) {
            [weakself showGuardUser:arr];
        }
    }];
}


@end
