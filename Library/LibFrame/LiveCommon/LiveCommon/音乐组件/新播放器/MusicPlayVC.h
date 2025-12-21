//
//  MusicPlayVC.h
//  LiveCommon
//
//  Created by klc on 2020/8/17.
//  Copyright © 2020 KLC. All rights reserved.
//

#import <UIKit/UIKit.h>

@class AppUserMusicDTOModel;



NS_ASSUME_NONNULL_BEGIN

typedef enum : NSUInteger {
    /**顺序播放*/
    playModeSquence    =0,
    /**循环播放*/
    playModeListLoop   =1,
    /**随机播放*/
    playModeRandom     =2,
    /**单曲循环*/
    playModeOneLoop    =3,
    
}PlayMusicMode;

@protocol LiveMusicPlayingDelegate <NSObject>


- (void)musicDidPlay:(AppUserMusicDTOModel *)musicModel;

- (void)musicDidPause;

- (void)musicDidResume;

- (void)musicDidStop;

- (void)changePlayMode:(PlayMusicMode)mode;


@end

/**可独立播放，支持下载*/

@interface MusicPlayVC : UIViewController 


@property(nonatomic, assign)int volume;  ///当前歌曲的播放音量


///停止播放
- (void)stopPlaySong;

///音乐播放完成
- (void)playCompleted;

///下一首
-(void)playNextSong;

///上一首
-(void)playPreviousSong;

///改变播放模式
- (void)playModeDidChange;

///当前播放歌曲是否正在播放
- (void)playStateDidChange:(BOOL)isPlaying;


@property(nonatomic,assign, readonly)BOOL isMusicPlayed;


@property(nonatomic,weak)id <LiveMusicPlayingDelegate> delegate;


///显示视图
- (void)show;

///关闭销毁视图
- (void)dismiss;


@end

NS_ASSUME_NONNULL_END
