//
//  AgoraVideoSourceObj.m
//  AgoraExtension
//
//  Created by klc_sl on 2020/9/17.
//  Copyright © 2020 . All rights reserved.
//

#import "AgoraVideoSourceObj.h"
#import "MyVidoCapture.h"
#import "AgoraRtcManager.h"

@interface AgoraVideoSourceObj ()<MyVideoCaptureDelegate>

@property (strong, nonatomic) MyVidoCapture *myVidoCapture;

@end


@implementation AgoraVideoSourceObj

@synthesize consumer;

- (void)dealloc
{
    self.myVidoCapture = nil;
    [AgoraManager.beautyCls deatoryBeautyObj];
}

- (instancetype)init
{
    self = [super init];
    if (self) {
    }
    return self;
}

- (BOOL)shouldInitialize {
    return YES;
}

- (MyVidoCapture *)myVidoCapture{
    if (!_myVidoCapture) {
        _myVidoCapture = [[MyVidoCapture alloc] initWithVideoView:nil];
        _myVidoCapture.delegate = self;
    }
    return _myVidoCapture;
}

- (void)shouldStart {
   // NSLog(@"过滤文字开始拍摄"));
    [self.myVidoCapture startCapture:AVCaptureDevicePositionFront];
}

- (void)shouldStop {
   // NSLog(@"过滤文字结束拍摄"));
    [self.myVidoCapture stopCapture];
    self.myVidoCapture.delegate = nil;
    self.myVidoCapture = nil;
}



- (void)shouldDispose {
}

- (AgoraVideoBufferType)bufferType {
    return AgoraVideoBufferTypePixelBuffer;
}

- (AgoraVideoCaptureType)captureType {
    return AgoraVideoCaptureTypeCamera;
}


- (AgoraVideoContentHint)contentHint {
    return AgoraVideoContentHintMotion;
}


#pragma mark - MyVideoCaptureDelegate -
- (void)myVideoCaptureDidOutputSampleBuffer:(CVPixelBufferRef)pixelBuffer Rotation:(int)rotation timeStamp:(CMTime)time isFront:(BOOL)Front{
    
    CVPixelBufferRef outputPixelBuffer = [AgoraManager.beautyCls renderOutputSampleBuffer:pixelBuffer Rotation:rotation isFront:Front];

    outputPixelBuffer?[self.consumer consumePixelBuffer:outputPixelBuffer withTimestamp:time rotation:AgoraVideoRotation90]:nil;
    
}


- (void)switchCamera:(void (^)(BOOL))positionBlock{
    [_myVidoCapture switchCamera:positionBlock];
}


@end
