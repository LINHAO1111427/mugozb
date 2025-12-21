//
//  OpenGuardView.m
//  TCDemo
//
//  Created by klc_tqd on 2019/11/14.
//  Copyright © 2019 CH. All rights reserved.
//

#import "OpenGuardView.h"
#import <SDWebImage/SDWebImage.h>
#import <Masonry/Masonry.h>

#import "ChooseGuardianCell.h"
#import <LibProjView/ForceAlertController.h>
#import <LibTools/LibTools.h>

#import <LibProjBase/LibProjBase.h>

#import <LibProjModel/ApiGuardModel.h>
#import <LibProjModel/KLCAppConfig.h>
#import <LibProjModel/KLCUserInfo.h>
#import <LibProjView/TipAlertView.h>
#import <LibProjModel/HttpApiGuard.h>

@interface OpenGuardView () <UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout>

@property(nonatomic, weak) UICollectionView *collectionView;

@property(nonatomic, weak) UIView *headerView;

@property (nonatomic,copy) NSArray *dataArr;

@property (nonatomic, assign)NSInteger selectIndex;

@property (nonatomic, weak) UILabel *userTips;

@property (nonatomic, weak) UIImageView *tipBgView;

@property (nonatomic, weak) UIImageView *userImgV;

@end

@implementation OpenGuardView

- (void)dealloc
{
    _toRechange = nil;
}


- (void)showView{
    [self createView];
    [self getReloadData];
}

- (void)createView{
    
    if (!_headerView) {
        self.headerView.hidden = NO;
        
        [self.collectionView reloadData];
        
        UILabel *titleL = [[UILabel alloc] initWithFrame:CGRectMake(12, 145, 200, 15)];
        titleL.text = kLocalizationMsg(@"守护TA");
        titleL.font = [UIFont systemFontOfSize:12];
        titleL.textColor = [UIColor grayColor];
        [self addSubview:titleL];
        
        UIButton *sureBtn = [UIButton buttonWithType:0];
        sureBtn.frame = CGRectMake(30, self.height-55, self.width-60, 40);
        sureBtn.layer.masksToBounds = YES;
        sureBtn.layer.cornerRadius = 20;
        [sureBtn setTitle:kLocalizationMsg(@"为TA守护") forState:UIControlStateNormal];
        sureBtn.titleLabel.font = [UIFont systemFontOfSize:15];
        [sureBtn setBackgroundImage:[UIImage imageNamed:@"live_shouhu_btn"] forState:UIControlStateNormal];
        [self addSubview:sureBtn];
        [sureBtn addTarget:self action:@selector(buyBtnClick) forControlEvents:UIControlEventTouchUpInside];
    }
}


- (UIView *)headerView{
    if (!_headerView) {
        UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 50, kScreenWidth, 90)];
        headerView.backgroundColor = [UIColor clearColor];
        [self addSubview:headerView];
        _headerView = headerView;
        
        ///主播头像
        UIImageView *imgA = [[UIImageView alloc] initWithFrame:CGRectMake(40, 0, 70, 70)];
        imgA.centerY = headerView.height/2.0;
        imgA.layer.masksToBounds = YES;
        imgA.layer.cornerRadius = 35;
        [imgA sd_setImageWithURL:[NSURL URLWithString:_userIcon] placeholderImage:[ProjConfig getDefaultImage]];
        [headerView addSubview:imgA];
        
        ///用户头像
        UIImageView *imgUser = [[UIImageView alloc] initWithFrame:CGRectMake(imgA.maxX-25, imgA.y+20, 50, 50)];
        imgUser.layer.masksToBounds = YES;
        imgUser.layer.cornerRadius = 25;
        imgUser.image = [UIImage imageNamed:@"live_shouhu_noIcon"];
        [headerView addSubview:imgUser];
        _userImgV = imgUser;
        
        ///提示文字的底部视图
        UIImageView *tipBgV = [[UIImageView alloc] initWithFrame:CGRectMake(imgUser.maxX+24, 0, headerView.width-40-(imgUser.maxX+24), 30)];
        tipBgV.image = [UIImage imageNamed:@"live_shouhu_btn"];
        tipBgV.centerY = imgUser.centerY;
        tipBgV.layer.masksToBounds = YES;
        tipBgV.layer.cornerRadius = 4.0;
        [headerView addSubview:tipBgV];
        tipBgV.hidden = YES;
        _tipBgView = tipBgV;
        
        ////提示文字
        UILabel *coinTipL = [[UILabel alloc] init];
        coinTipL.textColor = [UIColor lightGrayColor];
        coinTipL.font = [UIFont systemFontOfSize:14];
        coinTipL.text = kLocalizationMsg(@"给TA打CALL，快去守护主播吧");
        [headerView addSubview:coinTipL];
        _userTips = coinTipL;
        [coinTipL mas_makeConstraints:^(MASConstraintMaker *make) {
            make.center.equalTo(tipBgV);
        }];
        
    }
    return _headerView;
}

- (UICollectionView *)collectionView {
    if (!_collectionView) {
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
        layout.scrollDirection = UICollectionViewScrollDirectionVertical;
        layout.minimumInteritemSpacing = 5;
        layout.minimumLineSpacing = 5;
        UICollectionView *collectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(15, 160, kScreenWidth - 30, 85) collectionViewLayout:layout];
        collectionView.backgroundColor = [UIColor clearColor];
        collectionView.delegate = self;
        collectionView.dataSource = self;
        [collectionView registerClass:[ChooseGuardianCell class] forCellWithReuseIdentifier:@"ChooseGuardianCellID"];
        [self addSubview:collectionView];
        _collectionView = collectionView;
    }
    return _collectionView;
}

-(void)getReloadData{
    kWeakSelf(self);
    [HttpApiGuard getGuardList:_userId callback:^(int code, NSString *strMsg, ApiGuardEntityModel *model) {
        if (code == 1) {
            [weakself setGuardModel:model];
        }
    }];
    
}

- (void)setGuardModel:(ApiGuardEntityModel *)model{
    self.dataArr = model.apiGuardList;
    [self.collectionView reloadData];
    if (model.dayNumber>0) {
        self.tipBgView.hidden = NO;
        NSString *showStr = [NSString stringWithFormat:kLocalizationMsg(@"第%lld天守护TA"),model.dayNumber];
        self.userTips.textColor = [UIColor whiteColor];
        self.userTips.attributedText = [showStr attachmentForImage:[ProjConfig getCoinImage] bounds:CGRectMake(0, -3, 17, 17) before:YES];
        [self.userImgV sd_setImageWithURL:[NSURL URLWithString:[KLCUserInfo getAvatar]] placeholderImage:[ProjConfig getDefaultImage]];
    }else{
        self.tipBgView.hidden = YES;
        self.userTips.textColor = [UIColor lightGrayColor];
        self.userTips.text = kLocalizationMsg(@"给TA打CALL，快去守护主播吧");
        self.userImgV.image = [UIImage imageNamed:@"live_shouhu_noIcon"];
        
    }
    
    if (self.selectIndex == 0) {
        self.selectIndex = 1;
    }
    [self.collectionView selectItemAtIndexPath:[NSIndexPath indexPathForRow:_selectIndex-1 inSection:0] animated:NO scrollPosition:UICollectionViewScrollPositionNone];
}


#pragma mark ----- collectionView

- (NSInteger )collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.dataArr.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    ChooseGuardianCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"ChooseGuardianCellID" forIndexPath:indexPath];
    cell.guardModel = self.dataArr[indexPath.row];
    return cell;
}


- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    CGFloat itemWidth = (self.collectionView.frame.size.width  - 40 )/ 3 ;
    return CGSizeMake(itemWidth, 54);
}


- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {    
    return UIEdgeInsetsMake(15, 5, 15, 5);
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    self.selectIndex = indexPath.row+1;
}


#pragma mark - 开通守护
-(void)buyBtnClick{
   // NSLog(@"过滤文字%s"),__func__);
    if (_selectIndex == 0) {
        return;
    }
    if (self.dataArr.count == 0) {
        [SVProgressHUD showInfoWithStatus:kLocalizationMsg(@"没有守护类型")];
    }
    if (self.dataArr.count < self.selectIndex) {
        [SVProgressHUD showInfoWithStatus:kLocalizationMsg(@"守护类型不准确")];
        return;
    }
    
    ApiGuardModel *guardModel = self.dataArr[_selectIndex-1];
    
    [self goBuy:guardModel.tid coin:guardModel.coin];
    //    }];
    //    [self.weakSuperVC presentViewController:forceVC animated:YES completion:nil];
}

// MARK: - 购买守护
-(void)goBuy:(int64_t)tid coin:(double)coin{
    kWeakSelf(self);
    [HttpApiGuard guardListBuy:_userId tid:tid callback:^(int code, NSString *strMsg, HttpNoneModel *model) {
        if (code == 1) {
            [SVProgressHUD showSuccessWithStatus:strMsg];
            [weakself getReloadData];
            if (weakself.buySuccess) {
                weakself.buySuccess();
            }
        }else if (code == -1) {
            [weakself showRechangeAlert:coin];
        }else{
            [SVProgressHUD showInfoWithStatus:kLocalizationMsg(strMsg)];
        }
        
    }];
}

- (void)showRechangeAlert:(double)coin{
    kWeakSelf(self);
    [TipAlertView showTitle:[NSString stringWithFormat:kLocalizationMsg(@"你的余额不够%0.0lf%@"),coin,[KLCAppConfig unitStr]] subTitle:^(UILabel * _Nonnull subTitleL) {
        subTitleL.text = kLocalizationMsg(@"先去充值吧!");
    } sureBtnTitle:kLocalizationMsg(@"立即充值") btnClick:^{
        if (weakself.toRechange) {
            weakself.toRechange();
        }
    } cancel:nil];
}

// MARK: - 点击金币label
- (void)clickCoinLabelView:(UITapGestureRecognizer*)gr{
   // NSLog(@"过滤文字%s"),__func__);
}



@end
