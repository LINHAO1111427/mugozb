//
//  PresentedGoodNumber.m
//  LiveCommon
//
//  Created by klc on 2020/6/9.
//  Copyright © 2020 . All rights reserved.
//

#import "PresentedGoodNumber.h"
#import "LibTools/LibTools.h"
#import <LibProjBase/LibProjBase.h>
#import <LibProjView/FunctionSheetBaseView.h>
#import <Masonry/Masonry.h>
#import <SDWebImage/SDWebImage.h>
#import <LibProjModel/HttpApiAnchorController.h>
#import "GoodNumItemCell.h"
#import <LiveCommon/LiveManager.h>
#import <LibProjModel/AppLiangModel.h>
#import <LibProjView/TipAlertView.h>
#import <LibProjModel/KLCAppConfig.h>
#import <LiveCommon/LiveComponentMsgListener.h>
#import <LiveCommon/LiveComponentMsgMgr.h>
#import <LibProjView/ForceAlertController.h>

@interface PresentedGoodNumber ()<UICollectionViewDelegate, UICollectionViewDataSource>

@property (nonatomic, assign)int64_t uid;

@property (nonatomic, weak)UICollectionView *collV;

@property (nonatomic, copy)NSArray *items;

@end

@implementation PresentedGoodNumber

+ (void)presentNumber:(int64_t)uid userName:(NSString *)name userIcon:(NSString *)icon{
    ///显示UI
    [self showGoodNum:^(BOOL success, NSArray<AppLiangModel *> *items) {
        if (success) {
            PresentedGoodNumber *good = [[PresentedGoodNumber alloc] init];
            good.items = items;
            [good createUI:name userIcon:icon];
        }
    }];
}

+ (void)showGoodNum:(void(^)(BOOL success, NSArray<AppLiangModel *> *items))successBlock{
    ///靓号列表获取
    [HttpApiAnchorController getNumberList:0 pageSize:0 callback:^(int code, NSString *strMsg, NSArray<AppLiangModel *> *arr) {
        if (code != 1) {
            [SVProgressHUD showInfoWithStatus:strMsg];
        }
        if (successBlock) {
            successBlock((code == 1)?YES:NO,arr);
        }
    }];
}

///创建UI
- (void)createUI:(NSString *)name userIcon:(NSString *)icon{
 
    ///头部视图
    UIView *headBgView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 50)];
    [self addSubview:headBgView];
    
    UILabel *titleL = [[UILabel alloc] initWithFrame:CGRectMake(12, 0, 65, 15)];
    titleL.centerY = headBgView.height/2.0;
    titleL.text = kLocalizationMsg(@"赠送靓号给");
    titleL.font = [UIFont systemFontOfSize:12];
    titleL.textColor = [UIColor blackColor];
    [headBgView addSubview:titleL];
    
    UIImageView *userIcon = [[UIImageView alloc] initWithFrame:CGRectMake(titleL.maxX+1, 0, 24, 24)];
    userIcon.centerY = titleL.centerY;
    userIcon.layer.masksToBounds = YES;
    userIcon.layer.cornerRadius = 12;
    userIcon.contentMode = UIViewContentModeScaleAspectFill;
    [userIcon sd_setImageWithURL:[NSURL URLWithString:icon] placeholderImage:[ProjConfig getDefaultImage]];
    [headBgView addSubview:userIcon];
    
    UILabel *nameL = [[UILabel alloc] initWithFrame:CGRectMake(userIcon.maxX+5, 0, 200, 15)];
    nameL.centerY = titleL.centerY;
    nameL.text = name;
    nameL.font = [UIFont systemFontOfSize:12];
    nameL.textColor = [UIColor blackColor];
    [headBgView addSubview:nameL];
    
    [self.collV reloadData];
    
    self.frame = CGRectMake(0, 0, kScreenWidth, self.collV.maxY+25);
    
    [FunctionSheetBaseView showView:self cover:NO];
    
}

- (UICollectionView *)collV{
    if (!_collV) {
        NSInteger line = _items.count/3 + (_items.count%3>0?1:0);
        CGFloat collH = line * 86;
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
        layout.itemSize = CGSizeMake((kScreenWidth-24-36)/3.0, 70);
        layout.minimumInteritemSpacing = 18;
        layout.minimumLineSpacing = 15;
        layout.sectionInset = UIEdgeInsetsMake(0, 12, 0, 12);
        layout.scrollDirection = UICollectionViewScrollDirectionVertical;
        UICollectionView *collV = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 50, kScreenWidth, collH) collectionViewLayout:layout];
        collV.delegate = self;
        collV.dataSource = self;
        collV.backgroundColor = [UIColor clearColor];
        [collV registerClass:[GoodNumItemCell class] forCellWithReuseIdentifier:@"GoodNumItemCellIdentifier"];
        [self addSubview:collV];
        _collV = collV;
    }
    return _collV;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return _items.count;
}

- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    AppLiangModel *model = _items[indexPath.row];
    GoodNumItemCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"GoodNumItemCellIdentifier" forIndexPath:indexPath];
   // NSLog(@"过滤文字靓号==========%@    %lf"),model.name, model.coin);
    cell.titleL.text = [NSString stringWithFormat:@"ID:%@",model.name];
    NSString *coinStr = [NSString stringWithFormat:@"%0.0lf",model.coin];
    cell.contentL.attributedText = [coinStr attachmentForImage:[ProjConfig getCoinImage] bounds:CGRectMake(0, -4, 18, 18) before:YES];
    
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    AppLiangModel *model = _items[indexPath.row];
    kWeakSelf(self);
    ForceAlertController *alertVC = [ForceAlertController alertTitle:kLocalizationMsg(@"提示") message:kLocalizationMsg(@"是否赠送靓号给该主播?")];
    [alertVC addOptions:kLocalizationMsg(@"取消") textColor:ForceAlert_BlackColor clickHandle:nil];
    [alertVC addOptions:kLocalizationMsg(@"确定") textColor:ForceAlert_NormalColor clickHandle:^{
        [weakself sendAnchorPurchaseNumber:model];
    }];
    [[ProjConfig currentVC] presentViewController:alertVC animated:YES completion:nil];
}


- (void)sendAnchorPurchaseNumber:(AppLiangModel *)model{
    kWeakSelf(self);
    kWeakSelf(model);
    [HttpApiAnchorController purchaseNumber:[LiveManager liveInfo].anchorId numId:model.id_field callback:^(int code, NSString *strMsg, HttpNoneModel *model) {
        if (code == 1) {
            [SVProgressHUD showSuccessWithStatus:strMsg];
            [FunctionSheetBaseView deletePopView:weakself];
        }else if (code == 2){
            [weakself showRechangeAlert:weakmodel.coin];
        }else{
            [SVProgressHUD showInfoWithStatus:strMsg];
        }
    }];
}


- (void)showRechangeAlert:(double)buyCoin{
    kWeakSelf(self);
    [FunctionSheetBaseView deletePopView:weakself];
    [TipAlertView showTitle:[NSString stringWithFormat:kLocalizationMsg(@"你的余额不够%0.0lf%@"),buyCoin,[KLCAppConfig unitStr]] subTitle:^(UILabel * _Nonnull subTitleL) {
        subTitleL.text = kLocalizationMsg(@"先去充值吧!");
    } sureBtnTitle:kLocalizationMsg(@"立即充值") btnClick:^{
         [LiveComponentMsgMgr sendMsg:LM_GotoRecharge msgDic:nil];
    } cancel:nil];
}


@end
