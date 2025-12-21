//
//  SoundWaveView.m
//  LibProjView
//
//  Created by klc on 2020/6/10.
//  Copyright © 2020 . All rights reserved.
//

#import "SoundWaveView.h"
#import <LibTools/LibTools.h>

@interface SoundWaveView () <CAAnimationDelegate>

@property (nonatomic, copy) CAShapeLayer *pulseLayer;
@property (nonatomic, copy) CAAnimationGroup *groupAnimation;



@end

@implementation SoundWaveView

- (void)dealloc
{
    [self stopAnimation];
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
    }
    return self;
}


- (void)starAnimation{
    // 退出房间需要关闭动画
    _groupAnimation = nil;
    self.pulseLayer.transform = CATransform3DIdentity;
}

- (void)stopAnimation{
    [_pulseLayer removeAllAnimations];
    [_pulseLayer removeFromSuperlayer];
    _pulseLayer = nil;
    _groupAnimation = nil;
}

#pragma mark - 懒加载 -

- (CAShapeLayer *)pulseLayer{
    if (!_pulseLayer) {
        
        CGFloat width = self.bounds.size.width;
        // 动画图层
        _pulseLayer = [CAShapeLayer layer];
        _pulseLayer.bounds = CGRectMake(0, 0, width, width);
        _pulseLayer.position = CGPointMake(width/2, width/2);
        _pulseLayer.backgroundColor = [UIColor clearColor].CGColor;
        
        // 用BezierPath画一个原型
        _pulseLayer.path = [UIBezierPath bezierPathWithOvalInRect:_pulseLayer.bounds].CGPath;
        // 脉冲效果的颜色  (注释*1)
        _pulseLayer.fillColor = _broadColorRGB?_broadColorRGB.CGColor:kRGB_COLOR(@"#A0C8FA").CGColor;
        _pulseLayer.opacity = 0.0;
        

        [_pulseLayer addAnimation:self.groupAnimation forKey:@"animationGroup"];
        
        // 关键代码
        CAReplicatorLayer *replicatorLayer = [CAReplicatorLayer layer];
        replicatorLayer.bounds = CGRectMake(0, 0, width, width);
        replicatorLayer.position = CGPointMake(width/2, width/2);
        replicatorLayer.instanceCount = 3;  // 三个复制图层
        replicatorLayer.instanceDelay = 0.5;  // 频率
        [replicatorLayer addSublayer:_pulseLayer];
        [self.layer addSublayer:replicatorLayer];
        //        [self.layer insertSublayer:replicatorLayer atIndex:0];

        
    }
    return _pulseLayer;
}

- (CAAnimationGroup *)groupAnimation{
    if (_groupAnimation == nil) {
        // 透明
        CABasicAnimation *opacityAnimation = [CABasicAnimation animationWithKeyPath:@"opacity"];
        opacityAnimation.fromValue = @(1);  // 起始值
        opacityAnimation.toValue = @(0);     // 结束值
        
        // 扩散动画
        CABasicAnimation *scaleAnimation=[CABasicAnimation animationWithKeyPath:@"transform.scale"];
        scaleAnimation.fromValue=[NSNumber numberWithFloat:0.9];
        scaleAnimation.toValue=[NSNumber numberWithFloat:1.1];
        
        // 给CAShapeLayer添加组合动画
        _groupAnimation = [CAAnimationGroup animation];
        _groupAnimation.animations = @[scaleAnimation,opacityAnimation];
        _groupAnimation.duration = 1.0;   //持续时间
        _groupAnimation.autoreverses = NO; //循环效果
        _groupAnimation.repeatCount = 1;
        _groupAnimation.delegate = self;
        
    }
    return _groupAnimation;
}

#pragma mark - CAAnimationDelegate -
- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag{
    if (flag == YES) {
        [self stopAnimation];
    }
}

@end
