//
//  LiveGiftView.m
//  LiveCommon
//
//  Created by klc_sl on 2020/3/24.
//  Copyright © 2020 . All rights reserved.
//

#import "LiveGiftView.h"

#import "GiftListShowView.h"
#import "GiftSendView.h"
#import "GiftHeaderView.h"

#import <LibTools/LibTools.h>
#import <Masonry/Masonry.h>

#import <JXCategoryView/JXCategoryTitleView.h>
#import <JXCategoryView/JXCategoryIndicatorImageView.h>
#import <JXCategoryView/JXCategoryListContainerView.h>
#import <LibProjModel/HttpApiNobLiveGift.h>
#import <LibProjModel/NobLiveGiftModel.h>
#import <LibProjModel/ApiNobLiveGiftModel.h>
#import <LibProjModel/ApiGiftSenderModel.h>

@interface LiveGiftView ()<GiftListShowViewDelegate,JXCategoryViewDelegate,JXCategoryListContainerViewDelegate>

@property (nonatomic, strong)NobLiveGiftModel *selectModel; ///新选择的

@property (nonatomic, weak)JXCategoryTitleView *titleV;

@property (nonatomic, copy)NSArray *giftList;

@property (nonatomic, weak)GiftListShowView *packGiftV;

@property (nonatomic, assign)int64_t anchorId;

@property (nonatomic, weak)GiftSendView *sendV;     //底部发送视图

@property (nonatomic, assign)int giftType; ///礼物类型

@property (nonatomic, weak)GiftHeaderView *headerView;

@property (nonatomic, strong)NobLiveGiftModel *defaultGiftModel; ///默认选择的

@end


@implementation LiveGiftView

- (instancetype)initWithFrame:(CGRect)frame anchorId:(int64_t)anchorId hasContinueSend:(BOOL)has canSelectUser:(BOOL)can defaultGift:(NobLiveGiftModel * _Nullable)giftModel
{
    self = [super initWithFrame:frame];
    if (self) {
        self.anchorId = anchorId;
        self.defaultGiftModel = giftModel;
        [self createView:has canSelectUser:can];
        [self loadGiftData];
    }
    return self;
}

- (void)sendGiftSuccess:(BOOL)success senderModel:(ApiGiftSenderModel *)senderModel {
    
    [self.sendV sendGiftResult:success];
    
    if (success && senderModel) {
        
        [self changeUserLastCoin:senderModel.userCoin packTotalCoin:senderModel.backpackCoinSum];

        if (_giftList.count > self.titleV.selectedIndex) {
            ApiNobLiveGiftModel *GiftModel = self.giftList[self.titleV.selectedIndex];
            //////背包礼物  需要刷新数据
            if (GiftModel.giftTypeId == 4 && _packGiftV) {
                [_packGiftV reloadPackData];
            }
        }
    }
    
}

- (void)reloadUserItem:(NSArray *)users{
    self.headerView.userItems = users;
}

- (void)loadGiftData{
    kWeakSelf(self);
    [HttpApiNobLiveGift getGiftList:-1 callback:^(int code, NSString *strMsg, NSArray<ApiNobLiveGiftModel *> *arr) {
        if (code == 1) {
            [weakself showData:arr];
        }else{
            [SVProgressHUD showInfoWithStatus:strMsg];
        }
    }];
}

///显示礼物分类
- (void)createView:(BOOL)hasContinue canSelectUser:(BOOL)can{

    kWeakSelf(self);
    CGFloat headerH = 20;
    CGFloat lineH = 10;
    if (can) {
        ///选择用户信息 和背包
        GiftHeaderView *headerView = [[GiftHeaderView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 50)];
        [self addSubview:headerView];
        self.headerView = headerView;
        ///线
        UIImageView *line = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"gift_select_line"]];
        line.frame = CGRectMake(15, headerView.maxY, self.width-30, lineH);
        [self addSubview:line];
        
        headerH = 60;
    }

    
    ///发送UI
    GiftSendView *giftSendV =  [[GiftSendView alloc] initWithFrame:CGRectMake(0, self.height-50, self.width, 50)];
    giftSendV.isContinue = hasContinue;
    [self addSubview:giftSendV];
    _sendV = giftSendV;
    giftSendV.rechangeBtnClick = ^(BOOL isRechange) {
        if (isRechange) {
            if (weakself.delegate && [weakself.delegate respondsToSelector:@selector(giftView:gotoRechange:)]) {
                [weakself.delegate giftView:weakself gotoRechange:YES];
            }
        }else{
            if (weakself.delegate && [weakself.delegate respondsToSelector:@selector(sendAllPackGift:selUsers:)]) {
                [weakself.delegate sendAllPackGift:weakself selUsers:[weakself.headerView getSelectUsers]];
            }
        }
    };
    giftSendV.sendBtnClick = ^(int giftCount) {
        if (weakself.delegate && [weakself.delegate respondsToSelector:@selector(giftView:sendGift:Count:giftType:selUsers:)]) {
            [weakself.delegate giftView:weakself sendGift:weakself.selectModel Count:giftCount giftType:weakself.giftType selUsers:[weakself.headerView getSelectUsers]];
        }
    };
    ///线
    UIImageView *line = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"gift_select_line"]];
    line.frame = CGRectMake(15, giftSendV.y-10, self.width-30, lineH);
    [self addSubview:line];
    
    ///中间选择
    JXCategoryTitleView *titleV = [[JXCategoryTitleView alloc] initWithFrame:CGRectMake(0, headerH+6, self.width, 25)];
    titleV.delegate = self;
    titleV.cellSpacing = 30;
    titleV.contentEdgeInsetLeft = 15;
    titleV.contentEdgeInsetRight = 15;
    titleV.titleFont = [UIFont systemFontOfSize:13];
    titleV.titleSelectedFont = [UIFont systemFontOfSize:14];
    titleV.titleColor = [UIColor whiteColor];
    titleV.titleSelectedColor = [ProjConfig normalColors];
    titleV.averageCellSpacingEnabled = NO;
    [self addSubview:titleV];
    _titleV = titleV;
    
    JXCategoryIndicatorImageView *indicatorImageView = [[JXCategoryIndicatorImageView alloc] init];
    indicatorImageView.indicatorImageView.image = [UIImage imageNamed:@"btn_bg_pink"];
    indicatorImageView.indicatorCornerRadius = 1.5;
    indicatorImageView.indicatorImageView.clipsToBounds = YES;
    indicatorImageView.indicatorImageView.layer.cornerRadius = 1.5;
    indicatorImageView.indicatorImageView.layer.masksToBounds = YES;
    indicatorImageView.indicatorImageViewSize = CGSizeMake(10, 3);
    titleV.indicators = @[indicatorImageView];
    
    JXCategoryListContainerView *containerView = [[JXCategoryListContainerView alloc] initWithType:JXCategoryListContainerType_ScrollView delegate:self];
    containerView.frame = CGRectMake(0, titleV.maxY+10, self.width, giftSendV.y-lineH-(titleV.maxY+10));
    containerView.scrollView.scrollEnabled = NO;
    [self addSubview:containerView];
    self.titleV.listContainer = containerView;
    [containerView reloadData];
}

//改变用户的金币数量
- (void)changeUserLastCoin:(double)lastCoin packTotalCoin:(double)packTotalCoin{
    [self.sendV reShowPackTotalCoin:packTotalCoin lastCoin:lastCoin giftType:self.giftType];
}


///显示礼物数据
- (void)showData:(NSArray<ApiNobLiveGiftModel *> *)giftModels{
    if (giftModels.count) {
        ApiNobLiveGiftModel *model = giftModels.firstObject;
        self.giftType = model.giftTypeId;
        [self changeUserLastCoin:model.coin packTotalCoin:model.backGiftCoin];
    }
    
    NSMutableArray<ApiNobLiveGiftModel *> *giftList = [[NSMutableArray alloc] init];
    NSMutableArray *titles = [[NSMutableArray alloc] init];
    for (ApiNobLiveGiftModel *subGiftModel in giftModels) {
        [titles addObject:subGiftModel.giftTypeName];
        [giftList addObject:subGiftModel];
    }
    ///背包
    ApiNobLiveGiftModel *packModel = [[ApiNobLiveGiftModel alloc] init];
    packModel.giftTypeId = 4;
    packModel.giftTypeName = kLocalizationMsg(@"背包");
    [titles addObject:packModel.giftTypeName];
    [giftList addObject:packModel];
    

    ///判断默认选择第几个
    __block NSUInteger defaltIndex = 0;
    [giftList enumerateObjectsUsingBlock:^(ApiNobLiveGiftModel * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if (obj.giftTypeId == self.defaultGiftModel.type) {
            defaltIndex = idx;
            *stop = YES;
        }
    }];
    self.titleV.defaultSelectedIndex = defaltIndex;
    self.titleV.titles = titles;
    [self.titleV reloadData];
    
    _giftList = giftList;
    [self.titleV.listContainer reloadData];
}



#pragma mark -JXCategoryViewDelegate,JXCategoryListContainerViewDelegate-
- (void)categoryView:(JXCategoryBaseView *)categoryView didSelectedItemAtIndex:(NSInteger)index{
}

- (NSInteger)numberOfListsInlistContainerView:(JXCategoryListContainerView *)listContainerView{
    return _giftList.count;
}

- (id<JXCategoryListContentViewDelegate>)listContainerView:(JXCategoryListContainerView *)listContainerView initListForIndex:(NSInteger)index{
    
    ApiNobLiveGiftModel *giftListModel = _giftList[index];
    
    int64_t defaultId = 0;
    if (self.defaultGiftModel.type == giftListModel.giftTypeId) {
        defaultId = self.defaultGiftModel.id_field;
        self.defaultGiftModel = nil;
    }
    
    GiftListShowView *giftV = [[GiftListShowView alloc] initWithFrame:CGRectMake(0, 0, listContainerView.width, listContainerView.height) defaultGiftId:defaultId];

    giftV.delegate = self;
    giftV.anchorId = _anchorId;
    giftV.giftListModel = giftListModel;
    
    if (giftListModel.giftTypeId == 4) {
        _packGiftV = giftV;
    }
    return giftV;
}


#pragma mark -GiftListShowViewDelegate-
- (void)giftListView:(GiftListShowView *)listView selectGift:(NobLiveGiftModel *)gift giftType:(int)giftType{
    self.giftType = giftType;
    
    if (self.selectModel.id_field != gift.id_field) {
        self.selectModel = gift;
        [self.sendV selectOneGift:giftType];
    }
    [self changeUserLastCoin:listView.giftListModel.coin packTotalCoin:listView.giftListModel.backGiftCoin];
}




@end
