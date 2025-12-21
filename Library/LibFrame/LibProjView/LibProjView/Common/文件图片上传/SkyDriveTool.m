//
//  SkyDriveTool.m
//  LibProjView
//
//  Created by klc on 2020/6/9.
//  Copyright © 2020 . All rights reserved.
//

#import "SkyDriveTool.h"

#import <XTMediaKit/XTUploadFile.h>
#import <LibTools/LibTools.h>
#import <LibProjModel/KLCAppConfig.h>
#import <LibProjBase/LibProjBase.h>
#import <TZImagePickerController/TZImagePickerController.h>
#import <LibProjModel/HttpApiMonitoringController.h>


@interface SkyDriveTool()

@end

@implementation SkyDriveTool


/// 图片上传
/// @param image 数据
/// @param scene 0其他1用户图片2动态3短视频4私信5直播购6直播间7寻觅
/// @param complete 返回
+ (void)uploadImageFormScene:(int)scene image:(UIImage *)image complete:(void (^)(BOOL, NSString * _Nonnull))complete {
    [SkyDriveTool uploadImageFromSence:scene image:image type:0 roomId:-1 showId:@"-1" complete:complete];
}


/// 按图片顺序上传
/// @param images 图片数组
/// @param scene 0其他1用户图片2动态3短视频4私信5直播购6直播间7寻觅
/// @param complete 回调
+ (void)uploadImageArrayFormScene:(int)scene images:(NSArray<UIImage *> *)images complete:(void (^)(BOOL, NSArray<NSString *> * _Nonnull))complete {
    __block NSMutableArray *muArr = [[NSMutableArray alloc] initWithCapacity:1];
    __block NSInteger currentIndex = 0;
    __block NSInteger maxCount = images.count;
    for (UIImage *uploadImgs in images) {
        [SkyDriveTool uploadImageFromSence:scene image:uploadImgs type:0 roomId:-1 showId:@"-1" complete:^(BOOL success, NSString *imageUrl) {
            ++ currentIndex;
            if (success && imageUrl.length > 0) {
                [muArr addObject:imageUrl];
            }else{
            }
            if (currentIndex == maxCount) {
                complete?complete((muArr.count > 0)?YES:NO, muArr):nil;
                [muArr removeAllObjects];
                muArr = nil;
            }
        }];
    }
}


/// 图片上传 房间内部画面
/// @param image 数据
/// @param type 数据类型  1:视频 2:语音 3:1v1 4:电台 5:派对 6:短视频 7:动态 10:头像
/// @param roomId 直播间房间号
/// @param showId 直播间showId
/// @param complete 返回
+ (void)uploadImageFromLive:(UIImage *)image type:(int)type roomId:(int64_t)roomId showId:(NSString *)showId complete:(void (^)(BOOL, NSString * _Nonnull))complete {
    [SkyDriveTool uploadImageFromSence:6 image:image type:type roomId:roomId showId:showId complete:complete];
}



#pragma mark 图片上传


/// 图片总上传
/// @param image 数据
/// @param type 数据类型  1:视频 2:语音 3:1v1 4:电台 5:派对 6:短视频 7:动态 10:头像
/// @param roomId 直播间房间号
/// @param showId 直播间showId
/// @param complete 返回
+ (void)uploadImageFromSence:(int)sence image:(UIImage *)image type:(int)type roomId:(int64_t)roomId showId:(NSString *)showId complete:(void (^)(BOOL success, NSString * imageUrl))complete {
    
    [XTUploadFile uploadImage:image scene:sence complete:^(BOOL success, NSString * _Nonnull url) {
       // NSLog(@"过滤文字======SkyDriveTool====图片===%@"),url);
        if (success && url.length) {
            [SkyDriveTool checkImageUrl:url monitoringType:type roomId:roomId showId:showId complete:^(BOOL pass, NSString *strMsg) {
                complete?complete(pass,url):nil;
            }];
        }else{
            complete?complete(success,url):nil;
        }
    }];
}


#pragma mark 文件上传

/// 文件上传
/// @param filePath 文件路径
/// @param scene  0其他1用户图片2动态3短视频4私信5直播购6直播间7寻觅
/// @param complete 完成返回
/// @param progress 进度
+ (void)uploadFileFromScene:(int)scene filePath:(NSString *)filePath complete:(void (^)(BOOL, NSString * _Nonnull))complete progress:(void (^)(CGFloat))progress {
    [XTUploadFile uploadFile:filePath scene:scene complete:^(BOOL success, NSString * _Nonnull url) {
       // NSLog(@"过滤文字======SkyDriveTool====文件===%@"),url);
        complete?complete(success,url):nil;
    } progress:^(CGFloat uploadProgress) {
        progress?progress(uploadProgress):nil;
    }];
    
}



#pragma mark 文件检测
///检测照片上会否可用
+ (void)checkImageUrl:(NSString *)url monitoringType:(int)type roomId:(int64_t)roomId showId:(NSString *)showId complete:(void(^)(BOOL pass, NSString *strMsg))complete{
    ///有鉴定功能并且必须是图片
    if ([KLCAppConfig appConfig].haveMonitoring) {
        [HttpApiMonitoringController imageMonitoring:url monitoringType:type roomId:roomId showId:showId callback:^(int code, NSString *strMsg, HttpNoneModel *model) {
            complete?complete(code == 1?YES:NO,strMsg):nil;
        }];
    }else{
        complete?complete(YES,@""):nil;
    }
}


@end


