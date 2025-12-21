//
//  XTUploadFile.h
//  XTMediaKit
//
//  Created by shirley on 2019/6/18.
//  Copyright © 2019 XTY. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN


@interface XTUploadFile : NSObject


/// @param filePath 文件本地路径
/// @param scene 文件来源  0其他1用户图片2动态3短视频4私信5直播购6直播间7寻觅8举报
/// @param uploadProgress 上传进度回调
+ (void)uploadFile:(NSString *)filePath scene:(int)scene complete:(void(^)(BOOL success, NSString *url))completeHandle progress:(void (^)(CGFloat uploadProgress))uploadProgress;



/// 上传图片
/// @param image 图片资源
/// @param scene 文件来源  0其他1用户图片2动态3短视频4私信5直播购6直播间7寻觅8举报
/// @param completeHandle 完成回调
+ (void)uploadImage:(UIImage *)image scene:(int)scene complete:(void(^)(BOOL success, NSString *url))completeHandle;


@end

NS_ASSUME_NONNULL_END
