//
//  MyVidoCapture.h
//  OpenLive
//
//  Created by MBP DA1003 on 2020/9/16.
//  Copyright © 2019 Agora. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>

@protocol MyVideoCaptureDelegate <NSObject>

-(void)myVideoCaptureDidOutputSampleBuffer:(CVPixelBufferRef )pixelBuffer Rotation:(int)rotation timeStamp:(CMTime)time isFront:(BOOL)Front;

@end
 
@interface MyVidoCapture : NSObject

@property(nonatomic,weak)id<MyVideoCaptureDelegate>delegate;

-(instancetype)initWithVideoView:(UIView *)videoView;

- (void)startCapture:(AVCaptureDevicePosition)camera;
- (void)stopCapture;


- (void)switchCamera:(void(^)(BOOL isFront))positionBlock;



@end

 
