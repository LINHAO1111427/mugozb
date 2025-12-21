//
//  VideoPreviewView.m
//  CustomCamera
//
//  Created by long on 2017/11/9.
//  Copyright © 2017年 long. All rights reserved.
//

#import "VideoPreviewView.h"
#import <AVFoundation/AVFoundation.h>

@interface VideoPreviewView ()

@property (nonatomic, strong) AVPlayerLayer *playerLayer;
@property (nonatomic, strong) AVPlayer *player;
@property (nonatomic, strong) UIButton *deleteBtn;
@end

@implementation VideoPreviewView

- (void)dealloc
{
    [self removeObserver];
    [_player pause];
    _player = nil;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setupUI];
    }
    return self;
}


- (void)setupUI
{
    self.backgroundColor = [UIColor blackColor];
    self.alpha = 0;
    self.playerLayer = [[AVPlayerLayer alloc] init];
    self.playerLayer.frame = self.bounds;
    [self.layer addSublayer:self.playerLayer];
    
    UIButton *deleteBtn = [UIButton buttonWithType:0];
    [deleteBtn setImage:[UIImage imageNamed:@"dynamic_photo_delete"] forState:UIControlStateNormal];
    deleteBtn.frame = CGRectMake(self.playerLayer.frame.size.width-25, 0, 25, 25);
    deleteBtn.imageEdgeInsets = UIEdgeInsetsMake(5, 5, 5, 5);
    kWeakSelf(self);
    [deleteBtn klc_whenTapped:^{
        if (weakself.deleteBtnClick) {
            weakself.deleteBtnClick(0);
        }
    }];
    deleteBtn.hidden = YES;
    self.deleteBtn = deleteBtn;
    [self addSubview:self.deleteBtn];
     
}
- (void)setCanDelete:(BOOL)canDelete{
    _canDelete = canDelete;
    self.deleteBtn.hidden = !canDelete;
}

- (void)setVideoUrl:(NSURL *)videoUrl{
    _player = [AVPlayer playerWithURL:videoUrl];
    [_player addObserver:self forKeyPath:@"status" options:NSKeyValueObservingOptionNew context:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(playFinished) name:AVPlayerItemDidPlayToEndTimeNotification object:nil];
    self.playerLayer.player = _player;
    self.playerLayer.videoGravity = AVLayerVideoGravityResizeAspect;
    if (self.isMatch) {
        _player.volume = 0.0f;
        self.playerLayer.videoGravity = AVLayerVideoGravityResizeAspectFill;
    }
     
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context
{
    if ([keyPath isEqualToString:@"status"]) {
        if (_player.status == AVPlayerStatusReadyToPlay) {
            [UIView animateWithDuration:0.25 animations:^{
                self.alpha = 1;
            }];
        }
    }
}

- (void)playFinished
{
    if (self.isMatch) {
        CMTime duration = _player.currentItem.asset.duration;
        float seconds = CMTimeGetSeconds(duration);
        float nowSeconds = CMTimeGetSeconds(_player.currentTime);
        if (seconds > 10 && nowSeconds < 10) {
            return;
        }
    }
    [_player seekToTime:kCMTimeZero];
    [_player play];
}

- (void)play
{
    [_player play];
}

- (void)pause
{
    [_player pause];
}

- (void)reset
{
    [self removeObserver];
    [_player pause];
    _player = nil;
}

- (BOOL)isPlay
{
    return _player && _player.rate > 0;
}

- (void)removeObserver
{
    [_player removeObserver:self forKeyPath:@"status"];
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

@end
