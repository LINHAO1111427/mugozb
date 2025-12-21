//
//  AddWishView.m
//  LiveCommon
//
//  Created by klc_sl on 2020/3/17.
//  Copyright © 2020 . All rights reserved.
//

#import "AddWishView.h"
#import <LibTools/LibTools.h>
#import <LibProjBase/LibProjBase.h>
#import <LibProjView/FunctionSheetBaseView.h>
#import <LibProjModel/HttpApiAnchorWishList.h>
#import <LibProjModel/ApiUsersLiveWishModel.h>
#import <LibProjModel/HttpApiAnchorWishList.h>
#import <LibProjModel/NobLiveGiftModel.h>

#import <Masonry.h>
#import "AddWishItemCell.h"
#import "LibProjViewRes.h"
#import "AddWishGiftView.h"

@interface AddWishView ()<UICollectionViewDelegate,UICollectionViewDataSource,UITextFieldDelegate>

@property (nonatomic, weak)UICollectionView *collectV;
@property (nonatomic, strong)NSMutableArray<ApiUsersLiveWishModel *> *itemArr;
@property (nonatomic, copy)void(^selectWishBlock)(NSArray<ApiUsersLiveWishModel *> * items);
@property (nonatomic, assign)int64_t roomId;
@property (nonatomic, assign)int64_t touid;

@property (nonatomic, assign)BOOL hasCover;

@property (nonatomic, weak)UITextField *weakTextF; ///监听事件中的判断

@end

@implementation AddWishView

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}


+ (void)addMineWishAndRoomId:(int64_t)roomId touid:(int64_t)touid hasCover:(BOOL)has Block:(void (^)(NSArray<ApiUsersLiveWishModel *> * _Nonnull))block{
    AddWishView *addView = [[self alloc] init];
    addView.selectWishBlock = block;
    addView.roomId = roomId;
    addView.touid = touid;
    addView.hasCover = has;
    [addView showUI];
}



+ (void)getMineWishBlock:(void (^)(NSArray<ApiUsersLiveWishModel *> * _Nullable))block{
    [HttpApiAnchorWishList getWishList:[ProjConfig userId] callback:^(int code, NSString *strMsg, NSArray<ApiUsersLiveWishModel *> *arr) {
        if (code == 1 && block) {
            block(arr);
        }
    }];
}


- (void)showUI{
    
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyBoardFrameWillShowChange:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyBoardFrameWillHideChange:) name:UIKeyboardWillHideNotification object:nil];
    
    self.frame = CGRectMake(0, 0, kScreenWidth, self.collectV.maxY+70);

    ///标题
    UILabel *titleL = [[UILabel alloc] initWithFrame:CGRectMake(15, 0, 150, 19)];
    titleL.font = [UIFont systemFontOfSize:13];
    titleL.textColor = kRGBA_COLOR(@"#999999", 1.0);
    titleL.text = kLocalizationMsg(@"为您推荐热门心愿");
    [self addSubview:titleL];
    
    ///换一换
    UIButton *changeBtn = [[UIButton alloc] init];
    [changeBtn setTitle:kLocalizationMsg(@"完成") forState:UIControlStateNormal];
    [changeBtn setTitleColor:[ProjConfig normalColors] forState:UIControlStateNormal];
    changeBtn.titleLabel.font = [UIFont systemFontOfSize:13];
    [changeBtn setAttributedTitle:[kLocalizationMsg(@"换一换") attachmentForImage:[UIImage imageNamed:@"wish_change_pink"] bounds:CGRectMake(0, -2, 15, 12) before:YES textFont:[UIFont systemFontOfSize:13] textColor:[ProjConfig normalColors]] forState:UIControlStateNormal];
    [changeBtn addTarget:self action:@selector(changeBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:changeBtn];
    [changeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(19);
        make.centerY.equalTo(titleL);
        make.right.equalTo(self).mas_offset(-15);
    }];

    UIButton *sureBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, self.collectV.maxY+10, 140, 40)];
    [sureBtn setBackgroundImage:[UIImage imageNamed:@"btn_bg_pink"] forState:UIControlStateNormal];
    sureBtn.layer.masksToBounds = YES;
    sureBtn.layer.cornerRadius = 20;
    [sureBtn setTitle:kLocalizationMsg(@"确认创建") forState:UIControlStateNormal];
    [sureBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    sureBtn.titleLabel.font = [UIFont systemFontOfSize:14 weight:UIFontWeightMedium];
    [self addSubview:sureBtn];
    sureBtn.centerX = self.centerX;
    kWeakSelf(self);
    [sureBtn klc_whenTapped:^{
        [weakself addLiveWish];
    }];
    [FunctionSheetBaseView showTitle:kLocalizationMsg(@"心愿单") detailView:self cover:_hasCover];
    
    [AddWishView getMineWishBlock:^(NSArray<ApiUsersLiveWishModel *> * _Nullable wishList) {
        [weakself.itemArr removeAllObjects];
        [weakself.itemArr addObjectsFromArray:wishList];
        [weakself.collectV reloadData];
    }];
}

///键盘弹起降下
- (void)keyBoardFrameWillShowChange:(NSNotification *)notify{
    if (_weakTextF) {
        UIView *superV = self.superview;
        CGRect keyBoardRc = [notify.userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue];
        NSTimeInterval time = [notify.userInfo[UIKeyboardAnimationDurationUserInfoKey] doubleValue];
        [UIView animateWithDuration:time animations:^{
            CGRect rc = superV.frame;
            rc.origin.y = (keyBoardRc.origin.y < kScreenHeight)?(keyBoardRc.origin.y-rc.size.height):(kScreenHeight-rc.size.height);
            superV.frame = rc;
        }];
    }
}

- (void)keyBoardFrameWillHideChange:(NSNotification *)notify{
    UIView *superV = self.superview;
    CGRect keyBoardRc = [notify.userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue];
    NSTimeInterval time = [notify.userInfo[UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    [UIView animateWithDuration:time animations:^{
        CGRect rc = superV.frame;
        rc.origin.y = (keyBoardRc.origin.y < kScreenHeight)?(keyBoardRc.origin.y-rc.size.height):(kScreenHeight-rc.size.height);
        superV.frame = rc;
    }];
}


- (UICollectionView *)collectV{
    if (_collectV == nil) {
        
        CGFloat itemH = 160;
        CGFloat itemW = (kScreenWidth-30 - 30)/4.0;
        
        UICollectionViewFlowLayout *flow = [[UICollectionViewFlowLayout alloc] init];
        flow.sectionInset = UIEdgeInsetsMake(0, 0, 0, 0);
        flow.itemSize = CGSizeMake(itemW, itemH);
        flow.minimumLineSpacing = 0;
        flow.minimumInteritemSpacing = 9;
        flow.scrollDirection = UICollectionViewScrollDirectionVertical;

        UICollectionView *collV = [[UICollectionView alloc] initWithFrame:CGRectMake(15, 30, kScreenWidth-30, itemH+10) collectionViewLayout:flow];
        collV.delegate = self;
        collV.dataSource = self;
        collV.backgroundColor = [UIColor clearColor];
        NSString *nibName= [LibProjViewRes getNibFullName:@"AddWishItemCell"];
        [collV registerNib:[UINib nibWithNibName:nibName bundle:[NSBundle mainBundle]] forCellWithReuseIdentifier:@"AddWishItemCellIdentifier"];
        [self addSubview:collV];
        _collectV = collV;
        
    }
    return _collectV;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return _itemArr.count < 4?(_itemArr.count + 1):4;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    AddWishItemCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"AddWishItemCellIdentifier" forIndexPath:indexPath];
    if (_itemArr.count > indexPath.row) {
        cell.wishModel = _itemArr[indexPath.item];
    }
    cell.numTextF.delegate = self;
    cell.isAdd = (_itemArr.count > indexPath.row)?NO:YES;
    cell.addGiftBtnBlock = ^{
        [self addGiftBtnClick];
    };
    cell.removeGiftBtnBlock = ^(ApiUsersLiveWishModel * _Nonnull wishModel) {
        [self removeGiftBtnClick:wishModel];
    };
    return cell;
}

- (void)addGiftBtnClick{
    kWeakSelf(self);
    [self endEditing:YES];
    [AddWishGiftView addWishGift:YES sureTitle:kLocalizationMsg(@"确认") selectGiftBack:^(NobLiveGiftModel * _Nonnull giftModel, int selectNum) {
        __block BOOL hasValue = NO;
        [weakself.itemArr enumerateObjectsUsingBlock:^(ApiUsersLiveWishModel * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            if (obj.giftid == giftModel.id_field) {
                hasValue = YES;
                obj.num = selectNum;
//                [weakself.itemArr replaceObjectAtIndex:idx withObject:wishModel];
                *stop = YES;
            }
        }];
        if (!hasValue) {
            ApiUsersLiveWishModel *wishModel = [[ApiUsersLiveWishModel alloc] init];
            wishModel.gifticon = giftModel.gifticon;
            wishModel.giftid = (int)giftModel.id_field;
            wishModel.giftname = giftModel.giftname;
            wishModel.num = selectNum;
            [weakself.itemArr addObject:wishModel];
        }
        [weakself.collectV reloadData];
    }];
}

- (void)removeGiftBtnClick:(ApiUsersLiveWishModel *)wishModel{
    if (wishModel) {
        [_itemArr removeObject:wishModel];
        [self.collectV reloadData];
    }
}

- (NSMutableArray *)itemArr{
    if (!_itemArr) {
        _itemArr = [[NSMutableArray alloc] initWithCapacity:1];
    }
    return _itemArr;
}

///点击换一换按钮
- (void)changeBtnClick{
    [HttpApiAnchorWishList getWishGiftList:[ProjConfig userId] callback:^(int code, NSString *strMsg, NSArray<ApiUsersLiveWishModel *> *arr) {
        if (code == 1) {
            [self.itemArr removeAllObjects];
            [self.itemArr addObjectsFromArray:arr];
            [self.collectV reloadData];
        }else{
            [SVProgressHUD showInfoWithStatus:strMsg];
        }
    }];
}

///添加主播心愿单
- (void)addLiveWish{
    [self endEditing:YES];
    
    if (self.itemArr.count > 0) {
        kWeakSelf(self);
        [HttpApiAnchorWishList setWish:self.itemArr roomId:self.roomId touid:self.touid callback:^(int code, NSString *strMsg, HttpNoneModel *model) {
             if (code == 1) {
                if (weakself.selectWishBlock) {
                    weakself.selectWishBlock(weakself.itemArr);
                }
                [FunctionSheetBaseView deletePopView:weakself];
             }else{
                [SVProgressHUD showInfoWithStatus:strMsg];
             }
        }];
    }else{
        [SVProgressHUD showInfoWithStatus:kLocalizationMsg(@"快选择心仪的礼物吧")];
    }
}


- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField{
    _weakTextF = textField;
    return YES;
}
- (BOOL)textFieldShouldEndEditing:(UITextField *)textField{
    _weakTextF = nil;
    return YES;
}


@end
