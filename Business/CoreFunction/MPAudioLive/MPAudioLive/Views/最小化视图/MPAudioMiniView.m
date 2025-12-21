//
//  MPAudioMiniView.m
//  LiveCommon
//
//  Created by klc_sl on 2020/7/24.
//  Copyright © 2020 KLC. All rights reserved.
//

#import "MPAudioMiniView.h"
#import <LibTools/LibTools.h>
#import <LiveCommon/LiveManager.h>
#import <SDWebImage.h>
#import <LibProjBase/LibProjBase.h>

@interface MPAudioMiniView ()

@property (nonatomic, copy)void (^recoverBlock)(void);

@property (nonatomic, weak)UIImageView *miniView;

@end

@implementation MPAudioMiniView

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIApplicationDidBecomeActiveNotification object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIApplicationWillResignActiveNotification object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:liveRoomMiniRecoverNotify object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:liveRoomExitNotify object:nil];
}


- (void)leaveRoom:(NSNotification *)notify{
    [self stopRotateAnimating];
    [self removeFromSuperview];
}

- (void)miniRecover:(NSNotification *)notify{
    [self tapView:nil];
}

- (void)ApplicationWillResignActive{
    [self stopRotateAnimating];
}

- (void)UIApplicationDidBecomeActive{
    [self startAnimation];
}

- (instancetype)init
{
    self = [super init];
    if (self) {

        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(miniRecover:) name:liveRoomMiniRecoverNotify object:nil];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(ApplicationWillResignActive) name:UIApplicationWillResignActiveNotification object:nil];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(UIApplicationDidBecomeActive) name:UIApplicationDidBecomeActiveNotification object:nil];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(leaveRoom:) name:liveRoomExitNotify object:nil];
        
    }
    return self;
}


+ (void)showAudioMiniView:(UIView *)subViews recover:(void (^)(void))recover{
    MPAudioMiniView *miniV = [[MPAudioMiniView alloc] init];
    miniV.recoverBlock = recover;
    [miniV createUI:subViews];
}


+ (void)dismissView{
    UIView *miniV = [[UIApplication sharedApplication].keyWindow viewWithTag:9955772];
    if (miniV) {
        [miniV removeFromSuperview];
    }
}


- (void)createUI:(UIView *)subView{
    
    self.tag = 9955772;
    
    CGFloat mingViewW = (kScreenWidth * 50/320.0);
    self.frame = CGRectMake(kScreenWidth-20-50, kScreenHeight*2.0/3.0, mingViewW , mingViewW);
    
    UIImageView *imgV = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"audio_mini_iconbg"]];
    imgV.frame = self.bounds;
    [self addSubview:imgV];
    _miniView = imgV;
    
    UIImageView *userIcon = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, mingViewW-12, mingViewW-12)];
    userIcon.center = imgV.center;
    userIcon.contentMode = UIViewContentModeScaleAspectFill;
    userIcon.layer.masksToBounds = YES;
    userIcon.layer.cornerRadius = userIcon.height/2.0;
    userIcon.layer.borderColor = [UIColor whiteColor].CGColor;
    userIcon.layer.borderWidth = 2.0;
    [imgV addSubview:userIcon];
    [userIcon sd_setImageWithURL:[NSURL URLWithString:[LiveManager liveInfo].anchorIcon] placeholderImage:[ProjConfig getDefaultImage]];
    
    subView.frame = CGRectMake(0, 0, 1, 1);
    subView.hidden = YES;
    [self addSubview:subView];
    [[UIApplication sharedApplication].keyWindow addSubview:self];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapView:)];
    tap.numberOfTapsRequired = 1;
    [self addGestureRecognizer:tap];
    
    UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(panView:)];
    [self addGestureRecognizer:pan];
    
    [self startAnimation];
}

- (void)tapView:(UITapGestureRecognizer *)tap{
    if (_recoverBlock) {
        _recoverBlock();
    }
    
    [self stopRotateAnimating];
    [self removeFromSuperview];
}


- (void)panView:(UIPanGestureRecognizer *)pan{
    UIView *moveV = pan.view;
    //获取偏移量
    // 返回的是相对于最原始的手指的偏移量
    CGPoint moveP = [pan translationInView:moveV];
    
    if (pan.view.x + moveP.x < 0) {
        moveP = CGPointMake(0-pan.view.x, moveP.y);
    }
    if (pan.view.maxX + moveP.x > kScreenWidth) {
        moveP = CGPointMake(kScreenWidth-pan.view.maxX, moveP.y);
    }
    if (pan.view.y + moveP.y < 0) {
        moveP = CGPointMake(moveP.x, 0-pan.view.y);
    }
    if (pan.view.maxY + moveP.y > kScreenHeight) {
        moveP = CGPointMake(moveP.x, kScreenHeight - pan.view.maxY);
    }
    
    moveV.center = CGPointMake(pan.view.center.x + moveP.x, pan.view.center.y + moveP.y);
    // 复位,表示相对上一次
    [pan setTranslation:CGPointZero inView:moveV];
}


- (void)startAnimation{
    CABasicAnimation *animation =  [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
    //默认是顺时针效果，若将fromValue和toValue的值互换，则为逆时针效果
    animation.fromValue = [NSNumber numberWithFloat:0.f];
    animation.toValue =  [NSNumber numberWithFloat: M_PI *2];
    animation.duration  = 3.5;
    animation.autoreverses = NO;
    animation.fillMode =kCAFillModeForwards;
    animation.repeatCount = MAXFLOAT; //如果这里想设置成一直自旋转，可以设置为MAXFLOAT，否则设置具体的数值则代表执行多少次
    [_miniView.layer addAnimation:animation forKey:nil];
}


- (void)stopRotateAnimating{
    [_miniView.layer removeAllAnimations];
}



@end
