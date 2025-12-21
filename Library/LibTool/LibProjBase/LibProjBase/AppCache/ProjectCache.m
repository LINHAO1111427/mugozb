//
//  ProjectCache.m
//  TCDemo
//
//  Created by admin on 2019/10/19.
//  Copyright © 2019 CH. All rights reserved.
//

#import "ProjectCache.h"
#import <SDWebImage.h>
#import <HttpClient.h>

@implementation ProjectCache


+ (CGFloat)cacheSize{
    NSUInteger bytesCache = [[SDImageCache sharedImageCache] totalDiskSize];
    //换算成 MB (注意iOS中的字节之间的换算是1000不是1024)
    return bytesCache/1000.0/1000.0;
}


+ (void)clearCache{
    [[SDImageCache sharedImageCache] clearDiskOnCompletion:nil];
}


+ (void)cacheFileWithFilePath:(NSString *)filePath finishHandle:(void (^)(NSData * _Nullable, BOOL))finishHandle {
    
    if (filePath == nil || [filePath isKindOfClass:[NSNull class]]) {
       // NSLog(@"过滤文字路径不存在   --- "));
        finishHandle?finishHandle(nil,NO):nil;
        return;
    }
    
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *docDir = [paths objectAtIndex:0];
    
    NSString *imageUrl = filePath;
    NSString *existsFilePath = [NSString stringWithFormat:@"%@/%@",docDir,[imageUrl lastPathComponent]];
    
    // 缓存存在
    if ([[NSFileManager defaultManager] fileExistsAtPath:existsFilePath]) {
        NSData *data = [NSData dataWithContentsOfFile:existsFilePath];
        finishHandle?finishHandle(data,YES):nil;
        return;
    }
    // 缓存不存在
    else{
        
        [HttpClient downloadWithPath:filePath savePath:existsFilePath progress:^(NSProgress * _Nonnull downloadProgress) {
            
        } success:^(NSString * _Nonnull path) {
            
            if ([[NSFileManager defaultManager] fileExistsAtPath:existsFilePath]) {
                NSData *newData = [NSData dataWithContentsOfFile:existsFilePath];
                finishHandle?finishHandle(newData,YES):nil;
            }else{
               // NSLog(@"过滤文字保存文件的时候出错。 \n filePath === > %@"),existsFilePath);
                finishHandle?finishHandle(nil,NO):nil;
            }
        } failed:^(NSString * _Nonnull error) {
           // NSLog(@"过滤文字保存文件失败  --- >%@"),existsFilePath);
            finishHandle?finishHandle(nil,NO):nil;
        }];
    }
}


+ (NSURL *)recordingVideo:(BOOL)isMp4{
    NSString *filePath = [NSTemporaryDirectory() stringByAppendingString:[NSString stringWithFormat:@"%@.%@", [self getUniqueStrByUUID],isMp4?@"mp4":@"mov"]];
    return [NSURL fileURLWithPath:filePath];
}


+ (void)cacheAudioWithFilePath:(NSString *)filePath progress:(void (^)(NSProgress * _Nonnull))progress complete:(void (^)(NSURL * _Nonnull, BOOL))complete{
    
    if (filePath == nil || [filePath isKindOfClass:[NSNull class]]) {
        return;
    }
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *docDir = [paths objectAtIndex:0];
    NSString *localFilePath = [docDir stringByAppendingFormat:@"/%@",filePath];
    
    if ([[NSFileManager defaultManager] fileExistsAtPath:localFilePath]) { ///有
        if (complete) {
            complete([NSURL URLWithString:localFilePath], YES);
        }
    }else{  ///无
        
        [HttpClient downloadWithPath:filePath savePath:localFilePath progress:^(NSProgress * _Nonnull downloadProgress) {
            progress?progress(downloadProgress):nil;
        } success:^(NSString * _Nonnull path) {
            
            ([[NSFileManager defaultManager] fileExistsAtPath:localFilePath] && complete)?complete([NSURL URLWithString:localFilePath], YES):complete([NSURL URLWithString:@""], NO);
            
        } failed:^(NSString * _Nonnull error) {
            complete?complete([NSURL URLWithString:@""], NO):nil;
        }];
        
    }
}


+ (NSString *)getUniqueStrByUUID
{
    CFUUIDRef uuidObj = CFUUIDCreate(nil);//create a new UUID
    //get the string representation of the UUID
    CFStringRef uuidString = CFUUIDCreateString(nil, uuidObj);
    
    NSString *str = [NSString stringWithString:(__bridge NSString *)uuidString];
    
    CFRelease(uuidObj);
    CFRelease(uuidString);
    
    return [str lowercaseString];
}


@end
