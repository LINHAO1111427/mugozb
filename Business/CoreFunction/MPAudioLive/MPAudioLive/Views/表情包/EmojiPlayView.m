//
//  EmojiPlayView.m
//  MPAudioLive
//
//  Created by klc_sl on 2021/3/30.
//  Copyright © 2021 KLC. All rights reserved.
//

#import "EmojiPlayView.h"
#import <LibProjView/ShowAnimationPicView.h>
#import <Masonry/Masonry.h>
#import <LibTools/LibTools.h>

@interface EmojiPlayView ()

@property (nonatomic, weak)ShowAnimationPicView *playView;

@property (nonatomic, copy)NSString *playPath;

@property (nonatomic, assign)BOOL isCuntinuePlay;

@end

@implementation EmojiPlayView

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.userInteractionEnabled = NO;
        ShowAnimationPicView *playView = [[ShowAnimationPicView alloc] init];
        playView.userInteractionEnabled = NO;
        [self addSubview:playView];
        _playView = playView;
        [playView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(self);
        }];
    }
    return self;
}


- (void)stopAnimation{
    _playPath = @"";
    _isCuntinuePlay = NO;
    [self.playView stopAnimation];
}

- (void)playAnimation:(NSString *)path playTime:(double)time{
    _isCuntinuePlay = YES;
    _playPath = path;
    kWeakSelf(self);
    [self playUrl];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)((time>1?time-1:time)* NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        weakself.isCuntinuePlay = NO;
    });

}

- (void)playUrl{
    if (_playPath.length > 0) {
        kWeakSelf(self);
        [self.playView playAnimationFilePath:_playPath finishBlock:^{
            if (weakself.isCuntinuePlay) {
                [weakself playUrl];
            }
        }];
    }
}

@end
