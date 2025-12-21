//
//  AudioSelectPkView.m
//  MPVoiceLive
//
//  Created by CH on 2019/12/19.
//  Copyright © 2019 Orely. All rights reserved.
//

#import "AudioSelectPkView.h"
#import <Masonry/Masonry.h>
#import <LiveCommon/LiveComponentMsgListener.h>
#import <LiveCommon/LiveComponentMsgMgr.h>
#import <LibTools/LibTools.h>
#import <LibProjView/FunctionSheetBaseView.h>

@interface AudioSelectPkCell : UICollectionViewCell

@property(nonatomic,weak) UIButton *selectBtn;

@end

@implementation AudioSelectPkCell

- (UIButton *)selectBtn{
    if (_selectBtn == nil) {
        UIButton *selectBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        selectBtn.userInteractionEnabled = NO;
        [self addSubview:selectBtn];
        _selectBtn = selectBtn;
        [selectBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(self);
        }];
    }
    return _selectBtn;
}

@end



@interface AudioSelectPkView()<UICollectionViewDelegate , UICollectionViewDataSource, UICollectionViewDelegateFlowLayout>

@property(nonatomic,weak) UICollectionView *selectPkCollection;
@property(nonatomic,copy) NSArray *itemImageNameArr;

@property (nonatomic, copy)void (^selectTypeBlock)(LiveInfo_PKType);

@end

@implementation AudioSelectPkView

+ (void)showAndSelectType:(void (^)(LiveInfo_PKType))block{
    
    AudioSelectPkView *pkSelectV = [[AudioSelectPkView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 241)];
    pkSelectV.selectTypeBlock = block;
    [pkSelectV createUI];
    [FunctionSheetBaseView showView:pkSelectV cover:NO];
}

- (void)createUI{
    _itemImageNameArr = @[@{@"image":@"mg_danrenPK_con",@"type":@(LivePKTypeForSingle)},
                          @{@"image":@"mg_jiqingtuanzhan_icon",@"type":@(LivePKTypeForTeam)},
                          @{@"image":@"mg_fangjianPK_icon",@"type":@(LivePKTypeForRoom)},];
    self.selectPkCollection.hidden = NO;
    [_selectPkCollection reloadData];
    
    UIButton *closeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [closeBtn setImage:[UIImage imageNamed:@"live_guanbi_gray"] forState:UIControlStateNormal];
    [closeBtn addTarget:self action:@selector(clickCloseBtn:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:closeBtn];
    
    [closeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self);
        make.size.mas_equalTo(CGSizeMake(18, 18));
        make.bottom.equalTo(self).offset(-26);
    }];
}


- (void)clickCloseBtn:(UIButton *)sender{
    [FunctionSheetBaseView deletePopView:self];
}



- (UICollectionView *)selectPkCollection{
    if (_selectPkCollection == nil) {
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
        layout.itemSize = CGSizeMake(80, 106);
        CGFloat space = (self.width - _itemImageNameArr.count * layout.itemSize.width)/(_itemImageNameArr.count+1);
        layout.sectionInset = UIEdgeInsetsMake(1, space, 1, space);
        layout.minimumLineSpacing = 1;
        layout.minimumInteritemSpacing = space-10;
        layout.scrollDirection = UICollectionViewScrollDirectionVertical;
        UICollectionView *selectPkCollection = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 42, self.width, 108) collectionViewLayout:layout];
        [selectPkCollection registerClass:[AudioSelectPkCell class] forCellWithReuseIdentifier:@"AudioSelectPkCell"];
        selectPkCollection.backgroundColor = [UIColor clearColor];
        selectPkCollection.delegate = self;
        selectPkCollection.dataSource = self;
        [self addSubview:selectPkCollection];
        _selectPkCollection = selectPkCollection;
    }
    return _selectPkCollection;
}


// MARK: - CollectionDataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return _itemImageNameArr.count;
}

- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    AudioSelectPkCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"AudioSelectPkCell" forIndexPath:indexPath];
    NSDictionary *dic = _itemImageNameArr[indexPath.row];
    [cell.selectBtn setImage:[UIImage imageNamed:dic[@"image"]] forState:UIControlStateNormal];
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
    NSDictionary *dic = _itemImageNameArr[indexPath.row];
    if (self.selectTypeBlock) {
        self.selectTypeBlock([dic[@"type"] integerValue]);
    }
    [FunctionSheetBaseView deletePopView:self];
    
}

@end
