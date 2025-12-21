//
//  GiftListShowView.m
//  MPVideoLive
//
//  Created by admin on 2019/8/5.
//  Copyright © 2019 cat. All rights reserved.
//

#import "GiftListShowView.h"
#import <LibTools/CollectionPageFlowLayout.h>
#import "LiveGiftCell.h"
#import <Masonry/Masonry.h>
#import "LibProjViewRes.h" 
#import <LibProjModel/NobLiveGiftModel.h>
#import <LibProjModel/ApiNobLiveGiftModel.h>
#import <LibProjModel/HttpApiNobLiveGift.h>
#import <LibProjModel/HttpApiAnchorController.h>
#import <LibProjModel/GuardUserVOModel.h>
#import <LibProjModel/KLCUserInfo.h>
#import <LibProjView/GiftUserModel.h>
#import <LibProjView/FansGroupShowView.h>

@interface CollectionCellSpace : UICollectionViewCell



@end

@implementation CollectionCellSpace
- (instancetype)initWithFrame:(CGRect)frame andPlayDic:(NSDictionary *)zhuboDic{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
    }
    return self;
}

@end

@interface GiftListShowView ()<UICollectionViewDelegate,UICollectionViewDataSource>

@property (nonatomic, assign)int sectionItem;  //每组多少个

@property (nonatomic ,weak)UICollectionView *collectionV;

@property (nonatomic, weak)UIPageControl *pageControl;

@property (nonatomic, copy)NSIndexPath *selectPath;// 选中的某个礼物

@property (nonatomic, copy)NSArray<NobLiveGiftModel *> *giftListArr;

@property (nonatomic, weak)UIView *emptyV;

@property (nonatomic, weak)UIView *limitV;

///背包ID （只有在背包礼物时有这个值）
@property (nonatomic, assign)int64_t beforeSendBackid;
///默认选择的礼物ID
@property (nonatomic, assign)int64_t defaultGiftId;

@end

@implementation GiftListShowView

- (UIView *)listView{
    return self;
}

- (void)listWillAppear{
    ///送过背包礼物 & 是背包礼物页面，选择项大于数组值
    if (_beforeSendBackid > 0 && self.giftListModel.giftTypeId == 4 && _selectPath.item > _giftListArr.count) {
        ///清空数据 刷新页面
        _beforeSendBackid = 0;
        _selectPath = [NSIndexPath indexPathForRow:0 inSection:0];
        [self.collectionV reloadData];
    }
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(giftListView:selectGift:giftType:)]) {
        if (_giftListArr.count > 0 && (_selectPath.item < _giftListArr.count)) {
            [self.delegate giftListView:self selectGift:_giftListArr[_selectPath.item] giftType:_giftListModel.giftTypeId];
        }else{
            [self.delegate giftListView:self selectGift:nil giftType:_giftListModel.giftTypeId];
        }
        
    }
}


- (instancetype)initWithFrame:(CGRect)frame defaultGiftId:(int64_t)giftId
{
    self = [super initWithFrame:frame];
    if (self) {
        _sectionItem = 8;
        ///默认选第0个
        _selectPath = [NSIndexPath indexPathForRow:0 inSection:0];
        ///默认显示的礼物
        _defaultGiftId = giftId;
        [self createView];
    }
    return self;
}

- (void)createView{
    UIPageControl *pageC = [[UIPageControl alloc] init];
    pageC.currentPageIndicatorTintColor = [ProjConfig normalColors];
    pageC.pageIndicatorTintColor = [UIColor whiteColor];
    [self addSubview:pageC];
    _pageControl = pageC;
    [pageC mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self);
        make.centerX.equalTo(self);
        make.height.mas_equalTo(20);
    }];
    [pageC layoutIfNeeded];
    
    CollectionPageFlowLayout *flowlayout =[[CollectionPageFlowLayout alloc]init];
    NSInteger lineItemCount = _sectionItem/2;
    flowlayout.itemCountPerRow =lineItemCount;
    flowlayout.rowCount = 2;
    flowlayout.minimumLineSpacing = 5;
    flowlayout.minimumInteritemSpacing = 5;
    flowlayout.sectionInset = UIEdgeInsetsMake(1, 2.5, 1, 2.5);
    
    CGFloat collW = self.frame.size.width-20;
    CGFloat collH = self.frame.size.height-pageC.frame.size.height;
    CGFloat itemW = (collW-(lineItemCount)*flowlayout.minimumLineSpacing)/lineItemCount;
    CGFloat itemH = (collH-flowlayout.minimumInteritemSpacing-flowlayout.sectionInset.top-flowlayout.sectionInset.bottom)/2.0;
    flowlayout.itemSize = CGSizeMake(itemW, itemH);
    flowlayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    UICollectionView *collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(10, 0, collW, collH) collectionViewLayout:flowlayout];
    collectionView.showsHorizontalScrollIndicator = NO;
    collectionView.multipleTouchEnabled = NO;
    collectionView.delegate = self;
    collectionView.dataSource = self;
    collectionView.backgroundColor = [UIColor clearColor];
    collectionView.pagingEnabled = YES;
    NSString *nibName= [LibProjViewRes getNibFullName:@"LiveGiftCell"];
    [collectionView registerNib:[UINib nibWithNibName:nibName bundle:nil] forCellWithReuseIdentifier:@"LiveGiftCell"];
    [collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"LiveGiftCellSpace"];
    [self addSubview:collectionView];
    _collectionV = collectionView;
}

- (void)setGiftListModel:(ApiNobLiveGiftModel *)giftListModel {
    _giftListModel = giftListModel;
    
    ///先显示空空如也得页面
    if (giftListModel.giftList.count == 0) {
        [self reloadGiftList];
    } else {
        ///有值
        if (!_selectWish) {
            ///不是选择心愿单
            //        ///粉丝团或者守护 显示遮盖页面
            //        if ((giftModel.giftTypeId == 1 || giftModel.giftTypeId == 2) && self.anchorId> 0) {
            //            self.limitV.hidden = NO;
            //        }else if (giftModel.giftTypeId == 3 && [KLCUserInfo getNobleGrade] == 0){///贵族
            //            self.limitV.hidden = NO;
            //        }else{
            [self reloadCollectionView:giftListModel.giftList];
            //        }
        }else{
            [self reloadCollectionView:giftListModel.giftList];
        }
    }
}

///刷新页面
- (void)reloadCollectionView:(NSArray *)giftList{
    self.giftListArr = giftList;
    /// 如果是背包礼物并且前一个送的礼物也是背包礼物
    if (self.giftListModel.giftTypeId == 4 && self.beforeSendBackid > 0) {
        __block BOOL has = NO;
        [giftList enumerateObjectsUsingBlock:^(NobLiveGiftModel * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            if (obj.backid == self.beforeSendBackid) {
                has = YES;
                *stop = YES;
            }
        }];
        if (!has) {
            _selectPath = [NSIndexPath indexPathForItem:999999 inSection:0];
        }
    }else{
        if (self.defaultGiftId > 0) {
            __block NSUInteger item = 0;
            [giftList enumerateObjectsUsingBlock:^(NobLiveGiftModel * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                if (obj.id_field == self.defaultGiftId) {
                    item = idx;
                    *stop = YES;
                }
            }];
            self.defaultGiftId = 0;
            _selectPath = [NSIndexPath indexPathForRow:item inSection:0];
        }
        ///其他默认显示第一个
    }
    [self.collectionV reloadData];
    _pageControl.numberOfPages = _giftListArr.count/_sectionItem + (_giftListArr.count%_sectionItem?1:0);
    [self collectionView:_collectionV didSelectItemAtIndexPath:_selectPath];
    if (_selectPath.item > _sectionItem && _selectPath.item < giftList.count) {
        ///设置默认显示的位置
        NSInteger page = self.selectPath.item/_sectionItem;
        self.collectionV.contentOffset = CGPointMake(page*self.collectionV.width, 0);
        _pageControl.currentPage = page;
    }
}


- (void)clearData{
    _selectPath = [NSIndexPath indexPathForItem:999999 inSection:0];
    [_collectionV reloadData];
}

- (void)reloadPackData{
    [self reloadGiftList];
}

#pragma mark - delegate
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return (( _giftListArr.count/_sectionItem )*_sectionItem)+(_giftListArr.count%_sectionItem?_sectionItem:0);
}

- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.item >= _giftListArr.count) {
        UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"LiveGiftCellSpace" forIndexPath:indexPath];
        return cell;
    }
    NobLiveGiftModel *model = _giftListArr[indexPath.item];
    LiveGiftCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"LiveGiftCell" forIndexPath:indexPath];
    [cell showGift:model type:_giftListModel.giftTypeId];
    [cell selectItem:(indexPath.item == _selectPath.item)?YES:NO];
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.item >= _giftListArr.count) {
        if (self.delegate && [self.delegate respondsToSelector:@selector(giftListView:selectGift:giftType:)]) {
            [self.delegate giftListView:self selectGift:nil giftType:_giftListModel.giftTypeId];
        }
        return;
    }
    NobLiveGiftModel *model = _giftListArr[indexPath.item];
    self.beforeSendBackid = model.backid;
    if (self.delegate && [self.delegate respondsToSelector:@selector(giftListView:selectGift:giftType:)]) {
        [self.delegate giftListView:self selectGift:model giftType:_giftListModel.giftTypeId];
    }
    _selectPath = indexPath;
    [collectionView reloadData];
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    _pageControl.currentPage = scrollView.contentOffset.x/scrollView.frame.size.width;
}

- (void)reloadGiftList{
    kWeakSelf(self);
    [HttpApiNobLiveGift getGiftList:_giftListModel.giftTypeId callback:^(int code, NSString *strMsg, NSArray<ApiNobLiveGiftModel *> *arr) {
        if (code == 1) {
            if (arr.count > 0) {
                weakself.giftListModel = arr.firstObject;
            }else{
                weakself.giftListModel.giftList = [NSMutableArray array];
                weakself.giftListModel.backGiftCoin = 0;
            }
            self.emptyV.hidden = weakself.giftListModel.giftList.count;
            [weakself reloadCollectionView:weakself.giftListModel.giftList];
        }else{
            [SVProgressHUD showInfoWithStatus:strMsg];
        }
    }];
}

- (void)getGiftInfo{
    if (self.anchorId > 0) {
        kWeakSelf(self);
        /// 0:普通礼物 1:粉丝团(豪华礼物) 2:守护(专属礼物) 3:贵族礼物(特殊礼物) 4:背包礼物
        [HttpApiAnchorController getAnchorRelatedInfoVO:self.anchorId liveType:0 roomId:0 callback:^(int code, NSString *strMsg, AnchorRelatedInfoVOModel *model) {
            if (code == 1) {
                if (model.isFans == 1 && weakself.giftListModel.giftTypeId == 1) { ///粉丝团
                    [weakself.limitV removeFromSuperview];
                }
                if (model.isGuard == 1 && weakself.giftListModel.giftTypeId == 2) { ///守护
                    [weakself.limitV removeFromSuperview];
                }
            }
        }];
    }
}

- (UIView *)emptyV{
    if (!_emptyV) {
        UIImageView *imageV = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"gift_list_air"]];
        [_collectionV addSubview:imageV];
        _emptyV = imageV;
        
        UILabel *titleL = [[UILabel alloc] init];
        titleL.text = kLocalizationMsg(@"空空如也~");
        titleL.textColor = kRGBA_COLOR(@"#FFFFFF", 1.0);
        titleL.font = [UIFont systemFontOfSize:13];
        [imageV addSubview:titleL];
        
        [imageV mas_makeConstraints:^(MASConstraintMaker *make) {
            make.center.equalTo(_collectionV);
            make.size.mas_equalTo(CGSizeMake(180, 140));
        }];
        [titleL mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(imageV);
            make.bottom.equalTo(imageV).mas_offset(-16);
        }];
    }
    return _emptyV;
}

- (UIView *)limitV{
    if (!_limitV) {
        UIView *limitV = [[UIView alloc] init];
        [_collectionV addSubview:limitV];
        _limitV = limitV;
        
        UIImageView *imageV = [[UIImageView alloc] init];
        [limitV addSubview:imageV];
        
        UILabel *titleL = [[UILabel alloc] init];
        titleL.textColor = kRGBA_COLOR(@"#FFFFFF", 1.0);
        titleL.font = [UIFont systemFontOfSize:13];
        [imageV addSubview:titleL];
        UIButton *joinBtn = [UIButton buttonWithType:0];
        joinBtn.layer.masksToBounds = YES;
        joinBtn.titleLabel.font = [UIFont systemFontOfSize:13];
        [joinBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [joinBtn setBackgroundImage:[UIImage imageNamed:@"btn_bg_pink"] forState:UIControlStateNormal];
        [joinBtn addTarget:self action:@selector(openJoinBtnClick) forControlEvents:UIControlEventTouchUpInside];
        [limitV addSubview:joinBtn];
        [limitV mas_makeConstraints:^(MASConstraintMaker *make) {
            make.center.equalTo(_collectionV);
        }];
        [imageV mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(CGSizeMake(180, 140));
            make.top.left.right.equalTo(limitV);
        }];
        [titleL mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(imageV);
            make.bottom.equalTo(imageV).mas_offset(-27);
        }];
        [joinBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(limitV);
            make.size.mas_equalTo(CGSizeMake(130, 40));
            make.top.equalTo(imageV.mas_bottom);
            make.bottom.equalTo(limitV);
        }];
        [joinBtn layoutIfNeeded];
        joinBtn.layer.cornerRadius = 20;
        
        switch (_giftListModel.giftTypeId) {
            case 1:
            {
                imageV.image = [UIImage imageNamed:@"gift_select_fans"];
                titleL.text = kLocalizationMsg(@"您还未加入Ta的粉丝团哦~");
                [joinBtn setTitle:kLocalizationMsg(@"加入Ta的粉丝团") forState:UIControlStateNormal];
            }
                break;
            case 2:{
                imageV.image = [UIImage imageNamed:@"gift_select_guard"];
                titleL.text = kLocalizationMsg(@"守护Ta才可以送守护礼物哦~");
                [joinBtn setTitle:kLocalizationMsg(@"去守护Ta") forState:UIControlStateNormal];
            }
                break;
            case 3:{
                imageV.image = [UIImage imageNamed:@"gift_select_vip"];
                titleL.text = kLocalizationMsg(@"开通贵族才可以送贵族礼物哦~");
                [joinBtn setTitle:kLocalizationMsg(@"开通贵族") forState:UIControlStateNormal];
            }
                break;;
            default:
                break;
        }
        
    }
    return _limitV;
}

- (void)openJoinBtnClick{
    switch (_giftListModel.giftTypeId) {
        case 1:  ///粉丝团
        {
        }
            break;
        case 2:{  ///守护
            [RouteManager routeForName:RN_center_buyGuard currentC:[ProjConfig currentVC] parameters:@{@"userId":@(self.anchorId)}];
        }
            break;
        case 3:{ ///贵族
            [RouteManager routeForName:RN_User_buyVIP currentC:[ProjConfig currentVC] parameters:nil];
        }
            break;;
        default:
            break;
    }
}

@end

