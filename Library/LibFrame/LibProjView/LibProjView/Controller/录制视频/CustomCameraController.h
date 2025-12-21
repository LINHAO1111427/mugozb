//
//  CustomCameraController.h
//  CustomCamera
//
//  Created by long on 2017/6/26.
//  Copyright © 2017年 long. All rights reserved.
//

#import <UIKit/UIKit.h>

@class CustomCameraController;

typedef NS_ENUM(NSUInteger, CameraFunctionType) {
    CameraFunction_all          =0,   ///全部
    CameraFunction_onlyCamera   =1,   ///只有照相
    CameraFunction_onlyRecord   =2,   ///只有录像
};


@interface CustomCameraController : UIViewController


///录制视频的时间
@property (nonatomic, assign) CFTimeInterval maxRecordTime;

///是否允许选择相册 默认不显示
@property (nonatomic, assign) BOOL showPhotoAlbum;

///录制类型
@property (nonatomic, assign) CameraFunctionType functionType;

///录制前后(默认前置摄像头)
@property (nonatomic, assign) BOOL isFront;

///选择某些照片
- (void)selectPhotoDidComplete:(void(^)(CustomCameraController *cameraVC, NSArray <UIImage *> * images))photoComplete;

///选择一个视频
- (void)selectVideoDidComplete:(void(^)(CustomCameraController *cameraVC, NSURL *videoUrl, UIImage *preview, CGFloat duration))videoComplete;


@end
