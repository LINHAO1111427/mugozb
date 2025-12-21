//
//  MPLiveInfoComponent.m
//  TCDemo
//
//  Created by admin on 2019/9/26.
//  Copyright © 2019 CH. All rights reserved.
//

#import "MPLiveInfoComponent.h"


#import <TXImKit/TXImKit.h>
#import <LibTools/LibTools.h>
#import <LibTools/LiveMacros.h>
#import <LiveCommon/LiveComponentInterface.h>

#import <Masonry/Masonry.h>
#import <SDWebImage/SDWebImage.h>
#import <LiveCommon/LiveManager.h>

#import <LibProjBase/LibProjBase.h>
#import <LiveCommon/LiveComponentMsgListener.h>
#import <LiveCommon/LiveComponentMsgMgr.h>

#import <libProjModel/HttpApiPublicLive.h>
#import <LibProjModel/HttpApiHttpLive.h>
#import <LibProjModel/AppJoinRoomVOModel.h>
#import <LibProjModel/ApiCloseLiveModel.h>
#import <LibProjModel/ApiKickLiveModel.h>
#import <LibProjModel/ApiSimpleMsgRoomModel.h>
#import <LibProjModel/ApiUserBasicInfoModel.h>
#import <LibProjView/ForceAlertController.h>
#import <LibProjModel/OpenAuthDataVOModel.h>
#import "PLayMountsAnimationObj.h"
#import <LibProjView/ScreenfloatForRichmanJoinObj.h>
#import <LibProjView/PLayVIPJoinObj.h>

#import "PLayFansJoinObj.h"
#import "PLayGuardJoinObj.h"
#import <LiveCommon/LiveTimekeeping.h>
#import "LivePraiseAnimationLayer.h"

#import <MPCommon/ChangeBgImageVC.h>
#import "LiveExitSelectView.h"

#import "FamilyRecommendView.h"

@interface LiveInfoHitTapView : UIView

@end
@implementation LiveInfoHitTapView

- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event{
    UIView *hitV = [super hitTest:point withEvent:event];
    if (hitV == self) {
        return nil;
    }
    return hitV;
}

@end


@interface MPLiveInfoComponent ()<LiveComponentMsgListener,LiveComponentInterface>


@property (nonatomic, weak) UIView <MPLiveInfoHeaderInterface> *headerView;
@property (nonatomic, weak) UIView <MPLiveInfoBottomInterface> *bottomView;

/// 第一层
@property (nonatomic, weak) UIView *firstView;
/// 第二层
@property (nonatomic, weak) UIView *secondView;
///第二层信息view
@property (nonatomic, weak) LiveInfoHitTapView *liveInfoView;
/// 第三层
@property (nonatomic, weak) UIView *thirdView;
/// 第四层
@property (nonatomic, weak) UIView *fourthView;

@property (nonatomic, weak) UIViewController *superVC;

///关闭按钮
@property (nonatomic, weak) UIButton *closeBtn;

///聊天背景视图
@property (nonatomic, weak) UIImageView *bgImage;

/// 观众用户列表
@property(nonatomic, copy) NSArray <ApiUserBasicInfoModel *> *audiencelList;

///坐骑
@property (nonatomic, copy) PLayMountsAnimationObj *playMountsObj;
///VIP
@property (nonatomic, copy) PLayVIPJoinObj *playVIPObj;
///粉丝团
@property (nonatomic, copy) PLayFansJoinObj *playFansObj;
///守护
@property (nonatomic, copy) PLayGuardJoinObj *playGuardObj;
///点亮
@property (nonatomic, copy) LivePraiseAnimationLayer *praiseLayer;

///土豪进场
@property (nonatomic, copy)ScreenfloatForRichmanJoinObj *richJionObj;

///公会推荐
@property (nonatomic, weak)FamilyRecommendView *familyRecommendV;

@end

@implementation MPLiveInfoComponent


- (void)dealloc{
    [[LiveTimekeeping share] stopLiveTime];
    _praiseLayer = nil;
    _playVIPObj = nil;
    _playMountsObj = nil;
    _audiencelList = nil;
}

// MARK: - 初始化UI
- (void)parInitViewController:(UIViewController *)superVC views:(NSArray<UIView *> *)views{
    
    [LiveComponentMsgMgr addMsgListener:self];
    
    [[IMSocketIns getIns] addReceiver:socketGroupLive receiver:self];
    
    [self userJoinData];
    
    _superVC = superVC;
    ///第一层
    _firstView = views[0];
    // 第二层
    _secondView = views[1];
    // 第三层
    _thirdView = views[2];
    // 第四层
    _fourthView = views[3];
    
    if (![LiveManager liveInfo].roomModel) {  ///如果没有开播信息
        ///设置背景封面
       OpenAuthDataVOModel *openModel =  [LiveManager liveInfo].openData;
        if (openModel.voiceThumb.length > 0) {
            [self.bgImage sd_setImageWithURL:[NSURL URLWithString:openModel.voiceThumb] placeholderImage:[ProjConfig getLiveBgImage]];
        }
    }
    self.bgImage.hidden = NO;
    
}


// MARK: - 组件通讯
- (void)onMsg:(NSInteger)msgType msgDic:(NSDictionary *)msgDic{
    
    switch (msgType) {
        case LM_ChangeBackground:{
            [self changeBgImage];
        }
            break;
            
        case LM_AttentionAnchor:{
            [_headerView attentionAnchor:YES];
        }
            break;
            
            // 开播信息
        case LM_LiveRoomInfo:
        {
            [self createUI];
            [self openLiveInfo];
            [[LiveTimekeeping share] startLiveTime:[LiveManager liveInfo].roomModel.startTime];
        }
            break;
        case LM_UpdateWishList:{
            [_headerView reloadAnchorWishList:msgDic[@"models"]];
        }
            break;
        case LM_ShowLiveTime:{
            [[LiveTimekeeping share] showTimeAlert];
        }
            break;
            // 更新魅力值
        case LM_AnchorGiftNumber:{
            [LiveManager liveInfo].roomModel.votes = [msgDic[@"votes"] doubleValue];
            [_headerView updateAnchorVotesNumber:[msgDic[@"votes"] doubleValue]];
        }
            break;
            
            //显示屏幕信息
        case LM_ShowScreenAnimation:{
            if ([msgDic[@"animation"] intValue] == 0) {
                [self.liveInfoView addSubview:_closeBtn];
            }
        }
            break;
            //清除屏幕信息
        case LM_ClearScreenAnimation:{
            [_firstView addSubview:_closeBtn];
        }
            break;
            // PK 开始 （删除pk按钮）
        case LM_StartPK:{
        }
            break;
            //更新连麦人数
        case LM_UpdateConnectTip:{
            [_bottomView reloadUserLinkNumber:[msgDic[@"number"] intValue]];
        }
            break;
        case LM_ReloadFunBtn:{
            [_bottomView reloadFunctionBtn];
        }
            break;
        case LM_ExitRoom:
        case LM_LiveLeaveInfo:{
            [_headerView removeFromSuperview];
            [_bottomView removeFromSuperview];
            [[LiveTimekeeping share] stopLiveTime];
            _praiseLayer = nil;
            _playVIPObj = nil;
            _playMountsObj = nil;
            _audiencelList = nil;
        }
            break;
        case LM_updateVIPSeat:
        {
            [_headerView reloadVipSeat:msgDic];
        }
            break;
        case LM_RoomTotalVotes:{
            [LiveManager liveInfo].roomModel.roomTotalVotes = [msgDic[@"roomVotes"] doubleValue];
            [_headerView updateRoomVotesNumber:[msgDic[@"roomVotes"] doubleValue]];
        }
        default:
            break;
    }
}


// MARK: - Socket

- (void)onCloseLive:(ApiCloseLiveModel* )apiCloseLive{
    if (apiCloseLive.roomId == [LiveManager liveInfo].roomId) {
        [LiveComponentMsgMgr sendMsg:LM_LiveLeaveInfo msgDic:apiCloseLive?@{@"model":apiCloseLive}:nil];
    }
}

// MARK: 用户入场
- (void)onUserJoinRoom:(AppJoinRoomVOModel *)appJoinRoomVO {
    if (appJoinRoomVO.roomId != [LiveManager liveInfo].roomId) {
        return;
    }
    AppJoinRoomVOModel *model = [LiveManager liveInfo].roomModel;
    _audiencelList = [NSArray arrayWithArray:appJoinRoomVO.userList];
    model.watchNumber = appJoinRoomVO.watchNumber;
    [_headerView reloadAudienceNumber:_audiencelList userWatchNumber:appJoinRoomVO.watchNumber];
    
    [self playAudienceJoinAnimation:appJoinRoomVO];
    [_headerView reloadRoomData];
}

// MARK: 用户离场
- (void)onUserLeaveRoom:(ApiLeaveRoomModel *)apiLeaveRoom {
    if (apiLeaveRoom.roomId == [LiveManager liveInfo].roomId) {
        [self removeAudienceForUid:apiLeaveRoom.uid userWatchNumber:apiLeaveRoom.watchNumber];
    }
}

// MARK : 踢人
- (void)onManageKickRoom:(ApiKickLiveModel *)apiKickLive{
    if (apiKickLive.roomId != [LiveManager liveInfo].roomId) {
        return;
    }
    [self removeAudienceForUid:apiKickLive.touid userWatchNumber:apiKickLive.watchNumber];
    if (apiKickLive.touid == [ProjConfig userId]) {
        [LiveComponentMsgMgr sendMsg:LM_ExitRoom msgDic:nil];
    }
}
///购买守护
- (void)onBuyGuardListRoom:(NSMutableArray<GuardUserVOModel *> *)list {
    [_headerView reloadGuardUserList:list];
}
///更新直播间标题
- (void)onLiveTitleMsg:(NSString *)content{
    [LiveManager liveInfo].roomModel.title = content;
    [_headerView reloadRoomData];
}

/**
 修改房间背景图推送公告内容
 @param voicethumb null
 */
- (void)onUserBackground:(NSString *)voicethumb{
    [self.bgImage sd_setImageWithURL:[NSURL URLWithString:voicethumb] placeholderImage:[ProjConfig getLiveBgImage]];
}

///土豪进场消息
- (void)onJoinRoomMsgRoom:(ApiSimpleMsgRoomModel *)apiSimpleMsgRoom{
    if (apiSimpleMsgRoom.type == 1 && apiSimpleMsgRoom.roomId == [LiveManager liveInfo].roomId) {//进场
        [self.richJionObj playRichManJoinView:apiSimpleMsgRoom];
    }
    
}

///房间上锁
- (void)onLiveLockStatusMsg:(int)liveLockStatus{
    [LiveManager liveInfo].roomModel.liveLockStatus = liveLockStatus;
}

///房间中的角色 1:普通用户 2:管理员 3:主播
- (void)onRoomAdministrator:(int)roomRole{
    [LiveManager liveInfo].roomModel.role = roomRole;
    [_bottomView reloadFunctionBtn];
}

- (void)removeAudienceForUid:(int64_t)uid userWatchNumber:(int)userWatchNumber {
    NSMutableArray *muArr = [NSMutableArray arrayWithArray:_audiencelList];
    [muArr enumerateObjectsUsingBlock:^(ApiUserBasicInfoModel * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if (obj.uid == uid) {
            [muArr removeObject:obj];
            *stop = YES;
        }
    }];
    _audiencelList = [NSArray arrayWithArray:muArr];
    [_headerView reloadAudienceNumber:_audiencelList userWatchNumber:userWatchNumber];
}



// MARK: - Lazy
- (PLayMountsAnimationObj *)playMountsObj{
    if (!_playMountsObj) {
        _playMountsObj = [[PLayMountsAnimationObj alloc] initWithSuperView:_thirdView bannerSuperView:_fourthView];
    }
    return _playMountsObj;
}

- (PLayVIPJoinObj *)playVIPObj{
    if (!_playVIPObj) {
        _playVIPObj = [[PLayVIPJoinObj alloc] initWithSuperView:_fourthView];
    }
    return _playVIPObj;
}

- (PLayFansJoinObj *)playFansObj{
    if (!_playFansObj) {
        _playFansObj = [[PLayFansJoinObj alloc] initWithSuperView:_fourthView];
    }
    return _playFansObj;
}

- (PLayGuardJoinObj *)playGuardObj{
    if (!_playGuardObj) {
        _playGuardObj = [[PLayGuardJoinObj alloc] initWithSuperView:_fourthView];
    }
    return _playGuardObj;
}

- (ScreenfloatForRichmanJoinObj *)richJionObj{
    if (!_richJionObj) {
        _richJionObj = [[ScreenfloatForRichmanJoinObj alloc]initWithSuperView:_fourthView];
    }
    return _richJionObj;
}

- (LiveInfoHitTapView *)liveInfoView {
    if (!_liveInfoView) {
        LiveInfoHitTapView *liveInfoView = [[LiveInfoHitTapView alloc] initWithFrame:_secondView.bounds];
        [_secondView addSubview:liveInfoView];
        [_secondView insertSubview:liveInfoView atIndex:9];
        _liveInfoView = liveInfoView;
    }
    return _liveInfoView;
}

- (FamilyRecommendView *)familyRecommendV{
    if (!_familyRecommendV && [[ProjConfig shareInstence].baseConfig hasAnchorConference]) {
        FamilyRecommendView *family = [[FamilyRecommendView alloc] initShowInView:self.liveInfoView];
        _familyRecommendV = family;
    }
    return _familyRecommendV;
}

- (UIImageView *)bgImage{
    if (!_bgImage) {
        UIImageView *imgV = [[UIImageView alloc] initWithFrame:CGRectMake(-2, -5, kScreenWidth+4, kScreenHeight+10)];
        imgV.contentMode = UIViewContentModeScaleAspectFill;
        imgV.image = [ProjConfig getLiveBgImage];
        [_firstView addSubview:imgV];
        [_firstView sendSubviewToBack:imgV];
        _bgImage = imgV;
    }
    return _bgImage;
}

// MARK: - Other

- (void)createUI{
    if ([LiveManager liveInfo].roomRole != RoomRoleForAnchor) {  ///不是主播
        _praiseLayer = [[LivePraiseAnimationLayer alloc] initWithSuperView:_secondView];
    }
    
    ///1多人视频2语音直播3一对一4派对5电台6直播购物
    switch ([LiveManager liveInfo].serviceLiveType) {
        case 1:
            [LiveManager liveInfo].liveType = LiveTypeForMPVideoLive;
            break;
        case 2:
            [LiveManager liveInfo].liveType = LiveTypeForMPAudioLive;
            break;
        case 3:
            [LiveManager liveInfo].liveType = LiveTypeForOneToOne;
            break;
        case 4:
            
            break;
        case 5:
            
            break;
        case 6:
            [LiveManager liveInfo].liveType = LiveTypeForShoppingLive;
            break;
        default:
            break;
    }
    
    // 顶部视图
    Class<MPLiveInfoHeaderInterface> headerCls = [[LiveManager liveInfo].mpViewConfig getHeaderInfoView];
    UIView <MPLiveInfoHeaderInterface> *infoheaderView = [headerCls register];
    [self.liveInfoView addSubview:infoheaderView];
    _headerView = infoheaderView;
    
    Class<MPLiveInfoBottomInterface> bottomCls = [[LiveManager liveInfo].mpViewConfig getBottomInfoView];;
    UIView <MPLiveInfoBottomInterface> *bottomvV = [bottomCls register];
    [self.liveInfoView addSubview:bottomvV];
    _bottomView = bottomvV;
    
    ///关闭按钮
    [self createCloseBtn];
    
    infoheaderView.hidden = YES;
    bottomvV.hidden = YES;
    self.closeBtn.hidden = YES;
    
}

- (void)userJoinData{
    switch ([LiveManager liveInfo].liveType) {
        case LiveTypeForOneToOne:
            break;
        default:
        {
            // 观众第一次进房间显示 进入房间
            if ([LiveManager liveInfo].roomRole != RoomRoleForAnchor) {
                [HttpApiPublicLive joinRoomData:[LiveManager liveInfo].serviceLiveType roomId:[LiveManager liveInfo].roomId callback:^(int code, NSString *strMsg, HttpNoneModel *model) {
                   // NSLog(@"过滤文字%d=====%@"),code,strMsg);
                }];
            }
        }
            break;
    }
}

// 开播http请求
- (void)openLiveInfo{
    
    self.headerView.hidden = NO;
    self.bottomView.hidden = NO;
    self.closeBtn.hidden = NO ;
    self.familyRecommendV.hidden = NO;
    
    AppJoinRoomVOModel *model = [LiveManager liveInfo].roomModel;
    _audiencelList = [NSArray arrayWithArray:model.userList];
    [self.headerView reloadAudienceNumber:self.audiencelList userWatchNumber:model.watchNumber];
    
    if (model.voiceThumb.length) {
        [self.bgImage sd_setImageWithURL:[NSURL URLWithString:model.voiceThumb] placeholderImage:[ProjConfig getLiveBgImage]];
    }
    
    // 刷新房间数据
    [self.headerView reloadRoomData];
    
}

- (void)playAudienceJoinAnimation:(AppJoinRoomVOModel *)userModel{
    ///贵族 - 守护 - 粉丝团
    if (userModel.nobleGrade > 0) {
        [self.playVIPObj playVIPJoinView:userModel];
    }else{
        if (userModel.isSh == 1) {
            ///守护专属入场
            [self.playGuardObj playGuardJoinView:userModel];
        }else{
            if (userModel.isFans == 1) {
                [self.playFansObj playFansJoinView:userModel];
            }else{
                ///无
            }
        }
    }
    if (userModel.carSwf.length != 0) {
        // 播放坐骑动画
        [self.playMountsObj playUserJoinAnimation:userModel];
    }
}


- (void)createCloseBtn{
    ///关闭关闭
    UIButton *closeBtn = [UIButton buttonWithType:0];
    CGFloat contentInset = (liveHeaderBannerH - 16)/2.0;
    closeBtn.frame = CGRectMake(kScreenWidth-liveHeaderBannerH-(12-contentInset), liveHeaderBannerY, liveHeaderBannerH, liveHeaderBannerH);
    [closeBtn setImage:[UIImage imageNamed:@"live_guanbi_white"] forState:UIControlStateNormal];
    [closeBtn addTarget:self action:@selector(closeBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [closeBtn setImageEdgeInsets:UIEdgeInsetsMake(contentInset, contentInset, contentInset, contentInset)];
    [self.liveInfoView addSubview:closeBtn];
    _closeBtn = closeBtn;
}


- (void)closeBtnClick{
    [LiveExitSelectView showExitFunctionSelectView];
}


- (void)changeBgImage{
    /// type 类型0多人语音1一对一语音
    int type = 0;
    switch ([LiveManager liveInfo].liveType) {
        case LiveTypeForMPAudioLive:
            type = 0;
            break;
        case LiveTypeForOneToOne:
            type = 1;
            break;
        default:
            break;
    }
    kWeakSelf(self);
    ChangeBgImageVC *selectVc = [[ChangeBgImageVC alloc] init];
    [selectVc selectLiveBgThumb:type resultBlock:^(int64_t imageId, NSString * _Nonnull imageURL) {
        [weakself.bgImage sd_setImageWithURL:[NSURL URLWithString:imageURL] placeholderImage:[ProjConfig getLiveBgImage]];
    }];
    [_superVC.navigationController pushViewController:selectVc animated:YES];
}




@end
