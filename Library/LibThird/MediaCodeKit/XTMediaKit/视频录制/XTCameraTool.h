//
//  XTCameraTool.h
//  XTMedisKit
//
//  Created by shirley on 2019/6/19.
//  Copyright © 2019 XTY. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSUInteger, XTMediaWarningCode) {
    XTMediaAudioNoError,         ///无错误
    XTMediaVideoNoPermissions,   ///没有获取摄像机权限
    XTMediaAudioNoPermissions,   ///没有获取麦克风权限
};

@class XTCameraTool;
@protocol XTCameraToolDelegate <NSObject>

- (void)cameraTool:(XTCameraTool *)cameraTool warning:(XTMediaWarningCode)warningCode;

@end

@interface XTCameraTool : NSObject


+ (instancetype)new NS_UNAVAILABLE;


@property (nonatomic, weak)id<XTCameraToolDelegate> delegate;

/// 初始化必用方法

///图像显示视图同传入的父视图一样尺寸
- (void)showInView:(UIView *)superView;


///打开摄像头
- (void)startRunning;
///关闭摄像头
- (void)stopRunning;


///设置聚焦点
- (void)setFocusCursorWithPoint:(CGPoint)point focusImage:(UIImage *_Nullable)image;
///打开闪光灯
- (void)turnOnFlash;

- (BOOL)isFrontCamera;
///切换摄像头
- (void)switchCameraAction:(void(^)(BOOL front))handle;



///拍照片
- (void)takePicture:(void(^)(BOOL start))startBlock handle:(void(^)(UIImage *image))handle;



///录制
- (void)startShooting:(void(^)(BOOL start))startBlock;
- (void)stopShooting:(void(^)(NSURL *_Nullable videoUrl, UIImage *_Nullable preview, NSTimeInterval duration))handle;
///取消拍摄
- (void)cancelShooting;


/// 视频转码
/// @param videoUrl 视频地址
/// @param savePath 视频转换后的保存路径
/// @param block  isSuccess:是否成功。   errorCode 0：成功 1:失败 2:取消 3:其他
- (void)conversion:(NSURL *)videoUrl savePath:(NSURL *)savePath finishBlock:(void(^)(BOOL isSuccess, int errorCode))block;






@end

NS_ASSUME_NONNULL_END
