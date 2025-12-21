//
//  PlayNetworkAudio.h
//  LibProjBase
//
//  Created by klc on 2020/6/5.
//  Copyright © 2020 . All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

/*********************播放网络音效******************/

@interface PlayNetworkAudio : NSObject


/// 播放网络音乐
/// @param filePath 网络路径
/// @param num 次数  -1 循环播放
/// @param complete 播放完成
- (void)playNetworkAudio:(NSString *)filePath playNum:(int)num playComplete:(void(^_Nullable)(void))complete;


///播放停止
- (void)playStop;



@end

NS_ASSUME_NONNULL_END
