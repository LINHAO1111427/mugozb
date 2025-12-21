//
//  XTUploadFile.m
//  XTMediaKit
//
//  Created by shirley on 2019/6/18.
//  Copyright © 2019 XTY. All rights reserved.
//

#import "XTUploadFile.h"

#import "XTMediaManager.h"
#import "AVHttpSessionObj.h"
#import "AlyCloudObj.h"
 

@implementation XTUploadFile



/// @param filePath 文件本地路径
/// @param scene 资源
/// @param uploadProgress 上传进度回调
+ (void)uploadFile:(NSString *)filePath scene:(int)scene complete:(void (^)(BOOL, NSString * _Nonnull))completeHandle progress:(void (^)(CGFloat))uploadProgress{
    
    if (![self checkCloudKey] && completeHandle) {
        completeHandle(NO, @"");
    }
    NSString *fileName = [self getFileName:scene type:[XTUploadFile getFileTypeByFilePath:filePath]];
    
    
    __weak typeof(self) weakSelf = self;
    [AVHttpSessionObj uploadInfoWithScene:scene successBlock:^(BOOL success, NSString * _Nonnull token, NSDictionary * _Nonnull dic) {
        ///上传到三方
        if (success) {
            [weakSelf uploadThirdCloudFilePath:filePath fileName:fileName token:token param:dic complete:completeHandle progress:uploadProgress];
        }else{
            completeHandle?completeHandle(NO, @""):nil;
        }
    }];
    
}

/// 上传图片
/// @param image 图片资源
/// @param scene 资源
/// @param completeHandle 完成回调
+ (void)uploadImage:(UIImage *)image scene:(int)scene complete:(void (^)(BOOL, NSString * _Nonnull))completeHandle{
    
    if (![self checkCloudKey] && completeHandle) {
        completeHandle(NO, @"");
    }
    
    NSData *imageData = UIImageJPEGRepresentation(image, 0.5);
    if (!imageData) {
        completeHandle(NO, @"");
    }
    
    NSString *fileName = [self getFileName:scene type:1];
    
    __weak typeof(self) weakSelf = self;
    [AVHttpSessionObj uploadInfoWithScene:scene successBlock:^(BOOL success, NSString * _Nonnull token, NSDictionary * _Nonnull dic) {
        ///上传到三方
        if (success) {
            [weakSelf uploadThirdCloudImageData:imageData fileName:fileName token:token param:dic complete:completeHandle];
        }else{
            completeHandle?completeHandle(NO, @""):nil;
        }
    }];
}


#pragma mark  - 上传到三方 -
///图片
+ (void)uploadThirdCloudImageData:(NSData *)imageData fileName:(NSString *)fileName token:(NSString *)token param:(NSDictionary *)param complete:(void (^)(BOOL, NSString * _Nonnull))completeHandle{
    [AlyCloudObj alyunUploadImage:imageData filename:fileName param:param callBack:completeHandle];

}
///文件
+ (void)uploadThirdCloudFilePath:(NSString *)filePath fileName:(NSString *)fileName token:(NSString *)token param:(NSDictionary *)param complete:(void (^)(BOOL, NSString * _Nonnull))completeHandle progress:(void (^)(CGFloat))uploadProgress {
    
    [AlyCloudObj alyunUploadFile:filePath filename:fileName param:param callBack:completeHandle upProgress:uploadProgress];

}




#pragma mark - private -

+ (BOOL)checkCloudKey{
    Class<XTMediaConfig> config = [XTMediaManager share].config;
    if (config) {
        return YES;
    }else{
       // NSLog(@"过滤文字[XTMediaKit] 文件配置错误，请检查配置文件"));
        return NO;
    }
}



/// 获取文件名字
/// @param sence   0其他1用户图片2动态3短视频4私信5直播购6直播间7寻觅
/// @param type  1 图片 2视频 3语音
+ (NSString *)getFileName:(int)sence type:(int)type{
    
    Class<XTMediaConfig> config = [XTMediaManager share].config;
    int64_t userId = [config userId];
    
    NSArray *timeStr = [[self timeString:[NSDate date] dateFormat:@"yyyy-MM"] componentsSeparatedByString:@"-"];
    
    NSString *fileName = [self getNowTimeTimestamp];
    
    NSString *senceStr = @"otherFile";
    
    switch (sence) {
        case 1:{  ///用户图片
            senceStr = @"user";
        }
            break;
        case 2:{ ///动态
            senceStr = @"dynamic";
        }
            break;
        case 3:{ ///短视频
            senceStr = @"short";
        }
            break;
        case 4:{ ///私信
            senceStr = @"message";
        }
            break;
        case 5:{ ///直播购
            senceStr = @"shop";
        }
            break;
        case 6:{ ///直播间
            senceStr = @"live";
        }
            break;
        case 7:{ ///寻觅
            senceStr = @"seek";
        }
            break;
        case 8:{ ///举报
            senceStr = @"report";
        }
            break;
        default:{///其他文件
            senceStr = @"other";
        }
            break;
    }
    
    NSString *typeStr = @"";
    switch (type) {
        case 1: { ///图片
            senceStr = [senceStr stringByAppendingString:@"_img"];
            typeStr = @".jpeg";
        }   break;
        case 2: { ///视频
            senceStr = [senceStr stringByAppendingString:@"_video"];
            typeStr = @".mp4";
        }   break;
        case 3: { ///语音
            senceStr = [senceStr stringByAppendingString:@"_voice"];
            typeStr = @".m4a";
        }   break;
        case 4: { ///音乐
            senceStr = [senceStr stringByAppendingString:@"_music"];
            typeStr = @".mp3";
        }   break;
        default:
            break;
    }
    fileName = [NSString stringWithFormat:@"%@/%@/%@/i%lld_%@%@",senceStr, timeStr.firstObject, timeStr.lastObject, userId, fileName, typeStr];
    return fileName;
}

///2视频 3语音 4音乐 0未知
+ (int)getFileTypeByFilePath:(NSString *)filePath{
    
    NSString *str = [filePath componentsSeparatedByString:@"."].lastObject;
    if ([str isEqualToString:@"m4a"]) {
        return 3;
    }
    if ([str isEqualToString:@"mp4"]) {
        return 2;
    }
    if ([str isEqualToString:@"mp3"]) {
        return 4;
    }
    return 0;
    
}

+ (NSString *)typeForImageData:(NSData *)data{
    uint8_t c;
    [data getBytes:&c length:1];
    switch (c) {
        case 0xFF:
            return @"jpeg";
        case 0x89:
            return @"png";
        case 0x47:
            return @"gif";
        case 0x49:
        case 0x4D:
            return @"tiff";
    }
    return @"jpeg";
}


+ (NSString *)getNowTimeTimestamp{
    
    NSString *uuid = [self getUniqueStrByUUID];
    uuid = (uuid.length > 8)?[uuid substringFromIndex:uuid.length-8]:uuid;
    NSTimeInterval time=[[NSDate date] timeIntervalSince1970];
    NSString *timestamp = [NSString stringWithFormat:@"%@_%.0lf", uuid, time/100000.0];
    return timestamp;
    
}


+ (NSString *)timeString:(NSDate *)date dateFormat:(NSString *)dateFormat{
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    
    [formatter setDateFormat:dateFormat];
    
    NSString* string=[formatter stringFromDate:date];
    
    return string;
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


+ (BOOL)getWhetherUploadService{
    BOOL uploadService = NO;
    Class<XTMediaConfig> config = [XTMediaManager share].config;
    if (config && [config respondsToSelector:@selector(isUploadService)]) {
        uploadService = [config isUploadService];
    }
    return uploadService;
}

@end
