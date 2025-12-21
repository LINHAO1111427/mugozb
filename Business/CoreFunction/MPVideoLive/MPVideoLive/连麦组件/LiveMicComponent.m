//
//  AudienceVideoComponent.m
//  TCDemo
//
//  Created by CH on 2019/10/18.
//  Copyright © 2019 CH. All rights reserved.
//

#import "LiveMicComponent.h"
 
#import <LibTools/LibTools.h>
#import <TXImKit/TXImKit.h>
#import <MPCommon/AnchorWaitAlert.h>
 
#import <LiveCommon/LiveManager.h>
#import <LiveCommon/LiveComponentMsgMgr.h>
#import <LiveCommon/LiveComponentInterface.h>
#import <LiveCommon/LiveComponentMsgListener.h>

#import <LibProjModel/IMApiLive.h>
#import <LibProjModel/KLCUserInfo.h>
#import <LibProjModel/LiveBeanModel.h>
#import <LibProjModel/HttpApiHttpLive.h>
#import <LibProjModel/ApiUserInfoModel.h>
#import <LibProjModel/SingleStringModel.h>
#import <LibProjModel/AppJoinRoomVOModel.h>
#import <LibProjModel/ApiLinkEntityModel.h>
#import <LibProjModel/ApiBaseEntityModel.h>
#import <LibProjModel/HttpApiTencentCloudImController.h>
 

@interface LiveMicComponent()<LiveComponentInterface,LiveComponentMsgListener>

 

@property (nonatomic, weak) UIView *superV;

@property (nonatomic, copy) AnchorWaitAlert *pkAlert;

@property (nonatomic, assign) int64_t linkSessionId;

@end

@implementation LiveMicComponent

- (void)dealloc
{
   // NSLog(@"过滤文字%s"),__func__);
}

// MARK: - 初始化UI
- (void)parInitViewController:(UIViewController *)superVC views:(NSArray<UIView *> *)views{
    [LiveComponentMsgMgr addMsgListener:self];
    
    
    [[IMSocketIns getIns] addReceiver:socketGroupLive receiver:self];

    _superV = views[3]; // 第四层
    
}


// MARK: - 组件通讯
- (void)onMsg:(NSInteger)msgType msgDic:(NSDictionary *)msgDic{
    switch (msgType) {
            /************         主动关闭连麦          *************/
        case LM_LaunchCloseLinkMic:{
            NSDictionary *contentDic = @{
                @"anchorId":@([LiveManager liveInfo].anchorId),
                @"linkSessionID":@(_linkSessionId)
            };
            [self handleScoket:contentDic type:@"LiveUserLine" subType:@"invitationUserLineClose"];
        }
            break;
            /************         设置禁止/允许 连麦          *************/
        case LM_SetLinkMicStatus:{
            NSInteger state = [msgDic[@"state"] integerValue];
            NSDictionary *contentDic = @{
                @"status":@(state),
            };
            [self handleScoket:contentDic type:@"LiveUserLine" subType:@"setAnchorLineStatus"];
        }
            break;
            
            /**************  连麦互动按钮被点击 *********/
        case LM_LaunchConnMic:{
            [self launchConnectMic];
        }
            break;
            
        case LM_LiveLeaveInfo:
        case LM_ExitRoom:{
            [_pkAlert dismiss];
            _pkAlert = nil;
        }
            break;
            
        default:
            break;
    }
}

- (void)launchConnectMic{
    NSDictionary *contentDic = @{
        @"toUid":@([LiveManager liveInfo].anchorId)
    };
    [self handleScoket:contentDic type:@"LiveUserLine" subType:@"invitationUserLineReq"];
}


// MARK: - socket

- (void)onSetAnchorLineStatus:(ApiAnchorLineStatusModel *)apiAnchorLineStatus{
    
}

- (void)onUserCloseLine:(ApiCloseLineModel *)apiCloseLine{
    if (apiCloseLine.roomId != [LiveManager liveInfo].roomId) {
        return;
    }
    [_pkAlert dismiss];
    _pkAlert = nil;
    
    if (apiCloseLine.code == 1) {
        [SVProgressHUD showInfoWithStatus:kLocalizationMsg(@"连麦结束")];
        // 成功
        //        if (apiCloseLine.uid == [KLCUserInfo getUserId] ||
        //            apiCloseLine.touid == [KLCUserInfo getUserId]) {
        [LiveComponentMsgMgr sendMsg:LM_CloseVideoConnMic msgDic:nil];
        //        }
    }
}

- (void)onUserLineResp:(ApiUserLineRoomModel *)apiUserLineRoom{
    if (apiUserLineRoom.toRoomId != [LiveManager liveInfo].roomId) {
        return;
    }
    // 同意
    if (apiUserLineRoom.status == 1) {
        if ([KLCUserInfo getUserId] == apiUserLineRoom.uid) {
            // 用户连麦成功
            [SVProgressHUD showInfoWithStatus:kLocalizationMsg(@"主播同意了你的连麦")];
            [LiveComponentMsgMgr sendMsg:LM_StartVideoConnMic msgDic:@{@"model":apiUserLineRoom}];
        }
        // 主播自己连麦成功
        else if ([KLCUserInfo getUserId] == apiUserLineRoom.toUid &&
                 [LiveManager liveInfo].anchorId == [KLCUserInfo getUserId]){
            // 自己是主播，同意了连麦
            [LiveComponentMsgMgr sendMsg:LM_StartVideoConnMic msgDic:@{@"model":apiUserLineRoom}];
        }
        else{
//            [SVProgressHUD showInfoWithStatus:[NSString stringWithFormat:kLocalizationMsg(@"主播同意了用户%@的连麦"),apiUserLineRoom.toName]];
        }
    }
    
    // 拒绝
    else if (apiUserLineRoom.status == 2 && [KLCUserInfo getUserId] == apiUserLineRoom.toUid) {
        [SVProgressHUD showInfoWithStatus:kLocalizationMsg(@"主播拒绝了你的连麦")];
        return;
    }
    else if (apiUserLineRoom.status == 3 && [KLCUserInfo getUserId] == apiUserLineRoom.toUid){
        [SVProgressHUD showInfoWithStatus:kLocalizationMsg(@"主播暂无响应")];
        return;
    }
    else{
        
    }
}

/**
 用户发送连麦请求
 @param apiSendMsgUser null
 */
-(void)onUserLineReq:(ApiSendMsgUserModel* )apiSendMsgUser
{
    if (apiSendMsgUser.roomId != [LiveManager liveInfo].roomId) {
        return;
    }
    _linkSessionId = apiSendMsgUser.sessionID;
    
    if (_pkAlert) {
        return;
    }
    
    _pkAlert = [[AnchorWaitAlert alloc] initWithUserName:apiSendMsgUser.userName avatar:apiSendMsgUser.avatar content:apiSendMsgUser.content timeCount:apiSendMsgUser.line_time];
    kWeakSelf(self);
    
    // 选择 接受/拒绝 互动
    [_pkAlert setSelectIndexHandle:^(NSInteger type) {
        weakself.pkAlert = nil;
        if (type == 1) { // 同意
             
            [weakself sendInvitationResponse:1 userID:apiSendMsgUser.userId];
        }
        
        else if (type == 2){ // 不同意
             [weakself sendInvitationResponse:2 userID:apiSendMsgUser.userId];
        }
    }];
    
    // 时间到了没有响应
    [_pkAlert setTimeIsEndHandle:^{
        weakself.pkAlert = nil;
        [weakself sendInvitationResponse:3 userID:apiSendMsgUser.userId];
    }];
}

- (void)sendInvitationResponse:(int)type userID:(int64_t)userId{
    NSDictionary *contentDic = @{
        @"isAgree":@(type),
        @"fromUid":@(userId),
        @"linkSessionID":@(_linkSessionId)
    };
    [self handleScoket:contentDic type:@"LiveUserLine" subType:@"invitationUserLineResp"];
}

- (void)handleScoket:(NSDictionary *)contentDic type:(NSString *)type subType:(NSString *)subType{
    NSString *content = [contentDic convertToJsonData];
    [HttpApiTencentCloudImController handleListenSocket:content subType:subType type:type callback:^(int code, NSString *strMsg, HttpNoneModel *model) {
        if ([subType isEqualToString:@"invitationUserLineResp"]) {
            if (code != 1) {
                [SVProgressHUD showInfoWithStatus:strMsg];
            }
        }
        if ([subType isEqualToString:@"invitationUserLineReq"]) {
            if (code == 1) {
                [SVProgressHUD showInfoWithStatus:kLocalizationMsg(@"邀请中，请稍后")];
            }else{
                [SVProgressHUD showInfoWithStatus:strMsg];
            }
        }
        if ([subType isEqualToString:@"setAnchorLineStatus"] || [subType isEqualToString:@"invitationUserLineClose"]) {
            if (code == 1) {
                [SVProgressHUD showInfoWithStatus:strMsg];
            }else{
                [SVProgressHUD showInfoWithStatus:strMsg];
            }
        }
    }];
}

@end
