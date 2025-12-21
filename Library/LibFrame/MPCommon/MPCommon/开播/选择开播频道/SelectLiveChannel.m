//
//  SelectLiveChannel.m
//  LiveCommon
//
//  Created by klc_sl on 2020/3/17.
//  Copyright © 2020 . All rights reserved.
//

#import "SelectLiveChannel.h"
#import <LibTools/LibTools.h>
#import <LibProjBase/LibProjBase.h>
#import <LibProjView/FunctionSheetBaseView.h>
#import <LibProjModel/HttpApiHome.h>
 
#import <Masonry.h>
#import "SelectLiveItemCell.h"



@interface SelectLiveChannel ()<UICollectionViewDelegate,UICollectionViewDataSource>

@property (nonatomic, weak)UICollectionView *collectV;
@property (nonatomic, copy)NSArray *itemArr;
@property (nonatomic, copy)void (^selectChannel)(AppLiveChannelModel *item);
@property (nonatomic, copy)AppLiveChannelModel *selectModel; ///选择的频道

@property (nonatomic, assign)int64_t defaultSelectId;  ///默认选择Id
@property (nonatomic, weak)SelectLiveItemCell *selectCell;

@end

@implementation SelectLiveChannel

+ (void)showType:(int)type selectId:(int64_t)selectId selectBlock:(void (^)(AppLiveChannelModel * _Nonnull))block{
    kWeakSelf(self);
    [HttpApiHome getLiveChannel:type callback:^(int code, NSString *strMsg, NSArray<AppLiveChannelModel *> *arr) {
        if (code == 1) {
            [weakself createUI:arr block:block selectId:selectId] ;
        }else{
            [SVProgressHUD showInfoWithStatus:strMsg];
        }
    }];
}

+ (void)createUI:(NSArray *)items block:(void (^)(AppLiveChannelModel *item))block selectId:(int64_t)selectId{
    SelectLiveChannel *channelV = [[self alloc] init];
    channelV.selectChannel = block;
    channelV.defaultSelectId = selectId;
    [channelV show:items];
}

- (void)show:(NSArray *)itemArr{
    self.itemArr = itemArr;
    self.frame = CGRectMake(0, 0, kScreenWidth, self.collectV.height+40+60);
    [self.collectV reloadData];
    UIButton *sureBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, self.collectV.maxY+30, 240, 40)];
    sureBtn.backgroundColor = [ProjConfig normalColors];
    sureBtn.layer.masksToBounds = YES;
    sureBtn.layer.cornerRadius = 20;
    [sureBtn setTitle:kLocalizationMsg(@"完成") forState:UIControlStateNormal];
    [sureBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    sureBtn.titleLabel.font = [UIFont systemFontOfSize:16];
    [self addSubview:sureBtn];
    sureBtn.centerX = self.centerX;
    kWeakSelf(self);
    [sureBtn klc_whenTapped:^{
        if (!weakself.selectModel) {
            [SVProgressHUD showInfoWithStatus:kLocalizationMsg(@"请选择频道")];
        }
        if (weakself.selectChannel && weakself.selectModel) {
            weakself.selectChannel(weakself.selectModel);
            [FunctionSheetBaseView deletePopView:self];
        }
    }];
    
    [FunctionSheetBaseView showTitle:kLocalizationMsg(@"选择直播频道") detailView:self cover:NO];
}

- (UICollectionView *)collectV{
    if (_collectV == nil) {
        NSInteger lineNum = _itemArr.count/4+(_itemArr.count%4>0?1:0);
        
        UICollectionViewFlowLayout *flow = [[UICollectionViewFlowLayout alloc] init];
        flow.sectionInset = UIEdgeInsetsMake(20, 20, 20, 20);
        flow.itemSize = CGSizeMake((kScreenWidth-40-50)/4.0, 30);
        flow.minimumLineSpacing = 15;
        flow.minimumInteritemSpacing = 15;
        flow.scrollDirection = UICollectionViewScrollDirectionVertical;
        CGFloat collH = lineNum *30+ (lineNum-1)*15+40;
        
        UICollectionView *collV = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, collH) collectionViewLayout:flow];
        collV.delegate = self;
        collV.dataSource = self;
        collV.scrollEnabled = NO;
        collV.bounces = NO;
        collV.backgroundColor = [UIColor whiteColor];
        [collV registerClass:[SelectLiveItemCell class] forCellWithReuseIdentifier:@"SelectLiveItemCellIdentifier"];
        [self addSubview:collV];
        _collectV = collV;
    }
    return _collectV;
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return _itemArr.count;

}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    AppLiveChannelModel *model = _itemArr[indexPath.item];
    SelectLiveItemCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"SelectLiveItemCellIdentifier" forIndexPath:indexPath];
    cell.titleL.text = model.title;
    if (_defaultSelectId == model.id_field) {
        _selectModel = model;
        _selectCell = cell;
        [cell selectItem:YES];
    }else{
        [cell selectItem:NO];
    }
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    _selectModel = _itemArr[indexPath.item];
    [_selectCell selectItem:NO];
    _selectCell = (SelectLiveItemCell *)[collectionView cellForItemAtIndexPath:indexPath];
    [_selectCell selectItem:YES];
}


@end
