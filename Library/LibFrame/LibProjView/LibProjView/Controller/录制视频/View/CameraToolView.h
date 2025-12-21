//
//  CameraToolView.h
//  TCDemo
//
//  Created by admin on 2019/10/29.
//  Copyright © 2019 CH. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@protocol CameraToolViewDelegate <NSObject>

/**
 单击事件，拍照
 */
- (void)onTakePicture;
/**
 开始录制
 */
- (void)onStartRecord;
/**
 结束录制
 */
- (void)onFinishRecord;
/**
 选择相册
*/
- (void)onPhotoAlbum:(BOOL)isVideo;
/**
 重新拍照或录制
 */
- (void)onRetake;
/**
 照片确定
 */
- (void)onPhotoOkClick;
/**
 视频确定
*/
- (void)onVideoOkClickIsRecording:(BOOL)isRecording;
/**
 退出
 */
- (void)onDismiss;

@end




@interface CameraToolView : UIView
 
@property (nonatomic, weak) id<CameraToolViewDelegate> delegate;
///是否允许录屏
@property (nonatomic, assign) BOOL allowRecordVideo;
///是否允许选择上传照片
@property (nonatomic, assign) BOOL allowSelectPhoto;
///是否允许点击闪光灯
@property (nonatomic, assign) BOOL allowlightBtn;
///转换摄像头
@property (nonatomic, weak, readonly) UIButton *converBtn;
///闪光灯
@property (nonatomic, weak, readonly) UIButton *lightBtn;
///美颜
@property (nonatomic, weak, readonly) UIButton *beautyBtn;
///关闭退出
@property (nonatomic, weak, readonly) UIButton *dismissBtn;

@property (nonatomic, strong) UIViewController *superVc;
///拍摄时长
@property (nonatomic, assign)CGFloat duration;

///是否只有录制视频
@property(nonatomic, assign) BOOL onlyRecord;


- (instancetype)init DEPRECATED_MSG_ATTRIBUTE("Please user initWithFrame:maxRecordDuration:");
- (instancetype)initWithFrame:(CGRect)frame DEPRECATED_MSG_ATTRIBUTE("Please user initWithFrame:maxRecordDuration:");


- (instancetype)initWithFrame:(CGRect)frame maxRecordDuration:(CGFloat)max_time;
- (void)startAnimate;
- (void)stopAnimate:(void(^)(BOOL success))handle;


///拍照成功
- (void)photoSureView;

@end

NS_ASSUME_NONNULL_END
