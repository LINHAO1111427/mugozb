//
//  PresenterComponent.m
//  MPAudioLive
//
//  Created by klc_sl on 2021/6/4.
//  Copyright © 2021 KLC. All rights reserved.
//

#import "PresenterComponent.h"
#import <LiveCommon/LiveComponentMsgMgr.h>
#import <LiveCommon/LiveComponentMsgListener.h>
#import <LiveCommon/LiveComponentInterface.h>
#import <TXImKit/TXImKit.h>
#import <LibTools/LibTools.h>
#import "PresenterSeatView.h"
#import <LibProjModel/ApiUsersVoiceAssistanModel.h>
#import <LibProjModel/HttpApiHttpVoice.h>
#import <LibProjBase/LibProjBase.h>
#import <AgoraExtension/AgoraExtManager.h>
#import <LibProjView/GiftUserModel.h>
#import <LibProjModel/VoicePkVOModel.h>
#import <MPCommon/AnchorWaitAlert.h>


@interface PresenterComponent ()<LiveComponentInterface,LiveComponentMsgListener>

@property (nonatomic, weak) UIView *firstView;
@property (nonatomic, weak) UIView *secondView;

@property (nonatomic, weak) PresenterSeatView *presenterV;

@property (nonatomic, copy) AnchorWaitAlert *pkAlert;

@end

@implementation PresenterComponent

// MARK: - 初始化
- (void)parInitViewController:(UIViewController *)superVC views:(NSArray<UIView *> *)views{
    
    [[IMSocketIns getIns] addReceiver:socketGroupLive receiver:self];
    
    _firstView = views[0];
    _secondView = views[1];
    
    ///主持位
    kWeakSelf(self);
    PresenterSeatView *presenterV = [[PresenterSeatView alloc] initWithFrame:CGRectMake(0, liveHeaderBannerY+liveHeaderBannerH+10, kScreenWidth/5.0, kScreenWidth/4.0)];
    presenterV.centerX = _secondView.width/2.0;
    presenterV.userIconClick = ^{
        [weakself presenterSeatBtnClick];
    };
    presenterV.hidden = YES;
    [_secondView addSubview:presenterV];
    _presenterV = presenterV;
    
    [LiveComponentMsgMgr addMsgListener:self];
    
}

- (void)onMsg:(NSInteger)msgType msgDic:(NSDictionary *)msgDic{
    switch (msgType) {
        case LM_LiveRoomInfo:
        {
            [self updatePresenterInfo];
        }
            break;
        case LM_UpdateAnchorEmoji:{
            self.presenterV.seatModel.appStrickerVO = msgDic[@"emoji"];
            [self.presenterV playEmoj];
        }
            break;
            ///更改主播开关麦显示
        case LM_UpdateUserMicState:{
            int64_t presenter = self.presenterV.seatModel.presenterUserId;
            if ([msgDic[@"userId"] longLongValue] == presenter) { ///等于主持人 (改变主播的麦克风UI)
                self.presenterV.seatModel.onOffState = [msgDic[@"status"] boolValue];
                [self.presenterV reloadShowInfo];
                if (presenter == [ProjConfig userId]) {
                    [LiveManager liveInfo].offMic = [msgDic[@"status"] boolValue];
                    [LiveComponentMsgMgr sendMsg:LM_ReloadFunBtn msgDic:nil];
                }
            }
        }
            break;
        case LM_StartPK:{
            VoicePkVOModel *pkInfoModel = msgDic[@"model"];
            if (pkInfoModel.pkType != 1) {
                self.presenterV.hidden = YES;
            }
        }
            break;
            // pk结束
        case LM_FinishPK:{
            self.presenterV.hidden = NO;
        }
            break;
        case LM_VoiceDowmMic:{
            if ([LiveManager liveInfo].roomRole == 1) {
                [self downSeatBtnClick];
            }
        }
            break;
        case LM_LiveLeaveInfo:
        case LM_ExitRoom:{
            [_pkAlert dismiss];
            _pkAlert = nil;
            [_presenterV removeFromSuperview];
            _presenterV = nil;
        }
            break;
        default:
            break;
    }
}


- (void)updatePresenterInfo{
    self.presenterV.hidden = NO;
    AppJoinRoomVOModel *voModel = [LiveManager liveInfo].roomModel;
    self.presenterV.seatModel = voModel.presenterAssistant; ///需要修改的
    if (self.presenterV.seatModel.presenterUserId == [ProjConfig userId]) {
        [self presenterUPOrDown:YES];
    }
    [self.presenterV reloadShowInfo];
}

///点击上主持位
- (void)presenterSeatBtnClick{
    ///当前身份是副播或者主播
    switch ([LiveManager liveInfo].roomRole) {
        case RoomRoleForAnchor:
        {
            if (self.presenterV.seatModel.status == 1) {
                [self showPresenterInfo];
            }
        }
            break;
        case RoomRoleForBroadcaster:
        {
            if (self.presenterV.seatModel.status == 1) {
                [self showPresenterInfo];
            }else{
                [SVProgressHUD showInfoWithStatus:kLocalizationMsg(@"请先下麦后在上主持位")];
            }
        }
            break;
        default:
        {
            ///自己是主播或者自己是管理员
            if ([LiveManager liveInfo].anchorId == [ProjConfig userId] || [LiveManager liveInfo].roomModel.role == 2) {
                [self upPresenterSeatRequest];
            }else{
                ///其他人员能观看详细信息
                if (self.presenterV.seatModel.status == 1) {
                    [self showPresenterInfo];
                }else{
                    [self upPresenterSeatRequest];
                }
            }
        }
            break;
    }
}

- (void)showPresenterInfo{
    [LiveComponentMsgMgr sendMsg:LM_ShowUserInfo msgDic:@{@"userID":@(self.presenterV.seatModel.presenterUserId)}];
}

- (void)upPresenterSeatRequest{
    [HttpApiHttpVoice applyToBePresenter:[LiveManager liveInfo].roomId callback:^(int code, NSString *strMsg, HttpNoneModel *model) {
        if (code != 1) {
            [SVProgressHUD showInfoWithStatus:strMsg];
        }
    }];
}


- (void)downSeatBtnClick{
    [HttpApiHttpVoice downPresenter:[LiveManager liveInfo].roomId callback:^(int code, NSString *strMsg, HttpNoneModel *model) {
        if (code != 1) {
            [SVProgressHUD showInfoWithStatus:strMsg];
        }
    }];
}


#pragma mark - socket -
/**
 房间主持人上下麦
 */
- (void)presenterChange:(int64_t)upUserId downUserId:(int64_t)downUserId assistantPresenter:(ApiUsersVoiceAssistanModel *)assistantPresenter {
    if (assistantPresenter.roomId != [LiveManager liveInfo].roomId) {
        return;
    }
    if (assistantPresenter.status == 1) { ///有人
        [LiveComponentMsgMgr sendMsg:LM_UpdateUserMicState msgDic:@{@"status":@(assistantPresenter.onOffState),@"userId":@(assistantPresenter.presenterUserId)}];
    }
    self.presenterV.seatModel = assistantPresenter;
    [self.presenterV reloadShowInfo];
    [LiveManager liveInfo].roomModel.presenterAssistant = assistantPresenter;
    
    if (assistantPresenter.status == 1 && upUserId > 0) {
        GiftUserModel *model = [[GiftUserModel alloc] init];
        model.userId = assistantPresenter.presenterUserId;
        model.userName = assistantPresenter.userName;
        model.userIcon = assistantPresenter.avatar;
        model.isAnchor = NO;
        model.roomId = [LiveManager liveInfo].roomId;
        model.anchorId = [LiveManager liveInfo].anchorId;
        model.showId = [LiveManager liveInfo].serviceShowId;
        model.showStr = [NSString stringWithFormat:@"%@",assistantPresenter.userName];
        [LiveComponentMsgMgr sendMsg:LM_AddSendGiftUser msgDic:@{@"model":model}];
    }
    
    if (downUserId > 0) {
        GiftUserModel *model = [[GiftUserModel alloc] init];
        model.userId = downUserId;
        [LiveComponentMsgMgr sendMsg:LM_RemoveSendGiftUser msgDic:@{@"model":model}];
    }
    
    
    ///上主持位的人是自己
    if (upUserId == [ProjConfig userId]) {  ///自己是上麦人
        [self presenterUPOrDown:YES];
    }
    if (downUserId == [ProjConfig userId]) { ///自己是下麦人
        [self presenterUPOrDown:NO];
    }
}

- (void)refreshPresenterAssistant:(ApiUsersVoiceAssistanModel* )assistantPresenter{
    if (assistantPresenter.roomId != [LiveManager liveInfo].roomId) {
        return;
    }
    self.presenterV.seatModel = assistantPresenter;
    [self.presenterV reloadShowInfo];
}



/** 发送上主持位申请
 @param roomAssistantPromptVO null */

- (void)applyPresenterAssistant:(int64_t)roomId roomAssistantPromptVO:(RoomAssistantPromptVOModel *)roomAssistantPromptVO {
    
    if (roomId != [LiveManager liveInfo].roomId) {
        return;
    }
    if (_pkAlert) {
        return;
    }
    
    _pkAlert = [[AnchorWaitAlert alloc] initWithUserName:roomAssistantPromptVO.userName avatar:roomAssistantPromptVO.userAvatar content:roomAssistantPromptVO.content timeCount:roomAssistantPromptVO.lineTime];
    kWeakSelf(self);
    // 选择 接受/拒绝 互动
    [_pkAlert setSelectIndexHandle:^(NSInteger type) {
        weakself.pkAlert = nil;
        if (type == 1) { // 同意
            [weakself sendAgreeUpSeat:roomAssistantPromptVO.userId agree:1];
        }
        else if (type == 2){ // 不同意
            [weakself sendAgreeUpSeat:roomAssistantPromptVO.userId agree:-1];
        }
    }];
    // 时间到了没有响应
    [_pkAlert setTimeIsEndHandle:^{
        weakself.pkAlert = nil;
    }];
}


/** 回复主持位申请 @param status 1：同意 2:拒绝 3：超时 */
- (void)replyApplyPresenterAssistant:(int64_t)roomId status:(int)status {
    
    if (roomId == [LiveManager liveInfo].roomId) {
        switch (status) {
            case 1:
            {
                [SVProgressHUD showInfoWithStatus:kLocalizationMsg(@"对方同意了您上主持位")];
            }
                break;
            case 2:
            {
                [SVProgressHUD showInfoWithStatus:kLocalizationMsg(@"对方拒绝了您上主持位")];
            }
                break;
            case 3:
            {
                [SVProgressHUD showInfoWithStatus:kLocalizationMsg(@"对方未回应您上主持位的请求")];
            }
                break;
            default:
                break;
        }
    }

}


#pragma mark  - handle

- (void)presenterUPOrDown:(BOOL)up{
    if (up) {
        [[AgoraExtManager mpAudio] changeRole:1];
        [[AgoraExtManager pubMethod] localAudioClosed:NO];
        [LiveManager liveInfo].offMic = NO;
        [LiveManager liveInfo].roomRole = RoomRoleForAnchor;
        [LiveComponentMsgMgr sendMsg:LM_ReloadFunBtn msgDic:nil];
    }else{
        [[AgoraExtManager pubMethod] localAudioClosed:YES];
        [[AgoraExtManager mpAudio] changeRole:3];
        [LiveManager liveInfo].offMic = YES;
        [LiveManager liveInfo].roomRole = RoomRoleForAudience;
        [LiveComponentMsgMgr sendMsg:LM_ReloadFunBtn msgDic:nil];
    }
}

/// 主播互动 agree : 1 - 同意 2 - 拒绝 3 - 超时
- (void)sendAgreeUpSeat:(int64_t)userId agree:(int)agree{
    [HttpApiHttpVoice replyApplyToBePresenter:agree roomId:[LiveManager liveInfo].roomId userId:userId callback:^(int code, NSString *strMsg, HttpNoneModel *model) {
        if (code != 1) {
            [SVProgressHUD showInfoWithStatus:strMsg];
        }
    }];
}

@end
