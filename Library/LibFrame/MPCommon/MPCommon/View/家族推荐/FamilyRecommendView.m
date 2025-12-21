//
//  FamilyRecommendView.m
//  OTMLive
//
//  Created by klc_sl on 2020/12/18.
//  Copyright © 2020 KLC. All rights reserved.
//

#import "FamilyRecommendView.h"
#import <LibTools/LibTools.h>
#import <LibProjBase/LibProjBase.h>
#import <LibProjModel/HttpApiOTMCall.h>
#import <LiveCommon/LiveManager.h>
#import "FamilyRoomListView.h"
#import "FamilyListItemCell.h"
#import <LibProjModel/HttpApiApiGuild.h>
#import <LibProjModel/KLCUserInfo.h>
#import <LibProjModel/AdminUserModel.h>
#import <LibProjView/EmptyView.h>

@interface FamilyRecommendView ()<UICollectionViewDelegate, UICollectionViewDataSource>

@property (nonatomic, weak)EmptyView *emptyV;

@property (nonatomic, weak)UIView *animationV; ///动画视图

@property (nonatomic, weak)UIButton *openBtn; ///点击按钮

@property (nonatomic, weak)UICollectionView *familyCollV;

@property (nonatomic, weak)FamilyRoomListView *familyRoomV;

@property (nonatomic, copy)NSArray *items;

@property (nonatomic, assign)NSInteger selectIndex;  ///选择某一个

@property (nonatomic, weak)UIView *colorView; ///颜色值View

@end

@implementation FamilyRecommendView

- (instancetype)initShowInView:(UIView *)superV{
    self = [super init];
    if (self) {
        [self createUI:superV];
        
    }
    return self;
}


- (void)addTap:(UIView *)animationV{
    UISwipeGestureRecognizer *rightSwipe = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(swipeView:)];
    rightSwipe.direction = UISwipeGestureRecognizerDirectionRight;
    [animationV addGestureRecognizer:rightSwipe];
}

- (void)swipeView:(UISwipeGestureRecognizer *)swipe{
    ///左滑 //右滑
    if (swipe.direction == UISwipeGestureRecognizerDirectionRight) {
        _openBtn.selected = YES;
        [self openBtnClick:_openBtn];
    }
}


- (void)createUI:(UIView *)superV{
    self.frame = superV.bounds;
    [superV addSubview:self];
    
    CGFloat funcBtnW = 35.0;
    
    UIView *animationV = [[UIView alloc] initWithFrame:CGRectMake(self.width-funcBtnW, 0, 310+funcBtnW, self.height)];
    [self addSubview:animationV];
    [self addTap:animationV];
    _animationV = animationV;
    
    UIButton *openBtn = [UIButton buttonWithType:0];
    [animationV addSubview:openBtn];
    _openBtn = openBtn;
    openBtn.frame = CGRectMake(0, 93+kStatusBarHeight+80, funcBtnW, 60);
    [openBtn addTarget:self action:@selector(openBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [openBtn setBackgroundImage:[UIImage imageNamed:@"live_recommend_expand"] forState:UIControlStateNormal];
    [openBtn setBackgroundImage:[UIImage imageNamed:@"live_recommend_putaway"] forState:UIControlStateSelected];
    
    ///详情视图
    UIView *detailV = [[UIView alloc] initWithFrame:CGRectMake(openBtn.maxX, 0, animationV.width-funcBtnW, animationV.height)];
    detailV.backgroundColor = kRGBA_COLOR(@"#000000", 0.9);
    [animationV addSubview:detailV];
    
    ///标题
    UILabel *titleL = [[UILabel alloc] initWithFrame:CGRectMake(10, 10+kStatusBarHeight, 110, 20)];
    titleL.font = [UIFont systemFontOfSize:14 weight:UIFontWeightMedium];
    titleL.text = kLocalizationMsg(@"公会列表");
    titleL.textColor = [UIColor whiteColor];
    [detailV addSubview:titleL];
    
    ///底色
    UIView *colorV = [[UIView alloc] initWithFrame:CGRectMake(10, titleL.maxY+11, detailV.width-20, detailV.height-13-11-titleL.maxY)];
    colorV.layer.masksToBounds = YES;
    colorV.layer.cornerRadius = 10;
    colorV.backgroundColor = kRGBA_COLOR(@"#191919", 1.0);
    [detailV addSubview:colorV];
    _colorView = colorV;
    
    ///工会列表
    UICollectionViewFlowLayout *flow = [[UICollectionViewFlowLayout alloc] init];
    flow.itemSize = CGSizeMake(colorV.width-130, 100);
    flow.minimumLineSpacing = 5;
    flow.minimumInteritemSpacing = 0;
    flow.scrollDirection = UICollectionViewScrollDirectionVertical;
    flow.sectionInset = UIEdgeInsetsMake(0, 0, 0, 0);
    UICollectionView *familyCollV = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, colorV.width-130, detailV.height-(titleL.maxY+10)) collectionViewLayout:flow];
    familyCollV.delegate = self;
    familyCollV.dataSource = self;
    [familyCollV registerClass:[FamilyListItemCell class] forCellWithReuseIdentifier:@"FamilyListItemCell"];
    familyCollV.backgroundColor = [UIColor clearColor];
    [colorV addSubview:familyCollV];
    _familyCollV = familyCollV;
    
    ///房间列表
    FamilyRoomListView *familyRoomV = [[FamilyRoomListView alloc] initWithFrame:CGRectMake(familyCollV.maxX, familyCollV.y, colorV.width-familyCollV.maxX, familyCollV.height)];
    [colorV addSubview:familyRoomV];
    familyRoomV.hidden = YES;
    _familyRoomV = familyRoomV;
    
}

- (EmptyView *)emptyV{
    if (!_emptyV) {
        EmptyView *emptyV = [[EmptyView alloc] init];
        emptyV.frame = _colorView.bounds;
        emptyV.titleL.text = @"";
        emptyV.detailL.textColor = kRGBA_COLOR(@"#AAAAAA", 1.0);
        [_colorView addSubview:emptyV];
        [_colorView bringSubviewToFront:emptyV];
        _emptyV = emptyV;
    }
    return _emptyV;
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return _items.count;
}


- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    FamilyListItemCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"FamilyListItemCell" forIndexPath:indexPath];
    cell.userModel = _items[indexPath.row];
    [cell selectOneItem:(_selectIndex == indexPath.row)?YES:NO];
    [cell.joinBtn klc_whenTapped:^{
        [self joinBtnClick];
    }];
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    _selectIndex = indexPath.row;
    if (_items.count > 0) {
        [collectionView reloadData];
        AdminUserModel *userModel = _items[indexPath.row];
        _familyRoomV.familyId = userModel.id_field;
    }
}

- (void)joinBtnClick{
    if ([KLCUserInfo getRole]) {
        NSString *strUrl = @"/api/guild/toGuildList?pageSize=10&pageIndex=0";
        [RouteManager routeForName:RN_general_webView currentC:[ProjConfig currentVC] parameters:@{@"url":strUrl}];
        self.openBtn.selected = YES;
        [self openBtnClick:self.openBtn];
    }else{
        [SVProgressHUD showInfoWithStatus:kLocalizationMsg(@"认证成为主播后才能加入哦～")];
    }
}

///显示视图
- (void)animationViewShow:(BOOL)isShow{
    kWeakSelf(self);
    if (isShow) {
        [self.superview bringSubviewToFront:self];
        [UIView animateWithDuration:0.2 animations:^{
            weakself.animationV.x = weakself.width-weakself.animationV.width;
        }];
    }else{
        [UIView animateWithDuration:0.2 animations:^{
            weakself.animationV.x = weakself.width-35;
        } completion:^(BOOL finished) {
            
        }];
    }
}

///开关邀请视图
- (void)openBtnClick:(UIButton *)btn{
    _openBtn.selected = !_openBtn.selected;
    [self animationViewShow:_openBtn.selected];
    if (btn.selected) {
        [self loadAnchorList];
    }
}

- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event{
    UIView *hitV = [super hitTest:point withEvent:event];
    if (hitV == self && (_openBtn.selected == NO)) {
        return nil;
    }
    if (hitV == _animationV) {
        return nil;
    }
    return hitV;
}

///加载数据
- (void)loadAnchorList{
    kWeakSelf(self);
    [HttpApiApiGuild getGuildAll:^(int code, NSString *strMsg, NSArray<AdminUserModel *> *arr) {
        if (code == 1) {
            weakself.items = arr;
            [weakself.familyCollV reloadData];
            if (arr.count == 0) {
                weakself.familyRoomV.hidden = YES;
                weakself.emptyV.detailL.text = kLocalizationMsg(@"没有公会");
            }else{
                weakself.familyRoomV.hidden = NO;
                [weakself collectionView:self.familyCollV didSelectItemAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]];
            }
        }else{
            weakself.emptyV.detailL.text = strMsg;
        }
        weakself.emptyV.hidden = arr.count>0?YES:NO;
    }];
}
 

@end
