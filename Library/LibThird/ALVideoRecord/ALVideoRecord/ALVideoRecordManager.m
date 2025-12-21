//
//  ALVideoRecordManager.m
//  ALVideoRecord
//
//  Created by swh_y on 2022/6/22.
//

#import "ALVideoRecordManager.h"
#import <LibProjBase/ProjConfig.h>
#import <LibProjBase/RouteManager.h>
#import <LibProjBase/AppRouteName.h>

#import "AliyunVideoBase.h"
#import "AlivcShortVideoRoute.h"
#import "AliyunVideoCropParam.h"
#import "AliyunVideoRecordParam.h"
#import <AliyunVideoSDKBasic/AliyunVideoSDKInfo.h>
#import <AliyunVideoSDKBasic/AliyunVideoLicense.h>
static ALVideoRecordManager *_recordManager = nil;

@interface ALVideoRecordManager()<AliyunVideoBaseDelegate>
 
@end

@implementation ALVideoRecordManager
#pragma mark - 初始化
+ (ALVideoRecordManager *)shareInstence{
    if(_recordManager == nil)
    {
        _recordManager = [ALVideoRecordManager new];
    }
    return _recordManager;
}

+ (instancetype)share{
    return [[self alloc] init];
}

+ (instancetype)allocWithZone:(struct _NSZone *)zone{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken,^{
        _recordManager = [super allocWithZone:zone];
    });
    
    return _recordManager;
}
 
- (id)copyWithZone:(NSZone *)zone{
    return _recordManager;
}

- (id)mutableCopyWithZone:(NSZone *)zone{
    return _recordManager;
}
 
//录制配置
- (AliyunVideoRecordParam *)getRecordConfig{
    AliyunVideoRecordParam *config = [[AliyunVideoRecordParam alloc] init];
    config.position = AliyunCameraPositionFront;
    config.torchMode = AliyunCameraTorchModeOff;
    config.outputPath = [NSHomeDirectory() stringByAppendingPathComponent:@"Documents/aliyun_video_record.mp4"];
    config.beautifyStatus = YES;
    config.beautifyValue = 80;
    config.size = AliyunVideoVideoSize720P;
    config.ratio = AliyunVideoVideoRatio3To4;
    config.minDuration = 2.0;
    config.maxDuration = 10.0*60;
    config.videoQuality = AliyunVideoQualityHight;
    config.encodeMode = AliyunVideoEncodeModeHardH264;
    config.fps = 25;
    config.gop = 5;
    return config;
}

//裁剪配置
- (AliyunVideoCropParam *)getCropConfig{
    AliyunVideoCropParam *config = [[AliyunVideoCropParam alloc]init];
    config.outputPath = [NSHomeDirectory() stringByAppendingPathComponent:@"Documents/aliyun_video_record.mp4"];
    config.cutMode = AliyunVideoCutModeScaleAspectCut;
    config.size = AliyunVideoVideoSize720P;
    config.ratio = AliyunVideoVideoRatio3To4;
    config.minDuration = 2.0;
    config.maxDuration = 10.0*60;
    config.videoQuality = AliyunVideoQualityHight;
    config.encodeMode = AliyunVideoEncodeModeHardH264;
    config.fps = 25;
    config.gop = 5;
    return config;
}

#pragma mark - sdk注册与使用
- (void)registerAliRecordSdk{
    [AliyunVideoSDKInfo setLogLevel:5];//log等级
    NSError *error = [AliyunVideoSDKInfo registerSDK];
    if (error == nil) {
       // NSLog(@"过滤文字阿里短视频SDK初始化成功"));

    }else{
       // NSLog(@"过滤文字阿里短视频SDK初始化失败 error== %@"),error);
    }
    
   
    AliyunVideoLicenseResultCode code = [AliyunVideoLicenseManager Check];
    NSString *version = [AliyunVideoSDKInfo version]; // 版本号
    NSString *module = [AliyunVideoSDKInfo module];   // 版本类型
    int moduleCode =[AliyunVideoSDKInfo versionCode]; // 版本类型代码
    NSString *buildId =[AliyunVideoSDKInfo videoSDKBuildId]; // 版本打包ID
   // NSLog(@"过滤文字证书状态码（-1未初始化 0验证成功 1已经过期 2证书无效 3未知错误） code = %ld"),(long)code);
   // NSLog(@"过滤文字\n==============\n阿里短视频SDK信息\nVERSION：%@\nBUILD_ID：%@\nMODULE：%@\nMODULE_CODE：%d\n=============="), version, buildId, module, moduleCode);
}

/// 跳转短视频发布页面
/// @param filePath 视频路径
- (void)goForReleaseForVideo:(NSString *)filePath{
    if (filePath.length == 0) {
        return;
    }
    NSURL *fileURL = [NSURL fileURLWithPath:filePath];
    AVURLAsset *asset = [AVURLAsset assetWithURL:fileURL];
    float duration = [ALVideoRecordManager getTimeFromVideoPath:asset];
    UIImage *coverImage = [self getScreenShotImageFromVideoPath:asset];
    [RouteManager routeForName:RN_shortVideo_release currentC:[ProjConfig currentVC] parameters:@{@"videoUrl":fileURL,@"preview":coverImage,@"duration":@(duration)}];
}

/// 跳转短视频图片发布页面
/// @param image 图片
- (void)goForReleaseForImage:(UIImage *)image{
    if (!image) {
        return;
    }
    NSMutableArray *arr = [NSMutableArray array];
    [arr addObject:image];
    [RouteManager routeForName:RN_shortVideo_release currentC:[ProjConfig currentVC] parameters:@{@"images":arr}];
}


/// 获取视频时长
/// @param asset 本地文件
+ (CGFloat)getTimeFromVideoPath:(AVURLAsset *)asset{
    CMTime   time = [asset duration];
    CGFloat seconds = time.value/time.timescale;
    return seconds;
}


/// 获取视频的缩略图
/// @param asset 本地文件
- (UIImage *)getScreenShotImageFromVideoPath:(AVURLAsset *)asset{
    AVAssetImageGenerator *gen = [[AVAssetImageGenerator alloc] initWithAsset:asset];
    gen.appliesPreferredTrackTransform = YES;
    CMTime time = CMTimeMakeWithSeconds(0.0, 600);
    NSError *error = nil;
    CMTime actualTime;
    CGImageRef image = [gen copyCGImageAtTime:time actualTime:&actualTime error:&error];
    UIImage *shotImage = [[UIImage alloc] initWithCGImage:image];
    CGImageRelease(image);
    return shotImage;
}

#pragma mark - AliyunVideoBaseDelegate

/**
 录制完成回调

 @param base AliyunVideoBase
 @param recordVC 录制界面VC
 @param videoPath 视频保存路径
 */
- (void)videoBase:(AliyunVideoBase *)base recordCompeleteWithRecordViewController:(UIViewController *)recordVC videoPath:(NSString *)videoPath{
   // NSLog(@"过滤文字#####【阿里短视频】##### 录制完成回调 videoPath == %@"),videoPath);
    [recordVC.navigationController popToRootViewControllerAnimated:NO];
    [self goForReleaseForVideo:videoPath];
}



/**
 视频裁剪完成回调

 @param base AliyunVideoBase
 @param cropVC 裁剪页VC
 @param videoPath 视频保存路径
 */
- (void)videoBase:(AliyunVideoBase *)base cutCompeleteWithCropViewController:(UIViewController *)cropVC videoPath:(NSString *)videoPath{
   // NSLog(@"过滤文字#####【阿里短视频】##### 视频裁剪完成回调 videoPath == %@"),videoPath);
    [cropVC.navigationController popToRootViewControllerAnimated:NO];
    [self goForReleaseForVideo:videoPath];
}

/**
 图片裁剪完成回调
 
 @param base AliyunVideoBase
 @param cropVC 裁剪页VC
 @param image 图片
 */
- (void)videoBase:(AliyunVideoBase *)base cutCompeleteWithCropViewController:(UIViewController *)cropVC image:(UIImage *)image{
   // NSLog(@"过滤文字#####【阿里短视频】##### 图片裁剪完成回调 image == %@"),image);
    [cropVC.navigationController popToRootViewControllerAnimated:NO];
    [self goForReleaseForImage:image];
}

/**
 视频裁剪完成回调
 
 @param base AliyunVideoBase
 @param cropVC 裁剪页VC
 @param videoPath 视频保存路径
 @param sourcePath 原视频路径
 */
- (void)videoBase:(AliyunVideoBase *)base cutCompeleteWithCropViewController:(UIViewController *)cropVC videoPath:(NSString *)videoPath sourcePath:(NSString *)sourcePath{
   // NSLog(@"过滤文字#####【阿里短视频】##### 带原视频路径裁剪完成回调 video == %@ source = %@"),videoPath,sourcePath);
}


/**
 录制页跳转相册页

 @param recordVC 当前录制页VC
 @return 跳转相册页的视频配置，若返回空则沿用录制页的视频配置
 */
- (AliyunVideoCropParam *)videoBaseRecordViewShowLibrary:(UIViewController *)recordVC{
   // NSLog(@"过滤文字#####【阿里短视频】##### 录制页跳转相册页"));
    return [self getCropConfig];
}



/**
 相册页面跳转录制页

 @param photoVC 当前相册VC
 @return 跳转视频页的视频配置，若返回空则沿用相册裁剪页的视频配置
 */
- (AliyunVideoRecordParam *)videoBasePhotoViewShowRecord:(UIViewController *)photoVC{
   // NSLog(@"过滤文字#####【阿里短视频】##### 相册页面跳转录制页"));
    [photoVC.navigationController popViewControllerAnimated:YES];
    return [self getRecordConfig];
}


/**
 退出相册页
 */
- (void)videoBasePhotoExitWithPhotoViewController:(UIViewController *)photoVC{
    [photoVC.navigationController popViewControllerAnimated:YES];
   // NSLog(@"过滤文字#####【阿里短视频】##### 退出相册页"));
}

 
/**
 退出录制
 */
- (void)videoBaseRecordVideoExit{
    [[ProjConfig currentVC].navigationController popToRootViewControllerAnimated:YES];
   // NSLog(@"过滤文字#####【阿里短视频】##### 退出录制"));
}

@end

 
