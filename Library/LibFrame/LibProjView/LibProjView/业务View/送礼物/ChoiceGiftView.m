//
//  ChoiceGiftView.m
//  youMengLive
//
//  Created by admin on 2019/8/2.
//  Copyright © 2019 cat. All rights reserved.
//

#import "ChoiceGiftView.h"

#import <LibTools/LibTools.h>
#import <Masonry/Masonry.h>

#import "GiftUserModel.h"
#import <LibProjModel/NobLiveGiftModel.h>
#import <LibProjModel/HttpApiNobLiveGift.h>
#import <TXImKit/TXImKit.h>

#import <LibProjModel/KLCAppConfig.h>
#import <LibProjModel/ApiGiftSenderModel.h>
#import <LibProjModel/IMApiLiveGift.h>
#import <LibProjView/TipAlertView.h>

#import "LiveGiftView.h"
#import <LibProjBase/PopupTool.h>

#import "ForceAlertController.h"
#import <LibProjView/FansGroupShowView.h>

@interface GiftShowMoreBtnView : UIControl

@property (nonatomic, weak)UIButton *moreBtn;

@end

@implementation GiftShowMoreBtnView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.moreBtn.hidden = NO;
    }
    return self;
}

- (UIButton *)moreBtn{
    if (!_moreBtn) {
        UIButton *btn = [UIButton buttonWithType:0];
        btn.userInteractionEnabled = NO;
        [btn setImage:[UIImage imageNamed:@"nearby_lay_down_arrow_white"] forState:UIControlStateNormal];
        [self addSubview:btn];
        [btn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(CGSizeMake(20, 20));
            make.center.equalTo(self);
        }];
    }
    return _moreBtn;
}


@end


@interface ChoiceGiftView ()<UIGestureRecognizerDelegate,LiveGiftViewDelegate>


@property (nonatomic, weak)UIView *contentBgView; //内容视图（动画效果）
@property (nonatomic, weak)LiveGiftView *giftView;///礼物

@property (nonatomic, assign)BOOL isPack;  ///selectType = 0 礼物。  selectType = 1 背包
@property (nonatomic, copy)NSArray<GiftUserModel *> *selectUsers;   ///选择的用户
@property (nonatomic, strong)NobLiveGiftModel *selectGiftModel;  //选择的礼物
@property(nonatomic, assign)int giftCount;   //礼物个数
///接口用到-- 送礼物类型type
@property (nonatomic, assign)int sendType;

@property (nonatomic, copy)SendGiftSuccess successBlock;

@property (nonatomic, weak)GiftShowMoreBtnView *moreBtn;

@property (nonatomic, assign)CGFloat bgViewHeight;

///是否为可选择选择收礼人模式
@property (nonatomic, assign)BOOL isSelectUser;

@end

@implementation ChoiceGiftView

+ (void)showGift:(int)sendType users:(NSArray<GiftUserModel *> *)users hasContinue:(BOOL)has sendSuccess:(SendGiftSuccess)success {
    ChoiceGiftView *gift = [[ChoiceGiftView alloc] init];
    gift.isSelectUser = YES;
    gift.sendType = sendType;
    gift.successBlock = success;
    [gift createViewWithHasContinue:has userItems:users];
}


+ (void)showGiftNoSelectAll:(int)sendType giftId:(int64_t)giftId users:(NSArray<GiftUserModel *> *)users sendSuccess:(SendGiftSuccess)success {
    ChoiceGiftView *gift = [[ChoiceGiftView alloc] init];
    gift.isSelectUser = NO;
    gift.successBlock = success;
    gift.selectUsers = users;
    gift.sendType = sendType;
    gift.isPack = NO;
    gift.giftCount = 1;
    NobLiveGiftModel *giftModel = [[NobLiveGiftModel alloc] init];
    giftModel.id_field = giftId;
    gift.selectGiftModel = giftModel;
    [gift sendLiWuForSuccess:nil];
}

+ (void)showGiftNoSelectUser:(int)sendType users:(NSArray<GiftUserModel *> *)users hasContinue:(BOOL)has sendSuccess:(SendGiftSuccess)success {
    ChoiceGiftView *gift = [[ChoiceGiftView alloc] init];
    gift.isSelectUser = NO;
    gift.sendType = sendType;
    gift.successBlock = success;
    gift.selectUsers = users;
    [gift createViewWithHasContinue:has userItems:users];
}


+ (void)showGift:(int)sendType giftType:(int)giftType giftId:(int64_t)giftId users:(NSArray<GiftUserModel *> *)users hasContinue:(BOOL)has sendSuccess:(SendGiftSuccess)success{
    ChoiceGiftView *gift = [[ChoiceGiftView alloc] init];
    gift.isSelectUser = YES;
    gift.successBlock = success;
    gift.selectUsers = users;
    gift.sendType = sendType;
    NobLiveGiftModel *giftModel = [[NobLiveGiftModel alloc] init];
    giftModel.id_field = giftId;
    giftModel.type = giftType;
    gift.selectGiftModel = giftModel;
    [gift createViewWithHasContinue:has userItems:users];
}


- (void)touchView:(UITapGestureRecognizer *)tap{
    [self show:NO];
}


- (void)createViewWithHasContinue:(BOOL)has userItems:(NSArray<GiftUserModel *> *)userItems{
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(touchView:)];
    tap.delegate = self;
    [self addGestureRecognizer:tap];
    
    self.frame = CGRectMake(0, 0, kScreenWidth, kScreenHeight);
    
    self.bgViewHeight = 320 + kSafeAreaBottom + (self.isSelectUser?60:20);
    
    CGFloat sendW = kMaxWidth;
    
    UIView *bgV = [[UIView alloc] initWithFrame:CGRectMake(self.width-sendW, self.height, sendW, self.bgViewHeight)];
    [self addSubview:bgV];
    _contentBgView = bgV;
    bgV.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.8];
    [bgV cornerRadii:CGSizeMake(25, 25) byRoundingCorners:(UIRectCornerTopLeft|UIRectCornerTopRight)];
    
    ///唯一的主播Id
    int64_t anchorId = 0;
    for (GiftUserModel *users in userItems) {
        if (users.isAnchor == YES) {
            anchorId = users.userId;
        }
    }
    if (anchorId == 0) {
        GiftUserModel *users = userItems.firstObject;
        anchorId = users.userId;
    }
    ///礼物页面
    LiveGiftView *giftView = [[LiveGiftView alloc] initWithFrame:CGRectMake(0, 0, bgV.width, self.bgViewHeight-kSafeAreaBottom) anchorId:anchorId hasContinueSend:has canSelectUser:self.isSelectUser defaultGift:self.selectGiftModel];
    giftView.delegate = self;
    [giftView reloadUserItem:userItems];
    [bgV addSubview:giftView];
    _giftView = giftView;
    [giftView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(giftView.width, giftView.height));
        make.left.right.equalTo(bgV);
        make.bottom.equalTo(bgV).offset(-kSafeAreaBottom);
    }];
    
    [self show:YES];
}




//发送礼物
-(void)sendLiWuForSuccess:(void(^)(BOOL success, ApiGiftSenderModel *senderModel))resultBlock{
    if(!_selectGiftModel){
        [SVProgressHUD showInfoWithStatus:kLocalizationMsg(@"请选择礼物")];
        resultBlock?resultBlock(NO,nil):nil;
        return;
    }
    if (!self.selectUsers.count) {
        [SVProgressHUD showInfoWithStatus:kLocalizationMsg(@"请选择送礼对象!")];
        resultBlock?resultBlock(NO,nil):nil;
        return;
    }
    
    int64_t shortVideoId = -1;
    NSMutableArray<GiftSenderDataModel *> *selectUsers = [[NSMutableArray alloc] init];
    for (GiftUserModel *subUser in self.selectUsers) {
        
        shortVideoId = subUser.shortVideoId > 0?subUser.shortVideoId:-1;
        
        GiftSenderDataModel *giftSenderM = [[GiftSenderDataModel alloc] init];
        giftSenderM.anchorId = subUser.anchorId>0?subUser.anchorId:-1;
        giftSenderM.taggerUserId = subUser.userId;
        giftSenderM.roomId =  subUser.roomId>0?subUser.roomId:-1;
        giftSenderM.showId = subUser.showId.length?subUser.showId:@"-1";
        
        [selectUsers addObject:giftSenderM];
    }
    
    kWeakSelf(self);
    [HttpApiNobLiveGift giftSender:_isPack?_selectGiftModel.backid:-1 giftId:_selectGiftModel.id_field giftSenderDataList:selectUsers number:_giftCount shortVideoId:shortVideoId type:_sendType>0?_sendType:1 callback:^(int code, NSString *strMsg, NSArray<ApiGiftSenderModel *> *arr) {
        resultBlock?resultBlock((code == 1&&arr.count>0)?YES:NO,(arr.count>0?arr.lastObject:nil)):nil;
        if (code == 1) {
            if (weakself.successBlock) {
                weakself.successBlock(arr);
            }
        }
        else if (code ==3){
            [weakself showRechangeAlert:[NSString stringWithFormat:kLocalizationMsg(@"你的余额不够%0.0lf%@"),weakself.selectGiftModel.needcoin*weakself.giftCount,[KLCAppConfig unitStr]]];
        }
        else if (code ==4){
            [weakself showRechangeAlert:strMsg];
        }
        else if (code == 11){ ///粉丝团
            [weakself toRechange:strMsg resultCode:code userData:selectUsers.firstObject];
        }
        else if (code == 12){  ///守护
            [weakself toRechange:strMsg resultCode:code userData:selectUsers.firstObject];
        }
        else if (code == 13){  ///贵族
            [weakself toRechange:strMsg resultCode:code userData:selectUsers.firstObject];
        }
        else{
            [SVProgressHUD showInfoWithStatus:strMsg];
        }
    }];
}

////赠送背包中所有礼物
-(void)sendPackAll:(void(^)(BOOL success, ApiGiftSenderModel *senderModel))resultBlock{
    
    if (!self.selectUsers.count) {
        [SVProgressHUD showInfoWithStatus:kLocalizationMsg(@"请选择送礼对象!")];
        resultBlock?resultBlock(NO,nil):nil;
        return;
    }
    
    int64_t shortVideoId = -1;
    NSMutableArray<GiftSenderDataModel *> *selectUsers = [[NSMutableArray alloc] init];
    for (GiftUserModel *subUser in self.selectUsers) {
        
        shortVideoId = subUser.shortVideoId > 0?subUser.shortVideoId:-1;
        
        GiftSenderDataModel *giftSenderM = [[GiftSenderDataModel alloc] init];
        giftSenderM.anchorId = subUser.anchorId>0?subUser.anchorId:-1;
        giftSenderM.taggerUserId = subUser.userId;
        giftSenderM.roomId =  subUser.roomId>0?subUser.roomId:-1;
        giftSenderM.showId = subUser.showId.length?subUser.showId:@"-1";
        
        [selectUsers addObject:giftSenderM];
    }
    kWeakSelf(self);
    [HttpApiNobLiveGift senderGiftAll:selectUsers sendGiftType:_sendType>0?_sendType:1 shortVideoId:shortVideoId callback:^(int code, NSString *strMsg, NSArray<ApiGiftSenderModel *> *arr) {
        resultBlock?resultBlock((code == 1&&arr.count>0)?YES:NO,(arr.count>0?arr.lastObject:nil)):nil;
        if (code == 1) {
            if (weakself.successBlock) {
                weakself.successBlock(arr);
            }
        }else{
            [SVProgressHUD showInfoWithStatus:strMsg];
        }
    }];
}


- (void)showRechangeAlert:(NSString *)str{
    kWeakSelf(self);
    [TipAlertView showTitle:str subTitle:^(UILabel * _Nonnull subTitleL) {
        subTitleL.text = kLocalizationMsg(@"先去充值吧!");
    } sureBtnTitle:kLocalizationMsg(@"立即充值") btnClick:^{
        [weakself gotoRechange];
    } cancel:nil];
    
}


- (void)toRechange:(NSString *)message resultCode:(int)code userData:(GiftSenderDataModel *)userModel{
    ForceAlertController *alertVC = [ForceAlertController alertTitle:kLocalizationMsg(@"提示") message:message];
    [alertVC addOptions:kLocalizationMsg(@"取消") textColor:ForceAlert_BlackColor clickHandle:nil];
    [alertVC addOptions:(code == 12?kLocalizationMsg(@"去守护"):kLocalizationMsg(@"去开通")) textColor:ForceAlert_NormalColor clickHandle:^{
        switch (code) {
            case 11:
            {
                [FansGroupShowView showFansWith:userModel.taggerUserId hasBgColor:NO showUserInfo:^(int64_t userId) {
                    if (userId > 0) {
                        [RouteManager routeForName:RN_user_userInfoVC currentC:[ProjConfig currentVC] parameters:@{@"id":@(userId)}];
                    }
                }];
            }
                break;
            case 12:
            {   [RouteManager routeForName:RN_center_userGuard currentC:[ProjConfig currentVC] parameters:@{@"userId":@(userModel.taggerUserId)}];  }
                break;
            case 13:
            {   [RouteManager routeForName:RN_User_buyVIP currentC:[ProjConfig currentVC] parameters:nil];  }
                break;
            default:
                break;
        }
    }];
    [[ProjConfig currentVC] presentViewController:alertVC animated:YES completion:nil];
}


- (void)gotoRechange{
    [RouteManager routeForName:RN_center_myAccountAC currentC:[ProjConfig currentVC]];
}

- (void)moreBtnClick{
    [self hiddenSelectView:NO];
}

- (void)show:(BOOL)isShow{
    kWeakSelf(self);
    if (isShow) {
        UIView *v = [PopupTool getPopupViewForClass:[self class]];
        if (!v) {
            [[PopupTool share] createPopupViewWithLinkView:self allowTapOutside:NO];
            [UIView animateWithDuration:0.3 animations:^{
                //                self.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:isShow?0.4:0.0];
                CGRect rc = weakself.contentBgView.frame;
                rc.origin.y = kScreenHeight-rc.size.height;
                weakself.contentBgView.frame = rc;
            } completion:^(BOOL finished) {
            }];
        }
    }else{
        [_moreBtn removeFromSuperview];
        _moreBtn = nil;
        [UIView animateWithDuration:0.3 animations:^{
            //            self.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.0];
            CGRect rc = weakself.contentBgView.frame;
            rc.origin.y = kScreenHeight;
            weakself.contentBgView.frame = rc;
        } completion:^(BOOL finished) {
            [[PopupTool share] closePopupView:weakself animate:NO];
        }];
    }
}

- (void)hiddenSelectView:(BOOL)hidden{
    if ([[ProjConfig shareInstence].baseConfig whetherHiddenViewAtSendGift]) {
        ///可以隐藏
        kWeakSelf(self);
        if (hidden) {
            [self.contentBgView cornerRadii:CGSizeMake(0, 0) byRoundingCorners:(UIRectCornerTopLeft|UIRectCornerTopRight)];
            //            [UIView animateWithDuration:0.1 animations:^{
            CGFloat viewHeight = kSafeAreaBottom+50;
            weakself.contentBgView.frame = CGRectMake(weakself.contentBgView.x, weakself.height-viewHeight, weakself.contentBgView.width, viewHeight);
            //            } completion:^(BOOL finished) {
            weakself.moreBtn.y = weakself.contentBgView.y-weakself.moreBtn.height;
            //            }];
        }else{
            [weakself.moreBtn removeFromSuperview];
            weakself.moreBtn = nil;
            
            //            [UIView animateWithDuration:0.1 animations:^{
            CGFloat viewHeight = weakself.bgViewHeight;;
            weakself.contentBgView.frame = CGRectMake(weakself.contentBgView.x, weakself.height-viewHeight, weakself.contentBgView.width, viewHeight);
            //            } completion:^(BOOL finished) {
            [weakself.contentBgView cornerRadii:CGSizeMake(25, 25) byRoundingCorners:(UIRectCornerTopLeft|UIRectCornerTopRight)];
            //            }];
        }
    }
}


- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch{
    if (touch.view == self) {
        return YES;
    }
    return NO;
}

#pragma mark LiveGiftViewDelegate

- (void)giftView:(LiveGiftView *)giftView gotoRechange:(BOOL)go{
    if (go) {
        [self gotoRechange];
    }
}

- (void)giftView:(LiveGiftView *)giftView sendGift:(NobLiveGiftModel *)gift Count:(int)giftCount giftType:(int)type selUsers:(nonnull NSArray *)users{
    if (self.isSelectUser) {
        self.selectUsers = users;
    }
    self.isPack = (type == 4)?YES:NO;
    self.selectGiftModel = gift;
    self.giftCount = giftCount;
    kWeakSelf(self);
    [self sendLiWuForSuccess:^(BOOL success, ApiGiftSenderModel *senderModel) {
        [weakself.giftView sendGiftSuccess:success senderModel:senderModel];
        if (success) {
            if ([[ProjConfig shareInstence].baseConfig whetherHiddenViewAtSendGift]) {
                ///可以隐藏
                [weakself hiddenSelectView:YES];
            }
        }
    }];
}

///赠送所有礼物
- (void)sendAllPackGift:(LiveGiftView *)giftView selUsers:(NSArray *)users{
    if (self.isSelectUser) {
        self.selectUsers = users;
    }
    kWeakSelf(self);
    [self sendPackAll:^(BOOL success, ApiGiftSenderModel *senderModel) {
        [weakself.giftView sendGiftSuccess:success senderModel:senderModel];
        if (success) {
            if ([[ProjConfig shareInstence].baseConfig whetherHiddenViewAtSendGift]) {
                ///可以隐藏
                [weakself hiddenSelectView:YES];
            }
        }
    }];
}

- (GiftShowMoreBtnView *)moreBtn{
    if (!_moreBtn) {
        GiftShowMoreBtnView *moreBtn = [[GiftShowMoreBtnView alloc] initWithFrame:CGRectMake(self.contentBgView.x, 0, self.contentBgView.width, 35)];
        moreBtn.backgroundColor = self.contentBgView.backgroundColor;
        [self addSubview:moreBtn];
        [moreBtn addTarget:self action:@selector(moreBtnClick) forControlEvents:UIControlEventTouchUpInside];
        _moreBtn = moreBtn;
        [moreBtn cornerRadii:CGSizeMake(25, 25) byRoundingCorners:(UIRectCornerTopLeft|UIRectCornerTopRight)];
    }
    return _moreBtn;
}

@end
