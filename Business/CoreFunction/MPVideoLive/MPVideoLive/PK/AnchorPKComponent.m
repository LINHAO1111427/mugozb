//
//  AnchorPKComponent.m
//  TCDemo
//
//  Created by admin on 2019/10/11.
//  Copyright © 2019 CH. All rights reserved.
//

#import "AnchorPKComponent.h"

#import <LiveCommon/LiveManager.h>
#import <LiveCommon/LiveComponentMsgMgr.h>
#import <LiveCommon/LiveComponentInterface.h>
#import <LiveCommon/LiveComponentMsgListener.h>
 
#import "MagicPKView.h" // 魔法pkView
#import "PKSelectAlert.h"
#import "AnchorOnlineView.h"
#import "VideoSelectPKTimeView.h"

#import <LibTools/LibTools.h>
#import <LibTools/LiveMacros.h>

#import <TXImKit/TXImKit.h>
#import <MPCommon/AnchorWaitAlert.h>
 
#import <LibProjModel/ApiPKResultModel.h>
#import <LibProjModel/ApiBaseEntityModel.h>
#import <LibProjModel/ApiLinkEntityModel.h>
#import <LibProjModel/ApiSendLineMsgRoomModel.h>
#import <LibProjModel/IMRcvLiveAnchorLineSend.h>
#import <LibProjModel/HttpApiTencentCloudImController.h>


@interface AnchorPKComponent ()<LiveComponentInterface, LiveComponentMsgListener>

@property (nonatomic, copy) IMSocketIns *socket;


/// 当前正在互动的主播id
@property(nonatomic,assign) int64_t userId;

/// pk 是否同意 弹框提示
@property(nonatomic, copy) AnchorWaitAlert *pkAlert;
/// 选择发起的pk类型
@property(nonatomic,strong) PKSelectAlert *pkSelectAlert;

/// pk 占位视图
@property(nonatomic,weak) UIView *pkPlaceView;
/// pk 视图
@property(nonatomic,strong) MagicPKView *defaultPkView;

@property (nonatomic, weak) UIView *superView;


/// 0 - 直播 ; 1 - 互动; 2 - pk; 3  - 关闭
@property (nonatomic, assign) NSInteger type;

/// 弹窗图层
@property(nonatomic,strong) UIView *popupView;
/** 交互view */
@property(nonatomic,strong) UIView *interactiveView;

///// 发起pk
//@property(nonatomic,strong) UIButton *pkInteractionBtn;


///服务器需要sessionId
@property (nonatomic, assign) int64_t pkSessionId;

@end

@implementation AnchorPKComponent


- (void)dealloc
{
   // NSLog(@"过滤文字%s"),__func__);
}

// MARK: - 初始化UI

- (void)parInitViewController:(UIViewController *)superVC views:(NSArray<UIView *> *)views{
    [LiveComponentMsgMgr addMsgListener:self];
    [[IMSocketIns getIns] addReceiver:socketGroupLive receiver:self];
    
    _superView = views[0];
    _interactiveView = views[1];
    _popupView = views[4]; // 第五层
    
    // pk状态
    AppJoinRoomVOModel *joinRoomVO = [LiveManager liveInfo].roomModel;
    if (joinRoomVO.liveStatus == 4) {
        // 显示pk的进度
        [LiveComponentMsgMgr sendMsg:LM_StartPK msgDic:nil];
        [self showPkViewWithPkTime:joinRoomVO.pkTime];
        [self.defaultPkView updateShowData:@{@"pkuid1":@([LiveManager liveInfo].anchorId),@"pktotal1":@([LiveManager liveInfo].roomModel.currVotesPk),@"pktotal2":@([LiveManager liveInfo].roomModel.fromVotesPk)}];
        _type = 2;
        
        ///PK结果
        if (joinRoomVO.pkProcess == 4) {
            [self.defaultPkView showPkResult:@{@"iswin":@(joinRoomVO.isWin), @"punishTime":@(joinRoomVO.pkTime)}];
        }
    }
}


// MARK: - 组件通讯
- (void)onMsg:(NSInteger)msgType msgDic:(NSDictionary *)msgDic{
    switch (msgType) {
            
        case LM_LaunchPK:{
            [self pkInteractionWithButton];
        }
            break;
            // pk过程中礼物数据变化
        case LM_ChangePKValue:{
            ApiPkResultModel *model = msgDic[@"model"];
            [_defaultPkView updateShowData:@{@"pkuid1":@([LiveManager liveInfo].anchorId),@"pktotal1":@(model.votesPK),@"pktotal2":@(model.toVotesPK)}];
        }
            break;
            
            // 接收互动关闭
        case LM_CloseInteractionInfo: // 取消互动
        case LM_CloseInteraction:{ // 发送互动关闭
            if (_type == 2) { // 停止pk
                [self.defaultPkView resetPkView];
            }
            //                _pkInteractionBtn.hidden = YES;
            _type = 0;
            [self removePkView];
            
        }
            break;
            
        case LM_LiveLeaveInfo:
        case LM_ExitRoom:{ // 主播关闭了直播
            
            if (_type == 2) { // 停止pk
                [self.defaultPkView resetPkView];
                self.pkPlaceView.hidden = YES;
            }
            _type = 0;
            [self removePkView];
        }
            break;
        case LM_SuccessfulInteraction:{ // 同意互动
            _type = 1;
            ApiSendLineMsgRoomModel *lineRoom = msgDic[@"model"];
            if (lineRoom.toUid > 0) {
                _userId = lineRoom.toUid;
            }
        }
            break;
        default:
            break;
    }
    
}

#pragma mark - socket监听


- (void)onGiftPKResult:(ApiPkResultModel *)apiPKResult{
    [LiveComponentMsgMgr sendMsg:LM_ChangePKValue msgDic:@{@"model":apiPKResult}];
}


// MARK: pk响应结果
- (void)onPKResultResp:(ApiPkResultRoomModel *)apiPkResultRoom {
    if (apiPkResultRoom.roomId != [LiveManager liveInfo].roomId) {
        return;
    }
    [self.defaultPkView showPkResult:@{@"iswin":@(apiPkResultRoom.isWin),
                                   @"punishTime":@(apiPkResultRoom.punishTime)}];
}

// MARK: 收到其它主播pk申请
- (void)onAnchorPKReq:(ApiSendMsgUserModel *)apiSendMsgUser{
    _pkSessionId = apiSendMsgUser.sessionID;
    
    _pkAlert = [[AnchorWaitAlert alloc] initWithUserName:apiSendMsgUser.userName avatar:apiSendMsgUser.avatar content:apiSendMsgUser.content timeCount:apiSendMsgUser.line_time];
    
    kWeakSelf(self);
    // 选择 接受/拒绝 互动
    [_pkAlert setSelectIndexHandle:^(NSInteger type) {
        if (type == 1) { // 同意pk
            [weakself sendAgreePk:apiSendMsgUser.userId agree:1];
        }
        else if (type == 2){ // 不同意pk
            [weakself sendAgreePk:apiSendMsgUser.userId agree:2];
        }
        weakself.pkAlert = nil;
    }];
    
    // 时间到了没有响应
    [_pkAlert setTimeIsEndHandle:^{
        [weakself sendAgreePk:apiSendMsgUser.userId agree:3];
        weakself.pkAlert = nil;
    }];
    
}


// MARK: 主播同意了PK
- (void)onAnchorPKResp:(ApiSendPKMsgRoomModel *)ApiSendPKMsgRoom{
    
    switch (ApiSendPKMsgRoom.status) {
        case 1:
        {
            //                _pkInteractionBtn.hidden = YES;
            [LiveComponentMsgMgr sendMsg:LM_StartPK msgDic:nil];
            
            [SVProgressHUD showInfoWithStatus:kLocalizationMsg(@"开始PK")];
            [self showPkViewWithPkTime:ApiSendPKMsgRoom.pkTime];
            _type = 2;
            
        }
            break;
        case 2:
        {
            [SVProgressHUD showInfoWithStatus:kLocalizationMsg(@"主播拒绝PK")];
        }
            break;
        case 3:
        {
            [SVProgressHUD showInfoWithStatus:kLocalizationMsg(@"对方主播无响应")];
        }
            break;
        default:
            break;
    }
}


// MARK: - Other
// MARK: - lazy
- (PKSelectAlert *)pkSelectAlert{
    if (_pkSelectAlert == nil) {
        _pkSelectAlert = [[PKSelectAlert alloc] initWithAlertTitle:kLocalizationMsg(@"选择发起的pk类型")];
        kWeakSelf(self);
        [_pkSelectAlert clickDefaultPk:^{
            NSDictionary *contentDic = @{
                @"toUid":@(weakself.userId),
                @"pkCfgId":@(0)
            };
            [weakself handleScoket:contentDic type:@"LiveAnchorPk" subType:@"invitationAnchorLinePK"];
        } magicPk:^{
            NSDictionary *contentDic = @{
                @"toUid":@(weakself.userId),
                @"pkCfgId":@(0)
            };
            [weakself handleScoket:contentDic type:@"LiveAnchorPk" subType:@"invitationAnchorLinePK"];
        }];
    }
    return _pkSelectAlert;
}


// MARK: 开始pk的view
- (UIView *)pkPlaceView{
    if (_pkPlaceView == nil) {
        UIView *pkPlaceView  = [[UIView alloc] initWithFrame:CGRectMake(0, liveConnectViewY, kScreenWidth, liveConnectViewH)];
        [_superView addSubview:pkPlaceView];
        _pkPlaceView = pkPlaceView;
    }
    return _pkPlaceView;
}

// MARK: PK 血条view
- (MagicPKView *)defaultPkView{
    if (_defaultPkView == nil) {
        _defaultPkView = [[MagicPKView alloc] initWithSuperView:self.pkPlaceView dic:@{} anchorId:[NSString stringWithFormat:@"%lld",[LiveManager liveInfo].anchorId]];
        
        kWeakSelf(self);
       // NSLog(@"过滤文字初始化 block ---- %@"),self);
        [_defaultPkView setResultFinish:^{
           // NSLog(@"过滤文字结果 block ---- %@"),weakself);
            // 结果显示结束
            if (weakself.type == 2) { // 停止pk
                [weakself.defaultPkView resetPkView];
            }
            
            [LiveComponentMsgMgr sendMsg:LM_FinishPK msgDic:nil];
            weakself.type = 1;
            [weakself removePkView];
            
        }];
    }
    return _defaultPkView;
}


// MARK: - Action

// MARK: 发起pk
- (void)pkInteractionWithButton{
    kWeakSelf(self);
    [VideoSelectPKTimeView showPkTime:^(int64_t pkTimeId) {
        
        NSDictionary *contentDic = @{
            @"toUid":@(weakself.userId),
            @"pkCfgId":@(pkTimeId)
        };
        [weakself handleScoket:contentDic type:@"LiveAnchorPk" subType:@"invitationAnchorLinePK"];
    }];
}

// MARK: 显示pkView
- (void)showPkViewWithPkTime:(int)pkTime{

    [LiveManager liveInfo].currentState = CurrentStateForPK;
    [LiveComponentMsgMgr sendMsg:LM_ReloadFunBtn msgDic:nil];
    
    [self.defaultPkView resetPkView];
    [self removePkView];
    
    self.defaultPkView.pkTime = [NSString stringWithFormat:@"%d",pkTime];
    [self.defaultPkView updateShowData:@{@"pkuid1":@([LiveManager liveInfo].anchorId),@"pktotal1":@(0),@"pktotal2":@(0)}];
}

// MARK: 移除pkView
- (void)removePkView{
    
    [_defaultPkView resetPkView];
    _defaultPkView = nil;
    [_pkPlaceView removeFromSuperview];
    _pkPlaceView = nil;
    
}


/// 主播PK
- (void)sendAgreePk:(int64_t)userId agree:(NSUInteger)agree{
    NSDictionary *contentDic = @{
        @"isAgree":@(agree),
        @"fromUid":@(userId),
        @"pkSessionID":@(_pkSessionId)
        
    };
    [self handleScoket:contentDic type:@"LiveAnchorPk" subType:@"invitationAnchorPKResp"];
}




- (void)handleScoket:(NSDictionary *)contentDic type:(NSString *)type subType:(NSString *)subType{
    NSString *content = [contentDic convertToJsonData];
    [HttpApiTencentCloudImController handleListenSocket:content subType:subType type:type callback:^(int code, NSString *strMsg, HttpNoneModel *model) {
        if (code != 1) {
            [SVProgressHUD showInfoWithStatus:strMsg];
        }
    }];
}


@end
