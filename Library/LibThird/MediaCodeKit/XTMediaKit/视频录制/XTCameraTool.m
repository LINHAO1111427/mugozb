//
//  XTCameraTool.m
//  XTMedisKit
//
//  Created by shirley on 2019/6/19.
//  Copyright © 2019 XTY. All rights reserved.
//

#import "XTCameraTool.h"
#import <AVFoundation/AVFoundation.h>
#import <CoreMotion/CoreMotion.h>
#import <AssetsLibrary/AssetsLibrary.h>
#import "VideoConversionCoding.h"
 

@interface XTCameraTool ()<AVCaptureFileOutputRecordingDelegate>

//拍照录视频相关

//AVCaptureSession对象来执行输入设备和输出设备之间的数据传递
@property (nonatomic, strong) AVCaptureSession *session;
//AVCaptureDeviceInput对象是输入流
@property (nonatomic, strong) AVCaptureDeviceInput *videoInput;
//照片输出流对象
@property (nonatomic, strong) AVCaptureStillImageOutput *imageOutPut;
//视频输出流
@property (nonatomic, strong) AVCaptureMovieFileOutput *movieFileOutPut;
//预览图层，显示相机拍摄到的画面
@property (nonatomic, strong) AVCaptureVideoPreviewLayer *previewLayer;
//聚焦图
@property (nonatomic, weak) UIImageView *focusCursorImageView;
///监控设备方向
@property (nonatomic, strong) CMMotionManager *motionManager;

@property (nonatomic, assign) AVCaptureVideoOrientation orientation;
//录制视频保存的url
@property (nonatomic, copy) NSURL *videoUrl;
///图像显示层
@property (nonatomic, weak) UIImageView *showImage;

@property (nonatomic, weak) UIView *superView;

@property (nonatomic, copy) void (^recordingHandle)(NSURL * _Nullable, UIImage * _Nullable, NSTimeInterval);

@end



@implementation XTCameraTool

- (void)dealloc
{
   // NSLog(@"过滤文字 %s 文件销毁"),__func__);
    [_showImage.layer.sublayers makeObjectsPerformSelector:@selector(removeFromSuperlayer)];
    [_showImage removeFromSuperview];
    _showImage = nil;
    if ([_session isRunning]) {
        [_session stopRunning];
    }
    [[AVAudioSession sharedInstance] setActive:NO withOptions:AVAudioSessionSetActiveOptionNotifyOthersOnDeactivation error:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

 

///判断麦克风和相机是否可用
- (BOOL)checkAVAuthorization{
    AVAuthorizationStatus authStatus = [AVCaptureDevice authorizationStatusForMediaType:AVMediaTypeVideo];//读取设备授权状态
    if(authStatus == AVAuthorizationStatusRestricted || authStatus == AVAuthorizationStatusDenied){
       // NSLog(@"过滤文字[XTMediaKit] %zi"),XTMediaVideoNoPermissions);
        if (self.delegate && [self.delegate respondsToSelector:@selector(cameraTool:warning:)]) {
            [self.delegate cameraTool:self warning:XTMediaVideoNoPermissions];
        }
        return NO;
    }else{
        authStatus =  [AVCaptureDevice authorizationStatusForMediaType:AVMediaTypeAudio];
        if (authStatus == AVAuthorizationStatusRestricted || authStatus == AVAuthorizationStatusDenied) {
           // NSLog(@"过滤文字[XTMediaKit] %zi"),XTMediaAudioNoPermissions);
            if (self.delegate && [self.delegate respondsToSelector:@selector(cameraTool:warning:)]) {
                [self.delegate cameraTool:self warning:XTMediaAudioNoPermissions];
            }
            return NO;
        }else{
            if (self.delegate && [self.delegate respondsToSelector:@selector(cameraTool:warning:)]) {
                [self.delegate cameraTool:self warning:XTMediaAudioNoError];
            }
            return YES;
        }
    }
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self setupCamera];
        [self observeDeviceMotion];
        
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(willResignActive) name:UIApplicationWillResignActiveNotification object:nil];
    }
    return self;
}


- (void)showInView:(UIView *)superView{
    _superView = superView;
    self.showImage.frame = superView.bounds;
    self.previewLayer.frame = self.showImage.layer.bounds;
    [self setFocusCursorWithPoint:self.showImage.center focusImage:nil];
}


- (void)startRunning{
    
    [self.session startRunning];
    [self setFocusCursorWithPoint:self.showImage.center focusImage:nil];

    ///判断相机是否有权限
    AVAuthorizationStatus status = [AVCaptureDevice authorizationStatusForMediaType:AVMediaTypeVideo];
    if (status == AVAuthorizationStatusRestricted || status == AVAuthorizationStatusDenied) {
       // NSLog(@"过滤文字[XTMediaKit] %zi"),XTMediaVideoNoPermissions);
        if (self.delegate && [self.delegate respondsToSelector:@selector(cameraTool:warning:)]) {
            [self.delegate cameraTool:self warning:XTMediaVideoNoPermissions];
        }
    }else{
        ///判断语音是否有权限
        status =  [AVCaptureDevice authorizationStatusForMediaType:AVMediaTypeAudio];
        if (status == AVAuthorizationStatusRestricted || status == AVAuthorizationStatusDenied) {
           // NSLog(@"过滤文字[XTMediaKit] %zi"),XTMediaAudioNoPermissions);
            if (self.delegate && [self.delegate respondsToSelector:@selector(cameraTool:warning:)]) {
                [self.delegate cameraTool:self warning:XTMediaAudioNoPermissions];
            }
        }else{
            if (self.delegate && [self.delegate respondsToSelector:@selector(cameraTool:warning:)]) {
                [self.delegate cameraTool:self warning:XTMediaAudioNoError];
            }
        }
    }
}


- (void)stopRunning{
    [self.motionManager stopDeviceMotionUpdates];
    self.motionManager = nil;
    if (self.session) {
        [self.session stopRunning];
    }
    
    [_showImage.layer.sublayers makeObjectsPerformSelector:@selector(removeFromSuperlayer)];
    [_showImage removeFromSuperview];
    _showImage = nil;
}

- (void)willResignActive
{
    if ([self.session isRunning]) {
        ///结束录制
    }
}


- (void)setupCamera
{
    self.session = [[AVCaptureSession alloc] init];
    
    //相机画面输入流
    self.videoInput = [AVCaptureDeviceInput deviceInputWithDevice:[self frontCamera] error:nil];
    
    //照片输出流
    self.imageOutPut = [[AVCaptureStillImageOutput alloc] init];
    //这是输出流的设置参数AVVideoCodecJPEG参数表示以JPEG的图片格式输出图片
    NSDictionary *dicOutputSetting = [NSDictionary dictionaryWithObject:AVVideoCodecJPEG forKey:AVVideoCodecKey];
    [self.imageOutPut setOutputSettings:dicOutputSetting];
    
    //音频输入流
    AVCaptureDevice *audioCaptureDevice = [AVCaptureDevice devicesWithMediaType:AVMediaTypeAudio].firstObject;
    AVCaptureDeviceInput *audioInput = [[AVCaptureDeviceInput alloc] initWithDevice:audioCaptureDevice error:nil];
    
    //视频输出流
    //设置视频格式
    NSString *preset = AVCaptureSessionPreset1280x720;
    if ([self.session canSetSessionPreset:preset]) {
        self.session.sessionPreset = preset;
    } else {
        self.session.sessionPreset = AVCaptureSessionPreset1280x720;
    }
    self.movieFileOutPut = [[AVCaptureMovieFileOutput alloc] init];
    
    //将视频及音频输入流添加到session
    if ([self.session canAddInput:self.videoInput] && self.videoInput) {
        [self.session addInput:self.videoInput];
    }
    if ([self.session canAddInput:audioInput] && audioInput) {
        [self.session addInput:audioInput];
    }
    //将输出流添加到session
    if ([self.session canAddOutput:self.imageOutPut] && self.imageOutPut) {
        [self.session addOutput:self.imageOutPut];
    }
    if ([self.session canAddOutput:self.movieFileOutPut] && self.movieFileOutPut) {
        [self.session addOutput:self.movieFileOutPut];
    }
}



#pragma mark - 监控设备方向
- (void)observeDeviceMotion
{
    self.motionManager = [[CMMotionManager alloc] init];
    // 提供设备运动数据到指定的时间间隔
    self.motionManager.deviceMotionUpdateInterval = .5;
    
    if (self.motionManager.deviceMotionAvailable) {  // 确定是否使用任何可用的态度参考帧来决定设备的运动是否可用
        // 启动设备的运动更新，通过给定的队列向给定的处理程序提供数据。
        [self.motionManager startDeviceMotionUpdatesToQueue:[NSOperationQueue mainQueue] withHandler:^(CMDeviceMotion *motion, NSError *error) {
            [self performSelectorOnMainThread:@selector(handleDeviceMotion:) withObject:motion waitUntilDone:YES];
        }];
    } else {
        self.motionManager = nil;
    }
}

- (void)handleDeviceMotion:(CMDeviceMotion *)deviceMotion
{
    double x = deviceMotion.gravity.x;
    double y = deviceMotion.gravity.y;
    
    if (fabs(y) >= fabs(x)) {
        if (y >= 0){
            // UIDeviceOrientationPortraitUpsideDown;
            self.orientation = AVCaptureVideoOrientationPortraitUpsideDown;
        } else {
            // UIDeviceOrientationPortrait;
            self.orientation = AVCaptureVideoOrientationPortrait;
        }
    } else {
        if (x >= 0) {
            //视频拍照转向，左右和屏幕转向相反
            // UIDeviceOrientationLandscapeRight;
            self.orientation = AVCaptureVideoOrientationLandscapeLeft;
        } else {
            // UIDeviceOrientationLandscapeLeft;
            self.orientation = AVCaptureVideoOrientationLandscapeRight;
        }
    }
}

- (BOOL)isFrontCamera{
    return (self.videoInput.device.position == AVCaptureDevicePositionFront)?YES:NO;
}

- (void)turnOnFlash{
    AVCaptureDevicePosition position = self.videoInput.device.position;
    if (position == AVCaptureDevicePositionBack) {
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            AVCaptureDevice *device = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
            if ([device hasTorch] && [device hasFlash]) {
                [device lockForConfiguration:nil];
            }
            if (device.torchMode == AVCaptureTorchModeOn) {
                [device setTorchMode:AVCaptureTorchModeOff];
            }else{
                [device setTorchMode:AVCaptureTorchModeOn];
            }
            [device unlockForConfiguration];
        });
    } else {
        return;
    }
}

///切换摄像头
- (void)switchCameraAction:(void (^)(BOOL))handle{
    NSUInteger cameraCount = [AVCaptureDevice devicesWithMediaType:AVMediaTypeVideo].count;
    if (cameraCount > 1) {
        NSError *error;
        AVCaptureDeviceInput *newVideoInput;
        AVCaptureDevicePosition position = self.videoInput.device.position;
        if (position == AVCaptureDevicePositionBack) {
            if (handle) {
                handle(YES);
            }
            newVideoInput = [[AVCaptureDeviceInput alloc] initWithDevice:[self frontCamera] error:&error];
        } else if (position == AVCaptureDevicePositionFront) {
            if (handle) {
                handle(NO);
            }
            newVideoInput = [[AVCaptureDeviceInput alloc] initWithDevice:[self backCamera] error:&error];
        } else {
            if (handle) {
                handle(YES);
            }
            return;
        }
        
        if (newVideoInput) {
            [self.session beginConfiguration];
            [self.session removeInput:self.videoInput];
            if ([self.session canAddInput:newVideoInput]) {
                [self.session addInput:newVideoInput];
                self.videoInput = newVideoInput;
            } else {
                [self.session addInput:self.videoInput];
            }
            [self.session commitConfiguration];
        } else if (error) {
           // NSLog(@"过滤文字[XTMediaKit] 切换前后摄像头失败"));
        }
    }
}

- (AVCaptureDevice *)frontCamera {
    return [self cameraWithPosition:AVCaptureDevicePositionFront];
}

- (AVCaptureDevice *)backCamera {
    return [self cameraWithPosition:AVCaptureDevicePositionBack];
}

- (AVCaptureDevice *)cameraWithPosition:(AVCaptureDevicePosition) position {
    NSArray *devices = [AVCaptureDevice devicesWithMediaType:AVMediaTypeVideo];
    for (AVCaptureDevice *device in devices) {
        if ([device position] == position) {
            return device;
        }
    }
    return nil;
}



///拍照片
- (void)takePicture:(void (^)(BOOL))startBlock handle:(void (^)(UIImage * _Nonnull))handle{
    
    if (startBlock) {
        startBlock(YES);
    }
    
    AVCaptureConnection * videoConnection = [self.imageOutPut connectionWithMediaType:AVMediaTypeVideo];
    videoConnection.videoOrientation = self.orientation;
    if (!videoConnection) {
       // NSLog(@"过滤文字[XTMediaKit] take photo failed!"));
        return;
    }
    
    __weak typeof(self) weakSelf = self;
    [self.imageOutPut captureStillImageAsynchronouslyFromConnection:videoConnection completionHandler:^(CMSampleBufferRef imageDataSampleBuffer, NSError *error) {
        if (imageDataSampleBuffer == NULL) {
            return;
        }
        NSData * imageData = [AVCaptureStillImageOutput jpegStillImageNSDataRepresentation:imageDataSampleBuffer];
        UIImage * image = [UIImage imageWithData:imageData];
        if (handle) {
            handle(image);
        }
        [weakSelf.session stopRunning];
    }];
}


///录制
- (void)startShooting:(void (^)(BOOL))startBlock{
    if (startBlock) {
        startBlock(YES);
    }
    AVCaptureConnection *movieConnection = [self.movieFileOutPut connectionWithMediaType:AVMediaTypeVideo];
    movieConnection.videoOrientation = self.orientation;
    [movieConnection setVideoScaleAndCropFactor:1.0];
    if (![self.movieFileOutPut isRecording]) {
        NSURL *url = [self recordingVideo:NO];
        [self.movieFileOutPut startRecordingToOutputFileURL:url recordingDelegate:self];
        
    }
}

- (void)stopShooting:(void (^)(NSURL * _Nullable, UIImage * _Nullable, NSTimeInterval))handle {
    _recordingHandle = handle;
    [self.movieFileOutPut stopRecording];
    [self.session stopRunning];
    [self setVideoZoomFactor:1];
}


- (void)cancelShooting{
    [self.session startRunning];
    [self setFocusCursorWithPoint:self.showImage.center focusImage:nil];
    [self deleteVideo];
}


- (void)deleteVideo
{
    if (self.videoUrl) {
        [[NSFileManager defaultManager] removeItemAtURL:self.videoUrl error:nil];
        self.videoUrl = nil;
    }
}

- (void)conversion:(NSURL *)videoUrl savePath:(NSURL *)savePath finishBlock:(void (^)(BOOL, int))block{
    [VideoConversionCoding conversion:videoUrl savaPath:savePath finishBlock:^(BOOL isSuccess, int errorCode) {
        if (block) {
            block(isSuccess, errorCode);
        }
    }];
}


- (void)setVideoZoomFactor:(CGFloat)zoomFactor
{
    AVCaptureDevice * captureDevice = [self.videoInput device];
    NSError *error = nil;
    [captureDevice lockForConfiguration:&error];
    if (error) return;
    captureDevice.videoZoomFactor = zoomFactor;
    [captureDevice unlockForConfiguration];
}





#pragma mark - 设置聚焦光标位置 -
//设置聚焦光标位置
- (void)setFocusCursorWithPoint:(CGPoint)point focusImage:(UIImage * _Nullable)image
{
    if (!self.session.isRunning) return;
    self.focusCursorImageView.image = image;
    self.focusCursorImageView.center = point;
    self.focusCursorImageView.alpha = 1;
    self.focusCursorImageView.transform = CGAffineTransformMakeScale(1.1, 1.1);
    [UIView animateWithDuration:0.5 animations:^{
        self.focusCursorImageView.transform = CGAffineTransformIdentity;
    } completion:^(BOOL finished) {
        self.focusCursorImageView.alpha=0;
    }];
    
    //将UI坐标转化为摄像头坐标
    CGPoint cameraPoint = [self.previewLayer captureDevicePointOfInterestForPoint:point];
    [self focusWithMode:AVCaptureFocusModeAutoFocus exposureMode:AVCaptureExposureModeAutoExpose atPoint:cameraPoint];
}

//设置聚焦点
- (void)focusWithMode:(AVCaptureFocusMode)focusMode exposureMode:(AVCaptureExposureMode)exposureMode atPoint:(CGPoint)point
{
    AVCaptureDevice * captureDevice = [self.videoInput device];
    NSError * error;
    //注意改变设备属性前一定要首先调用lockForConfiguration:调用完之后使用unlockForConfiguration方法解锁
    if (![captureDevice lockForConfiguration:&error]) {
        return;
    }
    //聚焦模式
    if ([captureDevice isFocusModeSupported:focusMode]) {
        [captureDevice setFocusMode:AVCaptureFocusModeAutoFocus];
    }
    //聚焦点
    if ([captureDevice isFocusPointOfInterestSupported]) {
        [captureDevice setFocusPointOfInterest:point];
    }
    //曝光模式
    //    if ([captureDevice isExposureModeSupported:exposureMode]) {
    //        [captureDevice setExposureMode:AVCaptureExposureModeAutoExpose];
    //    }
    //    //曝光点
    //    if ([captureDevice isExposurePointOfInterestSupported]) {
    //        [captureDevice setExposurePointOfInterest:point];
    //    }
    [captureDevice unlockForConfiguration];
}



#pragma mark - AVCaptureFileOutputRecordingDelegate
- (void)captureOutput:(AVCaptureFileOutput *)output didStartRecordingToOutputFileAtURL:(NSURL *)fileURL fromConnections:(NSArray<AVCaptureConnection *> *)connections
{
    //    [self.toolView startAnimate];
}

- (void)captureOutput:(AVCaptureFileOutput *)output didFinishRecordingToOutputFileAtURL:(NSURL *)outputFileURL fromConnections:(NSArray<AVCaptureConnection *> *)connections error:(NSError *)error
{
    if (CMTimeGetSeconds(output.recordedDuration) < 0.5) {
        //视频长度小于1s 则拍照
        if (_recordingHandle) {
            _recordingHandle(nil, nil, 0);
        }
        return;
    }
    ///获取首页相册
    AVURLAsset *asset = [[AVURLAsset alloc] initWithURL:outputFileURL options:nil];
    AVAssetImageGenerator *gen = [[AVAssetImageGenerator alloc] initWithAsset:asset];
    gen.appliesPreferredTrackTransform = YES;
    CMTime time = CMTimeMakeWithSeconds(0.0, 600);
    CMTime actualTime;
    CGImageRef image = [gen copyCGImageAtTime:time actualTime:&actualTime error:nil];
    UIImage *img = [[UIImage alloc] initWithCGImage:image];
    CGImageRelease(image);
    
    CMTime timesdfsdf = output.recordedDuration;
    NSTimeInterval times = timesdfsdf.value/(timesdfsdf.timescale/1000.0);
    
    if (_recordingHandle) {
        _videoUrl = outputFileURL;
        _recordingHandle(outputFileURL, img, times);
    }
    
}




#pragma mark - private -

- (UIImageView *)showImage{
    if (!_showImage) {
        UIImageView *imageV = [[UIImageView alloc] initWithFrame:self.superView.bounds];
        imageV.contentMode = UIViewContentModeScaleAspectFill;
        imageV.backgroundColor = [UIColor blackColor];
        [imageV.layer setMasksToBounds:YES];
        [self.superView addSubview:imageV];
        [self.superView sendSubviewToBack:imageV];
        _showImage = imageV;
    }
    return _showImage;
}

- (AVCaptureVideoPreviewLayer *)previewLayer{
    if (!_previewLayer) {
        //预览层
        _previewLayer = [[AVCaptureVideoPreviewLayer alloc] initWithSession:self.session];
        [_previewLayer setVideoGravity:AVLayerVideoGravityResizeAspectFill];
        [self.showImage.layer insertSublayer:_previewLayer atIndex:0];
    }
    return _previewLayer;
}

- (UIImageView *)focusCursorImageView{
    if (!_focusCursorImageView) {
        UIImageView *focusCursorImageView = [[UIImageView alloc] init];
        focusCursorImageView.contentMode = UIViewContentModeScaleAspectFit;
        focusCursorImageView.clipsToBounds = YES;
        focusCursorImageView.frame = CGRectMake(0, 0, 80, 80);
        focusCursorImageView.alpha = 0;
        [self.superView addSubview:focusCursorImageView];
        _focusCursorImageView = focusCursorImageView;
    }
    return _focusCursorImageView;
}


- (NSURL *)recordingVideo:(BOOL)isMp4{
    NSString *filePath = [NSTemporaryDirectory() stringByAppendingString:[NSString stringWithFormat:@"%@.%@", [XTCameraTool getUniqueStrByUUID],isMp4?@"mp4":@"mov"]];
    return [NSURL fileURLWithPath:filePath];
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
