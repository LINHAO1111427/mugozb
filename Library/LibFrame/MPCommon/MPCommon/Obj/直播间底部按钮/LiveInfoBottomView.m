//
//  LiveInfoBottomView.m
//  LiveCommon
//
//  Created by admin on 2020/5/12.
//  Copyright © 2020 . All rights reserved.
//

#import "LiveInfoBottomView.h"
#import <LibTools/LibTools.h>
#import <LibProjBase/LibProjBase.h>
#import <Masonry/Masonry.h>
#import <MPCommon/LiveMoreCommonView.h>
#import <LiveCommon/LiveManager.h>
#import <LiveCommon/LiveInfomation.h>
#import <LibProjModel/KLCUserInfo.h>
#import <LiveCommon/LiveComponentMsgListener.h>
#import <LiveCommon/LiveComponentMsgMgr.h>
#import <LibTools/LiveMacros.h>

@implementation LiveFunctionItemModel

@end

@interface LiveFunctionItemCell : UICollectionViewCell

@property (nonatomic, weak)UIButton *functionIcon;

@property (nonatomic, weak)UIImageView *badgeImg;

@end

@implementation LiveFunctionItemCell

- (UIButton *)functionIcon{
    if (!_functionIcon) {
        UIButton *icon = [UIButton buttonWithType:0];
        [self addSubview:icon];
        _functionIcon = icon;
        [icon mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(self);
        }];
        [icon layoutIfNeeded];
        icon.layer.cornerRadius = icon.height/2.0;
    }
    return _functionIcon;
}

- (UIImageView *)badgeImg{
    if (!_badgeImg) {
        UIImageView *imageV = [[UIImageView alloc] init];
        imageV.contentMode = UIViewContentModeScaleAspectFit;
        [self addSubview:imageV];
        _badgeImg = imageV;
        [imageV mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(CGSizeMake(10, 10));
            make.right.equalTo(self.functionIcon).mas_offset(1);
            make.top.equalTo(self.functionIcon).mas_offset(-1);
        }];
    }
    return _badgeImg;
}


@end



@interface LiveInfoBottomView () <UICollectionViewDelegate, UICollectionViewDataSource>

@property (nonatomic, copy)NSArray<LiveFunctionItemModel *> *itemArr;   ///底部按钮

@property (nonatomic, assign)NSInteger bottomNum;  // 底部按钮的个数

@property (nonatomic, weak)UICollectionView *collV;

@property (nonatomic, weak)UIView *bottomV;   ///底部视图

@end

@implementation LiveInfoBottomView

- (void)dealloc
{
}


+ (CGRect)viewFrame{
    CGFloat viewY = liveConnectViewY + liveConnectViewH;
    return CGRectMake(0, viewY,  kScreenWidth,  kScreenHeight-kSafeAreaBottom-viewY);
}


- (void)changeFunctionItems:(NSArray<LiveFunctionItemModel *> *)items{
    
    _itemArr = items;
    
    for (int i = 0; i< items.count; i++) {
        LiveFunctionItemModel *model = items[i];
        if (model.msgType == 10000) {
            _bottomNum = i+1;
        }
    }
    _bottomNum = _bottomNum>0?_bottomNum:_itemArr.count;

    [_collV mas_updateConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(_bottomNum * 40);
    }];
    [_collV layoutIfNeeded];
    
    if (!_collV) {
        [self showChatView];
        [self.collV reloadData];
    }else{
        [_collV reloadData];
    }
}


- (void)showChatView{
    [self createChatView];
}

- (void)createChatView{
    
    UIButton *chatBtn = [UIButton buttonWithType:0];
    chatBtn.layer.masksToBounds = YES;
    chatBtn.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.4];
    [self.bottomV addSubview:chatBtn];
    [chatBtn addTarget:self action:@selector(chatBtnClick) forControlEvents:UIControlEventTouchUpInside];
    
    UIImageView *chatImg = [[UIImageView alloc] init];
    chatImg.image = [UIImage imageNamed:@"live_liaotian"];
    [chatBtn addSubview:chatImg];
    
    UILabel *textLab = [[UILabel alloc] init];
    textLab.text = kLocalizationMsg(@"来聊聊天...");
    textLab.font = [UIFont systemFontOfSize:12];
    textLab.textColor = kRGB_COLOR(@"#ffffff");
    [chatBtn addSubview:textLab];
    
    [chatBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.bottomV).mas_offset(12);
        make.size.mas_equalTo(CGSizeMake(120, 30));
        make.centerY.equalTo(self.bottomV);
    }];
    
    [chatImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(20, 20));
        make.centerY.equalTo(chatBtn);
        make.left.equalTo(chatBtn).mas_offset(10);
        make.right.equalTo(textLab.mas_left).mas_offset(-4);
    }];
    [textLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(chatBtn);
        make.right.equalTo(chatBtn);
    }];
    
    [chatBtn layoutIfNeeded];
    chatBtn.layer.cornerRadius = chatBtn.frame.size.height / 2;
    
}

- (UIView *)bottomV{
    if (!_bottomV) {
        UIView *bottomV = [[UIView alloc] init];
        [self addSubview:bottomV];
        [bottomV mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.bottom.equalTo(self);
            make.height.mas_equalTo(liveBottomViewH);
        }];
        [bottomV layoutIfNeeded];
        _bottomV = bottomV;
    }
    return _bottomV;
}

- (UICollectionView *)collV{
    if (!_collV) {
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
        layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        layout.minimumInteritemSpacing = 0;
        layout.minimumLineSpacing = 10;
        layout.itemSize = CGSizeMake(30, 30);
        layout.sectionInset = UIEdgeInsetsMake(5, 0, 5, 0);
        layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        UICollectionView *collectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 0,100, 40) collectionViewLayout:layout];
        collectionView.delegate = self;
        collectionView.dataSource = self;
        collectionView.backgroundColor = [UIColor clearColor];
        collectionView.bounces = NO;
        [collectionView registerClass:[LiveFunctionItemCell class] forCellWithReuseIdentifier:@"LiveFunctionItemCellIdentifier"];
        [self.bottomV addSubview:collectionView];
        _collV = collectionView;
        
        [collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.width.mas_equalTo(_bottomNum * 40);
            make.right.equalTo(self).mas_offset(-2);
            make.height.mas_equalTo(40);
            make.centerY.equalTo(self.bottomV);
        }];
        [collectionView layoutIfNeeded];
    }
    return _collV;
}
 

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return _bottomNum;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    LiveFunctionItemModel *model = _itemArr[indexPath.item];
    LiveFunctionItemCell *itemCell = [collectionView dequeueReusableCellWithReuseIdentifier:@"LiveFunctionItemCellIdentifier" forIndexPath:indexPath];
    [itemCell.functionIcon setBackgroundImage:[UIImage imageNamed:model.iconStr] forState:UIControlStateNormal];
    itemCell.badgeImg.hidden = (model.badgeStr.length>0)?NO:YES;
    if (model.badgeStr.length > 0) {
        itemCell.badgeImg.image = [UIImage imageNamed:model.badgeStr];
    }
    kWeakSelf(self);
    [itemCell.functionIcon klc_whenTapped:^{
        [weakself setFunction:model.msgType];
    }];
    return itemCell;
    
}


- (void)moreBtnClick{
    kWeakSelf(self);
    LiveMoreCommonView *more = [[LiveMoreCommonView alloc] init];
    [more selectOne:^(NSUInteger msgType) {
        [weakself setFunction:msgType];
    }];
    for (int i= 0; i< _itemArr.count; i++) {
        if (i > (_bottomNum-1)) {
            LiveFunctionItemModel *model = _itemArr[i];
            [more addItemName:model.name icon:model.iconStr msgType:model.msgType];
        }
    }
    [more show];
}


- (void)setFunction:(NSInteger)msgType{
    switch (msgType) {
        case 10000: ///更多
        {
            [self moreBtnClick];
        }
            break;
        default:
        {
            if (msgType < 10000) {
                [LiveComponentMsgMgr sendMsg:msgType msgDic:nil];
            }else{
                [self clickFunction:msgType];
            }
            
        }
        break;
    };
}

- (void)clickFunction:(NSInteger)msgType{
}
 

- (void)chatBtnClick{
    [LiveComponentMsgMgr sendMsg:LM_SendMessage msgDic:@{@"msg":@""}];
}


- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event{
    UIView *hitView = [super hitTest:point withEvent:event];
    if(hitView == self || hitView == _bottomV){
        return nil;
    }
    return hitView;
}


@end
