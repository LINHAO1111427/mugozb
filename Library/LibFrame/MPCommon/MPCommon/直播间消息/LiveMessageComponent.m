//
//  LiveMessageComponent.m
//  TCDemo
//
//  Created by CH on 2019/10/22.
//  Copyright © 2019 CH. All rights reserved.
//

#import "LiveMessageComponent.h"
#import <LiveCommon/LiveComponentInterface.h>
#import <LibProjBase/ProjConfig.h>
#import <LiveCommon/LiveComponentMsgListener.h>
#import <LiveCommon/LiveComponentMsgMgr.h>
#import <TXImKit/TXImKit.h>
#import <LibProjModel/KLCUserInfo.h>
#import <LibTools/LibTools.h>
#import <LibProjModel/ApiSimpleMsgRoomModel.h>
#import <LiveCommon/LiveManager.h>
#import <Masonry/Masonry.h>
#import <LibProjModel/ApiUserInfoModel.h>

#import <LibProjModel/ApiBaseEntityModel.h>
#import <LiveCommon/LiveManager.h>
#import <LibProjModel/OOOReturnModel.h>

#import <LibProjModel/ApiSendMsgRoomModel.h>
#import <LibProjModel/ApiTimerExitRoomModel.h>
#import <LibProjModel/ApiExitRoomModel.h>

#import "CoinInsufficientTipView.h"
#import "NoticeShowView.h"
#import "PlayAllUserBannerObj.h"
#import <LibProjView/BalanceLackPromptView.h>
#import <AgoraExtension/AgoraExtManager.h>
#import "LivePayTipsView.h"

@interface LiveMessageComponent()<LiveComponentInterface,LiveComponentMsgListener>

@property(nonatomic,weak) UIView *secondView;
@property(nonatomic,weak) UIView *thirdView;
@property(nonatomic,weak) UIView *fourthView;
@property(nonatomic,weak) UIView *fifthView;

@property(nonatomic,weak) UIViewController *superVC;

@property (nonatomic, copy) PlayAllUserBannerObj *allUserBannerObj;


@property (nonatomic, weak)LivePayTipsView *payTipsView;  ///支付弹窗

@property (nonatomic, assign)BOOL isTimeOut; ///计时付费房间超时状态

@end

@implementation LiveMessageComponent

- (void)dealloc
{
   // NSLog(@"过滤文字%s"),__func__);
    [[NSNotificationCenter defaultCenter] removeObserver:self name:liveRoomWillAppearNotify object:nil];
}

// MARK: - 初始化UI

- (void)parInitViewController:(UIViewController *)superVC views:(NSArray<UIView *> *)views{
    
    _superVC = superVC;
    
    [LiveComponentMsgMgr addMsgListener:self];
    [[IMSocketIns getIns] addReceiver:socketGroupLive receiver:self];
    
    _secondView = views[1];
    _thirdView = views[2];
    _fourthView = views[3];
    _fifthView = views[views.count-2];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(liveRoomWillAppear:) name:liveRoomWillAppearNotify object:nil];
    
}


// MARK: - 组件通讯
- (void)onMsg:(NSInteger)msgType msgDic:(NSDictionary *)msgDic{
    switch (msgType) {
        case LM_LiveRoomInfo:{
            [self initShowData];
        }
            break;
        case LM_GameRule:{  ///玩法
            [self gameRule];
        }
            break;
        case LM_LiveLeaveInfo:
        case LM_ExitRoom:{ // 点击关闭
            _allUserBannerObj = nil;
            [_payTipsView dismissView];
            [[NSNotificationCenter defaultCenter] removeObserver:self name:liveRoomWillAppearNotify object:nil];
        }
            break;
        case LM_PromissionShow:{
            [self.payTipsView showFeeTips];
        }
            break;
        case LM_UserJoinPlay:{
            [self.allUserBannerObj playAllUserView:msgDic[@"model"]];
        }
            break;
        default:
            break;
    }
}

// MARK: - Other

- (void)gameRule{
    [NoticeShowView showNotice];
}

- (void)initShowData{
    if ([LiveManager liveInfo].liveType == LiveTypeForMPAudioLive) {
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            if ([[LiveManager liveInfo].roomModel.notice hasValue] && [LiveManager liveInfo].roomRole != RoomRoleForAnchor) {
                if ([LiveManager liveInfo].roomModel.notice.length) {
                    [NoticeShowView showNotice];
                    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                        [NoticeShowView dismiss];
                    });
                }
            }
        });
    }
}


- (void)liveRoomWillAppear:(NSNotification *)notify{
    if (_isTimeOut) {
        [self.payTipsView showFeeTips];
        [self.payTipsView rechargeSuccess];
    }else{
        [_payTipsView rechargeSuccess];
    }
}


// MARK: - Lazy

// MARK: 弹幕view

- (PlayAllUserBannerObj *)allUserBannerObj {
    if (!_allUserBannerObj) {
        _allUserBannerObj = [[PlayAllUserBannerObj alloc] initWithSuperView:_fourthView];
    }
    return _allUserBannerObj;
}

// MARK: 消息view

- (LivePayTipsView *)payTipsView{
    if (!_payTipsView) {
        kWeakSelf(self);
        LivePayTipsView *tipV = [[LivePayTipsView alloc] initWithSuperView:_fifthView];
        tipV.paymengBlock = ^(BOOL success) {
            if (success) {
                weakself.isTimeOut = NO;
            }
        };
        _payTipsView = tipV;
    }
    return _payTipsView;
}



// MARK: - Socket -

/// 指定用户发送消息  根据 liveFunction 来判断 是否开启直播购功能  如果是直播购并且是观众 在主播切换直播购与普通直播时在此刷新状态
- (void)onUserSendApiJoinRoom:(AppJoinRoomVOModel *)appJoinRoomVO{
    if (appJoinRoomVO && [LiveManager liveInfo].roomId == appJoinRoomVO.roomId) {
        [LiveManager liveInfo].roomModel = appJoinRoomVO;
        if ([LiveManager liveInfo].roomRole == RoomRoleForAudience && appJoinRoomVO.liveFunction == 1) {
            [LiveComponentMsgMgr sendMsg:LM_ShowShoppingGoods msgDic:@{@"changeMode":@(1)}];///包含直播购且要求展示商品
        }else{
            [LiveComponentMsgMgr sendMsg:LM_GoodExplanation msgDic:@{@"pic":@"",@"goodsId":@(0),@"hasGoodExplain":@(NO)}];///撤销讲解
        }
        
        [LiveComponentMsgMgr sendMsg:LM_ShoppingBanner msgDic:@{@"url":appJoinRoomVO.shopLiveBanner.length > 0?appJoinRoomVO.shopLiveBanner:@""}];
        [LiveComponentMsgMgr sendMsg:LM_ReloadFunBtn msgDic:nil];
    }
}

/** 指定用户发消息 */
-(void) onAppointUserSend:(ApiSendMsgRoomModel* )apiSendMsgRoom{
}

/** 计时房间余额不足退出房间 */
-(void) onTimerExitRoom:(ApiTimerExitRoomModel* )apiTimerExitRoom{
    if (apiTimerExitRoom.roomId != [LiveManager liveInfo].roomId) {
        return;
    }
    [LiveManager promissionStop:YES];
    _isTimeOut = YES;
    [BalanceLackPromptView gotoRecharge:^(BOOL go) {
        if (!go) {
            [LiveComponentMsgMgr sendMsg:LM_CloseLive msgDic:nil];
        }
    }];
}

- (void)onRoomTotalVotes:(double)roomVotes{
    [LiveComponentMsgMgr sendMsg:LM_RoomTotalVotes msgDic:@{@"roomVotes":@(roomVotes)}];
}

/**
 修改房间公告推送公告内容
 @param conetnt null
 */
-(void) onUserNoticMsg:(NSString *)conetnt {
    ApiSimpleMsgRoomModel *model = [[ApiSimpleMsgRoomModel alloc] init];
    model.type = 13;
    model.content = conetnt;
    [LiveComponentMsgMgr sendMsg:LM_MessageForOther msgDic:@{@"model":model}];
    [LiveManager liveInfo].roomModel.notice = conetnt;
}

/**
 修改房间类型，其观众退出房间
 @param apiExitRoom null
 */
-(void) onUserUpLiveTypeExitRoom:(ApiExitRoomModel* )apiExitRoom {
    if (apiExitRoom.roomId != [LiveManager liveInfo].roomId) {
        return;
    }
    if ([LiveManager liveInfo].anchorId == [ProjConfig userId]) {
        return;
    }
    if ([LiveManager liveInfo].roomRole != RoomRoleForAnchor) {
        ///判断当前用户是否是贵族，并且修改的房间是贵族模式   或者普通房间
        if (apiExitRoom.roomType == 0 || ([LiveManager liveInfo].roomModel.nobleGrade > 0 && apiExitRoom.roomType == 4)) {
            
        }else{
            [self.payTipsView showChangeTips:apiExitRoom];
        }
    }
}


/**
 计时房间5分钟不足时发送提醒
 @param times 还能观看倒计时秒
 */
-(void) onUserTimmerRoomRemind:(int)times {
    [CoinInsufficientTipView showLastTime:times];
}


@end
