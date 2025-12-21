//
//  LiveMusicComponent.m
//  TCDemo
//
//  Created by CH on 2019/10/22.
//  Copyright © 2019 CH. All rights reserved.
//


#import <LiveCommon/LiveMusicComponent.h>
#import "LiveMusicComponent.h"
#import <LiveCommon/LiveComponentInterface.h>
#import <LiveCommon/LiveComponentMsgListener.h>
#import <LiveCommon/LiveComponentMsgMgr.h>

#import <LibTools/LibTools.h>
#import <TXImKit/TXImKit.h>

#import <AgoraExtension/AgoraExtManager.h>
#import <AgoraExtension/LiveMusicProtocol.h>

#import "MusicPlayVC.h"
#import "MiniPlayerView.h"
#import "PlayerVolumeView.h"
#import <LibProjBase/ProjConfig.h>
#import <LibProjView/FunctionSheetBaseView.h>
#import <SDWebImage/SDWebImage.h>
#import <LibProjModel/AppUserMusicDTOModel.h>
#import <LibProjBase/ProjectCache.h>

@interface LiveMusicComponent()<LiveComponentInterface, LiveComponentMsgListener,LiveMusicPlayingDelegate,MiniPlayerManageDelegate,MiniPlayerPlayDelegate,UIGestureRecognizerDelegate>


//二期音乐播放器
@property (nonatomic, copy) MusicPlayVC *playerVC;
//迷你播放器
@property (nonatomic, weak) MiniPlayerView *miniPlayerView;

@property (nonatomic, weak) UIView  *secondMask;

@property (nonatomic, copy)id <LiveMusicProtocol> musicIMManager;


@end


@implementation LiveMusicComponent

// MARK: - 初始化UI

- (void)dealloc
{
   // NSLog(@"过滤文字%s"),__func__);
    _musicIMManager = nil;
}

- (void)parInitViewController:(UIViewController *)superVC views:(NSArray<UIView *> *)views{
    
    [LiveComponentMsgMgr addMsgListener:self];
    [[IMSocketIns getIns] addReceiver:socketGroupLive receiver:self];
    
    _musicIMManager = [AgoraExtManager music];
    _secondMask = views[1];
    
}


// MARK: - 组件通讯
- (void)onMsg:(NSInteger)msgType msgDic:(NSDictionary *)msgDic{
    switch (msgType) {
            // 音乐按钮被点击
        case LM_SelectMusic:{
            
            [self showMusicPlayer];
        }
            break;
        case LM_LiveLeaveInfo:{
            
            [_playerVC stopPlaySong];
            [_playerVC dismiss];
            _playerVC = nil;
            [_miniPlayerView removeFromSuperview];
            _miniPlayerView = nil;
        }
            break;
        case LM_UpdateUserOnline:{
            if ([msgDic[@"status"] intValue] == 0) { ///下麦
                [_playerVC stopPlaySong];
                [_playerVC dismiss];
                _playerVC = nil;
                [_miniPlayerView removeFromSuperview];
                _miniPlayerView = nil;
                [_musicIMManager stopMusic];
            }
        }
            break;
        default:
            break;
    }
}


// MARK: 显示播放器view
- (void)showMusicPlayer{
    [self.playerVC show];
}


#pragma mark LazyLoad

-(MusicPlayVC *)playerVC{
    if (!_playerVC){
        _playerVC = [[MusicPlayVC alloc] init];
        _playerVC.delegate = self;
    }
    return _playerVC;
}



- (MiniPlayerView *)miniPlayerView{
    
    if (!_miniPlayerView) {
        MiniPlayerView *miniV = [[MiniPlayerView alloc] initWithFrame:CGRectMake(100, liveConnectViewY, 270, 36)];
        miniV.centerX = _secondMask.width/2.0;
        miniV.isPlaying = NO;
        miniV.manageDelegate = self;
        miniV.delegate = self;
        [_secondMask addSubview:miniV];
        _miniPlayerView = miniV;
        
        UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(miniViewLocationChange:)];
        pan.delegate = self;
        [miniV addGestureRecognizer:pan];
        
        kWeakSelf(self);
        [UIView animateWithDuration:0.5 animations:^{
            weakself.miniPlayerView.alpha = 1;
        }];
        
    }
    return _miniPlayerView;
}


#pragma mark liveMusicPlayingDelegate
- (void)musicDidPlay:(AppUserMusicDTOModel *)musicModel {
    kWeakSelf(self);
    
    weakself.miniPlayerView.isPlaying = YES;
    weakself.miniPlayerView.musicModel = musicModel;
    dispatch_async(dispatch_get_main_queue(), ^{
        [self.musicIMManager playMusicForPath:[NSURL URLWithString:musicModel.musicUrl] progress:^(int progress, int duration) {
            
        } complete:^{
            [weakself.playerVC playCompleted];
        }];
    });
}


-(void)musicDidResume{
    [_musicIMManager resumeMusic];
    _miniPlayerView.isPlaying = YES;
}

-(void)musicDidPause{
    [_musicIMManager pauseMusic];
    _miniPlayerView.isPlaying = NO;
}


-(void)musicDidStop{
    [_musicIMManager stopMusic];
    _miniPlayerView.isPlaying = NO;
    [self.miniPlayerView removeFromSuperview];
}

- (void)changePlayMode:(PlayMusicMode)mode{
    _miniPlayerView.currentPlayMode = mode;
}


#pragma mark MiniPlayerManageDelegate
- (void)miniPlayerWillDismiss:(MiniPlayerView *)miniView{
    kWeakSelf(self);
    [UIView animateWithDuration:0.3 animations:^{
        weakself.miniPlayerView.alpha = 0;
    }completion:^(BOOL finished) {
        [weakself.playerVC stopPlaySong];
        [weakself musicDidStop];
    }];
}

- (void)miniPlayerWillPopVolumeView:(MiniPlayerView *)miniView{
    kWeakSelf(self);
    [PlayerVolumeView showCurrentVolume:self.playerVC.volume changeVolume:^(int volume) {
        [weakself.musicIMManager adjustAudioVolume:volume];
        weakself.playerVC.volume = volume;
    }];
}

- (void)miniPlayerWillPopPlayListView:(MiniPlayerView *)miniView{
    [self showMusicPlayer];
}


#pragma mark MiniPlayerPlayDelegate

///改变播放模式
-(void)miniPlayerPlayModeDidChange{
    [self.playerVC playModeDidChange];
}
///播放上一首
-(void)miniPlayerPlayPreviousSong{
    [self.playerVC playPreviousSong];
}
///播放下一首
-(void)miniPlayerPlayNextSong{
    [self.playerVC playNextSong];
}
///是否播放
-(void)miniPlayerPlayStateDidChange:(BOOL)isPlaying{
    [self.playerVC playStateDidChange:isPlaying];
}



//拖动手势
-(void)miniViewLocationChange:(UIPanGestureRecognizer *)sender{
    
    UIView *playerView = sender.view;
    
    CGPoint point = [sender translationInView:playerView];
    
    if (playerView.x + point.x < 0) {
        point = CGPointMake(0-playerView.x, point.y);
    }
    if (playerView.maxX + point.x > kScreenWidth) {
        point = CGPointMake(kScreenWidth-playerView.maxX, point.y);
    }
    if (playerView.y + point.y < 0) {
        point = CGPointMake(point.x, 0-playerView.y);
    }
    if (playerView.maxY + point.y > kScreenHeight) {
        point = CGPointMake(point.x, kScreenHeight - playerView.maxY);
    }
    
    playerView.center = CGPointMake(playerView.center.x + point.x, playerView.center.y + point.y);
    [sender setTranslation:CGPointZero inView:playerView];
    
}


@end
