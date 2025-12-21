//
//  AnchorLiveComponent.m
//  TCDemo
//
//  Created by admin on 2019/9/26.
//  Copyright © 2019 CH. All rights reserved.
//

#import "LiveVideoComponent.h"

#import <LibProjModel/IMApiLive.h>

#import <LibTools/LibTools.h>
#import <LibProjBase/LibProjBase.h>
#import <LiveCommon/LiveComponentMsgListener.h>

#import <LiveCommon/LiveComponentInterface.h>
#import <LiveCommon/LiveComponentMsgMgr.h>

#import <LibProjView/ForceAlertController.h>
#import <LibProjModel/ApiSendLineMsgRoomModel.h>
#import <LibProjModel/IMApiLiveAnchorLine.h>
#import <LibProjModel/ApiUserLineRoomModel.h>
#import <LibProjModel/KLCAppConfig.h>
#import <LibProjModel/APPConfigModel.h>
#import <LibProjModel/AdminLiveConfigModel.h>
#import <LibProjModel/HttpApiHttpLive.h>
#import <LibProjView/SkyDriveTool.h>
#import <SDWebImage/SDWebImage.h>
#import <LiveCommon/LiveManager.h>
#import <TXImKit/TXImKit.h>
#import <LibProjModel/AppBackpackManageVOModel.h>
#import <Masonry/Masonry.h>
#import <AVFoundation/AVFoundation.h>

#import <AgoraExtension/AgoraExtManager.h>
#import "MPUserLinkMicView.h"
#import "MPAnchorConnView.h"

#import "LiveAdvertisingView.h"

@interface LiveVideoComponent ()<LiveComponentInterface,LiveComponentMsgListener>

@property (nonatomic, copy) IMApiLiveAnchorLine *liveApi;


@property (nonatomic, weak) UIView *superView;

/** 交互view */
@property (nonatomic, weak) UIView *secondView;

/// 0 - 普通直播； 1 - 互动； 2 - pk
@property (nonatomic, assign) NSUInteger type;


/** 互动主播 */
@property(nonatomic,weak) MPAnchorConnView *interactionMic;
/// 用户连麦视图
@property(nonatomic,weak) MPUserLinkMicView *linkMic;

///互动或者连麦的用户Id
@property (nonatomic, assign)int64_t linkOtherUserId;
///互动或者连麦的用户房间号
@property (nonatomic, assign)int64_t linkOtherRoomId;

/** 互动主播的房间id  */
@property (nonatomic, copy) NSString *otherRoomId;

@property (nonatomic, weak) UIImageView *anchorView;

@property (nonatomic, weak) UIImageView *pkBgImageV;

@property (nonatomic, copy) id<MPVideoProtocol> videoManager;


@property (nonatomic, weak) LiveAdvertisingView *adsView;

@end

@implementation LiveVideoComponent

- (void)dealloc{
   // NSLog(@"过滤文字%s"),__func__);
    [_videoManager leaveRoom];
    _videoManager = nil;
    _liveApi = nil;
}

// MARK: - 初始化UI

- (void)parInitViewController:(UIViewController *)superVC views:(NSArray<UIView *> *)views{
    
    _superView = views[0];
    _secondView = views[1];
    
    self.pkBgImageV.hidden = NO;
    
    _videoManager = [AgoraExtManager mpVideo];
    [_videoManager initMPVideoRole:1];
    
    if ([KLCAppConfig appConfig].haveMonitoring) {
        [_videoManager setSnasshotTime:[[ProjConfig shareInstence].baseConfig getLiveSnasshotTime] videoFrame:^(UIImage * _Nonnull image) {
            [SkyDriveTool uploadImageFromLive:image type:[LiveManager liveInfo].serviceLiveType roomId:[LiveManager liveInfo].roomId showId:[LiveManager liveInfo].serviceShowId complete:nil];
        }];
    }
    
    ///判断画面
    kWeakSelf(self);
    _videoManager.onConnectStatusBlock = ^(RTCForMPVideoConnectStatus status, NSString * _Nullable errorStr) {
        [weakself anchorLivelogToService:status error:errorStr];
    };
    
    [_videoManager preview:self.anchorView isOpen:YES];
    
    _liveApi = [[IMApiLiveAnchorLine alloc] init:[IMSocketIns getIns]];
    [LiveComponentMsgMgr addMsgListener:self];

}

// MARK: - 组件通讯
- (void)onMsg:(NSInteger)msgType msgDic:(NSDictionary *)msgDic{
    
    switch (msgType) {
            /*********      美颜被点击        ******/
        case LM_BeautyShow:{
            [self showFitter];
        }
            break;
            
             /************             预览开启或者关闭           *****************/
        case LM_PreviewStatus:{
            [_videoManager preview:self.anchorView isOpen:[msgDic[@"status"] boolValue]];
        }
            break;
            
            /*********      切换摄像头被点击        ******/
        case LM_RotateCamera:{
            [self rotateCamera];
        }
            break;
        
        case LM_FinishPK:{
            if (_interactionMic) {
                [LiveManager liveInfo].currentState = CurrentStateForInteraction;
                [LiveComponentMsgMgr sendMsg:LM_ReloadFunBtn msgDic:nil];
            }
        }
            break;
            
            /*********      互动成功消息        ******/
        case LM_SuccessfulInteraction:{
            [LiveManager liveInfo].currentState = CurrentStateForInteraction;
            [self agreeInteraction: msgDic[@"model"]];
            [LiveComponentMsgMgr sendMsg:LM_ReloadFunBtn msgDic:nil];
        }
            break;

            
            /*********      互动关闭消息        ******/
        case LM_CloseInteraction:     // 发送互动关闭
        case LM_CloseInteractionInfo:{   // 互动关闭消息
            [self cancelInteraction];
            [LiveManager liveInfo].currentState = CurrentStateForDefault;
            self.linkOtherUserId = 0;
            self.linkOtherRoomId = 0;
            [LiveComponentMsgMgr sendMsg:LM_ReloadFunBtn msgDic:nil];
        }
            break;

            
            /*********      观众连麦开始的消息        ******/
        case LM_StartVideoConnMic:{
            [LiveManager liveInfo].currentState = CurrentStateForConnect;
            [self agreeLinkMic:msgDic[@"model"]];
        }
            break;
            
            /*********      观众连麦结束的消息        ******/
        case LM_CloseVideoConnMic:{
            [LiveManager liveInfo].currentState = CurrentStateForDefault;
            self.linkOtherUserId = 0;
            self.linkOtherRoomId = 0;
            [self cancelLinkMic];
        }
            break;

        case LM_LiveRoomInfo:
        {
            [self openLiveForTTT:[LiveManager liveInfo].roomModel];
            [self showAdsView];
        }
             break;

            /*********      主播端信息被点击        ******/
        case LM_LiveLeaveInfo:
        case LM_ExitRoom:{             //
            if (self.type == 1) { // 互动状态关闭互动界面
                [self cancelInteraction];
            }
            else if (self.type == 2){ // pk状态 关闭互动界面
                [self cancelLinkMic];
            }

            [self closeLive];
            _videoManager = nil;
        }
            break;
        default:{
            
        }
            break;
    }
}


// MARK: - other
- (void)anchorLivelogToService:(RTCForMPVideoConnectStatus)status error:(NSString *)errorStr{
    if ([LiveManager liveInfo].currentState != CurrentStateForDefault) {
        ///app操作类型 1：合流成功 2：合流失败 3：合流回调成功 4：合流回调失败 5：退出合流
        [HttpApiHttpLive appLiveLog:status otherDescription:errorStr otherRoomId:self.linkOtherRoomId otherUserId:self.linkOtherUserId roomId:[LiveManager liveInfo].roomId callback:^(int code, NSString *strMsg, HttpNoneModel *model) {
        }];
    }
}


- (void)showAdsView{
    if (!_adsView) {
        LiveAdvertisingView *adver = [[LiveAdvertisingView alloc] initWithFrame:CGRectMake(kScreenWidth-70, liveLinkMicViewY, 50, 70)];
        [_secondView addSubview:adver];
        [_secondView insertSubview:adver atIndex:20];
        _adsView = adver;
    }
}

- (void)closeLive{
    [_videoManager leaveRoom];
    _videoManager = nil;
    _liveApi = nil;
    [self cancelInteraction];
    [self cancelLinkMic];
}

- (void)rotateCamera{
    [[AgoraExtManager mpVideo] switchCamera];
}

- (void)showFitter{
    [_videoManager showBeautyInView:nil complete:^{
        [LiveComponentMsgMgr sendMsg:LM_BeautyDismiss msgDic:nil];
    }];
}

/** 同意连麦 */
- (void)agreeLinkMic:(ApiUserLineRoomModel *)roomModel{
    self.linkOtherRoomId = [LiveManager liveInfo].roomId;
    self.linkOtherUserId = roomModel.uid;
    self.linkMic.userId = roomModel.uid;
    [_videoManager showLinkMicV:self.linkMic.userImage];
}

/** 同意互动 */
- (void)agreeInteraction:(ApiSendLineMsgRoomModel *)lineRoomModel{
    self.type = 1;
    // 改变本地视图
    self.linkOtherRoomId = lineRoomModel.toRoomId;
    self.linkOtherUserId = lineRoomModel.toUid;
    self.interactionMic.roomId = lineRoomModel.toRoomId;
    self.interactionMic.userId = lineRoomModel.toUid;
    [self.interactionMic.userCoverImgV sd_setImageWithURL:[NSURL URLWithString:lineRoomModel.toLiveThumb]];
    kWeakSelf(self);
    [_videoManager connectVideo:lineRoomModel.toRoomId showV:self.interactionMic.userImageV disconnectBlock:^{
        ForceAlertController *alertVC = [ForceAlertController alertTitle:kLocalizationMsg(@"提示") message:kLocalizationMsg(@"连麦失败, 请断开后重新链接")];
        [alertVC addOptions:kLocalizationMsg(@"我知道了") textColor:ForceAlert_NormalColor clickHandle:^{
            [weakself rtcDisconnect];
        }];
        [[ProjConfig currentVC] presentViewController:alertVC animated:YES completion:nil];
    }];
    self.anchorView.frame = CGRectMake(0, liveConnectViewY, kScreenWidth/2, liveConnectViewH);
}


// MARK:  - 取消用户连麦
- (void)cancelUserLinkMicWithButton:(UIButton *)sender{
    [LiveComponentMsgMgr sendMsg:LM_LaunchCloseLinkMic msgDic:nil];
    if (_linkMic) {
        [_linkMic removeFromSuperview];
        _linkMic = nil;
    }
}

- (void)rtcDisconnect{
    // 取消互动
    [LiveComponentMsgMgr sendMsg:LM_CloseInteraction msgDic:nil];
}

// MARK: 取消互动
- (void)cancelInteractionWithButton:(UIButton *)sender{
    // 取消互动
    [LiveComponentMsgMgr sendMsg:LM_CloseInteraction msgDic:nil];
}


/** 取消互动 */
- (void)cancelInteraction{
    self.type = 0;
    [_videoManager closeConnect];
    self.anchorView.frame = _superView.bounds;
    [_interactionMic.closeBtn removeFromSuperview];
    [_interactionMic removeFromSuperview];
    _interactionMic = nil;
}

///取消连麦
- (void)cancelLinkMic{
    self.type = 0;
    [_videoManager closeConnect];
    [_linkMic removeFromSuperview];
    _linkMic = nil;
}


- (void)openLiveForTTT:(AppJoinRoomVOModel *)model{
    [_videoManager createVideo:model.roomId];
}


- (void)alertPermissions{
    //弹出相机权限
    [AVCaptureDevice requestAccessForMediaType:AVMediaTypeVideo completionHandler:^(BOOL granted) {
    }];
    //弹出麦克风权限
    [AVCaptureDevice requestAccessForMediaType:AVMediaTypeAudio completionHandler:^(BOOL granted) {
    }];
}

- (UIImageView *)anchorView{
    if (!_anchorView) {
        [self alertPermissions];
        UIImageView *anchorView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight)];
        anchorView.backgroundColor = [UIColor blackColor];
        anchorView.layer.masksToBounds = YES;
        anchorView.clipsToBounds = YES;
        anchorView.contentMode = UIViewContentModeScaleAspectFill;
        [_superView addSubview:anchorView];
        _anchorView = anchorView;
    }
    return _anchorView;
}

- (MPUserLinkMicView *)linkMic{
    if (_linkMic == nil) {
        // 创建用户连麦的视图
        kWeakSelf(self);
        MPUserLinkMicView *linkMic = [[MPUserLinkMicView alloc] initWithFrame:CGRectMake(kScreenWidth - 12 - liveLinkMicViewW, liveLinkMicViewY, liveLinkMicViewW, liveLinkMicViewH)];
        [_secondView addSubview:linkMic];
        _linkMic = linkMic;
        linkMic.closeLinkMic = ^{
            [weakself cancelUserLinkMicWithButton:nil];
        };
    }
    return _linkMic;
}

///互动视图
- (MPAnchorConnView *)interactionMic{
    if (!_interactionMic) {
        kWeakSelf(self);
        MPAnchorConnView *liveMic = [[MPAnchorConnView alloc] initWithFrame:CGRectMake(kScreenWidth/2.0, liveConnectViewY, kScreenWidth/2, liveConnectViewH) btnSuperView:_secondView];
        [_superView addSubview:liveMic];
        _interactionMic = liveMic;
        liveMic.closeLinkMic = ^{
            [weakself cancelInteractionWithButton:nil];
        };
    }
    return _interactionMic;
}


- (UIImageView *)pkBgImageV{
    if (!_pkBgImageV) {
        UIImageView *imgV = [[UIImageView alloc] init];
        imgV.contentMode = UIViewContentModeScaleAspectFill;
        imgV.frame = _superView.bounds;
        [imgV sd_setImageWithURL:[NSURL URLWithString:[KLCAppConfig appConfig].appBackpackManageVO.videoLink]];
        [_superView addSubview:imgV];
        [_superView sendSubviewToBack:imgV];
        _pkBgImageV = imgV;
    }
    return _pkBgImageV;
}

@end
