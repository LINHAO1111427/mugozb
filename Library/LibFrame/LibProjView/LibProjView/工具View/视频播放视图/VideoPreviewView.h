//
//  VideoPreviewView.h
//  CustomCamera
//
//  Created by long on 2017/11/9.
//  Copyright © 2017年 long. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface VideoPreviewView : UIView

@property (nonatomic, copy) NSURL *videoUrl;

@property (nonatomic, assign) BOOL isMatch;//遇见

@property (nonatomic, assign) BOOL canDelete;//可删除
/**
 开始播放
 */
- (void)play;

/**
 暂停
 */
- (void)pause;

/**
 重置
 */
- (void)reset;

/**
 是否正在播放
 */
- (BOOL)isPlay;

/// 删除
@property (nonatomic, copy) void (^deleteBtnClick)(int index);

@end
