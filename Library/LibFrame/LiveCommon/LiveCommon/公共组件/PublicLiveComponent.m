//
//  PublicLiveComponent.m
//  TCDemo
//
//  Created by CH on 2019/10/22.
//  Copyright © 2019 CH. All rights reserved.
//

#import "PublicLiveComponent.h"
#import <LiveCommon/LiveComponentInterface.h>
#import <LibProjBase/ProjConfig.h>
#import <LiveCommon/LiveComponentMsgListener.h>
#import <LibProjBase/RouteManager.h>
#import <LibProjBase/AppRouteName.h>
#import <LiveCommon/LiveComponentMsgMgr.h>
#import <TXImKit/TXImKit.h>
#import <LibTools/LibTools.h>
#import <LibProjModel/ApiSimpleMsgRoomModel.h>
#import <LibProjModel/OOOReturnModel.h>
#import <LibProjModel/HttpApiAnchorController.h>
#import <LibProjModel/AnchorRelatedInfoVOModel.h>

#import <LiveCommon/LiveManager.h>
#import "LiveInputView.h"
#import "LiveBarrageView.h"
#import "LiveInfoMsgList.h"
#import <AgoraExtension/AgoraExtManager.h>
#import "SystemNoticeObj.h"

#import <LibProjView/AddWishView.h>
#import <LibProjView/FansGroupShowView.h>
#import <LibProjModel/HttpApiLiveLogController.h>
#import "LiveInViolationHintView.h"

@interface PublicLiveComponent()<LiveComponentInterface,LiveComponentMsgListener>

@property(nonatomic,weak) UIView *secondView;
@property(nonatomic,weak) UIView *thirdView;
@property(nonatomic,weak) UIView *fourthView;
@property(nonatomic,weak) UIView *fifthView;

@property(nonatomic,weak) UIViewController *superVC;
/// 消息列表view
@property(nonatomic,weak) LiveInfoMsgList *msgListView;
/// 弹幕列表view
@property(nonatomic,weak) LiveBarrageView *barrageListView;
///输入框
@property (nonatomic, weak) LiveInputView *inputView;
/// 系统公告
@property (nonatomic, copy) SystemNoticeObj *systemNotice;


@end

@implementation PublicLiveComponent

- (void)dealloc
{
   // NSLog(@"过滤文字%s"),__func__);
    _systemNotice = nil;
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
    
    self.msgListView.hidden = YES;
    
    [self agoraUserNotification];

}


// MARK: - 组件通讯
- (void)onMsg:(NSInteger)msgType msgDic:(NSDictionary *)msgDic{
    switch (msgType) {
        case LM_MessageForOther:{
            ApiSimpleMsgRoomModel *model = msgDic[@"model"];
            [_msgListView addMsg:[MessageModel convertWithApiSimpleMsgRoomModel:model]];
        }
            break;
            
        case LM_LiveRoomInfo:{
            [self showMsssageView];
            [self showSystemInfo];
        }
            break;
        case LM_SendMessage:{      // 显示输入框view
            [LiveInputView showInputView:msgDic[@"msg"]];
        }
            break;
        case LM_LiveLeaveInfo:
        case LM_ExitRoom:{ // 点击关闭
            [_msgListView removeFromSuperview];
            [_barrageListView removeFromSuperview];
            [_inputView removeFromSuperview];
            _systemNotice = nil;
        }
            break;
            
        case LM_GotoRecharge:  ///去充值
        {
            [self pushRecharge];
        }
            break;
        case LM_JoinFans: ///添加粉丝团
        {
            [self fansView];
        }
            break;
        case LM_AddWish:{ ///添加心愿单
            int64_t roomId = [LiveManager liveInfo].roomId;
            [AddWishView addMineWishAndRoomId:roomId>0?roomId:-1 touid:-1 hasCover:NO Block:nil];
        }
            break;
        case LM_BuyVIP:{   ///购买VIP
            [RouteManager routeForName:RN_User_buyVIP currentC:_superVC parameters:nil];
        }
            break;
        case LM_SetFans:{  ///粉丝团&编辑粉丝团
            [RouteManager routeForName:RN_activity_fansGroupAC currentC:_superVC parameters:@{@"id":@([ProjConfig userId]),@"title":kLocalizationMsg(@"我的粉丝团")}];
        }
            break;
        case LM_UserReport:{  ///举报用户
            [RouteManager routeForName:RN_base_userReportVC currentC:_superVC parameters:@{@"id":@([LiveManager liveInfo].anchorId)}];
        }
            break;
        case LM_GuardInfo:{  ///守护
            [RouteManager routeForName:RN_center_userGuard currentC:[ProjConfig currentVC] parameters:@{@"userId":@([LiveManager liveInfo].anchorId),@"title":kLocalizationMsg(@"Ta的守护")}];
        }
            break;
            
        default:
            break;
    }
}


- (void)showSystemInfo{
    
    NSString *systemNoticeMsg = @"";
    NSString *roomNoticeMes = @"";
    switch ([LiveManager liveInfo].liveType) {
        case LiveTypeForOneToOne:
        {
            if ([LiveManager liveInfo].o2oModel) {
                systemNoticeMsg = [LiveManager liveInfo].o2oModel.noticeMsg;
            }
        }
            break;
        default:
        {
            if ([LiveManager liveInfo].roomModel) {
                systemNoticeMsg = [LiveManager liveInfo].roomModel.noticeMsg;
                roomNoticeMes = [LiveManager liveInfo].roomModel.notice;
            }
        }
            break;
    }
    
    // 用户进来的时候，显示系统公告
    ApiSimpleMsgRoomModel *model = [[ApiSimpleMsgRoomModel alloc] init];
    model.type = 13;
    model.content = systemNoticeMsg;
    [_msgListView addMsg:[MessageModel convertWithApiSimpleMsgRoomModel:model]];
    
    ///显示房间公告
    if (roomNoticeMes.length > 0) {
        ApiSimpleMsgRoomModel *model = [[ApiSimpleMsgRoomModel alloc] init];
        model.type = 99;
        model.content = roomNoticeMes;
        [_msgListView addMsg:[MessageModel convertWithApiSimpleMsgRoomModel:model]];
    }
    
}


// MARK: - Other

- (void)showMsssageView{
    self.msgListView.hidden = NO;
    self.barrageListView.hidden = NO;
}

- (void)fansView{
    [FansGroupShowView showFansWith:[LiveManager liveInfo].anchorId hasBgColor:NO showUserInfo:^(int64_t userId) {
        if (userId > 0) {
            [LiveComponentMsgMgr sendMsg:LM_ShowUserInfo msgDic:@{@"userID":@(userId)}];
        }
    }];
}


// MARK: - Lazy

- (SystemNoticeObj *)systemNotice{
    if (!_systemNotice) {
        _systemNotice = [[SystemNoticeObj alloc] initWithSuperView:_fourthView];
    }
    return _systemNotice;
}

- (LiveBarrageView *)barrageListView{
    if (!_barrageListView) {
        LiveBarrageView *barrageV = [[LiveBarrageView alloc] initWithSuperView:_thirdView];
        _barrageListView = barrageV;
    }
    return _barrageListView;
}

// MARK: 消息view
- (LiveInfoMsgList *)msgListView{
    if (!_msgListView) {
        LiveInfoMsgList *msgList = [[LiveInfoMsgList alloc] initWithSuperView:_secondView];
        msgList.backgroundColor = [UIColor clearColor];
        _msgListView = msgList;
    }
    return _msgListView;
}


// MARK: - Function -
///充值
- (void)pushRecharge{
    ///显示充值中心
    [RouteManager routeForName:RN_center_myAccountAC currentC:_superVC];
}



// MARK: - Socket -
- (void)onSimpleMsgRoom:(ApiSimpleMsgRoomModel *)apiSimpleMsgRoom {
    if (apiSimpleMsgRoom.roomId != [LiveManager liveInfo].roomId) {
        return;
    }
    if (apiSimpleMsgRoom.type == 14) { //弹幕消息
        // 添加弹幕
        [_barrageListView addMsg:apiSimpleMsgRoom];
    }else if (apiSimpleMsgRoom.type == 1){
        [LiveComponentMsgMgr sendMsg:LM_UserJoinPlay msgDic:@{@"model":apiSimpleMsgRoom}];
    }else{
        [_msgListView addMsg:[MessageModel convertWithApiSimpleMsgRoomModel:apiSimpleMsgRoom]];
    }
}

/// 后台发送系统消息
- (void)onSimpleMsgAll:(ApiSimpleMsgRoomModel *)apiSimpleMsgRoom{
    if (apiSimpleMsgRoom.roomId > 0) {  ///如果有房间号 就需要判断是否是本房间的系统消息
        if (apiSimpleMsgRoom.roomId == [LiveManager liveInfo].roomId) {
            [self.systemNotice addMsg:apiSimpleMsgRoom];
        }
    }else{   ///如果没有房间号，说明是所有直播间都需要播放的消息
        [self.systemNotice addMsg:apiSimpleMsgRoom];
    }
}


- (void)onUserBan:(int64_t)sessionID banInfo:(NSString *)banInfo {
    [ProjConfig accountDisabled:banInfo];
}

- (void)onRoomBan:(int64_t)sessionID banInfo:(NSString *)banInfo {
    [ProjConfig accountDisabled:banInfo];
}


- (void)onMonitoringTip:(int)monitoringTipDuration monitoringTipContent:(NSString *)monitoringTipContent{
    [LiveInViolationHintView showForbidTipView:monitoringTipContent showTime:monitoringTipDuration];
}


/**
 更新直播间贵宾席
 @param vipSeatsAvatar null
 @param needToBuy 0:不需要购买 1:需要购买
 */
- (void)onRoomVipSeats:(NSString *)vipSeatsAvatar needToBuy:(int)needToBuy {
    NSDictionary *dic = @{@"avatar":vipSeatsAvatar.length?vipSeatsAvatar:@"", @"isNeed":@(needToBuy)};
    [LiveComponentMsgMgr sendMsg:LM_updateVIPSeat msgDic:dic];
}


///添加用户监听
- (void)agoraUserNotification{
    [AgoraExtManager pubMethod].userStatusBlock = ^(RTCForUserStatus status, NSString * _Nonnull statusStr) {
       // NSLog(@"过滤文字agora状态回调%d~~~~~~~%@"),status,statusStr);
        NSString *showId = [LiveManager liveInfo].serviceShowId;
        [HttpApiLiveLogController addRoomProcessLog:[LiveManager liveInfo].serviceLiveType optDescribe:statusStr optType:status roomId:[LiveManager liveInfo].roomId showId:showId?showId:@"" callback:^(int code, NSString *strMsg, HttpNoneModel *model) {
           // NSLog(@"过滤文字日志打印结果%d-%@"),code,strMsg);
        }];
    };
}


@end
