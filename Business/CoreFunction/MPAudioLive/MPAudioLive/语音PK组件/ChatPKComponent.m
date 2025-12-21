//
//  ChatPKComponent.m
//  MPVoiceLive
//
//  Created by CH on 2019/12/17.
//  Copyright © 2019 Orely. All rights reserved.
//

#import "ChatPKComponent.h"

#import <LiveCommon/LiveComponentInterface.h>

#import <LiveCommon/LiveComponentMsgListener.h>
#import <LiveCommon/LiveComponentMsgMgr.h>
#import <TXImKit/TXImKit.h>
#import <Masonry/Masonry.h>
#import <LibTools/LibTools.h>
#import <LiveCommon/LiveManager.h>
#import <LibProjBase/LibProjBase.h>
#import <LibProjModel/PkUserVoiceAssistanModel.h>
#import <LibProjModel/ApiUserInfoModel.h>
#import <LibProjModel/HttpApiHttpVoice.h>
#import <LibProjModel/ApiPkResultRoomModel.h>

#import "AudioSelectPkView.h"
#import "RoomPkSelectView.h"
#import "AudioPkLoadingView.h"  ///PK等待视图
#import "AudioPkMatchingView.h" ///Pk匹配成功
#import "AudioPkWinView.h"
#import "PkStartView.h"

#import <LibProjModel/ApiPkResultModel.h>

#import <LibTools/LiveMacros.h>

#import "PKInfoView.h"
#import "AudioPkFinishView.h"
#import <LibProjView/CustomPopUpAlert.h>
#import <AgoraExtension/AgoraExtManager.h>

@interface ChatPKComponent()<LiveComponentInterface,LiveComponentMsgListener>

@property (nonatomic, weak) UIView *firstView;
@property (nonatomic, weak) UIView *secondView;

///PK等待中的状态值
@property (nonatomic, weak) AudioPkLoadingView *loadingView;
/// 房间pk选择
@property (nonatomic, weak) RoomPkSelectView *roomPkSelectView;

@property (nonatomic, weak) PKInfoView *pkInfoV;
///匹配成功
@property (nonatomic, weak) AudioPkMatchingView *matchingView;

@end


@implementation ChatPKComponent

- (void)dealloc
{
   // NSLog(@"过滤文字%s"),__func__);
}

// MARK: - 初始化
- (void)parInitViewController:(UIViewController *)superVC views:(NSArray<UIView *> *)views{
    
    [[IMSocketIns getIns] addReceiver:socketGroupLive receiver:self];
    
    [LiveComponentMsgMgr addMsgListener:self];
    
    _firstView = views[0];
    _secondView = views[1];
}


/// 重置PK信息
- (void)resetPKInfo{
    [LiveManager liveInfo].pkType = LivePKTypeForNormal;
    [_pkInfoV removeFromSuperview];
    [_roomPkSelectView removeFromSuperview];
    _roomPkSelectView = nil;
    _pkInfoV = nil;
    
    [_matchingView dismissView];
    _matchingView = nil;
    [_loadingView dismissView];
    _loadingView = nil;
}

- (void)pkFinshBackRoom{
    [LiveManager liveInfo].currentState = CurrentStateForDefault;
    [self resetPKInfo];
    [LiveComponentMsgMgr sendMsg:LM_FinishPK msgDic:nil];
}


// MARK: - 组件通讯
- (void)onMsg:(NSInteger)msgType msgDic:(NSDictionary *)msgDic{
    
    switch (msgType) {
        case LM_LiveRoomInfo:{
            [self initPKInfo];
        }
            break;
            // 选择 pk弹窗
        case LM_LaunchPK:{
            if ([LiveManager liveInfo].pkType != LivePKTypeForNormal) {
                if ([LiveManager liveInfo].currentState == CurrentStateForPK) {
                    [SVProgressHUD showInfoWithStatus:kLocalizationMsg(@"当前正在PK中，不能再发起PK")];
                }else{
                    [self.loadingView showStartPKResult:[LiveManager liveInfo].pkType code:1];
                }
            }else{
                [self chatPkView];
            }
        }
            break;
        default:{
        }
            break;
    }
}



// MARK: - Private

///初始化PK数据
- (void)initPKInfo{
//    if ([LiveManager liveInfo].roomRole != RoomRoleForAnchor) {
        AppJoinRoomVOModel *joinModel = [LiveManager liveInfo].roomModel;
        ///pkProcess 0不在PK中 1匹配成功通知主播环节 2倒计时环节 3正式PK环节 4PK结果展示环节 5PK结束
        if (joinModel.voicePkVO.pkProcess > 1 && joinModel.voicePkVO.pkProcess < 5) {
            ///创建PK视图
            VoicePkVOModel *thisPkVO = joinModel.voicePkVO;
            [self setCurrentPKView:thisPkVO];
            
            int64_t lastTime = thisPkVO.processEndTime;
            ///PK状态
            PKProgressStatus pkStatus = PKProgressForPreparing;
            switch (thisPkVO.pkProcess) {
                case 2:
                    pkStatus = PKProgressForLoading;
                    break;
                case 3:
                    pkStatus = PKProgressForStart;
                    break;
                case 4:
                    pkStatus = PKProgressForEnd;
                    [_pkInfoV showPKResult:thisPkVO.pkResultRoom assistans:thisPkVO.pkResultRoom.assistans];
                    break;
                default:
                    pkStatus = PKProgressForStop;
                    break;
            }
            [_pkInfoV changePKStatus:pkStatus time:lastTime];
            [_pkInfoV updateMyGiftRank:thisPkVO.thisSenders enemyGiftRank:thisPkVO.otherSenders];
            [LiveComponentMsgMgr sendMsg:LM_StartPK msgDic:@{@"model":thisPkVO}];
            [self updatePKSeat:thisPkVO];
        }
//    }
}

///设置当前PK视图
- (void)setCurrentPKView:(VoicePkVOModel *)thisPkVO{

    LiveInfo_PKType pkType = [self changeServicePKType:thisPkVO.pkType];
    [LiveManager liveInfo].pkType = pkType;
    [LiveManager liveInfo].currentState = CurrentStateForPK;
    [self showPKInfoView:[self getPKFrame:pkType] type:pkType];
    [_pkInfoV showPKTitle:thisPkVO.rdTitle];
    
}


// MARK: 弹出 选择pk/关闭pk
- (void)chatPkView{
    kWeakSelf(self);
    [AudioSelectPkView showAndSelectType:^(LiveInfo_PKType type) {
        if ([LiveManager liveInfo].pkType != LivePKTypeForNormal) {
            [SVProgressHUD showInfoWithStatus:kLocalizationMsg(@"不要重复发起PK")];
            return;
        }
        
        [LiveManager liveInfo].pkType  = type;
        switch (type) {
            case LivePKTypeForSingle:  ///单人pk
            {
                [weakself requestStartPK:LivePKTypeForSingle result:^(BOOL success, int code, NSString *strMsg) {
                    if (success) {
                        [weakself.loadingView showStartPKResult:LivePKTypeForSingle code:1];
                    }else{
                        [SVProgressHUD showInfoWithStatus:strMsg];
                    }
                }];
            }
                break;
            case LivePKTypeForTeam:  ///激情团战
            {
                [weakself requestStartPK:LivePKTypeForTeam result:^(BOOL success, int code, NSString *strMsg) {
                    if (success) {
                        [weakself.loadingView showStartPKResult:LivePKTypeForTeam code:1];
                    }else{
                        if (code == 2) {
                            [weakself.loadingView showStartPKResult:LivePKTypeForTeam code:2];
                        }else{
                            [SVProgressHUD showInfoWithStatus:strMsg];
                        }
                    }
                }];
            }
                break;
            case LivePKTypeForRoom:   ///房间内PK
            {
                ///[weakself roomPkAnchorLoading];
                [weakself requestStartPK:LivePKTypeForRoom result:^(BOOL success, int code, NSString *strMsg) {
                    if (success) {
                    }else{
                        [SVProgressHUD showInfoWithStatus:strMsg];
                    }
                }];
            }
                break;
            default:
                break;
        }
    }];
}


// MARK: - Private
///更新PK麦位
- (void)updatePKSeat:(VoicePkVOModel *)pkModel{
    [_pkInfoV updateMyTotal:pkModel.totalVotes enemyTotal:pkModel.otherTotalVotes];
    [LiveComponentMsgMgr sendMsg:LM_UpdatePKSeats msgDic:@{@"model":pkModel}];
}


- (AudioPkLoadingView *)loadingView{
    if (!_loadingView && !_matchingView) {
        AudioPkLoadingView *loadingV = [AudioPkLoadingView showLoadingView];
        _loadingView = loadingV;
    }
    return _loadingView;
}

///发送开始Pk
- (void)requestStartPK:(LiveInfo_PKType)type result:(void(^)(BOOL success, int code, NSString *strMsg))resultBlock{
    ///PK类型 1房间PK 2单人Pk 3激情团战
    int pkType = 0;
    switch (type) {
        case LivePKTypeForRoom:
            pkType = 1;
            break;
        case LivePKTypeForSingle:
            pkType = 2;
            break;
        case LivePKTypeForTeam:
            pkType = 3;
            break;
        default:
            break;
    }
    kWeakSelf(self);
    [HttpApiHttpVoice applyPK:pkType roomID:[LiveManager liveInfo].roomId callback:^(int code, NSString *strMsg, HttpNoneModel *model) {
        if (code != 1) {
            [weakself resetPKInfo];
        }
        if (resultBlock) {
            resultBlock((code == 1?YES:NO), code, strMsg);
        }
    }];
}

- (void)sendGiftPk:(NSMutableArray<PkGiftSenderModel *> *)thisSenders otherSenders:(NSMutableArray<PkGiftSenderModel *> *)otherSenders {
    [_pkInfoV updateMyGiftRank:thisSenders enemyGiftRank:otherSenders];
}


///房间内PK(暂时不用)
- (void)roomPkAnchorLoading{
    ///显示PK选择项
    if (!_roomPkSelectView) {
        CGRect pkRc = [self getPKFrame:LivePKTypeForRoom];
        [LiveComponentMsgMgr sendMsg:LM_PrepareRoomPK msgDic:nil];
        RoomPkSelectView *selectVi = [[RoomPkSelectView alloc] initWithFrame:CGRectMake((pkRc.size.width-70)/2.0, pkRc.origin.y, 70, pkRc.size.height)];
        [_secondView addSubview:selectVi];
        _roomPkSelectView = selectVi;
        kWeakSelf(self);
        kWeakSelf(selectVi);
        [selectVi roomPKSelect:^(BOOL startPk) {
            if (startPk) {
                [weakself requestStartPK:LivePKTypeForRoom result:^(BOOL success, int code, NSString *strMsg) {
                    if (success) {
                        [weakselectVi removeFromSuperview];
                    }else{
                        [SVProgressHUD showInfoWithStatus:strMsg];
                    }
                }];
            }else{
                [weakself pkFinshBackRoom];
                [LiveComponentMsgMgr sendMsg:LM_FinishPK msgDic:nil];
            }
        }];
    }
}


///pk信息
- (void)showPKInfoView:(CGRect)frame type:(LiveInfo_PKType)type{
    if (!_pkInfoV) {
        PKInfoView *pkInfoV = [[PKInfoView alloc] initWithFrame:frame PKType:type];
        [_secondView addSubview:pkInfoV];
        [_secondView insertSubview:pkInfoV atIndex:_secondView.subviews.count-2];
        _pkInfoV = pkInfoV;
        
        kWeakSelf(self);
        [pkInfoV quitPK:^(PKProgressStatus status, NSArray * _Nullable assistans) {
            if (status == PKProgressForStop) {  ///PK停止
                ///房间PK并且是主播
                if (type == LivePKTypeForRoom && [LiveManager liveInfo].roomRole == RoomRoleForAnchor) {
                    ///再次PK弹窗
                    [AudioPkFinishView showFinishView:^(BOOL reStart) {
                        if (reStart) {
                            [weakself requestStartPK:LivePKTypeForRoom result:^(BOOL success, int code, NSString *strMsg) {
                                if (success) {
                                }else{
                                    [SVProgressHUD showInfoWithStatus:strMsg];
                                }
                            }];
                        }else{
                            [weakself pkFinshBackRoom];
                            [LiveComponentMsgMgr sendMsg:LM_FinishPK msgDic:nil];
                            [LiveComponentMsgMgr sendMsg:LM_UpdateSeats msgDic:@{@"models":assistans}];
                        }
                    }];
                    
                }else{
                    
                    [weakself pkFinshBackRoom];
                    [LiveComponentMsgMgr sendMsg:LM_FinishPK msgDic:nil];
                    [LiveComponentMsgMgr sendMsg:LM_UpdateSeats msgDic:@{@"models":assistans}];
                    
                }
            }else{ ///其他状态下中途停止
                
                [weakself pkFinshBackRoom];
                [LiveComponentMsgMgr sendMsg:LM_FinishPK msgDic:nil];
                
            }
            
        }];
    }
}


// MARK: - Socket

/**
 主播PK匹配超时
 @param pktype null
 */
- (void)matchPkTimeOut:(int)pktype {
    [self.loadingView matchingTimeOut];
}

/**
 通知双方主播PK匹配成功，准备进入PK开始倒计时
 @param thisPkVO null
 */
- (void)tellAuthorMatched:(VoicePkVOModel *)thisPkVO {
    if (thisPkVO.otherRoomID != [LiveManager liveInfo].roomId) {
        return;
    }
    [_loadingView dismissView];
    _loadingView = nil;
    if (!_matchingView) {
        AudioPkMatchingView *matchV = [AudioPkMatchingView initWithMatchingResult:thisPkVO];
        _matchingView = matchV;
    }
}

/**
 开始倒计时 预备进入PK (只向主播发)
 @param thisPkVO null
 */
- (void)OpenPKSuccess:(VoicePkVOModel *)thisPkVO{
    if (thisPkVO.thisRoomID != [LiveManager liveInfo].roomId) {
        return;
    }
    [_loadingView dismissView];
    _loadingView = nil;
    [_matchingView dismissView];
    _matchingView = nil;
    
    [self setCurrentPKView:thisPkVO];
    [_pkInfoV changePKStatus:PKProgressForLoading time:thisPkVO.processEndTime];
    
    [LiveComponentMsgMgr sendMsg:LM_StartPK msgDic:@{@"model":thisPkVO}];
    [self updatePKSeat:thisPkVO];
}


/**
 倒计时结束后开始PK
 @param thisPkVO null
 */
- (void)startPK:(VoicePkVOModel *)thisPkVO {
    if (thisPkVO.thisRoomID == [LiveManager liveInfo].roomId) {
        // 更新数据
        [_pkInfoV changePKStatus:PKProgressForStart time:thisPkVO.processEndTime];
        [self updatePKSeat:thisPkVO];
        [_pkInfoV showStartAmination];
    }
}

/**
 中途加入PK人员变动 或者 送礼活力值变更
 @param optType 操作类型  1上麦 2下麦 3开麦 4关麦 5送礼物 6被踢下麦 7锁麦
 */
- (void)updatePK:(VoicePkVOModel *)thisPkVO optUid:(int64_t)optUid optType:(int)optType{
    if (thisPkVO.thisRoomID != [LiveManager liveInfo].roomId) {
        return;
    }
    [self updatePKSeat:thisPkVO];
    switch (optType) {
        case 1:
        {
            if (optUid == [ProjConfig userId] && [LiveManager liveInfo].roomRole == RoomRoleForAudience) { ///用户自己上麦
                ///设置基础信息
                [LiveManager liveInfo].offMic = NO;
                [LiveComponentMsgMgr sendMsg:LM_ReloadFunBtn msgDic:nil];
                [LiveComponentMsgMgr sendMsg:LM_UpdateUserOnline msgDic:@{@"status":@(1)}];
            }
        }
            break;
        case 2:
        {
            if (optUid == [ProjConfig userId]) { ///用户自己下麦
                ///设置基础信息
                [LiveManager liveInfo].offMic = YES;
                [LiveComponentMsgMgr sendMsg:LM_ReloadFunBtn msgDic:nil];
                [LiveComponentMsgMgr sendMsg:LM_UpdateUserOnline msgDic:@{@"status":@(0)}];
            }
        }
            break;
        case 3: ///开麦
        case 4: ///关麦   1:开麦。0关麦
        {
            [LiveComponentMsgMgr sendMsg:LM_UpdateUserMicState msgDic:@{@"status":optType == 3?@(1):@(0),@"userId":@(optUid)}];
        }
            break;
        case 5: {  }///送礼物
            break;
        case 6:
        {
            if (optUid == [ProjConfig userId]) { ///用户自己上麦
                [LiveManager liveInfo].offMic = NO;
                [LiveComponentMsgMgr sendMsg:LM_UpdateUserOnline msgDic:@{@"status":@(0)}];
            }
        }
            break;
        case 7: {  } ///锁麦
            break;
        default:
            break;
    }
}

/**
 PK结果 惩罚或平局
 @param thisPkVO null
 */
- (void)beforefinishPK:(VoicePkVOModel *)thisPkVO{
    if (thisPkVO.thisRoomID != [LiveManager liveInfo].roomId) {
        return;
    }
    // 更新数据
    ApiPkResultRoomModel *result = thisPkVO.pkResultRoom;
    [_pkInfoV showPKResult:result assistans:result.assistans];
}



/**
 主播提前退出PK 两边都发
 @param thisAssistans null
 @param optUid 发起强退方的ID
 */
- (void)quitPK:(NSMutableArray<ApiUsersVoiceAssistanModel *> *)thisAssistans optUid:(int64_t)optUid pkType:(int)pkType {
    if (thisAssistans.firstObject.roomId != [LiveManager liveInfo].roomId) {
        return;
    }
    [self pkFinshBackRoom];
    [LiveComponentMsgMgr sendMsg:LM_UpdateSeats msgDic:@{@"models":thisAssistans}];
}

/**
 PK进入倒计时前踢出未参与的用户
 @param pkType null
 */
- (void)kickedBeforeOpen:(int)pkType {
    //弹框
    NSString *typeName;
    switch ([self changeServicePKType:pkType]) {
        case LivePKTypeForRoom:
        {
            typeName = kLocalizationMsg(@"房间PK");
        }
            break;
        case LivePKTypeForSingle:
        {
            typeName = kLocalizationMsg(@"单人PK");
        }
            break;
        case LivePKTypeForTeam:
        {
            typeName = kLocalizationMsg(@"激情团战");
        }
            break;
        default:
            typeName = @"PK";
            break;
    }
    CustomPopUpAlert *customAlert = [CustomPopUpAlert alertTitle:[NSString stringWithFormat:kLocalizationMsg(@"主播发起了%@"), typeName] message:kLocalizationMsg(@"稍后再上麦互动吧～") liveType:LiveTypeForCommon];
    customAlert.clickSureBlock = ^(NSString * _Nonnull passwordStr) {
    };
    [[ProjConfig currentVC] presentViewController:customAlert animated:YES completion:nil];
    
    ///用户自己下麦
    [LiveComponentMsgMgr sendMsg:LM_UpdateUserOnline msgDic:@{@"status":@(0)}];
}



///获得PK类型的视图高度
- (CGRect)getPKFrame:(LiveInfo_PKType)pkType{
    return [[LiveManager liveInfo] getAudioSeatFrame];
}


- (LiveInfo_PKType)changeServicePKType:(int)servicePkType{
    ///pkType：PK类型 1房间PK 2单人Pk 3激情团战
    LiveInfo_PKType pkType = LivePKTypeForNormal;
    switch (servicePkType) {
        case 1:
        {
            pkType = LivePKTypeForRoom;
        }
            break;
        case 2:
        {
            pkType = LivePKTypeForSingle;
        }
            break;
        case 3:
        {
            pkType = LivePKTypeForTeam;
        }
            break;
        default:
            break;
    }
    return pkType;
}


@end
