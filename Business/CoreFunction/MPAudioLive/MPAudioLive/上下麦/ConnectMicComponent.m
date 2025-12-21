//
//  ConnectMicComponent.m
//  LiveCommon
//
//  Created by CH on 2019/12/20.
//  Copyright © 2019 Orely. All rights reserved.
//

#import "ConnectMicComponent.h"

#import <LiveCommon/LiveComponentInterface.h>
#import <LiveCommon/LiveComponentMsgListener.h>
#import <LiveCommon/LiveComponentMsgMgr.h>
#import <LibTools/LibTools.h>
#import <LiveCommon/LiveManager.h>
#import "AnchorAudioLinkManagerView.h"

#import <MPAudioLive/ApplyLinkUserList.h>

#import <LibProjModel/HttpApiHttpVoice.h>
#import <MPCommon/AnchorWaitAlert.h>
#import <MPAudioLive/InviteAttentionAnchorList.h>
#import <TXImKit/TXImKit.h>
#import <LibProjModel/RoomAssistantPromptVOModel.h>

@interface ConnectMicComponent()<LiveComponentInterface,LiveComponentMsgListener>

@property (nonatomic, copy)NSDictionary<NSString *, AnchorWaitAlert *> *alertItems;

@property (nonatomic, weak)AnchorAudioLinkManagerView *linkManagerV;

@end

@implementation ConnectMicComponent

- (void)dealloc
{
   // NSLog(@"过滤文字%s"),__func__);
}

// MARK: - 初始化UI
- (void)parInitViewController:(UIViewController *)superVC views:(NSArray<UIView *> *)views{
    [LiveComponentMsgMgr addMsgListener:self];
    [[IMSocketIns getIns] addReceiver:socketGroupLive receiver:self];
}

- (void)onMsg:(NSInteger)msgType msgDic:(NSDictionary *)msgDic{
    switch (msgType) {
        ///查看申请连麦列表
        case LM_UI_applyOnlineList:{
            [LiveComponentMsgMgr sendMsg:LM_UpdateConnectTip msgDic:@{@"number":@(0)}];
            [self showApplyLinkAudienceList];
        }
            break;
        case LM_UI_anchorOnlineList:{
            [self showFollowAnchorList];
        }
            break;
            ///发起连麦
        case LM_VoiceUpMic:{
            [self showUserApplyLink];
        }
            break;
            ///关闭连麦
        case LM_CloseVideoConnMic:{
            [self quitMic];
        }
            break;
            ///点击下麦按钮
        case LM_VoiceDowmMic:{
            if ([LiveManager liveInfo].roomRole != 1) {
                [self quitMic];
            }
        }
            break;
        case LM_LiveLeaveInfo:
        case LM_ExitRoom:
        {
            _alertItems = nil;
        }
            break;
        default:{
        }
            break;
    }
}


// MARK: - Private
// MARK: 显示申请上麦的用户列表
- (void)showApplyLinkAudienceList{
    self.linkManagerV = [AnchorAudioLinkManagerView showMangerView];
}

// MARK: 显示关注的主播列表，邀请上麦
- (void)showFollowAnchorList{
    [InviteAttentionAnchorList inviteAttentionAnchor];
}


- (void)showUserApplyLink{
    [ApplyLinkUserList applyUserList];
}



- (void)quitMic{
    [HttpApiHttpVoice authDownAssistant:-1 roomId:[LiveManager liveInfo].roomId callback:^(int code, NSString *strMsg, ApiUsersVoiceAssistanModel *model) {
        if (code == 1 || code == 3) {
           [LiveComponentMsgMgr sendMsg:LM_UpdateUserOnline msgDic:@{@"status":@"0"}];
        }
        if (code != 1) {
            [SVProgressHUD showInfoWithStatus:strMsg];
        }
    }];
}

- (void)onVoiceLineNumber:(int64_t)roomId num:(int)num{
    if (roomId == [LiveManager liveInfo].roomId) {
        //提示连麦人数
        [LiveComponentMsgMgr sendMsg:LM_UpdateConnectTip msgDic:@{@"number":@(num)}];
    }
} 

///回复用户是否同意上麦
- (void)replyUserUpAssistan:(ApiUsersVoiceAssistanModel *)model isAgree:(BOOL)isAgree{
    [HttpApiHttpVoice dealUpAssistantAsk:model.no isAgree:isAgree?1:0 roomId:[LiveManager liveInfo].roomId userId:model.uid callback:^(int code, NSString *strMsg, HttpNoneModel *model) {
        if (code != 1) {
            [SVProgressHUD showInfoWithStatus:strMsg];
        }
    }];
}


- (void)removeUserAlertForItems:(int64_t)uid{
    NSMutableDictionary *muDic = [NSMutableDictionary dictionaryWithDictionary:_alertItems];
    NSString *uidKey = [NSString stringWithFormat:@"%lld",uid];
    AnchorWaitAlert *alertV = [muDic objectForKey:uidKey];
    [muDic removeObjectForKey:uidKey];
    [alertV dismiss];
}

#pragma mark  - socket -

/**
 房主拒绝游客的上麦申请
 @param roomID null
 */
- (void)refuseUpAstApply:(int64_t)roomID{
    if (roomID != [LiveManager liveInfo].roomId) {
        return;
    }
    [SVProgressHUD showInfoWithStatus:kLocalizationMsg(@"主播拒绝了你的上麦请求")];
}


/**
 房主同意游客的上麦申请
 @param roomID null
 */
- (void)agreeUpAstApply:(int64_t)roomID{
    
}

/**
 申请上麦超时 两边都发
 @param applyUid 申请人ID
 */
-(void) applyUpTimeOut:(int64_t)applyUid{
    
}


/**
 撤销上麦申请
 */
- (void)cancelApplyUp:(int64_t)authId {
    [self removeUserAlertForItems:authId];
}

/**
 直播间内游客申请上麦，给主播发送申请通知信息
 @param apiUsersVoiceAssistans null
 */
- (void)onVoiceLineRequset:(ApiUsersVoiceAssistanModel *)apiUsersVoiceAssistans {
    if (apiUsersVoiceAssistans.roomId != [LiveManager liveInfo].roomId) {
        return;
    }
    
    AnchorWaitAlert *waitV = [[AnchorWaitAlert alloc] initWithUserName:apiUsersVoiceAssistans.userName avatar:apiUsersVoiceAssistans.avatar content:kLocalizationMsg(@"申请上麦互动") timeCount:10];
    NSMutableDictionary *muDic = [[NSMutableDictionary alloc] initWithCapacity:1];
    [muDic addEntriesFromDictionary:_alertItems];
    [muDic setObject:waitV forKey:[NSString stringWithFormat:@"%lld",apiUsersVoiceAssistans.uid]];
    _alertItems = muDic;
    kWeakSelf(self);
    waitV.selectIndexHandle = ^(NSInteger type) {
        [weakself removeUserAlertForItems:apiUsersVoiceAssistans.uid];
        [weakself replyUserUpAssistan:apiUsersVoiceAssistans isAgree:type==1?YES:NO];
    };
    waitV.timeIsEndHandle = ^{
        [weakself removeUserAlertForItems:apiUsersVoiceAssistans.uid];
    };
    
}

/// 直播间邀请用户上麦
- (void)onVoiceAssistantPrompt:(int64_t)roomId roomAssistantPromptVO:(RoomAssistantPromptVOModel *)roomAssistantPromptVO{
    if (roomId == [LiveManager liveInfo].roomId) {
        AnchorWaitAlert *waitV = [[AnchorWaitAlert alloc] initWithUserName:roomAssistantPromptVO.userName avatar:roomAssistantPromptVO.userAvatar content:roomAssistantPromptVO.content timeCount:roomAssistantPromptVO.lineTime];
        NSMutableDictionary *muDic = [[NSMutableDictionary alloc] initWithCapacity:1];
        [muDic addEntriesFromDictionary:_alertItems];
        [muDic setObject:waitV forKey:[NSString stringWithFormat:@"%lld",roomAssistantPromptVO.userId]];
        _alertItems = muDic;
        kWeakSelf(self);
        waitV.selectIndexHandle = ^(NSInteger type) {
            [weakself removeUserAlertForItems:roomAssistantPromptVO.userId];
            [weakself replyAnchorUpAssistan:roomAssistantPromptVO.invitePeopleId isAgree:type==1?1:0];
        };
        waitV.timeIsEndHandle = ^{
            [weakself removeUserAlertForItems:roomAssistantPromptVO.userId];
        };
    }
}

/**
 回复邀请上麦申请
 @param status 1：同意 2:拒绝 3：超时
 */
- (void)replyInviteAssistant:(int64_t)roomId status:(int)status{
    
//    if (roomId == [LiveManager liveInfo].roomId) {
//        switch (status) {
//            case 1:
//            {
//                [SVProgressHUD showInfoWithStatus:kLocalizationMsg(@"用户已同意上麦")];
//            }
//                break;
//            case 2:
//            {
//                [SVProgressHUD showInfoWithStatus:kLocalizationMsg(@"用户已拒绝上麦")];
//            }
//                break;
//            case 3:
//            {
//                [SVProgressHUD showInfoWithStatus:kLocalizationMsg(@"邀请用户上麦操作已超时")];
//            }
//                break;
//            default:
//                break;
//        }
//    }
    
}


///回复主播是否同意上麦
- (void)replyAnchorUpAssistan:(int64_t)userId isAgree:(int)isAgree{
    [HttpApiHttpVoice replyAuthorInvt:userId reply:isAgree roomId:[LiveManager liveInfo].roomId callback:^(int code, NSString *strMsg, HttpNoneModel *model) {
        if (code != 1) {
            [SVProgressHUD showInfoWithStatus:strMsg];
        }
    }];
}



@end
