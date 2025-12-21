//
//  AnchorInteractiveComponent.m
//  TCDemo
//
//  Created by CH on 2019/10/17.
//  Copyright © 2019 CH. All rights reserved.
//

#import "AnchorInteractiveComponent.h"

#import <LibTools/LibTools.h>
#import <TXImKit/TXImKit.h>
#import <MPCommon/AnchorWaitAlert.h>

#import <LiveCommon/LiveManager.h>
#import <LiveCommon/LiveComponentMsgMgr.h>
#import <LiveCommon/LiveComponentInterface.h>
#import <LiveCommon/LiveComponentMsgListener.h>

#import <LibProjModel/IMRcvLiveSend.h>
#import <LibProjModel/HttpApiHttpLive.h>
#import <LibProjModel/SingleStringModel.h>
#import <LibProjModel/ApiBaseEntityModel.h>
#import <LibProjModel/ApiLinkEntityModel.h>
#import <LibProjModel/ApiSendLineMsgRoomModel.h>
#import <LibProjModel/HttpApiTencentCloudImController.h>
 
#import "AnchorOnlineView.h" // 显示主播互动列表
 
 
 


@interface AnchorInteractiveComponent()<LiveComponentInterface,LiveComponentMsgListener>

@property (nonatomic, weak) UIView *superV;

@property (nonatomic, copy) AnchorWaitAlert *pkAlert;

@property (nonatomic, assign) int64_t connSessionId;

@end

@implementation AnchorInteractiveComponent

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
            
            // 互动按钮被点击
        case LM_InviteVideoInteraction:{
            [self showAnchorListView];
        }
            break;
        case LM_CloseInteraction:{
            // 发送关闭互动消息的socket
            [self sendCancelConnect];
        }
            break;
        case LM_CloseInteractionInfo:{
            // 接受关闭互动消息的socket
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
// MARK: - Socket
// MARK: 主播取消了主播连麦
- (void)onAnchorCloseLine:(ApiCloseLineModel *)apiCloseLine{
    if (apiCloseLine.roomId != [LiveManager liveInfo].roomId) {
        return;
    }
    [LiveComponentMsgMgr sendMsg:LM_CloseInteractionInfo msgDic:nil];
    
    //    // 观众
    //    if ([LiveManager liveInfo].roomRole == 3) {
    //        [SVProgressHUD showInfoWithStatus:kLocalizationMsg(@"互动结束")];
    //    }
    
}

// MARK: 收到同意/拒绝互动请求

- (void)onAnchorLineResp:(ApiSendLineMsgRoomModel *)apiSendLineMsgRoom{
     
   // NSLog(@"过滤文字onAnchorLineResp"));
    
    switch (apiSendLineMsgRoom.status) {
        case 1:
        {
            if ([LiveManager liveInfo].roomRole == 1) {
                [SVProgressHUD showInfoWithStatus:kLocalizationMsg(@"主播同意互动")];
            }else{
            }
            [LiveComponentMsgMgr sendMsg:LM_SuccessfulInteraction msgDic:@{@"model":apiSendLineMsgRoom}];
        }
            break;
        case 2:
        {
            if ([LiveManager liveInfo].roomRole == 1) {
                [SVProgressHUD showInfoWithStatus:kLocalizationMsg(@"主播拒绝互动")];
            }
        }
            break;
        case 3:
        {
            if ([LiveManager liveInfo].roomRole == 1) {
                [SVProgressHUD showInfoWithStatus:kLocalizationMsg(@"对方主播无响应")];
            }
        }
            break;
        default:
            break;
    }
}


// MARK: 其他主播发送了互动请求
- (void)onAnchorLineReq:(ApiSendMsgUserModel *)apiSendMsgUser{
    
    _connSessionId = apiSendMsgUser.sessionID;
    
   // NSLog(@"过滤文字%s"),__func__);
    
    if (_pkAlert) {
        return;
    }
    _pkAlert = [[AnchorWaitAlert alloc] initWithUserName:apiSendMsgUser.userName avatar:apiSendMsgUser.avatar content:apiSendMsgUser.content timeCount:apiSendMsgUser.line_time];
    
    kWeakSelf(self);
    // 选择 接受/拒绝 互动
    [_pkAlert setSelectIndexHandle:^(NSInteger type) {
        weakself.pkAlert = nil;
        
        if (type == 1) { // 同意
            [weakself sendAgreeLink:apiSendMsgUser.userId agree:1];
        }
        else if (type == 2){ // 不同意
            [weakself sendAgreeLink:apiSendMsgUser.userId agree:2];
        }
    }];
    
    // 时间到了没有响应
    [_pkAlert setTimeIsEndHandle:^{
        weakself.pkAlert = nil;
        [weakself sendAgreeLink:apiSendMsgUser.userId agree:3];
        
    }];
}


///显示主播列表
- (void)showAnchorListView{
    kWeakSelf(self);
    [AnchorOnlineView showOnlineWishSelectConn:^(int64_t userID) {
        [weakself inviteUserID:userID];
    }];
}

- (void)inviteUserID:(int64_t)userId{
    NSDictionary *contentDic = @{
        @"toUid":@(userId)
    };
    [self handleScoket:contentDic type:@"LiveAnchorLine" subType:@"invitationAnchorLine"];
}




/// 主播互动 agree : 1 - 同意 2 - 拒绝 3 - 超时
- (void)sendAgreeLink:(int64_t)userId agree:(NSUInteger)agree{
    NSDictionary *contentDic = @{
        @"isAgree":@(agree),
        @"fromUid":@(userId),
        @"linkSessionID":@(self.connSessionId)
    };
    [self handleScoket:contentDic type:@"LiveAnchorLine" subType:@"invitationAnchorLineResp"];
    
}

- (void)sendCancelConnect{
    NSDictionary *contentDic = @{
        @"roomId":@(1),
        @"linkSessionID":@(self.connSessionId)
    };
    [self handleScoket:contentDic type:@"LiveAnchorLine" subType:@"invitationAnchorLineClose"];
}

- (void)handleScoket:(NSDictionary *)contentDic type:(NSString *)type subType:(NSString *)subType{
    NSString *content = [contentDic convertToJsonData];
    [HttpApiTencentCloudImController handleListenSocket:content subType:subType type:type callback:^(int code, NSString *strMsg, HttpNoneModel *model) {
        if ([subType isEqualToString:@"invitationAnchorLineResp"]) {
            if (code != 1) {
                [SVProgressHUD showInfoWithStatus:strMsg];
            }
        }
        if ([subType isEqualToString:@"invitationAnchorLine"]) {
            if (code == 1) {
                [SVProgressHUD showInfoWithStatus:kLocalizationMsg(@"邀请中，请稍后")];
            }else{
                [SVProgressHUD showInfoWithStatus:strMsg];
            }
        }
         
    }];
}

@end
