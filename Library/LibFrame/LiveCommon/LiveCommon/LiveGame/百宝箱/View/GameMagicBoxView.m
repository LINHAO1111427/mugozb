//
//  GameMagicBoxView.m
//  klcProject
//
//  Created by klc_sl on 2020/7/17.
//  Copyright © 2020 KLC. All rights reserved.
//

#import "GameMagicBoxView.h"
#import <LibTools/LibTools.h>

@interface GameMagicBoxView ()<CAAnimationDelegate>

@property (nonatomic, weak)UIImageView *boxImgV;
@property (nonatomic, copy)void(^stopBlock)(void);

@end

@implementation GameMagicBoxView


- (instancetype)initWithIsLuckyBox:(BOOL)luckyBox
{
    self = [super init];
    if (self) {
        _isLuckyBox = luckyBox;
        [self createUI];
    }
    return self;
}

- (void)createUI{
    ///百宝箱
    UIImageView *boxImgV = [[UIImageView alloc] init];
    boxImgV.contentMode = UIViewContentModeScaleAspectFit;
    [self addSubview:boxImgV];
    _boxImgV = boxImgV;
    
    [boxImgV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.equalTo(self);
        make.left.right.equalTo(self).inset(50);
    }];
    boxImgV.image = [UIImage imageNamed:[self getImage:NO]];
}


- (NSString *)getImage:(BOOL)isOpen{
    
    NSString *boxImage = _isLuckyBox?(isOpen?@"game_luck_open":@"game_luck_close"):(isOpen?@"game_gold_open":@"game_gold_close");
    return boxImage;
    
}

- (void)shakeBox{
    [self startAnimation];
}

- (void)openBox:(void (^)(void))stopBlock {
    _stopBlock = stopBlock;
    kWeakSelf(self);
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [weakself stopAnimation];
    });
}

- (void)closeBox{
    [_boxImgV.layer removeAllAnimations];
    _boxImgV.image = [UIImage imageNamed:[self getImage:NO]];
}


- (void)startAnimation{
    [_boxImgV layoutIfNeeded];
    
    CABasicAnimation *momAnimation = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
    momAnimation.fromValue = [NSNumber numberWithFloat:-0.2];
    momAnimation.toValue = [NSNumber numberWithFloat:0.2];
    momAnimation.duration = 0.2;
    momAnimation.repeatCount = CGFLOAT_MAX;
    momAnimation.autoreverses = YES;
    momAnimation.delegate = self;
    [_boxImgV.layer addAnimation:momAnimation forKey:@"animateLayer"];
}


- (void)stopAnimation{
    [_boxImgV.layer removeAllAnimations];
    _boxImgV.image = [UIImage imageNamed:[self getImage:YES]];
    kWeakSelf(self);
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        if (weakself.stopBlock) {
            weakself.stopBlock();
        }
    });
}


//暂停动画，图片未复位

-(void)pauseLayer:(CALayer*)layer
{
    CFTimeInterval pausedTime = [layer convertTime:CACurrentMediaTime() fromLayer:nil];
    
    layer.speed = 0.0;
    
    layer.timeOffset = pausedTime;
}

//重新开始动画

-(void)resumeLayer:(CALayer*)layer{
    
    CFTimeInterval pausedTime = [layer timeOffset];
    
    layer.speed = 1.0;
    
    layer.timeOffset = 0.0;
    
    layer.beginTime = 0.0;
    
    CFTimeInterval timeSincePause = [layer convertTime:CACurrentMediaTime() fromLayer:nil] - pausedTime;
    
    layer.beginTime = timeSincePause;
}

- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag{
    [_boxImgV.layer removeAllAnimations];
}

@end
