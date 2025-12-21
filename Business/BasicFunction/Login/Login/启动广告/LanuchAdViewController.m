//
//  LanuchAdViewController.m
//  Login
//
//  Created by klc on 2020/5/14.
//

#import "LanuchAdViewController.h"

#import <SDWebImage.h>
#import <LibTools/LibTools.h>
#import <LibProjBase/LibProjBase.h>
#import <AVFoundation/AVFoundation.h>

#import <LibProjModel/AppAdsModel.h>
#import <LibProjModel/HttpApiAppLogin.h>

#import <LibProjModel/HttpApiPublicLive.h>
#import <LibProjModel/KLCUserInfo.h>
#import <LibProjModel/KLCAppConfig.h>

@interface LanuchAdViewController ()

@property (copy, nonatomic) launchAdCallBack callBackBlock;
@property (strong, nonatomic) UIImage * lanuchImage;
@property (strong, nonatomic) AppAdsModel *model;
@property (strong, nonatomic) UIImageView * bgImageView;

///跳转btn
@property (weak, nonatomic) UIButton * ignoreBtn;

//视频播放
@property(nonatomic,strong)AVPlayerItem *avPlayerItem;
@property(nonatomic,strong)AVPlayer *avPlayer;
@property(nonatomic,strong)AVPlayerLayer *avPlayerLayer;
@property(nonatomic,strong)id timeObserver;

@property (strong, nonatomic) NSTimer *adTimer;
@property (assign, nonatomic) int timeNum;

///getConfig 是否可返回
@property (nonatomic, assign)BOOL configBack;
///广告 是否可返回
@property (nonatomic, assign)BOOL adverBack;

@property (nonatomic, strong)TimerBlock *timerBlock;

@end

@implementation LanuchAdViewController

- (UIImageView *)bgImageView{
    if (!_bgImageView) {
        _bgImageView = [[UIImageView alloc]initWithFrame:[UIScreen mainScreen].bounds];
        _bgImageView.userInteractionEnabled = YES;
        _bgImageView.contentMode = UIViewContentModeScaleAspectFill;
    }
    return _bgImageView;
}


- (instancetype)initWithCallBack:(launchAdCallBack)callBack{
    if (self = [super init]) {
        self.callBackBlock = callBack;
        self.view.backgroundColor = [UIColor whiteColor];
    }
    return self;
}

- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
}
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIImage *img = [ProjConfig getLanuchImg];
    [self.bgImageView setImage:img];
    [self.view addSubview:self.bgImageView];
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapAd)];
    [_bgImageView addGestureRecognizer:tap];

    __block BOOL isLoadingSuccess = NO;
    kWeakSelf(self);
    ///广告接口
    [HttpApiAppLogin adslist:1 type:0 callback:^(int code, NSString *strMsg, NSArray<AppAdsModel *> *arr) {
        isLoadingSuccess = YES;
        if (code == 1 && arr.count) {
            AppAdsModel *model = arr.firstObject;
            weakself.model = model;
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [weakself showLaunchImage];
            });
        }else{
            [self ignoreBtnClick:nil];
        }
    }];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        if (!isLoadingSuccess) {
           // NSLog(@"过滤文字*******广告启动失败*********"));
            [self ignoreBtnClick:nil];
        }
    });
    
    ///启动接口
    if ([[ProjConfig shareInstence].baseConfig hasNoLoginShow]) {
        kWeakSelf(self);
        self.timerBlock = [[TimerBlock alloc] init];
        [self.timerBlock startTimerForTotalTime:30 IntervalTime:0.1 progress:^(CGFloat progress) {
            [weakself netStatus];
        } finish:^{
            
        }];
    }else{
        self.configBack = YES;
    }
}

- (void)showLaunchImage{
    self.timeNum = MAX(self.model.playTime, 3);
    if ([self isVideo:self.model.thumb]) {//视频
        [self startPlay];
    }else{// 图片
        self.adTimer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(timeDown) userInfo:nil repeats:YES];
        [[NSRunLoop currentRunLoop] addTimer:self.adTimer forMode:NSRunLoopCommonModes];
        [self.adTimer setFireDate:[NSDate distantPast]];
        
        [self.bgImageView sd_setImageWithURL:[NSURL URLWithString:self.model.thumb] placeholderImage:[ProjConfig getLanuchImg]];
    }
    
    //跳过按钮
    UIButton *ignoreBtn = [[UIButton alloc]initWithFrame:CGRectMake(kScreenWidth-70, kStatusBarHeight+(kNavBarHeight-32)/2.0, 50, 32)];
    ignoreBtn.backgroundColor = kRGBA_COLOR(@"#000000", 0.4);
    ignoreBtn.layer.masksToBounds = YES;
    ignoreBtn.layer.cornerRadius = 5.;
    [ignoreBtn addTarget:self action:@selector(ignoreBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [ignoreBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    ignoreBtn.titleLabel.font = [UIFont systemFontOfSize:14];
    [self.bgImageView insertSubview:ignoreBtn atIndex:2];
    self.ignoreBtn = ignoreBtn;

    [ignoreBtn setTitle:[NSString stringWithFormat:@"%ds",self.timeNum] forState:UIControlStateNormal];

}

- (void)netStatus{
    //获取用户app配置文件
    kWeakSelf(self);
    if (!weakself.configBack) {
        [KLCAppConfig updateAppConfig:^(BOOL success) {
            if (success) {
                weakself.configBack = YES;
                [weakself disappearView:NO showUrl:@""];
                [weakself.timerBlock stopTimer];
                weakself.timerBlock = nil;
            }
        }];
    }
}

- (void)disappearView:(BOOL)isClick showUrl:(NSString *)url{
    if (self.configBack && self.adverBack) {
        if (self.callBackBlock) {
            self.callBackBlock(isClick, url);
        }
    }
}


+ (void)showAdInfo:(NSString *)openUrl{
    BOOL openSafari = [[NSUserDefaults standardUserDefaults] boolForKey:@"adJumpSafari"];
    if ([[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:openUrl]]) {
        if (openSafari) {
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:openUrl]];
        }else{
            [RouteManager routeForName:RN_general_webView currentC:[ProjConfig currentVC] parameters:@{@"url":openUrl}];
        }
    }
}



- (void)timeDown{
    if (self.timeNum == 0) {
        [self ignoreBtnClick:nil];
    }
    [self.ignoreBtn setTitle:[NSString stringWithFormat:@"%ds",self.timeNum] forState:UIControlStateNormal];
    self.timeNum--;

}

- (void)startPlay{
    self.avPlayerItem = [AVPlayerItem playerItemWithURL:[NSURL URLWithString:self.model.thumb]];
    self.avPlayer   = [AVPlayer playerWithPlayerItem:self.avPlayerItem];
    self.avPlayerLayer = [AVPlayerLayer playerLayerWithPlayer:self.avPlayer];
    self.avPlayerLayer.backgroundColor = (__bridge CGColorRef _Nullable)([UIColor blackColor]);
    self.avPlayerLayer.frame = self.bgImageView.bounds;
    self.avPlayerLayer.videoGravity = AVLayerVideoGravityResizeAspectFill;
    [self.bgImageView.layer addSublayer:self.avPlayerLayer];
    
    kWeakSelf(self);
    self.timeObserver =[self.avPlayer addPeriodicTimeObserverForInterval:CMTimeMake(1.0,1.0) queue:dispatch_get_main_queue() usingBlock:^(CMTime time) {
        CMTime duration = weakself.avPlayer.currentItem.duration;
        float totalSeconds = CMTimeGetSeconds(duration);
        float currentSeconds = CMTimeGetSeconds(time);
        float rate = currentSeconds/totalSeconds;
       // NSLog(@"过滤文字启动图视频 rate == %f"),rate);
        if (rate >= 0.998) {
            [weakself stopPlay];
        }
    }];
    [self.avPlayer play]; 
}

- (void)stopPlay{
    [self ignoreBtnClick:nil];
}
- (BOOL)isVideo:(NSString *)url{
    NSURL *videoURL = [NSURL URLWithString:url];
    AVAsset *asset = [AVURLAsset URLAssetWithURL:videoURL options:nil];
    NSArray *tracks = [asset tracksWithMediaType:AVMediaTypeVideo];
    //判断是否含有视频轨道
    BOOL hasVideoTrack = [tracks count] > 0;
    return hasVideoTrack;
}

- (void)ignoreBtnClick:(UIButton *)btn{
    [self removeAll];
    self.adverBack = YES;
    [self disappearView:NO showUrl:@""];
}
- (void)tapAd{
    if (self.model.url.length > 0) {
        [self removeAll];
        self.adverBack = YES;
        [self disappearView:YES showUrl:self.model.url];
    }
}
- (void)removeAll{
    [self.adTimer setFireDate:[NSDate distantFuture]];
    [self.adTimer invalidate];
    self.adTimer = nil;
    if (self.avPlayer) {
        [self.avPlayer pause];
        [self.avPlayerLayer removeFromSuperlayer];
        self.avPlayerLayer = nil;
        [self.avPlayer removeTimeObserver:self.timeObserver];
        self.timeObserver = nil;
        self.avPlayer = nil;
    }
    [self.bgImageView removeAllSubViews];
    [self.bgImageView removeFromSuperview];
    self.bgImageView = nil;
}
@end
