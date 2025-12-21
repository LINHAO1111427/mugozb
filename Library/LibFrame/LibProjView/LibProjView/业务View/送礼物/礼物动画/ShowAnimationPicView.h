//
//  ShowAnimationPicView.h
//  TCDemo
//
//  Created by CH on 2019/10/29.
//  Copyright © 2019 CH. All rights reserved.
//
//  用于播放gif/svga
//  

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface ShowAnimationPicView : UIView

//@property (nonatomic, copy)void(^startPlaying)(BOOL playing);

//- (void)playAnimationWithData:(NSData *)data fileExtension:(NSString *)fileExtension animationTime:(CGFloat)time cacheKey:(NSString *)cacheKey finishBlock:(void(^)(void))finishBlock;

- (void)playAnimationFilePath:(NSString *)filePath finishBlock:(void(^)(void))finishBlock;

- (void)stopAnimation;

@end

NS_ASSUME_NONNULL_END
