//
//  ShowAnimationPicView.m
//  TCDemo
//
//  Created by CH on 2019/10/29.
//  Copyright © 2019 CH. All rights reserved.
//

#import "ShowAnimationPicView.h"

#import <SVGAPlayer/SVGAPlayer.h>
#import <SVGAParser.h>
#import <FLAnimatedImage/FLAnimatedImage.h>
#import <SVGAPlayer/SVGAVideoEntity.h>
#import <LibTools/LibTools.h>
#import <LibProjBase/ProjectCache.h>

@interface ShowAnimationPicView ()<SVGAPlayerDelegate>

/// svga 播放器
@property(nonatomic,weak) SVGAPlayer *svgaPlayer;
/// svga 解析器
@property(nonatomic,copy) SVGAParser *svgaParser;

/// gif 动画view
@property(nonatomic,weak) FLAnimatedImageView *gifImageView;

/// 播放图画的缓存地址
@property(nonatomic,copy) NSString *cacheKey;
/// 动画播放时间
@property (nonatomic, assign)CGFloat time;

@property (nonatomic, copy)void (^finishBlock)(void);

@end



@implementation ShowAnimationPicView


- (void)dealloc{
    [self closeAnimation];
}

- (void)playAnimationWithData:(NSData *)data fileExtension:(NSString *)fileExtension animationTime:(CGFloat)time cacheKey:(NSString *)cacheKey finishBlock:(void (^)(void))finishBlock{
    _finishBlock = finishBlock;
    _time = time;
    _cacheKey = cacheKey;
    
    kWeakSelf(self);
    dispatch_async(dispatch_get_main_queue(), ^{
        if ([fileExtension isEqualToString:@"svga"]) {
            [weakself playSvgaWithData:data];
        } else if ([fileExtension isEqualToString:@"gif"]){
            [weakself playGifWithData:data];
        } else{
            if (finishBlock) {
                finishBlock();
            }
        }
    });
}


- (void)playAnimationFilePath:(NSString *)filePath finishBlock:(void (^)(void))finishBlock{
    _finishBlock = finishBlock;
    _cacheKey = filePath;
    kWeakSelf(self);
    [ProjectCache cacheFileWithFilePath:filePath finishHandle:^(NSData * _Nonnull data, BOOL success) {
        if (success) {
            [weakself playAnimationFile:data fileExtension:filePath.pathExtension];
        }else{
            if (finishBlock) {
                finishBlock();
            }
        }
    }];
}

- (void)playAnimationFile:(NSData *)data fileExtension:(NSString *)fileExtension{
    kWeakSelf(self);
    dispatch_async(dispatch_get_main_queue(), ^{
        if ([fileExtension isEqualToString:@"svga"]) {
            [weakself playSvgaWithData:data];
        } else if ([fileExtension isEqualToString:@"gif"]){
            [weakself playGifWithData:data];
        } else{
            if (weakself.finishBlock) {
                weakself.finishBlock();
            }
        }
    });
}


- (void)stopAnimation{
    [self stopGifAnimation];
    [self stopSvgaAnimation];
}


- (void)closeAnimation{
    [NSObject cancelPreviousPerformRequestsWithTarget:self selector:@selector(stopSvgaAnimation) object:nil];
    [NSObject cancelPreviousPerformRequestsWithTarget:self selector:@selector(stopGifAnimation) object:nil];
    [self stopGifAnimation];
    [self stopSvgaAnimation];
}


- (void)svgaPlayerDidFinishedAnimation:(SVGAPlayer *)player{
   // NSLog(@"过滤文字=========SVGA动画播放完了=========="));
    [self stopSvgaAnimation];
}

// MARK: 播放svga
- (void)playSvgaWithData:(NSData *)data{
    // 解析并且播放
    kWeakSelf(self);
    [self.svgaParser parseWithData:data cacheKey:_cacheKey completionBlock:^(SVGAVideoEntity * _Nonnull videoItem) {
        if (videoItem != nil) {
            weakself.svgaPlayer.videoItem = videoItem;
            if (videoItem.videoSize.height > 0 && videoItem.videoSize.width) {
                weakself.svgaPlayer.height = ((weakself.svgaPlayer.width * videoItem.videoSize.height)/videoItem.videoSize.width);
                weakself.svgaPlayer.centerY = self.height/2.0;
            }
            [weakself.svgaPlayer startAnimation];
        }else{
            if (weakself.finishBlock) {
                weakself.finishBlock();
            }
        }
    } failureBlock:^(NSError * _Nonnull error) {
        if (error) {
            NSAssert(NO, kLocalizationMsg(@"svga解析出错了，检查文件格式!"));
        }
        if (weakself.finishBlock) {
            weakself.finishBlock();
        }
    }];
}

// MARK: 播放gifData
- (void)playGifWithData:(NSData *)data{
    FLAnimatedImage *image = [FLAnimatedImage animatedImageWithGIFData:data];
    self.gifImageView.animatedImage = image;
    [self.gifImageView startAnimating];
}


// MARK: 停止播放gif
- (void)stopGifAnimation{
    [_gifImageView stopAnimating];
    [_gifImageView removeFromSuperview];
    _gifImageView = nil;
    if (_finishBlock) {
        _finishBlock();
    }
}

// MARK: 停止svga
- (void)stopSvgaAnimation{
    [_svgaPlayer stopAnimation];
    [_svgaPlayer clearDynamicObjects];
    [_svgaPlayer removeFromSuperview];
    _svgaParser = nil;
    if (_finishBlock) {
        _finishBlock();
    }
}


// MARK: - Lazy
- (SVGAPlayer *)svgaPlayer{
    if (_svgaPlayer == nil) {
        SVGAPlayer *svgaPlayer = [[SVGAPlayer alloc] initWithFrame:self.bounds];
        _svgaPlayer.contentMode = UIViewContentModeScaleAspectFit;
        svgaPlayer.loops = 1;
        svgaPlayer.delegate = self;
        [self addSubview:svgaPlayer];
        _svgaPlayer = svgaPlayer;
    }
    return _svgaPlayer;
}

- (SVGAParser *)svgaParser{
    if (_svgaParser == nil) {
        _svgaParser = [[SVGAParser alloc] init];
    }
    return _svgaParser;
}

- (FLAnimatedImageView *)gifImageView{
    if (!_gifImageView) {
        FLAnimatedImageView *giftImageView = [[FLAnimatedImageView alloc] initWithFrame:self.bounds];
        giftImageView.contentMode = UIViewContentModeScaleAspectFit;
        kWeakSelf(self);
        giftImageView.loopCompletionBlock = ^(NSUInteger loopCountRemaining) {
            // GIF 动画播放完成一次
           // NSLog(@"过滤文字%ld"),loopCountRemaining);
            [weakself stopGifAnimation];
        };
        [self addSubview:giftImageView];
        _gifImageView = giftImageView;
    }
    return _gifImageView;
}




@end
