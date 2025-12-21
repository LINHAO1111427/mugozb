//
//  CustomCameraController.m
//  CustomCamera
//
//  Created by long on 2017/6/26.
//  Copyright © 2017年 long. All rights reserved.
//

#import "CustomCameraController.h"
#import <AVFoundation/AVFoundation.h>
#import <CoreMotion/CoreMotion.h>
#import "CameraToolView.h"
#import "TZImagePickerController.h"
#import <AssetsLibrary/AssetsLibrary.h>

#import <LibProjBase/ProjectCache.h>
#import <LibProjBase/ProjConfig.h>
#import <LibTools/LibTools.h>
#import <LibProjBase/LibProjBase.h>

#import <LibProjModel/KLCAppConfig.h>
#import <LibProjModel/APPConfigModel.h>
#import <LibProjModel/AdminLiveConfigModel.h>
#import <XTMediaKit/XTCameraTool.h>

@interface CustomCameraController () <CameraToolViewDelegate,XTCameraToolDelegate>

///工具视图
@property (nonatomic, weak) CameraToolView *toolView;
///录像工具
@property (nonatomic, copy) XTCameraTool *cameraTool;


//录制视频保存的url
@property (nonatomic, copy) NSURL *videoUrl;
//录视频的第一帧
@property (nonatomic, copy) UIImage *videoPreview;
//录制视频时长 毫秒
@property (nonatomic, assign) CGFloat millisecond;
//拍照照片显示
@property (nonatomic, weak) UIImageView *takedImageView;
//拍照的照片
@property (nonatomic, copy) UIImage *takedImage;


@property (nonatomic, copy)void (^photoCompleteBlock)(CustomCameraController *, NSArray<UIImage *> *);

@property (nonatomic, copy)void (^videoCompleteBlock)(CustomCameraController *, NSURL *, UIImage *, CGFloat);

@end

@implementation CustomCameraController

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.modalPresentationStyle = UIModalPresentationFullScreen;
        _isFront = YES;
    }
    return self;
}

- (void)dealloc
{
   // NSLog(@"过滤文字 %s 文件销毁"),__func__);
    
    _cameraTool = nil;
    [_toolView removeFromSuperview];
    _takedImage = nil;
    _takedImageView = nil;
    
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationController.navigationBarHidden = YES;
    
    kWeakSelf(self);
    ///工具库
    [self.toolView.converBtn klc_whenTapped:^{
        [weakself btnToggleCameraAction];
    }];
    [self.toolView.lightBtn klc_whenTapped:^{
        [weakself turnONFlash];
    }];
    [self.toolView.beautyBtn klc_whenTapped:^{
        
    }];
    
    switch (_functionType) {
        case CameraFunction_onlyRecord:
        {
            self.toolView.onlyRecord = YES;
            [_cameraTool switchCameraAction:^(BOOL front) {
                weakself.toolView.allowlightBtn = !front;
            }];
        }
            break;
        default:
            break;
    }

}


- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [UIApplication sharedApplication].statusBarHidden = YES;
    [self.cameraTool startRunning];
}

- (XTCameraTool *)cameraTool{
    if (!_cameraTool) {
        ///视图
        _cameraTool = [[XTCameraTool alloc] init];
        _cameraTool.delegate = self;
        [_cameraTool showInView:self.view];
        
        if ([_cameraTool isFrontCamera] != self.isFront) {
            [_cameraTool switchCameraAction:^(BOOL front) {
                
            }];
        }
    }
    return _cameraTool;
}



- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
//    [UIApplication sharedApplication].statusBarHidden = YES;
//    [self.cameraTool startRunning];
    
}

- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
    [UIApplication sharedApplication].statusBarHidden = NO;
}


- (UIInterfaceOrientationMask)supportedInterfaceOrientations
{
    return UIInterfaceOrientationMaskPortrait;
}


- (void)selectPhotoDidComplete:(void (^)(CustomCameraController *, NSArray<UIImage *> *))photoComplete {
    _photoCompleteBlock = photoComplete;
}
- (void)selectVideoDidComplete:(void (^)(CustomCameraController *, NSURL *, UIImage *, CGFloat))videoComplete {
    _videoCompleteBlock = videoComplete;
}



#pragma mark - 点击屏幕设置聚焦点
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    CGPoint point = [touches.anyObject locationInView:self.view];
    if (point.y > [UIScreen mainScreen].bounds.size.height-150-kSafeAreaBottom) {
        return;
    }
    [self.cameraTool setFocusCursorWithPoint:point focusImage:[UIImage imageNamed:@"dynamic_camera_focus"]];
}


#pragma mark - 打开闪光灯
- (void)turnONFlash{
    [self.cameraTool turnOnFlash];
}
#pragma mark - 切换前后相机
//切换摄像头
- (void)btnToggleCameraAction
{
    kWeakSelf(self);
    [self.cameraTool switchCameraAction:^(BOOL front) {
        weakself.toolView.allowlightBtn = !front;
    }];
}


#pragma mark - CircleViewDelegate
//拍照
- (void)onTakePicture
{
    kWeakSelf(self);
    [self.cameraTool takePicture:^(BOOL start) {
        if (start) {
            [weakself.toolView photoSureView];
        }
    } handle:^(UIImage * _Nonnull image) {
        weakself.takedImage = image;
        weakself.takedImageView.hidden = NO;
        weakself.takedImageView.image = image;
    }];
}

- (CameraToolView *)toolView{
    if (!_toolView) {
        CameraToolView *toolView = [[CameraToolView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight) maxRecordDuration:_maxRecordTime];
        toolView.superVc = self;
        toolView.delegate = self;
        toolView.allowRecordVideo = ((self.functionType == CameraFunction_all)?YES:NO);
        toolView.allowSelectPhoto = self.showPhotoAlbum;
        [self.view addSubview:toolView];
        _toolView = toolView;
    }
    return _toolView;
}

- (UIImageView *)takedImageView{
    if (!_takedImageView) {
        UIImageView *takedImageView = [[UIImageView alloc] initWithFrame:self.view.bounds];
        takedImageView.backgroundColor = [UIColor blackColor];
        takedImageView.hidden = YES;
        takedImageView.contentMode = UIViewContentModeScaleAspectFit;
        [self.view insertSubview:takedImageView belowSubview:self.toolView];
        _takedImageView = takedImageView;
    }
    return _takedImageView;
}


//选择相册
- (void)onPhotoAlbum:(BOOL)isVideo{
    kWeakSelf(self);
    TZImagePickerController *imagePickerVc = [[TZImagePickerController alloc] initWithMaxImagesCount:isVideo?1:9 delegate:nil];
    imagePickerVc.modalPresentationStyle = UIModalPresentationFullScreen;
    imagePickerVc.allowPickingOriginalPhoto = NO;
    imagePickerVc.allowPickingVideo = isVideo;
    imagePickerVc.allowPickingImage = !isVideo;
    imagePickerVc.showSelectedIndex = YES;
    imagePickerVc.allowTakeVideo = NO;
    imagePickerVc.allowTakePicture = NO;
    imagePickerVc.barItemTextColor = [ProjConfig projNavTitleColor];
    imagePickerVc.naviTitleColor = [ProjConfig projNavTitleColor];
    imagePickerVc.naviBgColor = [UIColor whiteColor];
    [imagePickerVc setNavLeftBarButtonSettingBlock:^(UIButton *leftButton) {
        [leftButton setTitle:kLocalizationMsg(@"返回") forState:UIControlStateNormal];
        leftButton.titleLabel.font = [UIFont systemFontOfSize:15];
        [leftButton setTitleColor:[ProjConfig projNavTitleColor] forState:UIControlStateNormal];
    }];
    
    [imagePickerVc setDidFinishPickingPhotosHandle:^(NSArray<UIImage *> *photos, NSArray *assets, BOOL isSelectOriginalPhoto) {
        [weakself imagesBlock:photos];
    }];
    [imagePickerVc setDidFinishPickingVideoHandle:^(UIImage *coverImage, PHAsset *asset) {
        
        PHVideoRequestOptions* options = [[PHVideoRequestOptions alloc] init];
        options.version = PHVideoRequestOptionsVersionOriginal;
        options.networkAccessAllowed = YES;
        options.deliveryMode = PHVideoRequestOptionsDeliveryModeAutomatic;
        [SVProgressHUD showWithStatus:kLocalizationMsg(@"正在从iCloud加载视频")];
        [[PHImageManager defaultManager] requestAVAssetForVideo:asset options:options resultHandler:^(AVAsset* avasset, AVAudioMix* audioMix, NSDictionary* info){
            [SVProgressHUD dismiss];
            AVURLAsset *videoAsset = (AVURLAsset*)avasset;
            CMTime timesdfsdf = [videoAsset duration];
            CGFloat times = timesdfsdf.value/timesdfsdf.timescale;
            [weakself videoSure:videoAsset.URL preview:coverImage duration:times];
        }];
        
    }];
    [self presentViewController:imagePickerVc animated:YES completion:nil];
}

//开始录制
- (void)onStartRecord
{
    kWeakSelf(self);
    [self.cameraTool startShooting:^(BOOL start) {
        if (start) {
            [weakself.toolView startAnimate];
        }
    }];
}

//结束录制
- (void)onFinishRecord
{
    kWeakSelf(self);
    [self.toolView stopAnimate:^(BOOL success) {
        if (success) {
            [weakself.cameraTool stopShooting:^(NSURL * _Nullable videoUrl, UIImage * _Nullable preview, NSTimeInterval duration) {
                if (duration > 0) {
                    weakself.videoUrl = videoUrl;
                    weakself.videoPreview = preview;
                    weakself.millisecond = duration;
                }else{
                   // NSLog(@"过滤文字视频长度小于0.5s，按拍照处理"));
                    [weakself onTakePicture];
                }
                
            }];
        }
    }];
}


///重新拍照或录制
- (void)onRetake
{
    ///清楚基本数据
    self.videoUrl = nil;
    self.videoPreview = nil;
    self.millisecond = 0;
    self.takedImage = nil;
    self.takedImageView.hidden = YES;
    self.takedImageView.image = nil;
    
    [self.cameraTool cancelShooting];
}

///照片确定
- (void)onPhotoOkClick
{
    if (self.takedImage) {
        [self imagesBlock:[NSArray arrayWithObject:self.takedImage]];
    }
}

- (void)imagesBlock:(NSArray *)images{
    kWeakSelf(self);
    dispatch_async(dispatch_get_main_queue(), ^{
        if (weakself.photoCompleteBlock) {
            weakself.photoCompleteBlock(weakself, images);
        }
    });
}

///视频确定
- (void)onVideoOkClickIsRecording:(BOOL)isRecording{
    if (isRecording) {
        [self onFinishRecord];
    }
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self videoSure:self.videoUrl preview:self.videoPreview duration:self.millisecond];
    });
}


- (void)videoSure:(NSURL *)videoUrl preview:(UIImage *)preview duration:(CGFloat)duration{
    //  mp4转码
    if (videoUrl && preview && duration > 0) {
        [SVProgressHUD showWithStatus:kLocalizationMsg(@"视频转码中")];
        NSURL *mp4Url = [ProjectCache recordingVideo:YES];
        kWeakSelf(self);
        [self.cameraTool conversion:videoUrl savePath:mp4Url finishBlock:^(BOOL isSuccess, int errorCode) {
            [SVProgressHUD dismiss];
            ///errorCode 0：成功 1:失败 2:取消 3:其他
            if (isSuccess) {
                dispatch_async(dispatch_get_main_queue(), ^{
                    if (weakself.videoCompleteBlock) {
                        weakself.videoCompleteBlock(weakself, mp4Url, preview, duration);
                    }
                });
            }else{
                switch (errorCode) {
                    case 1:
                        [SVProgressHUD showInfoWithStatus:kLocalizationMsg(@"转换失败")];
                        break;
                    case 2:
                        [SVProgressHUD showInfoWithStatus:kLocalizationMsg(@"转换取消")];
                        break;
                    case 3:
                        [SVProgressHUD showInfoWithStatus:kLocalizationMsg(@"转换错误")];
                        break;
                    default:
                        [SVProgressHUD showInfoWithStatus:kLocalizationMsg(@"转换完成")];
                        break;
                }
                
            }
        }];
    }
}

//dismiss
- (void)onDismiss
{
    kWeakSelf(self);
    dispatch_async(dispatch_get_main_queue(), ^{
        
        [weakself.cameraTool stopRunning];
        weakself.cameraTool = nil;
        [weakself.toolView removeFromSuperview];
        weakself.toolView = nil;
        
        [self.navigationController popViewControllerAnimated:YES];
        [self dismissViewControllerAnimated:YES completion:nil];
    });
}

- (void)cameraTool:(XTCameraTool *)cameraTool warning:(XTMediaWarningCode)warningCode{
    if (warningCode == XTMediaAudioNoPermissions || warningCode == XTMediaVideoNoPermissions) {
        kWeakSelf(self);
        UIAlertController *alertVC = [UIAlertController alertControllerWithTitle:warningCode==XTMediaVideoNoPermissions?kLocalizationMsg(@"需要访问您的相机"):kLocalizationMsg(@"需要访问您的麦克风") message:nil preferredStyle:UIAlertControllerStyleAlert];
        [alertVC addAction:[UIAlertAction actionWithTitle:kLocalizationMsg(@"去设置") style:(UIAlertActionStyleDefault) handler:^(UIAlertAction * _Nonnull action) {
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:UIApplicationOpenSettingsURLString]];
        }]];
        [alertVC addAction:[UIAlertAction actionWithTitle:kLocalizationMsg(@"取消") style:(UIAlertActionStyleCancel) handler:^(UIAlertAction * _Nonnull action) {
            [weakself onDismiss];
        }]];
        [self presentViewController:alertVC animated:YES completion:nil];
    }
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end

