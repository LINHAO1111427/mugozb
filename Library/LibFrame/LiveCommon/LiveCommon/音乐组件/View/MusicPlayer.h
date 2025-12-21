//
//  MusicPlayer.h
//  TCDemo
//
//  Created by CH on 2019/10/23.
//  Copyright © 2019 CH. All rights reserved.
//
// music player
//
// 管理搜索，下载，选择
// 管理音乐播放器view


#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface MusicPlayer : NSObject

/// 初始化
- (instancetype)initWithSelectMusicListView:(UIView *)selectMusicView
                         playerView:(UIView *)playerView;

@end

NS_ASSUME_NONNULL_END
