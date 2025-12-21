//
//  AudioMicSeatsComponent.m
//  TCDemo
//
//  Created by CH on 2019/12/4.
//  Copyright © 2019 CH. All rights reserved.
//

#import "AudioMicSeatsComponent.h"
#import <UIKit/UIKit.h>

#import <LibTools/LibTools.h>
#import <LibProjBase/LibProjBase.h>
#import <LibTools/LiveMacros.h>
#import <TXImKit/TXImKit.h>
#import <AgoraExtension/AgoraExtManager.h>

#import <SDWebImage/SDWebImage.h>
#import <Masonry/Masonry.h>
#import <LiveCommon/LiveComponentInterface.h>
#import <LiveCommon/LiveComponentMsgListener.h>
#import <LiveCommon/LiveComponentMsgMgr.h>
#import <LibProjModel/VoicePkVOModel.h>

#import <LiveCommon/LiveManager.h>
#import <AgoraExtension/MPAudioProtocol.h>

// pk 匹配结果
#import <LibProjModel/ApiUsersVoiceAssistanModel.h>
#import <LibProjModel/PkUserVoiceAssistanModel.h>
#import <LibProjModel/AppStrickerVOModel.h>

#import <LibProjView/GiftUserModel.h>
#import "AudioMicSeatView.h"   // 麦位视图view

@interface AudioMicSeatsComponent()<LiveComponentInterface,LiveComponentMsgListener>


/** 麦位view */
@property (nonatomic, weak) AudioMicSeatView *micSeatView;

@property(nonatomic, weak) UIView *firstView;
@property(nonatomic, weak) UIView *secondView;

@property (nonatomic, strong) id<MPAudioProtocol> audioManager;

@property (nonatomic, assign)CGRect normalFrame;

@property (nonatomic, copy)NSLock *audioLock;


@end

@implementation AudioMicSeatsComponent


- (void)dealloc
{
    _audioManager = nil;
    _audioLock = nil;
}

// MARK: - 初始化
- (void)parInitViewController:(UIViewController *)superVC views:(NSArray<UIView *> *)views {
    
    _audioManager = [AgoraExtManager mpAudio];
    
    _firstView = views[0];
    _secondView = views[1];

    ///创建麦位
    AudioMicSeatView *seatView = [[AudioMicSeatView alloc] init];
    [_secondView addSubview:seatView];
    [_secondView insertSubview:seatView atIndex:1];
    _micSeatView = seatView;
    seatView.hidden = YES;
    _normalFrame = [[LiveManager liveInfo] getAudioSeatFrame];
    seatView.frame = _normalFrame;
    
    [LiveComponentMsgMgr addMsgListener:self];
    
    kWeakSelf(self);
    [_audioManager userVolume:^(NSUInteger num, int64_t uid) {
        [weakself userSpeaking:uid num:num];
    }];
    
}


// MARK: - 组件消息
- (void)onMsg:(NSInteger)msgType msgDic:(NSDictionary *)msgDic{
    switch (msgType) {
            
        case LM_LiveRoomInfo:{
            [self updateRoomModel];
        }
            break;
            
        case LM_UpdateUserOnline:{
            if ([msgDic[@"status"] intValue] == 0) { ///下麦
                [LiveManager liveInfo].roomRole =  RoomRoleForAudience;
                [[AgoraExtManager pubMethod] localAudioClosed:YES];
                [[AgoraExtManager mpAudio] changeRole:3];
            }else{ ///上麦
                [LiveManager liveInfo].roomRole =  RoomRoleForBroadcaster;
                [[AgoraExtManager mpAudio] changeRole:2];
                [[AgoraExtManager pubMethod] localAudioClosed:NO];
            }
            [LiveComponentMsgMgr sendMsg:LM_ReloadFunBtn msgDic:nil];
        }
            break;
            
            // 刷新下麦位信息
        case LM_UpdateSeats:{
            [_micSeatView setNormalSeatData:msgDic[@"models"]];
            [self giftNormalItems:msgDic[@"models"]];
        }
            break;
            ///刷新PK麦位
        case LM_UpdatePKSeats:{
            [self updatePKMicSeat:msgDic[@"model"]];
        }
            break;
            ///房间内Pk
        case LM_PrepareRoomPK:{
            CGRect rc = [[LiveManager liveInfo] getAudioSeatFrame];
            [self.micSeatView changeRoomPerparePKFrame:CGRectMake(12, rc.origin.y, kScreenWidth-24, rc.size.height)];
        }
            break;
        case LM_StartPK:{
            VoicePkVOModel *pkInfoModel = msgDic[@"model"];
            if (pkInfoModel.pkType != 1 || [LiveManager liveInfo].roomRole == RoomRoleForAnchor) {
                [_audioManager connectRoom:pkInfoModel.otherRoomID otherUid:pkInfoModel.otherAnchorId];
            }
            CGRect rc =  [[LiveManager liveInfo] getAudioSeatFrame];
            [self.micSeatView changePKViewFrame:CGRectMake(12, rc.origin.y, kScreenWidth-24, rc.size.height) showType:[LiveManager liveInfo].pkType];

        }
            break;
            // pk结束
        case LM_FinishPK:{
            [_audioManager closeConnect];
            [self.micSeatView changePKViewFrame:_normalFrame showType:LivePKTypeForNormal];
            [self.micSeatView setNormalSeatData:@[]];
        }
            break;
            ///更改自己的开关麦克风状态
        case LM_UpdateUserMicState:{
            if ([msgDic[@"userId"] longLongValue] == [ProjConfig userId]) {  ///等于自己（改变自己的麦克风开关）
                [LiveManager liveInfo].offMic = ![msgDic[@"status"] boolValue];
                [[AgoraExtManager pubMethod] localAudioClosed:[LiveManager liveInfo].offMic];
                [LiveComponentMsgMgr sendMsg:LM_ReloadFunBtn msgDic:nil];
            }
        }
            break;
            /************              清屏/显屏          *****************/
            //显示屏幕信息
        case LM_ShowScreenAnimation:{
            if ([msgDic[@"animation"] intValue] == 0) {
                [_secondView addSubview:_micSeatView];
            }
        }
            break;
            //清除屏幕信息
        case LM_ClearScreenAnimation:{
            [_firstView addSubview:_micSeatView];
        }
            break;
            
            /************              结束         *****************/
        case LM_ExitRoom:
        case LM_LiveLeaveInfo:{
            [_audioManager leaveRoom];
            _audioManager = nil;
            _micSeatView.hidden = YES;
            [_micSeatView removeFromSuperview];
        }
            break;
        default:
            break;
    }
}


#pragma mark - Private -

- (NSLock *)audioLock{
    if (!_audioLock) {
        _audioLock = [[NSLock alloc] init];
    }
    return _audioLock;
}

///用户说话动效
- (void)userSpeaking:(int64_t)uid num:(NSUInteger)num{
    [_micSeatView userSpeaking:num uid:uid];
}


/// 开播后获取数据
- (void)updateRoomModel{
    AppJoinRoomVOModel *roomModel = [LiveManager liveInfo].roomModel;
    if ([LiveManager liveInfo].roomRole == RoomRoleForAnchor) {
        [_audioManager initMPAudioRole:1];
    }else{
        [_audioManager initMPAudioRole:3];
    }
    [_audioManager joinRoom:roomModel.roomId];
    
    // 副播位置
    self.micSeatView.hidden = NO;
    [self.micSeatView changePKViewFrame:_micSeatView.frame showType:LivePKTypeForNormal];
    
    [self.micSeatView setNormalSeatData:roomModel.assistanList];
    
    [self giftNormalItems:roomModel.assistanList];
    ///判断是否在麦上
    [roomModel.assistanList enumerateObjectsUsingBlock:^(ApiUsersVoiceAssistanModel * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if (obj.uid == [ProjConfig userId] && [LiveManager liveInfo].roomRole == RoomRoleForAudience) { ///用户自己上麦
            [LiveManager liveInfo].offMic = NO;
            [LiveComponentMsgMgr sendMsg:LM_ReloadFunBtn msgDic:nil];
            [LiveComponentMsgMgr sendMsg:LM_UpdateUserOnline msgDic:@{@"status":@(1)}];
        }
    }];
}


- (void)updatePKMicSeat:(VoicePkVOModel *)pkModel{
        
    NSMutableArray<PkUserVoiceAssistanModel *> *thisPKVOArr = [[NSMutableArray alloc] initWithCapacity:1];
    NSMutableArray<PkUserVoiceAssistanModel *> *otherPKVOArr = [[NSMutableArray alloc] initWithCapacity:1];
    switch ([LiveManager liveInfo].pkType) {
        case LivePKTypeForRoom:
        {
            ///房间内PK主播的表情包
            if (pkModel.appStrickerVO.gifUrl.length > 0) {
                [LiveComponentMsgMgr sendMsg:LM_UpdateAnchorEmoji msgDic:@{@"emoji":pkModel.appStrickerVO}];
            }
        }
            break;
        case LivePKTypeForSingle:
        case LivePKTypeForTeam:
        {
            ///我方
            ApiUsersVoiceAssistanModel *ownNoraml = [[ApiUsersVoiceAssistanModel alloc] init];
            ownNoraml.avatar = pkModel.thisAvatar;
            ownNoraml.sex = pkModel.thisSex;
            ownNoraml.userName = pkModel.thisUsername;
            ownNoraml.noTalking = 0;
            ownNoraml.onOffState = pkModel.hostVolumn;
            ownNoraml.coin = pkModel.anchorVotes;
            ownNoraml.assistanName = @" ";
            ownNoraml.status = 1;
            ownNoraml.uid = pkModel.thisPresenterUserId;
            ownNoraml.anchorId = pkModel.thisAnchorId;
            ownNoraml.appStrickerVO = pkModel.appStrickerVO;
            ownNoraml.avatarFrame = pkModel.thisAvatarFrame;
            PkUserVoiceAssistanModel *own = [[PkUserVoiceAssistanModel alloc] init];
            own.giftVotes = pkModel.anchorVotes;
            own.pkNo = -1;
            own.usersVoiceAssistan = ownNoraml;
            [thisPKVOArr addObject:own];
            
            ///对方
            ApiUsersVoiceAssistanModel *otherNoraml = [[ApiUsersVoiceAssistanModel alloc] init];
            otherNoraml.avatar = pkModel.otherAvatar;
            otherNoraml.sex = pkModel.otherSex;
            otherNoraml.userName = pkModel.otherUsername;
            otherNoraml.noTalking = 0;
            otherNoraml.onOffState = pkModel.otherHostVolumn;
            otherNoraml.coin = pkModel.otherAnchorVotes;
            otherNoraml.assistanName = @" ";
            otherNoraml.status = 1;
            otherNoraml.uid = pkModel.otherPresenterUserId;
            otherNoraml.anchorId = pkModel.otherAnchorId;
            otherNoraml.appStrickerVO = pkModel.otherAppStrickerVO;
            otherNoraml.avatarFrame = pkModel.otherAvatarFrame;
            PkUserVoiceAssistanModel *other = [[PkUserVoiceAssistanModel alloc] init];
            other.giftVotes = pkModel.otherAnchorVotes;
            other.pkNo = -1;
            other.usersVoiceAssistan = otherNoraml;
            [otherPKVOArr addObject:other];
        }
            break;
        default:
            break;
    }
    
    [LiveComponentMsgMgr sendMsg:LM_UpdateUserMicState msgDic:@{@"status":@(pkModel.hostVolumn),@"userId":@([LiveManager liveInfo].anchorId)}];
    
    (pkModel.thisAssistans.count>0)?[thisPKVOArr addObjectsFromArray:pkModel.thisAssistans]:nil;
    (pkModel.otherAssistans.count>0)?[otherPKVOArr addObjectsFromArray:pkModel.otherAssistans]:nil;

    [self.micSeatView setPKOwnData:thisPKVOArr otherData:otherPKVOArr];
    [self giftPKItems:thisPKVOArr otherData:otherPKVOArr otherRoomID:pkModel.otherRoomID otherShowId:pkModel.otherShowId otherAnchorId:pkModel.otherAnchorId];
    
    ///判断是否在麦上
    NSArray<PkUserVoiceAssistanModel *> *tempArr = [NSArray arrayWithArray:thisPKVOArr];
    tempArr = [tempArr arrayByAddingObjectsFromArray:otherPKVOArr];
    [tempArr enumerateObjectsUsingBlock:^(PkUserVoiceAssistanModel * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if (obj.usersVoiceAssistan.uid == [ProjConfig userId] && [LiveManager liveInfo].roomRole == RoomRoleForAudience) { ///用户自己上麦
            [LiveManager liveInfo].offMic = NO;
            [LiveComponentMsgMgr sendMsg:LM_ReloadFunBtn msgDic:nil];
            [LiveComponentMsgMgr sendMsg:LM_UpdateUserOnline msgDic:@{@"status":@(1)}];
        }
    }];
}


#pragma mark - 标记送礼人 -
- (void)giftNormalItems:(NSArray<ApiUsersVoiceAssistanModel *> *)normalData{
    [self.audioLock lock];
   // NSLog(@"过滤文字=====语音中的麦位个数麦位=====%zi"), normalData.count);
    NSMutableArray *itemArr = [[NSMutableArray alloc] init];
    [itemArr addObject:[self getGiftAnchorModel]];
    
    GiftUserModel *userModel = [self getAssistantPresenterModel];
    userModel?[itemArr addObject:userModel]:nil;
    
    for (ApiUsersVoiceAssistanModel *assimodel in normalData) {
        if (assimodel.status == 1 && (assimodel.uid != [LiveManager liveInfo].anchorId)) {
            [itemArr addObject:[self getSubAnchorModel:assimodel roomId:[LiveManager liveInfo].roomId anchorId:[LiveManager liveInfo].anchorId showId:[LiveManager liveInfo].serviceShowId]];
        }
    }
    [LiveComponentMsgMgr sendMsg:LM_ChangeAllSendGiftUser msgDic:@{@"models":itemArr}];
    [self.audioLock unlock];
}


- (void)giftPKItems:(NSArray<PkUserVoiceAssistanModel *> *)ownModels otherData:(NSArray<PkUserVoiceAssistanModel *> *)otherModels otherRoomID:(int64_t)otherRoomID otherShowId:(NSString *)otherShowId otherAnchorId:(int64_t)otherAnchorId{
    
    [self.audioLock lock];
   // NSLog(@"过滤文字PK中的麦位个数左麦位%zi  右麦位%zi"), ownModels.count, otherModels.count);
    NSMutableArray *itemArr = [[NSMutableArray alloc] init];
    [itemArr addObject:[self getGiftAnchorModel]];
    
    GiftUserModel *presenterGiftModel = [self getAssistantPresenterModel];
    presenterGiftModel?[itemArr addObject:presenterGiftModel]:nil;
    
    ///自己队伍
    for (PkUserVoiceAssistanModel *pkAssimodel in ownModels) {
       // NSLog(@"过滤文字====%lld====%@"),pkAssimodel.usersVoiceAssistan.uid,pkAssimodel.usersVoiceAssistan.userName);
        ApiUsersVoiceAssistanModel *assModel = pkAssimodel.usersVoiceAssistan;
        if ((assModel.status == 1) && (assModel.uid != [LiveManager liveInfo].anchorId)  && (assModel.uid != presenterGiftModel.userId)) {
            [itemArr addObject:[self getSubAnchorModel:assModel roomId:[LiveManager liveInfo].roomId anchorId:assModel.anchorId showId:[LiveManager liveInfo].serviceShowId]];
        }
    }
    ///对方队伍
    for (PkUserVoiceAssistanModel *otherPkAssimodel in otherModels) {
       // NSLog(@"过滤文字====%lld====%@"),otherPkAssimodel.usersVoiceAssistan.uid,otherPkAssimodel.usersVoiceAssistan.userName);
        ApiUsersVoiceAssistanModel *ohterAssModel = otherPkAssimodel.usersVoiceAssistan;
        if ((ohterAssModel.status == 1) && (ohterAssModel.uid != [LiveManager liveInfo].anchorId) && (ohterAssModel.uid != presenterGiftModel.userId)) {
            [itemArr addObject:[self getSubAnchorModel:ohterAssModel roomId:otherRoomID anchorId:otherAnchorId showId:otherShowId]];
        }
    }
    [LiveComponentMsgMgr sendMsg:LM_ChangeAllSendGiftUser msgDic:@{@"models":itemArr}];
    [self.audioLock unlock];
}


///获得礼物的信息
- (GiftUserModel *)getGiftAnchorModel{
    GiftUserModel *model = [[GiftUserModel alloc] init];
    model.userId = [LiveManager liveInfo].anchorId;
    model.userName = [LiveManager liveInfo].anchorName;
    model.userIcon = [LiveManager liveInfo].anchorIcon;
    model.isAnchor = YES;
    model.roomId = [LiveManager liveInfo].roomId;
    model.anchorId = [LiveManager liveInfo].anchorId;
    model.showId = [LiveManager liveInfo].serviceShowId;
    model.showStr = [NSString stringWithFormat:@"%@",[LiveManager liveInfo].anchorName];
    return model;
}

- (GiftUserModel *)getSubAnchorModel:(ApiUsersVoiceAssistanModel *)assiModel roomId:(int64_t)roomId anchorId:(int64_t)anchorId showId:(NSString *)showId{
    GiftUserModel *model = [[GiftUserModel alloc] init];
    model.userId = assiModel.uid;
    model.userName = assiModel.userName;
    model.userIcon = assiModel.avatar;
    model.isAnchor = NO;
    model.roomId = roomId;
    model.anchorId = anchorId;
    model.showId = showId;
    model.showStr = [NSString stringWithFormat:@"%@",assiModel.userName];
    return model;
}

- (GiftUserModel *)getAssistantPresenterModel{
    ApiUsersVoiceAssistanModel *assistanModel = [LiveManager liveInfo].roomModel.presenterAssistant;
    if (assistanModel.presenterUserId > 0 && assistanModel.presenterUserId != [LiveManager liveInfo].anchorId) {
        GiftUserModel *model = [[GiftUserModel alloc] init];
        model.userId = assistanModel.presenterUserId;
        model.userName = assistanModel.userName;
        model.userIcon = assistanModel.avatar;
        model.isAnchor = NO;
        model.roomId = [LiveManager liveInfo].roomId;
        model.anchorId = [LiveManager liveInfo].anchorId;
        model.showId = [LiveManager liveInfo].serviceShowId;
        model.showStr = [NSString stringWithFormat:@"%@",assistanModel.userName];
        return model;
    }
    return nil;
}

@end
