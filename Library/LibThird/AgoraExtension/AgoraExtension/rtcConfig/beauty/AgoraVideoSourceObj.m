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
@property (nonatomic, assign) BOOL isCapturing;

@end

@implementation AgoraVideoSourceObj

- (void)dealloc {
    [self stopCapture];
    [AgoraManager.beautyCls deatoryBeautyObj];
}

- (MyVidoCapture *)myVidoCapture {
    if (!_myVidoCapture) {
        _myVidoCapture = [[MyVidoCapture alloc] initWithVideoView:nil];
        _myVidoCapture.delegate = self;
    }
    return _myVidoCapture;
}

- (void)startCapture {
    if (self.isCapturing) {
        return;
    }
    self.isCapturing = YES;
    [AgoraManager.rtcEngine setVideoSourceType:ByteRTCVideoSourceTypeExternal WithStreamIndex:ByteRTCStreamIndexMain];
    [AgoraManager.rtcEngine stopVideoCapture];

    AVCaptureDevicePosition position = (AgoraManager.currentCameraId == ByteRTCCameraIDBack)
        ? AVCaptureDevicePositionBack
        : AVCaptureDevicePositionFront;
    [self.myVidoCapture startCapture:position];
}

- (void)stopCapture {
    if (!self.isCapturing) {
        return;
    }
    self.isCapturing = NO;
    [self.myVidoCapture stopCapture];
    self.myVidoCapture.delegate = nil;
    self.myVidoCapture = nil;
    [AgoraManager.rtcEngine setVideoSourceType:ByteRTCVideoSourceTypeInternal WithStreamIndex:ByteRTCStreamIndexMain];
}

- (ByteRTCVideoRotation)rotationForValue:(int)rotation {
    switch (rotation) {
        case 90:
            return ByteRTCVideoRotation90;
        case 180:
            return ByteRTCVideoRotation180;
        case 270:
            return ByteRTCVideoRotation270;
        default:
            return ByteRTCVideoRotation0;
    }
}

#pragma mark - MyVideoCaptureDelegate
- (void)myVideoCaptureDidOutputSampleBuffer:(CVPixelBufferRef)pixelBuffer Rotation:(int)rotation timeStamp:(CMTime)time isFront:(BOOL)Front {
    CVPixelBufferRef outputPixelBuffer = [AgoraManager.beautyCls renderOutputSampleBuffer:pixelBuffer Rotation:rotation isFront:Front];
    CVPixelBufferRef finalBuffer = outputPixelBuffer ? outputPixelBuffer : pixelBuffer;
    ByteRTCVideoRotation rtcRotation = [self rotationForValue:rotation];
    [AgoraManager.rtcEngine pushExternalVideoFrame:finalBuffer time:time rotation:rtcRotation];
}

- (void)switchCamera:(void (^)(BOOL))positionBlock {
    [self.myVidoCapture switchCamera:^(BOOL isFront) {
        AgoraManager.currentCameraId = isFront ? ByteRTCCameraIDFront : ByteRTCCameraIDBack;
        ByteRTCMirrorType mirrorType = isFront ? ByteRTCMirrorTypeRender : ByteRTCMirrorTypeNone;
        [AgoraManager.rtcEngine setLocalVideoMirrorType:mirrorType];
        if (positionBlock) {
            positionBlock(isFront);
        }
    }];
}

@end
