//
//  VideoBeautyInterface.h
//  AgoraExtension
//
//  Created by shirley on 2020/3/16.
//  Copyright © 2020 . All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@protocol LiveBeautyProtocol <NSObject>


///显示到某一个视图上
+ (void)showBeautyInView:(UIView *)superV complete:(void (^)(void))complete;


///绘制
+ (CVPixelBufferRef)renderOutputSampleBuffer:(CVPixelBufferRef)pixelBuffer Rotation:(int)rotation isFront:(BOOL)Front;



///文件销毁
+ (void)deatoryBeautyObj;


@end

NS_ASSUME_NONNULL_END
