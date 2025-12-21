//
//  CAuthorityVideoRecordVc.m
//  MineCenter
//
//  Created by ssssssss on 2020/11/30.
//  Copyright © 2020 KLC. All rights reserved.
//

#import "CAuthorityVideoRecordVc.h"
#import "VertifyVideoPlayerView.h"
#import "VertifyVideoRecordProgressView.h"
#import <XTMediaKit/XTCameraTool.h>
#import <LibProjModel/AnchorAuthVOModel.h>
#import <LibProjModel/HttpApiAnchorAuthenticationController.h>
 
static const CGFloat KTimerInterval = 0.02;  //进度条timer

@interface CAuthorityVideoRecordVc ()<XTCameraToolDelegate>

@property (nonatomic, strong)AnchorAuthVOModel *authModel;

@property (nonatomic, strong) UIView *recordBtn;
@property (nonatomic, strong)UIButton *startVideoBtn;//开始按钮
@property (nonatomic, strong) UIView *recordBackView;
@property (nonatomic, weak) UIView *contentView;
@property(nonatomic, strong) UILabel *tipLabel;

@property (nonatomic, weak) VertifyVideoPlayerView *playView;

@property (nonatomic, strong) VertifyVideoRecordProgressView *progressView;//进度条
@property (nonatomic, strong) NSURL *recordVideoOutPutUrl;
@property (nonatomic, strong) NSTimer *timer;
@property (nonatomic, assign) CGFloat recordTime;//录制时间
@property (nonatomic, strong) UIImage *videoPreviewImage;
@property (nonatomic, copy) XTCameraTool *cameraTool;

@end

@implementation CAuthorityVideoRecordVc

- (instancetype)initWith:(AnchorAuthVOModel *)authModel{
    self = [super init];
    if (self) {
        self.authModel = authModel;
        self.modalPresentationStyle = UIModalPresentationFullScreen;
    }
    return self;
}

- (void)dealloc{
   // NSLog(@"过滤文字%s"),__func__);
}

- (UIBarButtonItem *)rt_customBackItemWithTarget:(id)target action:(SEL)action{
    [BaseNavBarItem navbar:self bgImage:[UIImage imageWithColor:[UIColor whiteColor]] foregroundColor:[UIColor blackColor]];
    return [[UIBarButtonItem alloc] initWithCustomView:[BaseNavBarItem navBackBtnImage:[UIImage imageNamed:@"main_navbar_back_black"] target:self action:@selector(backBtnClick)]];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationController.navigationBarHidden = NO;
    self.navigationItem.title = kLocalizationMsg(@"视频认证");
    self.navigationController.navigationBar.translucent = NO;
    
    self.view.backgroundColor = [UIColor blackColor];
    
    UIView *contentView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight-kNavBarHeight)];
    [self.view addSubview:contentView];
    _contentView = contentView;
    [_contentView addSubview:self.recordBackView];//半透明背景
    [_contentView addSubview:self.progressView];//进度条
    [_contentView addSubview:self.recordBtn];//录制按钮
    [_contentView bringSubviewToFront:_recordBtn];

    [self createTipView];
}


////显示提示文字
- (void)createTipView{
    
    UIView *tipV = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 30)];
    tipV.backgroundColor = kRGB_COLOR(@"#333333");
    [self.view addSubview:tipV];
    [tipV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.equalTo(self.view);
    }];
    UILabel *tipTitleL = [[UILabel alloc] init];
    tipTitleL.text = [[ProjConfig shareInstence].baseConfig userAuthShowString];
    tipTitleL.textColor = [UIColor whiteColor];
    tipTitleL.numberOfLines = 0;
    tipTitleL.font = [UIFont systemFontOfSize:14];
    [tipV addSubview:tipTitleL];
    [tipTitleL mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(tipV).offset(10);
        make.right.equalTo(tipV).offset(-10);
        make.top.equalTo(tipV).offset(8);
        make.bottom.equalTo(tipV).offset(-8);
    }];
}


- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [UIApplication sharedApplication].statusBarHidden = YES;
    [self.cameraTool startRunning];
}


- (XTCameraTool *)cameraTool{
    if (!_cameraTool) {
        ///视图
        _cameraTool = [[XTCameraTool alloc] init];
        _cameraTool.delegate = self;
        [_cameraTool showInView:self.view];
    }
    return _cameraTool;
}


- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    [UIApplication sharedApplication].statusBarHidden = YES;
    [self.cameraTool startRunning];
}

- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
    [UIApplication sharedApplication].statusBarHidden = NO;
}


- (UIInterfaceOrientationMask)supportedInterfaceOrientations
{
    return UIInterfaceOrientationMaskPortrait;
}


#pragma mark - 点击屏幕设置聚焦点
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    CGPoint point = [touches.anyObject locationInView:self.view];
    if (point.y > [UIScreen mainScreen].bounds.size.height-150-kSafeAreaBottom) {
        return;
    }
    [self.cameraTool setFocusCursorWithPoint:point focusImage:[UIImage imageNamed:@"dynamic_camera_focus"]];
}


//dismiss
- (void)onDismiss
{
    kWeakSelf(self);
    dispatch_async(dispatch_get_main_queue(), ^{
        [weakself.cameraTool stopRunning];
        weakself.cameraTool = nil;
        [weakself.contentView removeFromSuperview];
        weakself.contentView = nil;
        [self.navigationController popViewControllerAnimated:YES];
        [self dismissViewControllerAnimated:YES completion:nil];
    });
}

#pragma mark  --计时器相关--
- (NSTimer *)timer{
    if (!_timer){
        _timer = [NSTimer scheduledTimerWithTimeInterval:KTimerInterval target:self selector:@selector(fire:) userInfo:nil repeats:YES];
    }
    return _timer;
}

- (void)fire:(NSTimer *)timer{
    
    self.recordTime += KTimerInterval;
    CGFloat authTime = [[ProjConfig shareInstence].baseConfig userAuthTime];
    self.progressView.totolProgress = authTime;
    self.progressView.progress = self.recordTime;
    
    self.tipLabel.text = [NSString stringWithFormat:@"%.2fs",self.recordTime];
    
    if(self.recordTime >= authTime){
        [self stopRecord];
        [self stopTimer];
    }
}

- (void)startTimer{
    [self.timer invalidate];
    self.timer = nil;
    self.recordTime = 0;
    [self.timer fire];
}

- (void)stopTimer{
    [self.timer invalidate];
    self.timer = nil;
}


#pragma mark - 点击事件

- (void)backBtnClick{
    self.recordTime = 0;
    [self.cameraTool cancelShooting];
    [_playView removeFromSuperview];
    [self onDismiss];
}


#pragma mark - 开始录制
- (void)startRecordClick:(UIButton *)btn{
    kWeakSelf(self);
    if (self.recordTime <= 0) {
        [self.cameraTool startShooting:^(BOOL start) {
            if (start) {
                weakself.tipLabel.textColor =[ProjConfig normalColors];
                weakself.recordVideoOutPutUrl = nil;
                [weakself startRecordAnimate];
                CGRect rect = weakself.progressView.frame;
                rect.size = CGSizeMake(weakself.recordBackView.size.width, weakself.recordBackView.size.height);
                rect.origin = CGPointMake(weakself.recordBackView.origin.x, weakself.recordBackView.origin.y);
                weakself.progressView.frame = weakself.recordBackView.frame;
            }
        }];
    }
}

- (void)startRecordAnimate{
    [self startTimer];
    [self.startVideoBtn setBackgroundImage:[UIImage imageWithColor:[UIColor whiteColor]] forState:UIControlStateNormal];
}

#pragma mark - 停止录制
- (void)stopRecord{
    kWeakSelf(self);
    [weakself.cameraTool stopShooting:^(NSURL * _Nullable videoUrl, UIImage * _Nullable preview, NSTimeInterval duration) {
        if (duration > 0) {
            weakself.recordVideoOutPutUrl = videoUrl;
            weakself.videoPreviewImage = preview;
            weakself.recordTime = duration;
            weakself.tipLabel.text = kLocalizationMsg(@"提交");
            dispatch_async(dispatch_get_main_queue(), ^{
                [weakself showVedio:videoUrl];
            });
        }
    }];;
}


#pragma mark - 录制结束循环播放视频
- (void)showVedio:(NSURL *)playUrl{
    kWeakSelf(self);
    VertifyVideoPlayerView *playView= [[VertifyVideoPlayerView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight-kNavBarHeight)];
    playView.backgroundColor = [UIColor clearColor];
    [_contentView addSubview:playView];
    [_contentView insertSubview:playView aboveSubview:_contentView];
    _playView = playView;
    playView.playUrl = playUrl;
    __weak typeof(self) instance = self;
    playView.confirmBlock = ^{
        if (!instance.recordVideoOutPutUrl) {
            return ;
        }
        [weakself videoConversion];
    };
    
    playView.remakeBlock = ^{
        weakself.tipLabel.textColor = [ProjConfig normalColors];
        [weakself.progressView setProgress:0];
        [instance clickCancel];
        [instance clearVideo];
    };
}

- (void)videoConversion{
    //  mp4转码
    if (self.recordVideoOutPutUrl) {
        [SVProgressHUD showWithStatus:kLocalizationMsg(@"视频转码中")];
        NSURL *mp4Url = [ProjectCache recordingVideo:YES];
        kWeakSelf(self);
        [self.cameraTool conversion:self.recordVideoOutPutUrl savePath:mp4Url finishBlock:^(BOOL isSuccess, int errorCode) {
            [SVProgressHUD dismiss];
            ///errorCode 0：成功 1:失败 2:取消 3:其他
            if (isSuccess) {
                [weakself uploadVideoWithFile:mp4Url preview:weakself.videoPreviewImage];
            }else{
                switch (errorCode) {
                    case 1:
                        [SVProgressHUD showInfoWithStatus:kLocalizationMsg(@"转换失败")];
                        break;
                    case 2:
                        [SVProgressHUD showInfoWithStatus:kLocalizationMsg(@"转换取消")];
                        break;
                    case 3:
                        [SVProgressHUD showInfoWithStatus:kLocalizationMsg(@"转换错误")];
                        break;
                    default:
                        [SVProgressHUD showInfoWithStatus:kLocalizationMsg(@"转换完成")];
                        break;
                }
                
            }
        }];
    }
}
//上传视频
- (void)uploadVideoWithFile:(NSURL*)fileUrl preview:(UIImage *)previewImage{
    kWeakSelf(self);
    [SkyDriveTool uploadFileFromScene:1 filePath:[fileUrl path] complete:^(BOOL success, NSString * _Nonnull url) {
        [SVProgressHUD dismiss];
        if (success) {
             //请求接口
            [weakself clearVideo:fileUrl];
            weakself.authModel.videoAuth = url;
            [weakself updateInfo];
        }else{
            [SVProgressHUD showInfoWithStatus:kLocalizationMsg(@"上传失败")];
        }
    } progress:^(CGFloat uploadProgress) {
        [SVProgressHUD showProgress:uploadProgress];
    }];
}
- (void)updateInfo{
    if (self.authModel) {
        kWeakSelf(self);
        [HttpApiAnchorAuthenticationController authUpdate:self.authModel callback:^(int code, NSString *strMsg, HttpNoneModel *model) {
            if (code == 1) {
                dispatch_async(dispatch_get_main_queue(), ^{
                    if (weakself.completionBlock) {
                        weakself.completionBlock(weakself.authModel);
                    }
                    [weakself onDismiss];
                });
            }else{
                [SVProgressHUD showInfoWithStatus:strMsg];
            }
        }];
    }
}
//清理本地视频
- (void)clearVideo:(NSURL *)url{
    if ( [[NSFileManager defaultManager] fileExistsAtPath:[url path]]) {
        BOOL success =  [[NSFileManager defaultManager]removeItemAtPath:[url path] error:nil];
        if (success) {
           // NSLog(@"过滤文字删除成功"));
        }else{
           // NSLog(@"过滤文字删除失败"));
        }
    }
}
- (void)clearVideo{
    self.recordTime = 0;
    self.recordVideoOutPutUrl = nil;
    [self.cameraTool cancelShooting];
}


#pragma mark - 取消录制的视频
- (void)clickCancel{
    self.recordTime = 0;
    self.recordBtn.transform = CGAffineTransformMakeScale(1, 1);
    self.recordBackView.transform = CGAffineTransformMakeScale(1, 1);
    [self.cameraTool cancelShooting];
    self.tipLabel.text = kLocalizationMsg(@"开始");
}


- (void)cameraTool:(XTCameraTool *)cameraTool warning:(XTMediaWarningCode)warningCode{
    if (warningCode == XTMediaAudioNoPermissions || warningCode == XTMediaVideoNoPermissions) {
        kWeakSelf(self);
        UIAlertController *alertVC = [UIAlertController alertControllerWithTitle:warningCode==XTMediaVideoNoPermissions?kLocalizationMsg(@"需要访问您的相机"):kLocalizationMsg(@"需要访问您的麦克风") message:nil preferredStyle:UIAlertControllerStyleAlert];
        [alertVC addAction:[UIAlertAction actionWithTitle:kLocalizationMsg(@"去设置") style:(UIAlertActionStyleDefault) handler:^(UIAlertAction * _Nonnull action) {
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:UIApplicationOpenSettingsURLString]];
        }]];
        [alertVC addAction:[UIAlertAction actionWithTitle:kLocalizationMsg(@"取消") style:(UIAlertActionStyleCancel) handler:^(UIAlertAction * _Nonnull action) {
            [weakself onDismiss];
        }]];
        [self presentViewController:alertVC animated:YES completion:nil];
    }
}
 
#pragma mark - lazy
- (UILabel *)tipLabel{
    if (!_tipLabel) {
        CGFloat deta = [UIScreen mainScreen].bounds.size.width/375;
        CGFloat width = 60.0*deta;
        _tipLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, (width-20)/2.0, width, 20)];
        _tipLabel.textColor = [UIColor whiteColor];
        _tipLabel.textAlignment = NSTextAlignmentCenter;
        _tipLabel.font = [UIFont boldSystemFontOfSize:14];
        _tipLabel.text  = kLocalizationMsg(@"开始");
    }
    return _tipLabel;
}

- (VertifyVideoRecordProgressView *)progressView{
    if (!_progressView) {
        _progressView = [[VertifyVideoRecordProgressView alloc] initWithFrame:self.recordBackView.frame];
    }
    return _progressView;
}

- (UIView *)recordBackView{
    if (!_recordBackView) {
        CGRect rect = self.recordBtn.frame;
        CGFloat gap = 7.5;
        rect.size = CGSizeMake(rect.size.width + gap*2, rect.size.height + gap*2);
        rect.origin = CGPointMake(rect.origin.x - gap, rect.origin.y - gap);
        _recordBackView = [[UIView alloc]initWithFrame:rect];
        _recordBackView.backgroundColor = kRGBA_COLOR(@"#FFFFFF",1.0);
        _recordBackView.alpha = 0.6;
        _recordBackView.clipsToBounds = YES;
        [_recordBackView.layer setCornerRadius:_recordBackView.frame.size.width/2];
    }
    return _recordBackView;
}



-(UIView *)recordBtn{
    if (!_recordBtn) {
        _recordBtn = [[UIView alloc]init];
        CGFloat deta = [UIScreen mainScreen].bounds.size.width/375;
        CGFloat width = 60.0*deta;
        _recordBtn.frame = CGRectMake((self.view.width - width)/2, self.view.height - 120-kSafeAreaBottom-kNavBarHeight, width, width);
        [_recordBtn.layer setCornerRadius:_recordBtn.frame.size.width/2];
        _recordBtn.clipsToBounds = YES;
        _recordBtn.backgroundColor = [UIColor whiteColor];
        _recordBtn.userInteractionEnabled = YES;
        [_recordBtn addSubview:self.startVideoBtn];
        [_recordBtn addSubview:self.tipLabel];
    }
    return _recordBtn;
}
- (UIButton *)startVideoBtn{
    if (!_startVideoBtn) {
        CGFloat deta = [UIScreen mainScreen].bounds.size.width/375;
        CGFloat width = 60.0*deta;
        UIButton *startVideoBtn = [[UIButton alloc]initWithFrame:_recordBtn.bounds];
        startVideoBtn.layer.cornerRadius = width/2.0;
        startVideoBtn.clipsToBounds = YES;
        [startVideoBtn setBackgroundImage:[UIImage createImageSize:startVideoBtn.size gradientColors:@[kRGB_COLOR(@"#FF54A0"),kRGB_COLOR(@"#FF6CF6")] percentage:@[@0.3,@1.0] gradientType:GradientFromTopToBottom] forState:UIControlStateNormal];
        [startVideoBtn addTarget:self action:@selector(startRecordClick:) forControlEvents:UIControlEventTouchUpInside];
        _startVideoBtn = startVideoBtn;
    }
    return _startVideoBtn;
}

@end
