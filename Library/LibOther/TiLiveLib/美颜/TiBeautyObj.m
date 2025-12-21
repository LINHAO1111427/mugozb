//
//  TiBeautyObj.m
//  kLiao
//
//  Created by admin on 2019/7/20.
//  Copyright © 2019 cat. All rights reserved.
//

#import "TiBeautyObj.h"
#import "TiUIManager.h"
#import <AgoraExtension/LiveBeautyProtocol.h>
#import <TiSDK/TiSDKInterface.h>
#import "TIMenuPlistManager.h"

@interface XTLiveBeautyView : NSObject<TiUIManagerDelegate>

@property (nonatomic, copy) void (^complete)(void);
@property (nonatomic, strong) UIView *bgView;

+ (instancetype)share;
- (void)destroyBeauty;

@end

static XTLiveBeautyView *_klBeauty = nil;

@implementation XTLiveBeautyView

- (void)dealloc{
    [self destroyBeauty];
    _complete = nil;
}

- (void)destroyBeauty{
    dispatch_async(dispatch_get_main_queue(), ^{
        [[TiUIManager shareManager] destroy];
    });
    _bgView = nil;
    if (_complete) {
        _complete();
    }
    _klBeauty = nil;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
    }
    return self;
}

+ (instancetype)share{
    if (_klBeauty == nil) {
        _klBeauty = [[XTLiveBeautyView alloc] init];
    }
    return _klBeauty;
}

- (void)tiShow:(UIView *)superView complete:(void (^)(void))complete{
    _complete = complete;
    
    UIView *superV = superView;
    if (!superV) {
        superV = [UIApplication sharedApplication].keyWindow;
    }
    _bgView = superV;
    [[TiUIManager shareManager] loadToView:superV forDelegate:self];
    [[TiUIManager shareManager] showMainMenuView];
}

/** * 切换摄像头 */
- (void)didClickSwitchCameraButton{
}

/** * 拍照 */
- (void)didClickCameraCaptureButton{
}

/** * 点击退出手势 */
- (void)didClickOnExitTap{
    [self destroyBeauty];
}


@end



@interface TiBeautyObj () <LiveBeautyProtocol>

@end


@implementation TiBeautyObj

+ (void)initWithTiKey:(NSString *)key{
    //打开日志
    [TiSDK setLog:YES];
    
    [TiSDK init:key CallBack:^(InitStatus status) {
        [[NSNotificationCenter defaultCenter] postNotificationName:@"TiSDKInitStatusNotification" object:nil];
    }];
    ///初始化
    [[TIMenuPlistManager shareManager] initData];
}

///绘制
+ (CVPixelBufferRef)renderOutputSampleBuffer:(CVPixelBufferRef)pixelBuffer Rotation:(int)rotation isFront:(BOOL)Front {
    
    CVPixelBufferRef outputPixelBuffer = pixelBuffer;
    BOOL isMirror = YES;
    
    UIDeviceOrientation iDeviceOrientation = [[UIDevice currentDevice] orientation];
    TiRotationEnum rotationEnum;
    switch (iDeviceOrientation) {
        case UIDeviceOrientationPortrait:
            rotationEnum = CLOCKWISE_90;
            break;
        case UIDeviceOrientationLandscapeLeft:
            rotationEnum = isMirror ? CLOCKWISE_90 : CLOCKWISE_270;
            break;
        case UIDeviceOrientationLandscapeRight:
            rotationEnum = isMirror ? CLOCKWISE_270 : CLOCKWISE_90;
            break;
        case UIDeviceOrientationPortraitUpsideDown:
            rotationEnum = CLOCKWISE_180;
            break;
        default:
            rotationEnum = CLOCKWISE_0;
            break;
    }
    
    CVPixelBufferLockBaseAddress(outputPixelBuffer, 0);
    
    int iWidth = (int)CVPixelBufferGetWidth(outputPixelBuffer);
    int iHeight = (int)CVPixelBufferGetHeight(outputPixelBuffer);
    
    unsigned char *pixels = (unsigned char *)CVPixelBufferGetBaseAddressOfPlane(outputPixelBuffer,0);
    
    [[TiSDKManager shareManager] renderPixels:pixels Format:NV12 Width:iWidth Height:iHeight Rotation:CLOCKWISE_90 Mirror:Front?YES:NO];
    
    CVPixelBufferUnlockBaseAddress(outputPixelBuffer, 0);
    
    return outputPixelBuffer;
    
}


///文件销毁
+ (void)deatoryBeautyObj{
    [[TiSDKManager shareManager] destroy];
    [[XTLiveBeautyView share] destroyBeauty];
}

///显示到某一个视图上
+ (void)showBeautyInView:(UIView *)superV complete:(void (^)(void))complete{
    [[XTLiveBeautyView share] tiShow:superV complete:complete];
}


@end
