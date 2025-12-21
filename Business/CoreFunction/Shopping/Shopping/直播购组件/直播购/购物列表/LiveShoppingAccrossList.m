//
//  LiveShoppingAccrossList.m
//  LiveCommon
//
//  Created by klc_sl on 2020/7/4.
//  Copyright © 2020 . All rights reserved.
//

#import "LiveShoppingAccrossList.h"
#import <LibTools/LibTools.h>
#import <LiveCommon/LiveManager.h>
#import "LiveShoppingAccrossCell.h"
#import <LibProjModel/HttpApiShopGoods.h>
#import <LibProjModel/ShopLiveGoodsModel.h>
#import <LiveCommon/LiveComponentMsgMgr.h>
#import <LiveCommon/LiveComponentMsgListener.h>
#import <LibProjBase/LibProjBase.h>
#import <LibProjView/EmptyView.h>

@interface LiveShoppingAccrossList ()<UICollectionViewDataSource, UICollectionViewDelegate>

@property (nonatomic, weak)UICollectionView *collV;

@property (nonatomic, copy)NSArray<ShopLiveGoodsModel *> *itemArr;

@property (nonatomic, weak)EmptyView *emptyV;
@end


@implementation LiveShoppingAccrossList

- (EmptyView *)emptyV{
    if (!_emptyV) {
        EmptyView *emptyView = [[EmptyView alloc] init];
        emptyView.titleL.text = @"";
        emptyView.detailL.text = kLocalizationMsg(@"～暂无商品～");
        [emptyView showInView:self.collV];
        _emptyV = emptyView;
    }
    return _emptyV;
}
+ (void)showGoodsList{
    LiveShoppingAccrossList *shppping = [[LiveShoppingAccrossList alloc] initWithFrame:CGRectMake(12, kScreenHeight - kSafeAreaBottom - liveBottomViewH - 5 - 120, kScreenWidth-24, 120)];
    [shppping getLiveGoods];
    [[PopupTool share] createPopupViewWithLinkView:shppping allowTapOutside:YES];
}

- (void)getLiveGoods{
    kWeakSelf(self);
    [HttpApiShopGoods getLiveGoods:[LiveManager liveInfo].anchorId callback:^(int code, NSString *strMsg, ShopLiveGoodsDTOModel *model) {
        if (code == 1) {
            weakself.itemArr = model.liveGoodsList;
            BOOL hasGoodExplain = NO;
            ShopLiveGoodsModel *mm;
            for (ShopLiveGoodsModel *mod in model.liveGoodsList) {
                if (mod.idExplain) {
                    hasGoodExplain = YES;
                    mm = mod;
                    break;
                }
            }
            NSString *picStr = @"";
            if (hasGoodExplain) {
                if (mm.goodsPicture.length > 0) {
                    picStr = [mm.goodsPicture componentsSeparatedByString:@","].firstObject;
                }
            }
            weakself.emptyV.hidden = weakself.itemArr.count;
            [LiveComponentMsgMgr sendMsg:LM_GoodExplanation msgDic:@{@"pic":picStr,@"goodsId":@(mm.goodsId),@"hasGoodExplain":@(hasGoodExplain)}];
            [weakself.collV reloadData];
        }else{
            [SVProgressHUD showInfoWithStatus:strMsg];
        }
    }];
}

- (UICollectionView *)collV{
    if (!_collV) {
        self.layer.masksToBounds = YES;
        self.layer.cornerRadius = 4.0;
        UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
        flowLayout.itemSize = CGSizeMake(60, self.height-20);
        flowLayout.minimumLineSpacing = 15;
        flowLayout.minimumInteritemSpacing = 0;
        flowLayout.sectionInset = UIEdgeInsetsMake(0, 10, 0, 10);
        flowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        UICollectionView *collV = [[UICollectionView alloc] initWithFrame:self.bounds collectionViewLayout:flowLayout];
        collV.dataSource = self;
        collV.delegate = self;
//        [collV shadowPathWith:[UIColor blackColor] shadowOpacity:0.5 shadowRadius:5 shadowSide:KLCShadowPathAllSide shadowPathWidth:4];
        collV.backgroundColor = kRGB_COLOR(@"#F6F6F6");
        [collV registerClass:[LiveShoppingAccrossCell class] forCellWithReuseIdentifier:@"LiveShoppingAccrossCellIdentifier"];
        [self addSubview:collV];
        _collV = collV;
    }
    return _collV;
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return _itemArr.count;
}


- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    LiveShoppingAccrossCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"LiveShoppingAccrossCellIdentifier" forIndexPath:indexPath];
    ShopLiveGoodsModel *goodsModel = _itemArr[indexPath.item];
    [cell showGoods:goodsModel];
    if ([LiveManager liveInfo].roomRole == RoomRoleForAnchor) {
        cell.stateBtn.hidden = NO;
        kWeakSelf(self);
        kWeakSelf(goodsModel);
        [cell.stateBtn klc_whenTapped:^{
            [weakself setExplain:weakgoodsModel];
        }];
    }else{
        cell.stateBtn.hidden = YES;
    }
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    ShopLiveGoodsModel *goodsModel = _itemArr[indexPath.item];
    [LiveComponentMsgMgr sendMsg:LM_ShoppingGoodsDetail msgDic:@{@"goodId":@(goodsModel.goodsId)}];
    [[PopupTool share] closePopupView:self];
}


- (void)setExplain:(ShopLiveGoodsModel *)goods{
    kWeakSelf(self);
    [HttpApiShopGoods setExplainStatus:goods.goodsId roomId:[LiveManager liveInfo].roomId callback:^(int code, NSString *strMsg, HttpNoneModel *model) {
        if (code == 1) {
            [weakself reloadGoodsId:goods.goodsId];
        }else{
            [SVProgressHUD showInfoWithStatus:strMsg];
        }
    }];
}

- (void)reloadGoodsId:(int64_t)goodsId{
    for (ShopLiveGoodsModel *goodsModel in _itemArr) {
        if (goodsModel.goodsId == goodsId) {
            goodsModel.idExplain = 1;
        }else{
            goodsModel.idExplain = 0;
        }
    }
    kWeakSelf(self);
    dispatch_async(dispatch_get_main_queue(), ^{
//        [weakself.collV reloadData];
        [weakself getLiveGoods];
    });
}

@end
