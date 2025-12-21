//
//  MPAudioObserver.m
//  MPAudioLive
//
//  Created by klc_sl on 2020/6/30.
//  Copyright © 2020 KLC. All rights reserved.
//

#import "MPAudioObserver.h"
#import <LibProjModel/ApiUserInfoModel.h>
#import <LibTools/LibTools.h>
#import <LibProjModel/HttpApiHttpVoice.h>
#import <LibProjView/CheckRoomPermissions.h>
#import <LibProjBase/LibProjBase.h>
#import <LibProjModel/AppJoinRoomVOModel.h>
#import <MPAudioLive/InviteUserView.h>

@interface MPAudioObserver ()

@property (nonatomic, weak) InviteUserView *invite; // 邀请1v1页面

@end

@implementation MPAudioObserver

- (instancetype)init
{
    self = [super init];
    if (self) {
       // NSLog(@"过滤文字初始化多人语音监听"));
    }
    return self;
}

/**
 主播邀请上麦
 @param joinRoom null
 @param inviteInfo null
 @param isPay 门票房间是否付过钱  -1不是门票房间  1是门票房间付过钱 0是门票房间没付过钱
 */
- (void)invtUserUpAssitan:(AppJoinRoomVOModel *)joinRoom inviteInfo:(ApiUserInfoModel *)inviteInfo isPay:(int)isPay {
    
    kWeakSelf(self);
    InviteUserView *invite = [InviteUserView inviteUserInfoShow:inviteInfo userCurrentRole:1];
    [invite setSureBtnTitle:kLocalizationMsg(@"同意") cancelBtnTitle:kLocalizationMsg(@"拒接") content:kLocalizationMsg(@"邀请你上麦互动了")];
    [invite clickRefuseBtn:^{
        [weakself replyAnchorUpAssistan:inviteInfo.userId isAgree:0 roomId:joinRoom.roomId];
    }];
    [invite clickAgreeBtn:^{
        [weakself chectRoom:joinRoom isPay:isPay inviteUid:inviteInfo.userId];
    }];
    _invite = invite;
}


- (void)chectRoom:(AppJoinRoomVOModel *)roomModel isPay:(int)isPay inviteUid:(int64_t)inviteUid{
    kWeakSelf(self);
    [[CheckRoomPermissions share] joinRoom:roomModel.roomId liveDataType:LiveTypeForMPAudio joinRoom:^(AppJoinRoomVOModel * _Nonnull joinModel) {
        if (joinModel.roomId > 0) {
            [weakself agreeInvite:joinModel inviteUid:inviteUid];
        }
    } closeRoom:^(AppHomeHallDTOModel * _Nonnull dtoModel) {
        [SVProgressHUD showInfoWithStatus:kLocalizationMsg(@"该直播间已关闭")];
    } fail:nil];
    [_invite agreeDismiss];
}


- (void)agreeInvite:(AppJoinRoomVOModel *)roomModel inviteUid:(int64_t)inviteUid{
    [self replyAnchorUpAssistan:inviteUid isAgree:1 roomId:roomModel.roomId];
    [RouteManager routeForName:RN_live_audioForAudienceVC currentC:[ProjConfig currentVC] parameters:@{@"model":roomModel}];
}


///回复主播是否同意上麦
- (void)replyAnchorUpAssistan:(int64_t)userId isAgree:(int)isAgree roomId:(int64_t)roomId{
    [_invite cancelDismiss];
    [HttpApiHttpVoice replyAuthorInvt:userId reply:isAgree roomId:roomId callback:^(int code, NSString *strMsg, HttpNoneModel *model) {
        if (code != 1) {
            [SVProgressHUD showInfoWithStatus:strMsg];
        }
    }];
}


///邀请超时
- (void)invtTimeOut:(int64_t)sendInvtUid{
    [_invite cancelDismiss];
}




@end
