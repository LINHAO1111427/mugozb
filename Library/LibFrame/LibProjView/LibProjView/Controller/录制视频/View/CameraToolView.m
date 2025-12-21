//
//  CameraToolView.m
//  TCDemo
//
//  Created by admin on 2019/10/29.
//  Copyright © 2019 CH. All rights reserved.
//

#import "CameraToolView.h"
#import <LibTools/LibTools.h>
#import <LibProjBase/ProjConfig.h>
#import "CircleProgressView.h"
#import <LibProjView/ForceAlertController.h>

#define kTopViewScale 0.5
#define kBottomViewScale .7
#define kAnimateDuration .1

@interface CameraToolView () <CAAnimationDelegate, UIGestureRecognizerDelegate>


/////////////////////////////////////////////////////////////////////////数据
///可拍摄最长时间
@property (nonatomic, assign) CGFloat maxRecordDuration;
///可上传最小视频时间
@property (nonatomic, assign) CGFloat defaultRecordDuration;
///
@property (nonatomic, copy)TimerBlock *timer;
///当前是否为摄像状态
@property (nonatomic, assign)BOOL isVideoRecord;

@property (nonatomic, assign)BOOL isRecording;
/////////////////////////////////////////////////////////////////////////视图
///开始拍摄按钮
@property (nonatomic, weak)UIButton *startBtn;
///拍摄录像切换
@property (nonatomic, weak)UISegmentedControl *segmentC;
///拍摄进度条
@property (nonatomic, weak)CircleProgressView *progressV;
///录制时长显示
@property (nonatomic, weak) UILabel *videoTimeL;
///拍摄底部View
@property (nonatomic, weak) UIView *ShootBgView;
///视频删除按钮
@property (nonatomic, weak)UIButton *videoDeleteBtn;
///视频确认按钮
@property (nonatomic, weak)UIButton *videoSureBtn;
///选择照片按钮
@property (nonatomic, weak, readonly) UIButton *photoBtn;

@end

@implementation CameraToolView

- (instancetype)initWithFrame:(CGRect)frame maxRecordDuration:(CGFloat)max_time
{
    self = [super initWithFrame:frame];
    if (self) {
        _isVideoRecord = NO;
        _timer = [[TimerBlock alloc] init];
        if (max_time < 5.0) {
            max_time = 30.0;
        }
        self.maxRecordDuration = max_time;
        self.defaultRecordDuration = 5.0;//默认最短时间
        self.duration = 0.0;
        [self createShootView];
        
    }
    return self;
}


- (void)setAllowRecordVideo:(BOOL)allowRecordVideo{
    _allowRecordVideo = allowRecordVideo;
    self.segmentC.hidden = !allowRecordVideo;
}

- (void)setAllowSelectPhoto:(BOOL)allowSelectPhoto{
    _allowSelectPhoto = allowSelectPhoto;
    self.photoBtn.hidden = !allowSelectPhoto;
}

- (void)setAllowlightBtn:(BOOL)allowlightBtn{
    _allowlightBtn = allowlightBtn;
    self.lightBtn.userInteractionEnabled = allowlightBtn;
    [self.lightBtn setImage:[UIImage imageNamed:allowlightBtn?@"dynamic_light_click":@"dynamic_light_unclick"] forState:UIControlStateNormal];
}

///创建拍摄视图
- (void)createShootView{
    
    CGFloat selfHeight = self.frame.size.height;
    CGFloat selfWidth = self.frame.size.width;
    
    CGFloat functionBtnW = 40;  //小功能按钮的宽度
    CGFloat functionBtnH = 50;  //小功能按钮的高度
    
    UIView *bgView = [[UIView alloc] initWithFrame:self.bounds];
    [self addSubview:bgView];
    _ShootBgView = bgView;
    
    //进度条
    CGFloat progressW = 70;
    CircleProgressView *progressV = [[CircleProgressView alloc] initWithFrame:CGRectMake((selfWidth-70)/2.0, selfHeight-kSafeAreaBottom-130, progressW, progressW) withRadius:progressW/2.0-5 withLineWidth:4 defaultColor:[UIColor whiteColor]  progressColor:[ProjConfig normalColors]];
    _progressV = progressV;
    [bgView addSubview:_progressV];
    
    //拍摄
    UIButton *startBtn = [UIButton buttonWithType:0];
    startBtn.layer.cornerRadius = 25;
    startBtn.clipsToBounds = YES;
    startBtn.frame = CGRectMake((selfWidth-50)/2.0, selfHeight-kSafeAreaBottom-120, 50, 50);
    [startBtn setBackgroundImage:[UIImage imageWithColor:[ProjConfig normalColors]] forState:UIControlStateNormal];
    [startBtn addTarget:self action:@selector(tapAction:) forControlEvents:UIControlEventTouchUpInside];
    [bgView addSubview:startBtn];
    _startBtn = startBtn;
    
    //选择segment
    UISegmentedControl *segmentV = [[UISegmentedControl alloc] initWithItems:@[kLocalizationMsg(@"拍摄"),kLocalizationMsg(@"视频")]];
    segmentV.selectedSegmentIndex = 0;
    segmentV.frame = CGRectMake((selfWidth-150)/2.0, CGRectGetMinY(startBtn.frame)-60, 150, 30);
    segmentV.tintColor = [ProjConfig normalColors];
    if (kiOS13) {
        segmentV.selectedSegmentTintColor = [ProjConfig normalColors];
    }
    segmentV.layer.masksToBounds = YES;
    segmentV.layer.cornerRadius = 4;
    segmentV.backgroundColor = [UIColor blackColor];
    [segmentV addTarget:self action:@selector(segmentClick:) forControlEvents:UIControlEventValueChanged];
    [segmentV setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor whiteColor]} forState:UIControlStateNormal];
    [segmentV setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor whiteColor]} forState:UIControlStateSelected];
    [bgView addSubview:segmentV];
    _segmentC = segmentV;
    
    
    //退出按钮
    UIButton *dismissBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    dismissBtn.frame = CGRectMake(15, kNavBarHeight-functionBtnH+20, functionBtnW, functionBtnH);
    [dismissBtn setImage:[UIImage imageNamed:@"dynamic_close"] forState:UIControlStateNormal];
    [dismissBtn setTitleColor:[UIColor clearColor] forState:UIControlStateNormal];
    [dismissBtn addTarget:self action:@selector(dismissVC) forControlEvents:UIControlEventTouchUpInside];
    [bgView addSubview:dismissBtn];
    _dismissBtn = dismissBtn;
    
    //上传
    UIButton *photoBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    photoBtn.frame = CGRectMake(0, 0, functionBtnW, functionBtnH);
    photoBtn.titleLabel.font = [UIFont systemFontOfSize:12];
    photoBtn.center = CGPointMake((selfWidth-15-CGRectGetMaxX(startBtn.frame))/2.0+CGRectGetMaxX(startBtn.frame), startBtn.center.y);
    [photoBtn setImage:[UIImage imageNamed:@"dynamic_upload_photo"] forState:UIControlStateNormal];
    [photoBtn setTitle:kLocalizationMsg(@"上传") forState:UIControlStateNormal];
    [photoBtn btnSetUpImgDownForSpace:3];
    [photoBtn addTarget:self action:@selector(selectPhotoAlbum) forControlEvents:UIControlEventTouchUpInside];
    [bgView addSubview:photoBtn];
    _photoBtn = photoBtn;
    
    //翻转摄像头
    UIButton *converBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    converBtn.frame = CGRectMake(selfWidth-functionBtnW-dismissBtn.frame.origin.x, dismissBtn.frame.origin.y, functionBtnW, functionBtnH);
    converBtn.titleLabel.font = [UIFont systemFontOfSize:12];
    [converBtn setImage:[UIImage imageNamed:@"dynamic_coversion_camera"] forState:UIControlStateNormal];
    [converBtn setTitle:kLocalizationMsg(@"翻转") forState:UIControlStateNormal];
    [converBtn btnSetUpImgDownForSpace:3];
    [bgView addSubview:converBtn];
    _converBtn = converBtn;
    
    //闪光灯
    UIButton *lightBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    lightBtn.frame = CGRectMake(converBtn.frame.origin.x,CGRectGetMaxY(converBtn.frame)+20, functionBtnW, functionBtnH);
    lightBtn.titleLabel.font = [UIFont systemFontOfSize:12];
    [lightBtn setImage:[UIImage imageNamed:@"dynamic_light_click"] forState:UIControlStateNormal];
    [lightBtn setTitle:kLocalizationMsg(@"闪光灯") forState:UIControlStateNormal];
    [lightBtn btnSetUpImgDownForSpace:3];
    [bgView addSubview:lightBtn];
    _lightBtn = lightBtn;
    
    //    //美颜
    //    UIButton *beautyBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    //    beautyBtn.frame = CGRectMake(converBtn.frame.origin.x,CGRectGetMaxY(lightBtn.frame)+20, functionBtnW, functionBtnH);
    //    beautyBtn.titleLabel.font = [UIFont systemFontOfSize:12];
    //    [beautyBtn setImage:[UIImage imageNamed:@"dynamic_camera_beauty"] forState:UIControlStateNormal];
    //    [beautyBtn setTitle:kLocalizationMsg(@"美颜") forState:UIControlStateNormal];
    //    [beautyBtn btnSetUpImgDownForSpace:3];
    //    [bgView addSubview:beautyBtn];
    //    _beautyBtn = beautyBtn;
    
    
    //录屏时间
    UILabel *timeLab = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 50, 12)];
    timeLab.text = @"0:00";
    timeLab.font = [UIFont systemFontOfSize:12];
    timeLab.center = startBtn.center;
    timeLab.textAlignment = NSTextAlignmentCenter;
    timeLab.textColor = [UIColor whiteColor];
    timeLab.hidden = YES;
    [bgView addSubview:timeLab];
    _videoTimeL = timeLab;
    
    //删除视频
    UIButton *removeVideoBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    removeVideoBtn.frame = CGRectMake(0,0, functionBtnW, functionBtnW);
    removeVideoBtn.imageEdgeInsets = UIEdgeInsetsMake(6, 6, 6, 6);
    removeVideoBtn.center = CGPointMake((selfWidth-15-CGRectGetMaxX(startBtn.frame))*2.0/3.0+CGRectGetMaxX(startBtn.frame), self.startBtn.center.y);
    [removeVideoBtn setImage:[UIImage imageNamed:@"dynamic_video_delete"] forState:UIControlStateNormal];
    [bgView addSubview:removeVideoBtn];
    removeVideoBtn.hidden = YES;
    [removeVideoBtn addTarget:self action:@selector(retake:) forControlEvents:UIControlEventTouchUpInside];
    _videoDeleteBtn = removeVideoBtn;
    
    //确认发布视频
    UIButton *releaseVideoBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    releaseVideoBtn.frame = CGRectMake(0,0, functionBtnW, functionBtnW);
    releaseVideoBtn.imageEdgeInsets = UIEdgeInsetsMake(6, 6, 6, 6);
    releaseVideoBtn.center = CGPointMake((selfWidth-15-CGRectGetMaxX(startBtn.frame))/3.0+CGRectGetMaxX(startBtn.frame), self.startBtn.center.y);
    [releaseVideoBtn setImage:[UIImage imageNamed:@"dynamic_video_release"] forState:UIControlStateNormal];
    [releaseVideoBtn addTarget:self action:@selector(doneClick:) forControlEvents:UIControlEventTouchUpInside];
    [bgView addSubview:releaseVideoBtn];
    releaseVideoBtn.hidden = YES;
    _videoSureBtn = releaseVideoBtn;
    
    
}

#pragma mark - 照片确认视图
- (void)photoSureView{
    self.ShootBgView.hidden = YES;
    
    UIView *photoSureV = [[UIView alloc] initWithFrame:self.bounds];
    [self addSubview:photoSureV];
    
    //确认按钮
    UIButton *sureBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    sureBtn.frame =  CGRectMake(0, 0, 60, 80);
    sureBtn.centerY = self.photoBtn.centerY+10;
    sureBtn.centerX = photoSureV.width/2.0;
    [sureBtn addTarget:self action:@selector(doneClick:) forControlEvents:UIControlEventTouchUpInside];
    [photoSureV addSubview:sureBtn];
    UIImageView *sureImgV = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 60, 60)];
    sureImgV.image = [UIImage imageNamed:@"dynamic_photo_sure"];
    [sureBtn addSubview:sureImgV];
    UILabel *sureL = [[UILabel alloc] initWithFrame:CGRectMake(0, sureImgV.maxY+4, sureBtn.width, 16)];
    sureL.textAlignment = NSTextAlignmentCenter;
    sureL.text = kLocalizationMsg(@"提交");
    sureL.font = [UIFont systemFontOfSize:14];
    sureL.textColor = [UIColor whiteColor];
    [sureBtn addSubview:sureL];
    
    
    //取消按钮
    UIButton *cancelBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    cancelBtn.frame =  CGRectMake(0, 0, 40, 60);
    cancelBtn.centerY = sureBtn.centerY;
    cancelBtn.centerX = self.photoBtn.centerX;
    [cancelBtn addTarget:self action:@selector(retake:) forControlEvents:UIControlEventTouchUpInside];
    [photoSureV addSubview:cancelBtn];
    UIImageView *cancelImgV = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 40, 40)];
    cancelImgV.image = [UIImage imageNamed:@"dynamic_photo_cancel"];
    [cancelBtn addSubview:cancelImgV];
    UILabel *cancelL = [[UILabel alloc] initWithFrame:CGRectMake(0, cancelImgV.maxY+4, cancelBtn.width, 16)];
    cancelL.textAlignment = NSTextAlignmentCenter;
    cancelL.text = kLocalizationMsg(@"重拍");
    cancelL.font = [UIFont systemFontOfSize:14];
    cancelL.textColor = [UIColor whiteColor];
    [cancelBtn addSubview:cancelL];
    
}

///是否为摄像状态
- (void)viewChangeIsShoot:(BOOL)shoot{
    self.videoTimeL.hidden = !shoot;
//    self.progressV.hidden = !shoot;
    if (_allowSelectPhoto) {
        self.photoBtn.hidden = (shoot && _duration>0)?YES:NO;
    }
    self.videoSureBtn.hidden = ((shoot && (_duration > 0 && _duration>_defaultRecordDuration))?NO:YES);;
    self.videoDeleteBtn.hidden = ((shoot && (_duration > 0))?NO:YES);
}

///是否正在录像
- (void)startRecord:(BOOL)start{
    if (_allowSelectPhoto) {
        _photoBtn.hidden = start;
    }
    _dismissBtn.hidden = start;
    _converBtn.hidden = start;
    _lightBtn.hidden = start;
    _segmentC.hidden = start;
    
    if (self.onlyRecord) {
        _segmentC.hidden = YES;
    }
}

#pragma mark - 动画
- (void)startAnimate
{
    self.isRecording = YES;
    [self startRecord:YES];
    kWeakSelf(self);
    [self.timer startTimerForTotalTime:self.maxRecordDuration IntervalTime:0.01 progress:^(CGFloat progress) {
        weakself.duration = progress;
        weakself.videoTimeL.text = [NSString stringWithFormat:@"%0.02lfs",progress];
        CGFloat rate = progress/weakself.maxRecordDuration;
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            if (progress >= self.defaultRecordDuration) {
                self.videoSureBtn.hidden = NO;
                self.videoDeleteBtn.hidden = NO;
            }
            [weakself.progressV updateProgress:rate];
        });
        [weakself startRecord:YES];
    } finish:^{
        [weakself tapAction:nil];
    }];
}

- (void)stopAnimate:(void (^)(BOOL))handle
{

    ///添加此判断影响关闭录制
    if (self.duration < self.defaultRecordDuration) {
        [SVProgressHUD showInfoWithStatus:kLocalizationMsg(@"正在拍摄，请勿点击")];
        return;
    }
    
    [self.timer stopTimer];
    [self startRecord:NO];
    [self viewChangeIsShoot:YES];
    self.isRecording = NO;
    if (handle) {
        handle(YES);
    }
}


#pragma mark - 点击事件

- (void)segmentClick:(UISegmentedControl *)segment{
    
    BOOL newFunc = segment.selectedSegmentIndex?YES:NO;
    if (_isVideoRecord != newFunc) {
        _isVideoRecord = newFunc;
        [self viewChangeIsShoot:_isVideoRecord];
        ///将数据删除
        if (self.delegate && [self.delegate respondsToSelector:@selector(onRetake)]) {
            [self.delegate performSelector:@selector(onRetake)];
        }
    }
}

- (void)tapAction:(UIButton *)btn
{
    if (_isVideoRecord) {  //1视频
        if (self.duration > 0) {
            if (self.delegate && [self.delegate respondsToSelector:@selector(onFinishRecord)]) {
                [self.delegate performSelector:@selector(onFinishRecord)];
            }
        }else{
            if (self.delegate && [self.delegate respondsToSelector:@selector(onStartRecord)]) {
                [self.delegate performSelector:@selector(onStartRecord)];
            }
        }
    }else{   //拍摄
        if (self.delegate && [self.delegate respondsToSelector:@selector(onTakePicture)]) {
            [self.delegate performSelector:@selector(onTakePicture)];
        }
    }
    
}

- (void)dismissVC
{
    if (self.delegate && [self.delegate respondsToSelector:@selector(onDismiss)]) {
        [self.delegate performSelector:@selector(onDismiss)];
    }
}

- (void)retake:(UIButton *)btn
{
    self.ShootBgView.hidden = NO;
    kWeakSelf(self);
    if (_isVideoRecord) {
        [self.timer stopTimer];
        [self startRecord:NO];
        self.isRecording = NO;
        [self viewChangeIsShoot:YES];
        if (self.delegate && [self.delegate respondsToSelector:@selector(onFinishRecord)]) {
            [self.delegate performSelector:@selector(onFinishRecord)];
        }
        ForceAlertController *alertVC = [ForceAlertController alertTitle:kLocalizationMsg(@"提示") message:kLocalizationMsg(@"确认删除上一段视频")];
        [alertVC addOptions:kLocalizationMsg(@"取消") textColor:ForceAlert_BlackColor clickHandle:nil];
        [alertVC addOptions:kLocalizationMsg(@"确定") textColor:ForceAlert_NormalColor clickHandle:^{
            weakself.duration = 0;
            weakself.videoTimeL.text = @"0.00s";
            [weakself.progressV updateProgress:0.0];
            [weakself viewChangeIsShoot:YES];
            
        }];
        [self.superVc presentViewController:alertVC animated:YES completion:nil];
        
    }else{
        [btn.superview removeFromSuperview];
    }
    if (self.delegate && [self.delegate respondsToSelector:@selector(onRetake)]) {
        [self.delegate performSelector:@selector(onRetake)];
    }
}


- (void)doneClick:(UIButton *)btn
{
    
    if (_isVideoRecord) {
        if (self.isRecording) {
            [self.timer stopTimer];
            [self startRecord:NO];
            [self viewChangeIsShoot:YES];
        }
        if (self.delegate && [self.delegate respondsToSelector:@selector(onVideoOkClickIsRecording:)]) {
            [self.delegate onVideoOkClickIsRecording:self.isRecording];
            self.isRecording = NO;
        }
    }else{
        if (self.delegate && [self.delegate respondsToSelector:@selector(onPhotoOkClick)]) {
            [self.delegate performSelector:@selector(onPhotoOkClick)];
        }
    }
}

- (void)selectPhotoAlbum{
    if (self.delegate && [self.delegate respondsToSelector:@selector(onPhotoAlbum:)]) {
        [self.delegate onPhotoAlbum:_isVideoRecord];
    }
}


-(void)setOnlyRecord:(BOOL)onlyRecord{
    _onlyRecord = onlyRecord;
    if (self.onlyRecord) {
        _segmentC.selectedSegmentIndex = 1;
        [self segmentClick:_segmentC];
        _segmentC.hidden = YES;
        
    }
}

- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event{
    UIView *hitView = [super hitTest:point withEvent:event];
    if (hitView == self) {
        return nil;
    }
    return hitView;
}

@end

