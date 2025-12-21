//
//  LiveManager.m
//  LibProjView
//
//  Created by klc_sl on 2020/3/18.
//  Copyright © 2020 . All rights reserved.
//
#import "LiveManager.h"
#import <LibTools/LibTools.h>
#import <Masonry/Masonry.h>
#import <LiveCommon/LiveComponentMsgListener.h>
#import <LiveCommon/LiveComponentMsgMgr.h>
#import <LibProjBase/LibProjBase.h>
#import <TXImKit/TXImKit.h>
#import <AgoraExtension/AgoraExtManager.h>
#import <LibProjBase/ProjBaseData.h>
#import "LiveTimekeeping.h"
#import "LiveBaseViewObj.h"

@interface LiveManager ()<LiveComponentMsgListener, LiveBaseViewObjDelegate ,LiveLevelViewDelegate>
///直播间信息
@property (nonatomic, copy) LiveInfomation *infomation;

@property (nonatomic, copy) NSArray *currViews;

@property (nonatomic, weak) UIView *weakPopupView;

@property (nonatomic, copy) LiveBaseViewObj *liveObj;

@property (nonatomic, weak) LiveLevelView *currPlayView;

@property (nonatomic, assign) BOOL liveCanClear;

@end

static LiveManager *_liveManger = nil;

@implementation LiveManager

+ (instancetype)manager{
    if (_liveManger == nil) {
        _liveManger = [[LiveManager alloc] init];
    }
    return _liveManger;
}

- (void)dealloc
{
   // NSLog(@"过滤文字%s"),__func__);
}


+ (void)removeSelf{
    [AgoraExtManager disconnect];
    if (_liveManger) {
        [_liveManger removeObj];
    }
}

- (void)leaveRoom{
    [_liveManger.liveObj.liveVC leaveRoom:YES];
    [LiveManager removeSelf];
}

/// 异常退出
- (void)abnormalExit{
    [ProjBaseData share].userState = 0;
    [[IMSocketIns getIns] removeReceiverByGroupID:socketGroupLive];
    [LiveComponentMsgMgr sendMsg:LM_AbnormalExit msgDic:@{@"anchorId":@(_infomation.anchorId),@"roomId":@(_infomation.roomId),@"liveType":@(_infomation.liveType)}];
    _infomation = nil;
}

- (void)tokenInvalid:(NSNotification *)notify{
    [self abnormalExit];
    [self leaveRoom];
}

- (void)willTerminate:(NSNotification *)notify{
    [self abnormalExit];
    [IMSocketIns closeIns];
    [LiveManager removeSelf];
}

- (void)changeLiveRoom:(NSNotification *)notify{
    //    [_liveManger.liveObj.liveVC leaveRoom:NO];
    //    [self abnormalExit];
    //    [LiveManager removeSelf];
    
    {
        ///切换房间时清除数据单独处理
        [AgoraExtManager disconnect];
        [self removeNotification];
        [[LiveTimekeeping share] stopLiveTime];
        
        [PopupTool closeAllPopupView];
        [PopupTool share].popupSuperView = nil;
        
        [ProjBaseData share].userState = 0;
        
        [[IMSocketIns getIns] removeReceiverByGroupID:socketGroupLive];
        
        _infomation = nil;
        _liveManger = nil;
        //    _liveObj = nil;
        [[NSNotificationCenter defaultCenter] postNotificationName:liveRoomExitNotify object:nil];
    }
}


- (void)userLeaveRoom:(NSNotification *)notify{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:NotificationClearUserState object:nil];
    switch ([LiveManager liveInfo].liveType) {
        case LiveTypeForOneToOne:
        {
            [SVProgressHUD showInfoWithStatus:kLocalizationMsg(@"通话异常")];
        }
            break;
        default:
        {
            //            [SVProgressHUD showInfoWithStatus:[NSString stringWithFormat:kLocalizationMsg(@"%@君出小差了，重新进入房间吧"),[LiveManager liveInfo].liveType == 1?kLocalizationMsg(@"语音"):kLocalizationMsg(@"直播")]];
            [SVProgressHUD showInfoWithStatus:kLocalizationMsg(@"网络不给力，直播将退出！")];
        }
            break;
    }
    [self leaveRoom];
}

- (void)removeNotification{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:NotificationUserLogout object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:liveChangeRoomNotify object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIApplicationWillTerminateNotification object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:NotificationClearUserState object:nil];
}

- (void)addNotification{
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(tokenInvalid:) name:NotificationUserLogout object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(willTerminate:) name:UIApplicationWillTerminateNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(changeLiveRoom:) name:liveChangeRoomNotify object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(userLeaveRoom:) name:NotificationClearUserState object:nil];
}

- (void)removeObj{
    
    [self removeNotification];
    [[LiveTimekeeping share] stopLiveTime];
    [PopupTool closeAllPopupView];
    [PopupTool share].popupSuperView = nil;
    
    [ProjBaseData share].userState = 0;
    
    [[IMSocketIns getIns] removeReceiverByGroupID:socketGroupLive];
    
    _infomation = nil;
    _liveManger = nil;
    
    _liveObj = nil;
    [[NSNotificationCenter defaultCenter] postNotificationName:liveRoomExitNotify object:nil];
}

- (instancetype)init
{
    self = [super init];
    if (self) {
    }
    return self;
}

- (LiveInfomation *)infomation{
    if (!_infomation) {
        _infomation = [[LiveInfomation alloc] init];
    }
    return _infomation;
}

- (UIView *)weakPopupView{
    if (!_weakPopupView && self.currPlayView.liveViews.count>1) {
        UIView *popupSuperView = self.currPlayView.liveViews[self.currPlayView.liveViews.count-2];
        UIView *popView = [[UIView alloc] initWithFrame:popupSuperView.bounds];
        popView.userInteractionEnabled = NO;
        [popupSuperView addSubview:popView];
        _weakPopupView = popView;
    }
    return _weakPopupView;
}

- (void)initialData{
    _liveObj = [[LiveBaseViewObj alloc] init];
    _liveObj.delegate = self;
}

///直播间信息
+ (LiveInfomation *)liveInfo{
    return _liveManger?_liveManger.infomation:[LiveManager manager].infomation;
}

///设置显示的viewcontroller
+ (void)initBaseVC:(LiveBaseViewController *)baseVC{
    [[LiveManager manager] removeNotification];
    [[LiveManager manager] addNotification];
    [[LiveManager manager] initialData];
    
    [[LiveManager manager].liveObj showViewInController:baseVC mpLiveListReqParam:baseVC.mpliveReqParam];
}


///设置是否可以清屏
+ (void)setCanClear:(BOOL)canClear{
    if (_liveManger) {
        _liveManger.liveCanClear = canClear;
        _liveManger.currPlayView.canClear = canClear;
    }
}

+ (UIViewController *)getCurrentVC{
    if (_liveManger) {
        return _liveManger.liveObj.liveVC;
    }
    return nil;
}


#pragma mark - LiveLevelViewDelegate -

- (void)clearScreen:(BOOL)clear startOrEnd:(BOOL)start {
    [LiveComponentMsgMgr sendMsg:clear?LM_ClearScreenAnimation:LM_ShowScreenAnimation msgDic:@{@"animation":@(start?1:0)}];
}

///离开没有加入的直播间
- (void)leaveLiveRoomForNotJoin{
    [[UIApplication sharedApplication] setIdleTimerDisabled:NO];
    [LiveManager livePopViewClear:YES];
    [self removeNotification];
    [self leaveRoom];
}

- (void)reloadLiveRoomInfo:(LiveLevelView *)liveView{
    [self LiveBaseView:self.liveObj liveInfoAtCurrentView:liveView];
}

#pragma mark - LiveBaseViewObjDelegate -

///已经完整显示当前页面
- (void)LiveBaseView:(LiveBaseViewObj *)baseViewObj liveInfoAtCurrentView:(nonnull LiveLevelView *)liveView{

    self.currPlayView = liveView;
    self.currPlayView.viewDelegate = self;
    liveView.canClear = self.liveCanClear;

    if (liveView.currIndex != -1) {
        ///推出其他直播间
        [self abnormalExit];
    }
    [LiveManager livePopViewClear:NO];
    [LiveComponentMsgMgr removeAllListener];
    [liveView joinRoomAllCompInfo:baseViewObj.liveVC.compClass successHandle:^{
        [LiveComponentMsgMgr addMsgListener:self];
    }];
    
}




#pragma mark - 组件管理 -

// MARK: - 组件消息
- (void)onMsg:(NSInteger)msgType msgDic:(NSDictionary *)msgDic{
    switch (msgType) {
        case LM_LiveRoomInfo:{
            /// 0 空闲： 1: 主播身份直播中  2: 一对一中  3 用户身份在直播间内
            int status = 0;
            switch (_infomation.liveType) {
                case LiveTypeForMPAudioLive:
                case LiveTypeForMPVideoLive:
                case LiveTypeForShoppingLive:
                {
                    status = (_infomation.roomRole == RoomRoleForAnchor)?1:0;
                }
                    break;
                case LiveTypeForOneToOne:{
                    status = 2;
                }
                default:
                {
                    status = 0;
                }
                    break;
            }
            [ProjBaseData share].userState = status?status:3;
            [ProjBaseData share].roomId = _infomation.roomId;
        }
            break;
        case LM_LiveLeaveInfo:
        {
            [self.currPlayView clearView:NO animation:NO];
            [[UIApplication sharedApplication] setIdleTimerDisabled:NO];
            if ([LiveManager liveInfo].isMini) {
                [self leaveRoom];
            }
        }
            break;
        case LM_ExitRoom:
        {
            ///放在liveleaveInfo中可能会删除其他UI
            [LiveManager livePopViewClear:YES];
            [self removeNotification];
            [self leaveRoom];
        }
            break;
        case LM_MiniLiveRoom:
        {
            [self.liveObj.liveVC leaveRoom:YES];
        }
            break;
            
        case LM_FunctionClearScreen:
        {
            [self.currPlayView clearView:YES animation:YES];
        }
            break;
        case LM_FunctionShowScreen:
        {
            [self.currPlayView clearView:NO animation:YES];
        }
            break;
            
        default:
            break;
    }
}


#pragma mark - 业务处理 -

+ (void)livePopViewClear:(BOOL)clear{
    if (_liveManger) {
        if (!clear && _liveManger.currPlayView.liveViews.count > 0) {
            [PopupTool share].popupSuperView = _liveManger.weakPopupView;
        }else{
            [PopupTool share].popupSuperView =  nil;
        }
    }
}


+ (void)promissionStop:(BOOL)stop{
    if (_liveManger) {
        [LiveManager livePopViewClear:YES];
        [LiveManager livePopViewClear:NO];
        
        LiveInfomation *liveInfo = _liveManger.infomation;
        
        switch (liveInfo.liveType) {
            case LiveTypeForMPAudioLive:  ///多人语音
            case LiveTypeForMPVideoLive:  ///视频直播
            case LiveTypeForShoppingLive:   ///直播购
            {
                switch (liveInfo.roomRole) {
                    case RoomRoleForBroadcaster:
                    {
                        if (stop) {
                            [[AgoraExtManager pubMethod] remoteVideoClosed:stop];
                            [[AgoraExtManager pubMethod] remoteVoiceClosed:stop];
                            [[AgoraExtManager pubMethod] localVideoClosed:stop];
                            [[AgoraExtManager pubMethod] localAudioClosed:stop];
                        }else{
                            [[AgoraExtManager pubMethod] remoteVideoClosed:stop];
                            [[AgoraExtManager pubMethod] remoteVoiceClosed:liveInfo.offAudio];
                            [[AgoraExtManager pubMethod] localAudioClosed:liveInfo.offMic];
                            [[AgoraExtManager pubMethod] localVideoClosed:liveInfo.offCamera];
                        }
                    }
                        break;
                    default:
                    {
                        [[AgoraExtManager pubMethod] remoteVideoClosed:stop];
                        [[AgoraExtManager pubMethod] remoteVoiceClosed:stop];
                    }
                        break;
                }
            }
                break;
            default:
                break;
        }
        
    }
    if (stop) {
        UIView *fifthView = _liveManger.currPlayView.liveViews[_liveManger.currPlayView.liveViews.count-2];
        UIVisualEffectView *effectV = [fifthView viewWithTag:99234];
        if (fifthView) {
            if (effectV) {
                [fifthView sendSubviewToBack:effectV];
            }else{
                effectV = [[UIVisualEffectView alloc] initWithEffect:[UIBlurEffect effectWithStyle:UIBlurEffectStyleDark]];
                effectV.alpha = 0.8;
                effectV.tag = 99234;
                effectV.frame = fifthView.bounds;
                effectV.userInteractionEnabled = YES;
                [fifthView addSubview:effectV];
                [fifthView sendSubviewToBack:effectV];
            }
        }
    }else{
        UIView *fifthView = _liveManger.currPlayView.liveViews[_liveManger.currPlayView.liveViews.count-2];
        UIVisualEffectView *effectV = [fifthView viewWithTag:99234];
        if (fifthView && effectV) {
            [effectV removeFromSuperview];
            effectV = nil;
        }
    }
}

+ (void)recoverLive{
    if (_liveManger) {
        [ProjBaseData share].isMiniRoom = _liveManger.infomation.isMini = NO;
        [[ProjConfig currentVC].navigationController pushViewController:_liveManger.liveObj.liveVC animated:YES];
        _liveManger.liveObj.managerView.frame = CGRectMake(0, 0, kScreenWidth, kScreenHeight);
        [_liveManger.liveObj.liveVC.view addSubview:_liveManger.liveObj.managerView];
        _liveManger.liveObj.liveVC.navigationController.navigationBarHidden = YES;
        _liveManger.liveObj.managerView.hidden = NO;
    }
}


+ (void)showAudioMiniView{
    if (_liveManger) {
        Class<MPLiveInterface> cls = _liveManger.infomation.mpViewConfig;
        [ProjBaseData share].isMiniRoom  = _liveManger.infomation.isMini = YES;
        [cls showAudioMiniView:_liveManger.liveObj.managerView recover:^{
            [LiveManager recoverLive];
        }];
    }
}


@end
