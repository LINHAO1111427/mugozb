//
//  PlayVideoView.h
//  TCDemo
//
//  Created by admin on 2019/11/5.
//  Copyright © 2019 CH. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@protocol PlayVideoDelegate <NSObject>

- (void)playVideoDuration:(float)duration progress:(float)progress;

@end

@interface PlayVideoView : UIView

@property(nonatomic, weak)id<PlayVideoDelegate> delegate;

@property (nonatomic, assign)BOOL isPlaying;

///需要在播放和设置封面前最先设置
@property (nonatomic, assign)BOOL imageModeAspectFill;

///封面图地址
@property (nonatomic, copy)NSString *preview;

- (void)playVideo:(NSString *)url;

- (void)pause;

- (void)resume;

- (void)stop;

- (void)seekTime:(float)time;
///设置静音
- (void)isMute:(BOOL)isMute;

@end

NS_ASSUME_NONNULL_END
