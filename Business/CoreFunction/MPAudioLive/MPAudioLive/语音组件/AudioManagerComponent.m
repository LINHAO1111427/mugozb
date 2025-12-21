//
//  AudioComponent.m
//  emo
//
//  Created by CH on 2019/12/5.
//  Copyright © 2019 . All rights reserved.
//

#import "AudioManagerComponent.h"

#import <LibProjModel/HttpApiHttpVoice.h>

#import <LiveCommon/LiveComponentInterface.h>
#import <LiveCommon/LiveComponentMsgListener.h>
#import <LiveCommon/LiveComponentMsgMgr.h>

#import <LiveCommon/LiveManager.h>
#import <LibProjBase/LibProjBase.h>
#import <TXImKit/TXImKit.h>
#import <LibTools/LibTools.h>
#import <MPAudioLive/LiveChatEmojiView.h>
#import <MPAudioLive/SoundEffectView.h>

@interface AudioManagerComponent()<LiveComponentInterface,LiveComponentMsgListener>

@property (nonatomic, weak)UIView *secondView;

@end

@implementation AudioManagerComponent

- (void)dealloc
{
   // NSLog(@"过滤文字%s"),__func__);
}

// MARK: - 初始化
- (void)parInitViewController:(UIViewController *)superVC views:(NSArray<UIView *> *)views{
    
    [LiveComponentMsgMgr addMsgListener:self];
    [[IMSocketIns getIns] addReceiver:socketGroupLive receiver:self];
    
    // 第二层
    _secondView = views[1];
}


// MARK: - 组件消息
- (void)onMsg:(NSInteger)msgType msgDic:(NSDictionary *)msgDic{
    switch (msgType) {
            
        case LM_LiveLeaveInfo:
        case LM_ExitRoom:
        {
            
        }
            break;
        case LM_LiveRoomInfo:{
        }
            break;
        case LM_EmojiShow:{  ///emoji
            [LiveChatEmojiView showEmoji];
        }
            break;
        case LM_SoundEffect:{ ///播放音效
            [SoundEffectView showEffect];
        }
            break;
        default:{
        }
            break;
    }
}


// MARK: - Socket

/**
 主播将指定麦序的麦位上副播踢出
 @param assisId 被踢出的副播id
 @param assitan null
 */
- (void)kickOutAssistan:(int64_t)assisId assitan:(NSMutableArray<ApiUsersVoiceAssistanModel *> *)assitan {
    if (assitan.firstObject.roomId != [LiveManager liveInfo].roomId) {
        return;
    }
    [LiveComponentMsgMgr sendMsg:LM_UpdateSeats msgDic:@{@"models":assitan}];
    if (assisId == [ProjConfig userId]) { ///用户自己上麦
        [LiveComponentMsgMgr sendMsg:LM_UpdateUserOnline msgDic:@{@"status":@(0)}];
    }
}


/**
 副播下麦操作
 @param apiVoiceAssistanEntity null
 */
- (void)downVoiceAssistan:(NSMutableArray<ApiUsersVoiceAssistanModel *> *)apiVoiceAssistanEntity downUid:(int64_t)downUid {
    if (apiVoiceAssistanEntity.firstObject.roomId != [LiveManager liveInfo].roomId) {
        return;
    }
    [LiveComponentMsgMgr sendMsg:LM_UpdateSeats msgDic:@{@"models":apiVoiceAssistanEntity}];

    ///用户自己下麦
    if (downUid == [ProjConfig userId]) {
        [LiveComponentMsgMgr sendMsg:LM_UpdateUserOnline msgDic:@{@"status":@(0)}];
    }
}


/**
  主持人开关麦操作
 @param onOffState null
 */
- (void)hostOffVolumn:(int)onOffState {
    if ([LiveManager liveInfo].roomModel.presenterAssistant.presenterUserId > 0) {
        [LiveComponentMsgMgr sendMsg:LM_UpdateUserMicState msgDic:@{@"status":@(onOffState),@"userId":@([LiveManager liveInfo].roomModel.presenterAssistant.presenterUserId)}];
    }
    
}


/// 语音房间非PK状态下的主持人发送表情包
- (void)sendAnchorSticker:(ApiUsersVoiceAssistanModel *)presenterAssistant {
    if (presenterAssistant.roomId != [LiveManager liveInfo].roomId) {
        return;
    }
    [LiveComponentMsgMgr sendMsg:LM_UpdateAnchorEmoji msgDic:@{@"emoji":presenterAssistant.appStrickerVO}];
}

/**
 副播开关麦操作
 @param apiVoiceAssistanEntity null
 */
- (void)offVolumn:(NSMutableArray<ApiUsersVoiceAssistanModel *> *)apiVoiceAssistanEntity setUid:(int64_t)setUid {
    if (apiVoiceAssistanEntity.firstObject.roomId != [LiveManager liveInfo].roomId) {
        return;
    }
    [LiveComponentMsgMgr sendMsg:LM_UpdateSeats msgDic:@{@"models":apiVoiceAssistanEntity}];
    
    [apiVoiceAssistanEntity enumerateObjectsUsingBlock:^(ApiUsersVoiceAssistanModel * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if (obj.uid == setUid) {
            [LiveComponentMsgMgr sendMsg:LM_UpdateUserMicState msgDic:@{@"status":@(obj.onOffState),@"userId":@(obj.uid)}];
            *stop = YES;
        }
    }];
}



/**
 封锁指定麦序的麦位
 @param assistanNo 指定麦序
 */
- (void)LockThisAssistan:(int)assistanNo assitan:(NSMutableArray<ApiUsersVoiceAssistanModel *> *)assitan  {
    if (assitan.firstObject.roomId != [LiveManager liveInfo].roomId) {
        return;
    }
    [LiveComponentMsgMgr sendMsg:LM_UpdateSeats msgDic:@{@"models":assitan}];
}


/**
 观众上麦操作
 @param apiVoiceAssistanEntity null
 */
- (void)onUpVoiceAssistan:(NSMutableArray<ApiUsersVoiceAssistanModel *> *)apiVoiceAssistanEntity upUid:(int64_t)upUid {
    
    if (apiVoiceAssistanEntity.firstObject.roomId != [LiveManager liveInfo].roomId) {
        return;
    }
    [LiveComponentMsgMgr sendMsg:LM_UpdateSeats msgDic:@{@"models":apiVoiceAssistanEntity}];
    
    if (upUid == [ProjConfig userId] && [LiveManager liveInfo].roomRole == RoomRoleForAudience) { ///用户自己上麦
        [LiveManager liveInfo].offMic = NO;
        [LiveComponentMsgMgr sendMsg:LM_ReloadFunBtn msgDic:nil];
        [LiveComponentMsgMgr sendMsg:LM_UpdateUserOnline msgDic:@{@"status":@(1)}];
    }
}


- (void)sendGift:(NSMutableArray<ApiUsersVoiceAssistanModel*>* )hGetAssistanList{
    if (hGetAssistanList.firstObject.roomId != [LiveManager liveInfo].roomId) {
        return;
    }
    [LiveComponentMsgMgr sendMsg:LM_UpdateSeats msgDic:@{@"models":hGetAssistanList}];
}


- (void)sendStricker:(int)no hGetAssistanList:(NSMutableArray<ApiUsersVoiceAssistanModel *> *)hGetAssistanList{
    if (hGetAssistanList.firstObject.roomId != [LiveManager liveInfo].roomId) {
        return;
    }
    [LiveComponentMsgMgr sendMsg:LM_UpdateSeats msgDic:@{@"models":hGetAssistanList}];
}







@end
