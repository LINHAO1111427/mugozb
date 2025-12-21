//
//  ProjectCache.h
//  TCDemo
//
//  Created by admin on 2019/10/19.
//  Copyright © 2019 CH. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreGraphics/CoreGraphics.h>

NS_ASSUME_NONNULL_BEGIN

@interface ProjectCache : NSObject

+ (CGFloat)cacheSize;

+ (void)clearCache;

+ (void)cacheFileWithFilePath:(NSString *)filePath finishHandle:(void(^_Nullable)(NSData *_Nullable data,BOOL success))finishHandle;


/// 录制或转换视频的地址
/// @param isMp4 是否为mp4格式
+ (NSURL *)recordingVideo:(BOOL)isMp4;


///判断本地是否有缓存如果有直接返回，如果没有先下载
+ (void)cacheAudioWithFilePath:(NSString *)filePath progress:(void(^)(NSProgress *downloadProgress))progress complete:(void(^)(NSURL *filePath, BOOL has))complete;


@end

NS_ASSUME_NONNULL_END
