//
//  SkyDriveTool.h
//  LibProjView
//
//  Created by klc on 2020/6/9.
//  Copyright © 2020 . All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
NS_ASSUME_NONNULL_BEGIN

@interface SkyDriveTool : NSObject


/// 图片上传
/// @param image 数据
/// @param scene  0其他1用户图片2动态3短视频4私信5直播购6直播间7寻觅8举报
/// @param complete 返回
+ (void)uploadImageFormScene:(int)scene image:(UIImage *)image complete:(void (^)(BOOL success,NSString *imageUrl))complete;


/// 按图片顺序上传
/// @param images 图片数组
/// @param scene  0其他1用户图片2动态3短视频4私信5直播购6直播间7寻觅8举报
/// @param complete 回调
+ (void)uploadImageArrayFormScene:(int)scene images:(NSArray<UIImage *> *)images complete:(void (^)(BOOL success ,NSArray<NSString *>* urlArr))complete;


/// 图片上传 房间内部画面
/// @param image 数据
/// @param type 数据类型 1:视频 2:语音 3:1v1 4:电台 5:派对 6:短视频 7:动态 10:头像
/// @param roomId 直播间房间号
/// @param showId 直播间showId
/// @param complete 返回
+ (void)uploadImageFromLive:(UIImage *)image type:(int)type roomId:(int64_t)roomId showId:(NSString *)showId complete:(void (^_Nullable)(BOOL success,NSString *imageUrl))complete;


/// 文件上传
/// @param filePath 文件路径
/// @param scene   0其他1用户图片2动态3短视频4私信5直播购6直播间7寻觅8举报
/// @param complete 完成返回
/// @param progress 进度
+ (void)uploadFileFromScene:(int)scene filePath:(NSString *)filePath complete:(void (^)(BOOL success,NSString *url))complete progress:(void (^)(CGFloat uploadProgress))progress;



@end

NS_ASSUME_NONNULL_END
