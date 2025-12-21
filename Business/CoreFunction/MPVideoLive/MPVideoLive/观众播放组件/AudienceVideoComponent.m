//
//  LiveVideoComponent.m
//  TCDemo
//
//  Created by admin on 2019/9/28.
//  Copyright © 2019 CH. All rights reserved.
//

#import "AudienceVideoComponent.h"

#import <LibProjModel/LiveBeanModel.h>
#import <LibProjModel/IMApiLive.h>

#import <LiveCommon/LiveComponentInterface.h>
#import <LiveCommon/LiveComponentMsgMgr.h>
#import <LiveCommon/LiveComponentMsgListener.h>

#import <LibTools/LiveMacros.h>

#import <LibProjModel/IMRcvLiveSend.h>

#import <LibProjModel/HttpApiHttpLive.h>

#import <LibProjModel/ApiUserLineRoomModel.h>
#import <LibProjModel/ApiSendLineMsgRoomModel.h>
#import <LiveCommon/LiveManager.h>
#import <LibProjModel/AppJoinRoomVOModel.h>
#import <LibTools/LibTools.h>
#import <TXImKit/TXImKit.h>
#import <SDWebImage/SDWebImage.h>
#import <Masonry/Masonry.h>
#import <AgoraExtension/AgoraExtManager.h>
#import <LibProjModel/KLCAppConfig.h>
#import <LibProjModel/APPConfigModel.h>
#import <LibProjModel/AdminLiveConfigModel.h>
#import <LibProjView/SkyDriveTool.h>
#import "MPUserOwnView.h"
#import <LibProjView/GiftUserModel.h>
#import <LibProjModel/AppBackpackManageVOModel.h>
#import "LiveAdvertisingView.h"

#import "MPOtherLinkAnchorView.h"

@interface AudienceVideoComponent ()<LiveComponentInterface,LiveComponentMsgListener>

@property (nonatomic, copy) IMApiLive *liveApi;
@property (nonatomic, copy) IMRcvLiveSend *recvLive;

@property(nonatomic,strong) AppJoinRoomVOModel *roomModel;

///本房间主播画面
@property (nonatomic, weak) UIImageView *ownAnchorImgV;
/** 互动主播画面 */
@property (nonatomic, weak) MPOtherLinkAnchorView *otherConnAnchorImgV;

@property (nonatomic, weak) UIView *pkBgView;  ///PK背景视图

@property (nonatomic, copy) id <MPVideoProtocol> videoManager;

@property (nonatomic, weak) UIView *firstView;
/** 交互view */
@property(nonatomic, weak) UIView *secondView;


/** 连麦观众视图 */
@property (nonatomic, weak) MPUserOwnView *linkMic;

///PK背景页面
@property (nonatomic, weak) UIImageView *pkBgImageV;

@property (nonatomic, copy) NSString *playUrl;


@property (nonatomic, weak) LiveAdvertisingView *adsView;

@end


@implementation AudienceVideoComponent

- (void)dealloc
{
    [_videoManager leaveRoom];
    _videoManager = nil;
    _roomModel = nil;
    [_linkMic removeFromSuperview];
    _linkMic = nil;
}

// MARK: - 初始化UI
- (void)parInitViewController:(UIViewController *)superVC views:(NSArray<UIView *> *)views{
    
    _firstView = views[0];
    _secondView = views[1];
    
    _videoManager = [AgoraExtManager mpVideo];
    
    if ([KLCAppConfig appConfig].haveMonitoring) {
        [_videoManager setSnasshotTime:[[ProjConfig shareInstence].baseConfig getLiveSnasshotTime] videoFrame:^(UIImage * _Nonnull image) {
            [SkyDriveTool uploadImageFromLive:image type:[LiveManager liveInfo].serviceLiveType roomId:[LiveManager liveInfo].roomId showId:[LiveManager liveInfo].serviceShowId complete:nil];
        }];
    }
    
    _liveApi = [[IMApiLive alloc] init:[IMSocketIns getIns]];
    [LiveComponentMsgMgr addMsgListener:self];

    [self playVideo];
    
    // pk状态
    AppJoinRoomVOModel *voModel = [LiveManager liveInfo].roomModel;
    if (voModel.liveStatus == 3 || voModel.liveStatus == 4) {
        [self showAnchorLinkView:voModel.otherPull toThumb:voModel.otherLiveThumb toRoomId:voModel.otherRoomId];
    }
}

// MARK: - 组件通讯
- (void)onMsg:(NSInteger)msgType msgDic:(NSDictionary *)msgDic{
    switch (msgType) {
        case LM_LiveRoomInfo:{
            [self anchorBaseInfo];
            [self showAdsView];
        }
            break;
            /************              连麦成功消息           *****************/
        case LM_StartVideoConnMic:{
            [LiveManager liveInfo].currentState = CurrentStateForConnect;
            ApiUserLineRoomModel *model = msgDic[@"model"];
            [self linkMicForAnchorRoomId:model.toRoomId];
            [LiveManager liveInfo].roomRole = RoomRoleForBroadcaster;
        }
            break;
            
            /************              关闭连麦消息           *****************/
        case LM_CloseVideoConnMic:{
            [LiveManager liveInfo].currentState = CurrentStateForDefault;
            [self closeLinkMic];
            [LiveManager liveInfo].roomRole = RoomRoleForAudience;
        }
            break;
            /************              主播开始互动消息           *****************/
        case LM_SuccessfulInteraction:{
            ApiSendLineMsgRoomModel *lineRoom = msgDic[@"model"];
            [self showAnchorLinkView:lineRoom.toPull toThumb:lineRoom.toLiveThumb toRoomId:lineRoom.toRoomId];
        }
            break;
            /************              主播结束互动消息           *****************/
        case LM_CloseInteractionInfo:
        case LM_CloseInteraction:
        {
            [self removeAnchorLinkView];
        }
            break;
        /************              结束PK消息           *****************/
        case LM_FinishPK:{
        }
            break;
        /************             开始PK消息           *****************/
        case LM_StartPK:{
        }
            break;
            /************              主播离开/回来           *****************/
        case LM_AnchorStatus:{
            NSInteger status = [msgDic[@"status"] integerValue];
            if (status == 1) { // 回来
                 [[AgoraExtManager pubMethod] localVideoClosed:YES];
            }
            else{       // 离开
                 [[AgoraExtManager pubMethod] localVideoClosed:NO];
            }
        }
            break;
             /************              清屏/显屏          *****************/
            //显示屏幕信息
        case LM_ShowScreenAnimation:{
            if ([msgDic[@"animation"] intValue] == 0) {
                [_secondView addSubview:_linkMic];
            }
        }
            break;
             //清除屏幕信息
        case LM_ClearScreenAnimation:{
            [_firstView addSubview:_linkMic];
        }
            break;
            
            /************              主播端关闭了直播           *****************/
        case LM_LiveLeaveInfo:
        case LM_ExitRoom:{
            [self closeLive];
            _roomModel = nil;
        }
            break;
            
        default:{
            
        }
            break;
            
    }
}


// MARK: - Other
- (void)closeLive{
    [_videoManager leaveRoom];
    _videoManager = nil;
    _ownAnchorImgV = nil;
    [_otherConnAnchorImgV.playImgV stop];
    _otherConnAnchorImgV = nil;
    [_linkMic removeFromSuperview];
    _linkMic = nil;
}


///显示两个主播的连麦
- (void)showAnchorLinkView:(NSString *)toPull toThumb:(NSString *)toThumb toRoomId:(int64_t)roomId{
    ///当前主播直播和另一房间直播合成一条url播放
    {
//                CGFloat viewW = kScreenWidth;
//                CGFloat viewH = viewW * 1280.0/720.0;
//                self.ownAnchorImgV.frame = CGRectMake((viewW-kScreenWidth)/2.0, -(viewH*0.20+kStatusBarHeight), viewW, viewH);
//                [self.pkBgView addSubview:self.ownAnchorImgV];
    }
   
    ///当前主播和另一个房间的主播各有一条url播放
    {
        CGFloat viewW = kScreenWidth/2.0;
        CGFloat viewH = self.pkBgView.height;
        self.ownAnchorImgV.frame = CGRectMake(0, 0, viewW, viewH);
        self.otherConnAnchorImgV.frame = CGRectMake(kScreenWidth/2.0, 0, viewW, viewH);
        [self.pkBgView addSubview:self.ownAnchorImgV];
        [self.pkBgView addSubview:self.otherConnAnchorImgV];
        
        self.otherConnAnchorImgV.otherRoomId = roomId;
        self.otherConnAnchorImgV.playImgV.imageModeAspectFill = YES;
        self.otherConnAnchorImgV.playImgV.preview = toThumb;
        [self.otherConnAnchorImgV.playImgV playVideo:toPull];
    }
}

///关闭两个主播的连麦
- (void)removeAnchorLinkView{
    self.ownAnchorImgV.frame = CGRectMake(0, 0, kScreenWidth, kScreenHeight);
    [_firstView addSubview:self.ownAnchorImgV];
    [self.otherConnAnchorImgV.playImgV stop];
    [self.otherConnAnchorImgV removeFromSuperview];
    self.otherConnAnchorImgV = nil;
    [self.pkBgView removeFromSuperview];
    self.pkBgView = nil;
}

- (void)showAdsView{
    if (!_adsView) {
        LiveAdvertisingView *adver = [[LiveAdvertisingView alloc] initWithFrame:CGRectMake(kScreenWidth-70, liveLinkMicViewY, 50, 70)];
        [_secondView addSubview:adver];
        [_secondView insertSubview:adver atIndex:20];
        _adsView = adver;
    }
}

- (void)cancelUserLinkMicWithButton:(UIButton *)sender{
    [LiveComponentMsgMgr sendMsg:LM_LaunchCloseLinkMic msgDic:nil];
}

- (void)anchorBaseInfo{
    AppJoinRoomVOModel *voModel = [LiveManager liveInfo].roomModel;
    [self.ownAnchorImgV sd_setImageWithURL:[NSURL URLWithString:voModel.liveThumb]];
}

- (void)playVideo{
    AppJoinRoomVOModel *model = [LiveManager liveInfo].roomModel;
    if (model == nil) {
        [SVProgressHUD showInfoWithStatus:kLocalizationMsg(@"用户信息为空")];
        return;
    }
    [self.ownAnchorImgV sd_setImageWithURL:[NSURL URLWithString:model.liveThumb]];
    [self linkLookForAnchorRoomId:model.roomId];
    [_videoManager playVideoUrl:model.pull showV:self.ownAnchorImgV thumb:model.liveThumb];
    self.pkBgImageV.hidden = NO;
}

//MARK: 和主播连麦
- (void)linkMicForAnchorRoomId:(int64_t)roomId{
    [_videoManager initMPVideoRole:2];
    [_videoManager joinVideo:roomId anchorId:[LiveManager liveInfo].anchorId showV:self.linkMic.userImage];
    [LiveManager liveInfo].offMic = NO;
}
- (void)linkLookForAnchorRoomId:(int64_t)roomId{
    [_videoManager initMPVideoRole:3];
    [_videoManager joinLookVideo:roomId anchorId:[LiveManager liveInfo].anchorId showV:self.ownAnchorImgV];
    [LiveManager liveInfo].offMic = NO;
}

/// 关闭和主播的连麦
- (void)closeLinkMic{
    [_linkMic removeFromSuperview];
    _linkMic = nil;
    [_videoManager leaveRoomToPlay];
}


///MARK: 懒加载视图
- (UIImageView *)ownAnchorImgV{
    if (!_ownAnchorImgV) {
        UIImageView *imgV = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight)];
        imgV.backgroundColor = [UIColor blackColor];
        imgV.layer.masksToBounds = YES;
        imgV.layer.cornerRadius = 0.0;
        imgV.clipsToBounds = YES;
        imgV.contentMode = UIViewContentModeScaleAspectFill;
        [_firstView addSubview:imgV];
        _ownAnchorImgV = imgV;
        [imgV layoutIfNeeded];
    }
    return _ownAnchorImgV;
}

- (MPOtherLinkAnchorView *)otherConnAnchorImgV{
    if (!_otherConnAnchorImgV) {
        MPOtherLinkAnchorView *otherLinkView = [[MPOtherLinkAnchorView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight) interactionBgView:_secondView];
        [_secondView addSubview:otherLinkView];
        _otherConnAnchorImgV = otherLinkView;
    }
    return _otherConnAnchorImgV;
}

- (MPUserOwnView *)linkMic{
    if (!_linkMic) {
        // 创建用户连麦的视图
        kWeakSelf(self);
        MPUserOwnView *linkMic = [[MPUserOwnView alloc] initWithFrame:CGRectMake(kScreenWidth - 12 - liveLinkMicViewW, liveLinkMicViewY, liveLinkMicViewW, liveLinkMicViewH)];
        [_secondView addSubview:linkMic];
        _linkMic = linkMic;
        linkMic.closeLinkMic = ^{
            [weakself closeLinkMic];
            [LiveComponentMsgMgr sendMsg:LM_LaunchCloseLinkMic msgDic:nil];
        };
        linkMic.rotateCamera = ^{
             [weakself.videoManager switchCamera];
        };
    }
    return _linkMic;
}

- (UIImageView *)pkBgImageV{
    if (!_pkBgImageV) {
        UIImageView *imgV = [[UIImageView alloc] init];
        imgV.contentMode = UIViewContentModeScaleAspectFill;
        imgV.frame = _firstView.bounds;
        [imgV sd_setImageWithURL:[NSURL URLWithString:[KLCAppConfig appConfig].appBackpackManageVO.videoLink]];
        imgV.layer.masksToBounds = YES;
        imgV.clipsToBounds = YES;
        [_firstView addSubview:imgV];
        [_firstView sendSubviewToBack:imgV];
        _pkBgImageV = imgV;
    }
    return _pkBgImageV;
}

- (UIView *)pkBgView{
    if (!_pkBgView) {
        UIView *bgView = [[UIView alloc] initWithFrame: CGRectMake(0, liveConnectViewY, kScreenWidth, liveConnectViewH)];
        bgView.layer.masksToBounds = YES;
        bgView.clipsToBounds = YES;
        [_firstView addSubview:bgView];
        [_firstView insertSubview:bgView aboveSubview:self.pkBgImageV];
        _pkBgView = bgView;
    }
    return _pkBgView;
}


@end
