//
//  LiveMusicProtocol.h
//  AgoraExtension
//
//  Created by admin on 2020/1/4.
//  Copyright © 2020 . All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@protocol LiveMusicProtocol <NSObject>


#pragma mark ----播放音乐----


/** 开始播放音乐 */
- (void)playMusicForPath:(NSURL *)path progress:(void (^_Nullable)(int progress, int duration))progress complete:(void(^ _Nullable)(void))complete;

/** 停止播放音乐 */
- (void)stopMusic;

///暂停
- (void)pauseMusic;

///恢复
- (void)resumeMusic;


/// 调整本地和远端音量///0~100。默认100为原始文件音量
- (void)adjustAudioVolume:(NSInteger)value;


/// 播放音效文件
- (int)playEffectFilePath:(NSString *)filePath soundId:(int)soundId;



@end

NS_ASSUME_NONNULL_END
