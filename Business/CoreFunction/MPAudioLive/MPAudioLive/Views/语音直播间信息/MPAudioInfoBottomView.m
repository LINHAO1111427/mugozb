//
//  MPAudioInfoBottomView.m
//  LiveCommon
//
//  Created by admin on 2020/1/9.
//  Copyright © 2020 . All rights reserved.
//

#import "MPAudioInfoBottomView.h"
#import <LiveCommon/MPLiveInfoBottomInterface.h>
#import <LibTools/LibTools.h>
#import <LiveCommon/LiveManager.h>
#import <LibProjModel/HttpApiHttpVoice.h>
#import <LibProjModel/APPConfigModel.h>
#import <AgoraExtension/AgoraExtManager.h>
#import <MPCommon/LiveIMFuncView.h>
#import <LibProjBase/LibProjBase.h>
#import <LiveCommon/LiveComponentMsgListener.h>
#import <LiveCommon/LiveComponentMsgMgr.h>
#import <LibProjModel/KLCAppConfig.h>
#import "LiveConnectTipObj.h"

@interface MPAudioInfoBottomView ()<MPLiveInfoBottomInterface>

@property (nonatomic, assign)BOOL hasPk;

@property (nonatomic, weak)LiveIMFuncView *imView;

@property (nonatomic, weak)UIButton *musicBtn;

///连麦提示
@property (nonatomic, copy)LiveConnectTipObj *connectTipObj;

@end

@implementation MPAudioInfoBottomView

- (void)dealloc
{
    self.connectTipObj = nil;
}

+ (instancetype)register{
    return [[MPAudioInfoBottomView alloc] initWithFrame:[self viewFrame]];
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self changeItems:[self getItems]];
        [self createOtherView];
    }
    return self;
}

- (void)createOtherView{
    
    UIButton *musicBtn = [UIButton buttonWithType:0];
    [musicBtn setBackgroundImage:[UIImage imageNamed:@"live_audio_music"] forState:UIControlStateNormal];
    musicBtn.frame = CGRectMake(self.width-4-50, 0, 50, 50);
    musicBtn.hidden = YES;
    [musicBtn klc_whenTapped:^{
        if ([LiveManager liveInfo].roomRole == RoomRoleForAnchor || [LiveManager liveInfo].roomRole == RoomRoleForBroadcaster) {
            [LiveComponentMsgMgr sendMsg:LM_SelectMusic msgDic:nil];
        }else{
            [SVProgressHUD showInfoWithStatus:kLocalizationMsg(@"请上麦后再播放音乐")];
        }
    }];
    [self addSubview:musicBtn];
    self.musicBtn = musicBtn;
    
    if ([LiveManager liveInfo].anchorId == [ProjConfig userId] || [LiveManager liveInfo].roomModel.role == 2) {
        self.musicBtn.hidden = NO;
    }else{
        self.musicBtn.hidden = YES;
    }
    
    LiveIMFuncView *imView = [[LiveIMFuncView alloc] initWithFrame:CGRectMake(0, musicBtn.maxY+20, 40, 40)];
    imView.centerX = musicBtn.centerX;
    [self addSubview:imView];
    
    
    UIButton *magicBox = [UIButton buttonWithType:0];
    [magicBox setBackgroundImage:[UIImage imageNamed:@"game_magicBox_icon"] forState:UIControlStateNormal];
    magicBox.frame = CGRectMake(0, imView.maxY+20, 48, 30);
    magicBox.centerX = imView.centerX;
    [magicBox klc_whenTapped:^{
        [LiveComponentMsgMgr sendMsg:LM_MagicBox msgDic:nil];
    }];
    [self addSubview:magicBox];
}



- (void)reloadFunctionBtn{
    if ([LiveManager liveInfo].anchorId == [ProjConfig userId] || [LiveManager liveInfo].roomModel.role == 2) {
        self.musicBtn.hidden = NO;
    }else{
        self.musicBtn.hidden = YES;
    }
    [self changeItems:[self getItems]];
}

- (NSArray *)getItems{
    
    NSArray *itemArr;
    ///最多6个功能按钮
    switch ([LiveManager liveInfo].roomRole) {
        case RoomRoleForAnchor:
        {
            NSMutableArray *muArr = [[NSMutableArray alloc] initWithCapacity:1];
            if ([LiveManager liveInfo].roomModel.role == 2 || [LiveManager liveInfo].roomModel.role == 3) {
                [muArr addObject:@{@"name":kLocalizationMsg(@"连麦"),    @"icon":@"live_audio_connnect",    @"selectIcon":@"live_audio_connnect",      @"msgType":@(LM_UI_applyOnlineList)}];
            }

            [muArr addObject: @{@"name":kLocalizationMsg(@"麦克风"),  @"icon":@"live_jingyin_open",    @"selectIcon":@"live_jingyin_close",    @"msgType":@(10001)}];
            [muArr addObject: @{@"name":kLocalizationMsg(@"表情包"), @"icon":@"live_audio_emoji_black",    @"selectIcon":@"live_audio_emoji_black",  @"msgType":@(LM_EmojiShow)}];
            [muArr addObject: @{@"name":kLocalizationMsg(@"礼物"),    @"icon":@"live_songli",    @"selectIcon":@"live_songli",       @"msgType":@(LM_ShowGiftView)}];
            [muArr addObject:@{@"name":kLocalizationMsg(@"下麦"),  @"icon":@"live_audio_xiamai",    @"selectIcon":@"live_audio_xiamai",        @"msgType":@(LM_VoiceDowmMic)}];
            [muArr addObject:@{@"name":kLocalizationMsg(@"更多"),    @"icon":@"live_gengduo",    @"selectIcon":@"live_gengduo",       @"msgType":@(10000)} ];
            [muArr addObject:@{@"name":@"PK",    @"icon":@"live_pk_black",    @"selectIcon":@"live_pk_black",        @"msgType":@(LM_LaunchPK)}];
            [muArr addObject:@{@"name":kLocalizationMsg(@"分享"),    @"icon":@"live_fenxiang_more",    @"selectIcon":@"live_fenxiang_more",  @"msgType":@(LM_ShareView)} ];
            [muArr addObject:@{@"name":kLocalizationMsg(@"静音"),    @"icon":@"live_voice_open",    @"selectIcon":@"live_voice_close",       @"msgType":@(10002)}];
            
            if ([[ProjConfig shareInstence].baseConfig isContainFansGroup]) {
                [muArr addObject:@{@"name":kLocalizationMsg(@"粉丝团"),  @"icon":@"live_fensituan_pink",    @"selectIcon":@"live_fensituan_pink",   @"msgType":@(([LiveManager liveInfo].anchorId == [ProjConfig userId])?LM_SetFans:LM_JoinFans)}];
            }
            
            if ([[ProjConfig shareInstence].baseConfig isContainWishList] && [LiveManager liveInfo].anchorId == [ProjConfig userId]) {
                [muArr addObject:@{@"name":kLocalizationMsg(@"心愿单"),   @"icon":@"add_wish_xinyuandan",    @"selectIcon":@"add_wish_xinyuandan",   @"msgType":@(LM_AddWish)} ];
            }
            [muArr addObject:@{@"name":kLocalizationMsg(@"任务"),   @"icon":@"live_renwu_more",    @"selectIcon":@"live_renwu_more",   @"msgType":@(LM_ShowTask)}];
            [muArr addObject:@{@"name":kLocalizationMsg(@"音效氛围"),    @"icon":@"live_audio_effect",    @"selectIcon":@"live_audio_effect",  @"msgType":@(LM_SoundEffect)}];
            [muArr addObject:@{@"name":kLocalizationMsg(@"红包"),   @"icon":@"live_hongbao_more",    @"selectIcon":@"live_hongbao_more",   @"msgType":@(LM_SendRedPacket)} ];
            [muArr addObject:@{@"name":kLocalizationMsg(@"聊天背景"),  @"icon":@"live_change_bgImage",    @"selectIcon":@"live_change_bgImage",        @"msgType":@(LM_ChangeBackground)} ];
            [muArr addObject:@{@"name":kLocalizationMsg(@"房间公告"),  @"icon":@"live_fangjiangonggao",    @"selectIcon":@"live_fangjiangonggao",        @"msgType":@(LM_ChangeNotice)}];
            [muArr addObject:@{@"name":kLocalizationMsg(@"设置"),   @"icon":@"live_shezhi",    @"selectIcon":@"live_shezhi",   @"msgType":@(LM_SetRoomInfo)} ];
            [muArr addObject:@{@"name":kLocalizationMsg(@"直播时长"),  @"icon":@"live_livetime",    @"selectIcon":@"live_livetime",        @"msgType":@(LM_ShowLiveTime)}];
            [muArr addObject:@{@"name":kLocalizationMsg(@"贵族"),  @"icon":@"live_guizu",    @"selectIcon":@"live_guizu",        @"msgType":@(LM_BuyVIP)}];
            itemArr = [NSArray arrayWithArray:muArr];
        }
            break;
        case RoomRoleForBroadcaster:
        {
            NSMutableArray *muArr = [[NSMutableArray alloc] initWithCapacity:1];
            
            if ([LiveManager liveInfo].roomModel.role == 2 || [LiveManager liveInfo].roomModel.role == 3) {
                [muArr addObject:@{@"name":kLocalizationMsg(@"连麦"),    @"icon":@"live_audio_connnect",    @"selectIcon":@"live_audio_connnect",      @"msgType":@(LM_UI_applyOnlineList)}];
            }
            
            //            [muArr addObject:@{@"name":kLocalizationMsg(@"大转盘"),  @"icon":@"live-zhuanpan",    @"selectIcon":@"live-zhuanpan",        @"msgType":@(LM_LuckySpin)}];
            //            [muArr addObject:@{@"name":kLocalizationMsg(@"游戏"),  @"icon":@"game_magicBox_icon",    @"selectIcon":@"game_magicBox_icon",   @"msgType":@(LM_MagicBox)}];
            [muArr addObject:@{@"name":kLocalizationMsg(@"麦克风"),  @"icon":@"live_jingyin_open",    @"selectIcon":@"live_jingyin_close",     @"msgType":@(10001)}];
            [muArr addObject:@{@"name":kLocalizationMsg(@"表情包"),    @"icon":@"live_audio_emoji_black",    @"selectIcon":@"live_audio_emoji_black",  @"msgType":@(LM_EmojiShow)}];
            [muArr addObject:@{@"name":kLocalizationMsg(@"礼物"),    @"icon":@"live_songli",    @"selectIcon":@"live_songli",       @"msgType":@(LM_ShowGiftView)}];
            [muArr addObject:@{@"name":kLocalizationMsg(@"下麦"),  @"icon":@"live_audio_xiamai",    @"selectIcon":@"live_audio_xiamai",        @"msgType":@(LM_VoiceDowmMic)}];
            [muArr addObject:@{@"name":kLocalizationMsg(@"更多"),    @"icon":@"live_gengduo",    @"selectIcon":@"live_gengduo",      @"msgType":@(10000)}];
            if ([LiveManager liveInfo].anchorId == [ProjConfig userId]) {
                [muArr addObject:@{@"name":kLocalizationMsg(@"设置"),   @"icon":@"live_shezhi",    @"selectIcon":@"live_shezhi",   @"msgType":@(LM_SetRoomInfo)} ];
                [muArr addObject:@{@"name":kLocalizationMsg(@"心愿单"),   @"icon":@"add_wish_xinyuandan",    @"selectIcon":@"add_wish_xinyuandan",   @"msgType":@(LM_AddWish)} ];
                [muArr addObject:@{@"name":kLocalizationMsg(@"直播时长"),  @"icon":@"live_livetime",    @"selectIcon":@"live_livetime",        @"msgType":@(LM_ShowLiveTime)}];
            }
            [muArr addObject:@{@"name":kLocalizationMsg(@"音效氛围"),    @"icon":@"live_audio_effect",    @"selectIcon":@"live_audio_effect",  @"msgType":@(LM_SoundEffect)}];
            [muArr addObject:@{@"name":kLocalizationMsg(@"分享"),    @"icon":@"live_fenxiang_more",    @"selectIcon":@"live_fenxiang_more",  @"msgType":@(LM_ShareView)}];
            [muArr addObject:@{@"name":kLocalizationMsg(@"任务"),   @"icon":@"live_renwu_more",    @"selectIcon":@"live_renwu_more",   @"msgType":@(LM_ShowTask)}];
            [muArr addObject:@{@"name":kLocalizationMsg(@"红包"),   @"icon":@"live_hongbao_more",    @"selectIcon":@"live_hongbao_more",   @"msgType":@(LM_SendRedPacket)}];
            
            if ([[ProjConfig shareInstence].baseConfig isContainFansGroup]) {
                [muArr addObject:@{@"name":kLocalizationMsg(@"粉丝团"),  @"icon":@"live_fensituan_pink",    @"selectIcon":@"live_fensituan_pink",   @"msgType":@(([LiveManager liveInfo].anchorId == [ProjConfig userId])?LM_SetFans:LM_JoinFans)}];
            }
            
            [muArr addObject:@{@"name":kLocalizationMsg(@"音量"),    @"icon":@"live_voice_open",    @"selectIcon":@"live_voice_close",       @"msgType":@(10002)}];
            [muArr addObject:@{@"name":kLocalizationMsg(@"贵族"),  @"icon":@"live_guizu",    @"selectIcon":@"live_guizu",        @"msgType":@(LM_BuyVIP)}];
            itemArr = [NSArray arrayWithArray:muArr];
            
        }
            break;
        default:       ///观众
        {
            NSMutableArray *muArr = [[NSMutableArray alloc] initWithCapacity:1];
            
            if ([LiveManager liveInfo].roomModel.role == 2 || [LiveManager liveInfo].roomModel.role == 3) {
                [muArr addObject:@{@"name":kLocalizationMsg(@"连麦"),    @"icon":@"live_audio_connnect",    @"selectIcon":@"live_audio_connnect",      @"msgType":@(LM_UI_applyOnlineList)}];
            }
            //            [muArr addObject: @{@"name":kLocalizationMsg(@"大转盘"),  @"icon":@"live-zhuanpan",    @"selectIcon":@"live-zhuanpan",        @"msgType":@(LM_LuckySpin)}];
            //            [muArr addObject:@{@"name":kLocalizationMsg(@"游戏"),  @"icon":@"game_magicBox_icon",    @"selectIcon":@"game_magicBox_icon",   @"msgType":@(LM_MagicBox)}];
            [muArr addObject:@{@"name":kLocalizationMsg(@"礼物"),    @"icon":@"live_songli",    @"selectIcon":@"live_songli",       @"msgType":@(LM_ShowGiftView)}];
            [muArr addObject:@{@"name":kLocalizationMsg(@"上麦"),  @"icon":@"live_audio_shangmai",    @"selectIcon":@"live_audio_shangmai",        @"msgType":@(LM_VoiceUpMic)}];
            [muArr addObject:@{@"name":kLocalizationMsg(@"更多"),    @"icon":@"live_gengduo",    @"selectIcon":@"live_gengduo",      @"msgType":@(10000)}];
            
            if ([LiveManager liveInfo].anchorId == [ProjConfig userId]) {
                [muArr addObject:@{@"name":kLocalizationMsg(@"设置"),   @"icon":@"live_shezhi",    @"selectIcon":@"live_shezhi",   @"msgType":@(LM_SetRoomInfo)} ];
                [muArr addObject:@{@"name":kLocalizationMsg(@"心愿单"),   @"icon":@"add_wish_xinyuandan",    @"selectIcon":@"add_wish_xinyuandan",   @"msgType":@(LM_AddWish)}];
                [muArr addObject:@{@"name":kLocalizationMsg(@"直播时长"),  @"icon":@"live_livetime",    @"selectIcon":@"live_livetime",        @"msgType":@(LM_ShowLiveTime)}];
            }
            
            [muArr addObject:@{@"name":kLocalizationMsg(@"贵族"),  @"icon":@"live_guizu",    @"selectIcon":@"live_guizu",        @"msgType":@(LM_BuyVIP)}];
            [muArr addObject:@{@"name":kLocalizationMsg(@"分享"),    @"icon":@"live_fenxiang_more",    @"selectIcon":@"live_fenxiang_more",  @"msgType":@(LM_ShareView)}];
            
            if ([[ProjConfig shareInstence].baseConfig isContainFansGroup]) {
                [muArr addObject:@{@"name":kLocalizationMsg(@"粉丝团"),  @"icon":@"live_fensituan_pink",    @"selectIcon":@"live_fensituan_pink",   @"msgType":@(([LiveManager liveInfo].anchorId == [ProjConfig userId])?LM_SetFans:LM_JoinFans)}];
            }
            
            [muArr addObject:@{@"name":kLocalizationMsg(@"红包"),   @"icon":@"live_hongbao_more",    @"selectIcon":@"live_hongbao_more",   @"msgType":@(LM_SendRedPacket)}];
            [muArr addObject:@{@"name":kLocalizationMsg(@"任务"),   @"icon":@"live_renwu_more",    @"selectIcon":@"live_renwu_more",   @"msgType":@(LM_ShowTask)}];
            [muArr addObject:@{@"name":kLocalizationMsg(@"音量"),    @"icon":@"live_voice_open",    @"selectIcon":@"live_voice_close",       @"msgType":@(10002)}];
            itemArr = [NSArray arrayWithArray:muArr];
        }
            break;
    }
    
    return itemArr;
}


- (void)changePKShow:(BOOL)hasPk{
    _hasPk = hasPk;
    [self changeItems:[self getItems]];
}


- (void)clickFunction:(NSInteger)msgType{
    switch (msgType) {
        case 10001:  ///关闭自己的声音
        {
            [self setMicStatus];
        }
            break;
        case 10002:  ///关闭远端的声音
        {
            [self setVoiceStatus];
        }
            break;
        default:
            break;
    };
    
    [self changeItems:[self getItems]];
}

- (void)changeItems:(NSArray *)items{
    
    NSMutableArray<LiveFunctionItemModel *> *muArr = [[NSMutableArray alloc] initWithCapacity:1];
    for (NSDictionary *subDic in items) {
        
        LiveFunctionItemModel *model = [[LiveFunctionItemModel alloc] init];
        model.msgType = [subDic[@"msgType"] integerValue];
        model.name = subDic[@"name"];
        model.iconStr = subDic[@"icon"];
        
        switch (model.msgType) {
            case 10001:
            {
                model.iconStr = [LiveManager liveInfo].offMic? subDic[@"selectIcon"]:subDic[@"icon"];
            }
                break;
            case 10002:
            {
                model.iconStr = [LiveManager liveInfo].offAudio? subDic[@"selectIcon"]:subDic[@"icon"];
            }
                break;
            default:
                break;
        }
        
        [muArr addObject:model];
    }
    
    ///发送连麦按钮的位置
    kWeakSelf(self);
    [muArr enumerateObjectsUsingBlock:^(LiveFunctionItemModel * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        ///根据更多按钮，计算连麦的尺寸
        if (obj.msgType == 10000) {
            [weakself.connectTipObj updatePointRightSpace:40*idx+20+10];
            *stop = YES;
        }
    }];
    [self changeFunctionItems:[NSArray arrayWithArray:muArr]];
}


- (void)setMicStatus{
    [HttpApiHttpVoice offVolumn:[LiveManager liveInfo].offMic roomId:[LiveManager liveInfo].roomId callback:^(int code, NSString *strMsg, ApiUsersVoiceAssistanModel *model) {
        if (code == 1) {
            [[AgoraExtManager pubMethod] localAudioClosed:!model.onOffState];
        }else{
            [SVProgressHUD showInfoWithStatus:strMsg];
        }
    }];
}


- (void)setVoiceStatus{
    [LiveManager liveInfo].offAudio = ![LiveManager liveInfo].offAudio;
    [[AgoraExtManager pubMethod] remoteVoiceClosed:[LiveManager liveInfo].offAudio];
    [self reloadFunctionBtn];
}


- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event{
    UIView *hitV = [super hitTest:point withEvent:event];
    if (hitV == self) {
        return nil;
    }
    return hitV;
}

- (void)reloadUserLinkNumber:(int)linkNum{
    [self.connectTipObj updateLiveConnectNumber:linkNum];
}

- (LiveConnectTipObj *)connectTipObj{
    if (!_connectTipObj && ([LiveManager liveInfo].roomModel.role==2||[LiveManager liveInfo].roomModel.role==3)) {
        _connectTipObj = [[LiveConnectTipObj alloc] initWithSuperView:self];
    }
    return _connectTipObj;
}


@end
