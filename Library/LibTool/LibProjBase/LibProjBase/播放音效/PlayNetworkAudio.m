//
//  PlayNetworkAudio.m
//  LibProjBase
//
//  Created by klc on 2020/6/5.
//  Copyright © 2020 . All rights reserved.
//

#import "PlayNetworkAudio.h"
#import <AVFoundation/AVFoundation.h>
#import <MediaPlayer/MediaPlayer.h>

@interface PlayNetworkAudio ()

@property (nonatomic ,strong) AVPlayer *audioPlay;  ///网络音效播放

@property (nonatomic ,strong) id timeObserver;

@end


@implementation PlayNetworkAudio

- (void)playNetworkAudio:(NSString *)filePath playNum:(int)num playComplete:(void (^)(void))complete{
    [self playStop];
    
    if (filePath.length == 0) {
       // NSLog(@"过滤文字播放地址有误"));
        return;
    }
    if (num < -1) {
       // NSLog(@"过滤文字输入的播放次数有误"));
        return;
    }
    
    __block int playNum = num;
    AVPlayerItem *item = [[AVPlayerItem alloc]initWithURL:[NSURL URLWithString:filePath]];
    _audioPlay = [[AVPlayer alloc]initWithPlayerItem:item];
    _audioPlay.volume = 0.9;
    __weak typeof(self) weakself = self;
    self.timeObserver =  [self.audioPlay addPeriodicTimeObserverForInterval:CMTimeMake(1.0, 1.0) queue:dispatch_get_main_queue() usingBlock:^(CMTime time) {
        
        CMTime duration = weakself.audioPlay.currentItem.duration;
        float totalSeconds = CMTimeGetSeconds(duration);
        float currentSeconds = CMTimeGetSeconds(time);
        float rate = currentSeconds/totalSeconds;
        if (rate >= 0.99) {
            switch (playNum) {
                case 1:  ///播放的最后一次
                case 0:
                {
                    if (complete) {
                        complete();
                    }
                }
                    break;
                case -1:   ///循环播放
                {
                    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                        [weakself playNetworkAudio:filePath playNum:playNum playComplete:nil];
                    });
                }
                    break;
                default:   ///
                {
                    --playNum;
                    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                         [weakself playNetworkAudio:filePath playNum:playNum playComplete:complete];
                    });
                }
                    break;
            }
        }
    }];
    
    [_audioPlay play];
}


- (void)playStop{
    [_audioPlay pause];
    if (_timeObserver) {
        [_audioPlay removeTimeObserver:_timeObserver];
        _timeObserver = nil;
    }
    _audioPlay = nil;
}


@end
