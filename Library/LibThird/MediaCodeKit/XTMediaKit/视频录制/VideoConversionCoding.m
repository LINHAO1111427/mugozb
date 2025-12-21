//
//  VideoConversionCoding.m
//  TCDemo
//
//  Created by admin on 2019/11/5.
//  Copyright © 2019 CH. All rights reserved.
//

#import "VideoConversionCoding.h"
#import <AssetsLibrary/AssetsLibrary.h>

@implementation VideoConversionCoding

/// 0：成功。  1:失败。 2 取消  3.其他
+ (void)conversion:(NSURL *)movUrl savaPath:(NSURL *)savePath finishBlock:(void (^)(BOOL, int))block{
    
    AVURLAsset *avAsset = [AVURLAsset URLAssetWithURL:movUrl options:nil];
    NSArray *compatiblePresets = [AVAssetExportSession exportPresetsCompatibleWithAsset:avAsset];
    /**
     AVAssetExportPresetHighestQuality 表示视频的转换质量，
     */
    if ([compatiblePresets containsObject:AVAssetExportPresetHighestQuality]) {
        
        AVAssetExportSession *exportSession = [[AVAssetExportSession alloc] initWithAsset:avAsset presetName:AVAssetExportPresetHighestQuality];
        //转换完成保存的文件路径
        exportSession.outputURL = savePath;
        
        //要转换的格式，这里使用 MP4
        exportSession.outputFileType = AVFileTypeMPEG4;
        
        //转换的数据是否对网络使用优化
        exportSession.shouldOptimizeForNetworkUse = YES;
        
        //异步处理开始转换
        [exportSession exportAsynchronouslyWithCompletionHandler:^(void)
        {
            //转换状态监控
            int code = 3;   ///其他
            BOOL success = NO;
            switch (exportSession.status) {
                case AVAssetExportSessionStatusUnknown:
                   // NSLog(@"过滤文字AVAssetExportSessionStatusUnknown"));
                    break;
                    
                case AVAssetExportSessionStatusWaiting:
                   // NSLog(@"过滤文字AVAssetExportSessionStatusWaiting"));
                    break;
                    
                case AVAssetExportSessionStatusExporting:
                   // NSLog(@"过滤文字AVAssetExportSessionStatusExporting"));
                    break;
                case AVAssetExportSessionStatusFailed:
                    code = 1;
                   // NSLog(@"过滤文字AVAssetExportSessionStatusFailed"));
                    break;
                case AVAssetExportSessionStatusCancelled:
                    code = 2;
                   // NSLog(@"过滤文字AVAssetExportSessionStatusCancelled"));
                    break;
                case AVAssetExportSessionStatusCompleted:
                {
                    success = YES;
                    code = 0;
                    //转换完成
                   // NSLog(@"过滤文字AVAssetExportSessionStatusCompleted"));
                    break;
                }
            }
            if (block) {
                block(success,code);
            }
        }];
    }
}

@end
