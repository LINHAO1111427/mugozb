//
//  MiniPlayerView.h
//  LiveCommon
//
//  Created by klc on 2020/8/20.
//  Copyright © 2020 KLC. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MusicPlayVC.h"

@class MiniPlayerView;

@protocol MiniPlayerPlayDelegate <NSObject>

///改变播放模式
-(void)miniPlayerPlayModeDidChange;

///播放上一首
-(void)miniPlayerPlayPreviousSong;

///播放下一首
-(void)miniPlayerPlayNextSong;

///是否播放
-(void)miniPlayerPlayStateDidChange:(BOOL)isPlaying;


@end


@protocol MiniPlayerManageDelegate <NSObject>

///音量调节
-(void)miniPlayerWillPopVolumeView:(MiniPlayerView *_Nonnull)miniView;
///显示播放列表
-(void)miniPlayerWillPopPlayListView:(MiniPlayerView *_Nonnull)miniView;
///关闭mini播放器
-(void)miniPlayerWillDismiss:(MiniPlayerView *_Nonnull)miniView;


@end


NS_ASSUME_NONNULL_BEGIN

@class AppUserMusicDTOModel;
@interface MiniPlayerView : UIView


@property(nonatomic, strong)AppUserMusicDTOModel *musicModel;  ///歌曲的

@property(nonatomic, assign)PlayMusicMode currentPlayMode;//播放模式

//主播放器是否在播放
@property(nonatomic,assign)BOOL isPlaying;


@property(nonatomic,weak)id <MiniPlayerPlayDelegate> delegate;


@property(nonatomic,weak)id <MiniPlayerManageDelegate> manageDelegate;



@end

NS_ASSUME_NONNULL_END
