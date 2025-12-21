//
//  MyVidoCapture.m
//  OpenLive
//
//  Created by MBP DA1003 on 2020/9/16.
//  Copyright © 2019 Agora. All rights reserved.
//

#import "MyVidoCapture.h"

@interface MyVidoCapture ()<AVCaptureVideoDataOutputSampleBufferDelegate>


@property(nonatomic,strong)UIView *myVideoView;
@property(nonatomic,assign) AVCaptureDevicePosition currentCamera;
@property (nonatomic, strong) AVCaptureSession *captureSession;
@property (nonatomic, strong) AVCaptureVideoDataOutput *currentOutput;
@property (nonatomic, strong, nullable) dispatch_queue_t captureQueue;

@property(nonatomic,strong) AVCaptureVideoPreviewLayer *previewLayer;

@end

@implementation MyVidoCapture




-(instancetype)initWithVideoView:(UIView * )videoView{
    if (self = [super init]) {
        self.myVideoView = videoView;
        
        self.captureQueue = dispatch_queue_create("MyVidoCaptureQueue", NULL);
        
        self.currentCamera = AVCaptureDevicePositionFront;
        
        self.captureSession = [[AVCaptureSession alloc] init];
        self.captureSession.usesApplicationAudioSession = false;
        
        self.currentOutput = [[AVCaptureVideoDataOutput alloc] init];
        [self.currentOutput setAlwaysDiscardsLateVideoFrames:true];
        [self.currentOutput setVideoSettings:@{(id)kCVPixelBufferPixelFormatTypeKey: @(kCVPixelFormatType_420YpCbCr8BiPlanarFullRange)}]; // 设置视频帧格式
        [self.currentOutput setSampleBufferDelegate:self queue:self.captureQueue];
        
        if ([self.captureSession canAddOutput:self.currentOutput]) {
            [self.captureSession addOutput:self.currentOutput];
        }
        //        AVCaptureVideoPreviewLayer *layer = [AVCaptureVideoPreviewLayer layerWithSession:self.captureSession];
        //        [self.previewLayer removeFromSuperlayer];
        //        layer.frame = videoView.bounds;
        //        [videoView.layer insertSublayer:layer below:videoView.layer.sublayers.firstObject];
        //        self.previewLayer = layer;
        
    }
    return self;
}

-(void)startCapture:(AVCaptureDevicePosition)camera{
    _currentCamera = camera;
    // 异步串行队列
    __weak __typeof(self) weakSelf = self;
    dispatch_async(_captureQueue, ^{
        
        [self changeCaptureDevice:camera toCaptureSession:weakSelf.captureSession];
        
        [weakSelf.captureSession beginConfiguration];
        
        if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone)
        {
            [weakSelf.captureSession setSessionPreset:AVCaptureSessionPreset1280x720]; // 设置视频帧尺寸
        }
        else
        {
            [weakSelf.captureSession setSessionPreset:AVCaptureSessionPresetPhoto];
        }
        [weakSelf.captureSession commitConfiguration];
        
        [weakSelf.captureSession startRunning];
        
    });
    
}

-(void)stopCapture{
    __weak typeof(self) weakself = self;
    dispatch_async(weakself.captureQueue, ^{
        [weakself.captureSession stopRunning];
    });
}

- (void)switchCamera:(void (^)(BOOL))positionBlock {
    [self stopCapture];
    if (self.currentCamera == AVCaptureDevicePositionFront) {
        self.currentCamera = AVCaptureDevicePositionBack;
    } else{
        self.currentCamera = AVCaptureDevicePositionFront;
    }
    [self startCapture:self.currentCamera];
    if (positionBlock) {
        positionBlock((self.currentCamera == AVCaptureDevicePositionFront)?YES:NO);
    }
}


-(void)changeCaptureDevice:(AVCaptureDevicePosition)camera toCaptureSession:(AVCaptureSession *)captureSession{
    
    AVCaptureDevice  *captureDevice = [self cameraWithPosition:camera];
    
    NSArray *currentInputs =  captureSession.inputs;
    AVCaptureDeviceInput *input = currentInputs.firstObject;
    if (input.device.localizedName == captureDevice.uniqueID) {
        return;
    }
    
    AVCaptureDeviceInput *newInput = [AVCaptureDeviceInput deviceInputWithDevice:captureDevice error:nil];
    if(!newInput){return;}
    
    [captureSession beginConfiguration];
    
    [captureSession removeInput:input];
    [captureSession addInput:newInput];
    
    [captureSession commitConfiguration];
    
    
    
}

- (AVCaptureDevice *)cameraWithPosition:(AVCaptureDevicePosition)position {
    NSArray *devices = [AVCaptureDevice devicesWithMediaType:AVMediaTypeVideo];
    for ( AVCaptureDevice *device in devices )
        if ( device.position == position )
            return device;
    return nil;
}


// 视频帧回调函数
- (void)captureOutput:(AVCaptureOutput *)captureOutput didOutputSampleBuffer:(CMSampleBufferRef)sampleBuffer fromConnection:(AVCaptureConnection *)connection {
    
    CVPixelBufferRef pixelBuffer = (CVPixelBufferRef)CMSampleBufferGetImageBuffer(sampleBuffer);
    if(!pixelBuffer){
        return;
    }
    CMTime time = CMSampleBufferGetPresentationTimeStamp(sampleBuffer);
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(myVideoCaptureDidOutputSampleBuffer:Rotation:timeStamp:isFront:)]) {
        [self.delegate myVideoCaptureDidOutputSampleBuffer:pixelBuffer Rotation:90 timeStamp:time isFront:(self.currentCamera == AVCaptureDevicePositionBack)?NO:YES];
    }
}

- (void)dealloc
{
    self.myVideoView = nil;
    self.captureSession = nil;
    self.currentOutput = nil;
}



@end




