//
//  SoundEffectView.m
//  LiveCommon
//
//  Created by klc_sl on 2020/7/30.
//  Copyright © 2020 KLC. All rights reserved.
//

#import "SoundEffectView.h"
#import <LiveCommon/LiveManager.h>
#import <LibTools/LibTools.h>
#import <LibProjView/FunctionSheetBaseView.h>
#import <LibProjModel/HttpApiHttpVoice.h>
#import <SDWebImage.h>
#import "SoundEffectItemCell.h"
#import <AgoraExtension/AgoraExtManager.h>
#import <LibProjView/EmptyView.h>
#import <LibProjModel/HttpApiPublicLive.h>
#import <LibProjModel/AppLiveEffectVOModel.h>

@interface SoundEffectView () <UICollectionViewDelegate, UICollectionViewDataSource>

@property (nonatomic, weak) UICollectionView *collV;

@property(nonatomic, copy)NSArray *getEffectList;

@property (nonatomic, weak) EmptyView *emptyV;


@end

@implementation SoundEffectView

+ (void)showEffect{
    SoundEffectView *emoji = [[SoundEffectView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 240)];
    [emoji createUI];
}

- (EmptyView *)emptyV{
    if (!_emptyV) {
        EmptyView *emptyV = [[EmptyView alloc] init];
        [emptyV showInView:self];
        _emptyV = emptyV;
    }
    return _emptyV;
}

- (void)createUI{
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    layout.itemSize = CGSizeMake((self.width-30)/4.0, 100);
    layout.sectionInset = UIEdgeInsetsMake(20, 12, 20, 12);
    layout.minimumInteritemSpacing = 0.0;
    layout.minimumLineSpacing = 0.0;
    UICollectionView *collV = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, self.width, self.height) collectionViewLayout:layout];
    collV.delegate = self;
    collV.dataSource = self;
    collV.backgroundColor = [UIColor whiteColor];
    [collV registerClass:[SoundEffectItemCell class] forCellWithReuseIdentifier:@"SoundEffectItemCellIdentifer"];
    [self addSubview:collV];
    _collV = collV;
    [FunctionSheetBaseView showView:self cover:NO];
    
    [self loadShowData];
}

- (void)loadShowData{
    kWeakSelf(self);
    [HttpApiPublicLive getAppLiveEffectAll:^(int code, NSString *strMsg, NSArray<AppLiveEffectVOModel *> *arr) {
        if (code == 1) {
            weakself.getEffectList = arr;
            [weakself.collV reloadData];
        }
        weakself.emptyV.hidden = arr.count;
        weakself.emptyV.detailL.text = strMsg;
    }];
    
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.getEffectList.count;
}

- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    SoundEffectItemCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"SoundEffectItemCellIdentifer" forIndexPath:indexPath];
    AppLiveEffectVOModel *voModel = self.getEffectList[indexPath.row];
    [cell.imageV sd_setImageWithURL:[NSURL URLWithString:voModel.effectImg]];
    cell.titleLab.text = voModel.effectName;
    return cell;
    
}

// MARK: - Delegate
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    AppLiveEffectVOModel *voModel = self.getEffectList[indexPath.row];
    [[AgoraExtManager music] playEffectFilePath:voModel.effectUrl soundId:1];
}

@end
