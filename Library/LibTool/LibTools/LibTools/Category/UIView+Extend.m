//
//  UIView+Extend.m
//  LibTools
//
//  Created by admin on 2020/1/17.
//  Copyright © 2020 . All rights reserved.
//

#import "UIView+Extend.h"

@implementation UIView (Extend)

- (void)cornerRadii:(CGSize)size byRoundingCorners:(UIRectCorner)corners{
    UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:self.bounds byRoundingCorners:corners cornerRadii:size];
    CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
    maskLayer.frame = self.bounds;
    maskLayer.path = maskPath.CGPath;
    self.layer.mask = maskLayer;
}
-(void)startRotateAnimating:(CGFloat)duration{
    if([self.layer animationForKey:@"rotatianAnimKey"]){
    if (self.layer.speed == 1) {
            return;
        }
        self.layer.speed = 1;
        self.layer.beginTime = 0;
        CFTimeInterval pauseTime = self.layer.timeOffset;
        self.layer.timeOffset = 0;
        self.layer.beginTime = [self.layer convertTime:CACurrentMediaTime() fromLayer:nil] - pauseTime;
    }else{
        [self addRotateAnimation:duration];
    }
}
-(void)addRotateAnimation:(CGFloat)duration{
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
    //默认是顺时针效果，若将fromValue和toValue的值互换，则为逆时针效果
    animation.toValue =   [NSNumber numberWithFloat: M_PI *2];
    animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear];
    animation.duration = duration;
    animation.autoreverses = NO;
    animation.cumulative = NO;
    animation.removedOnCompletion = NO;
    animation.fillMode = kCAFillModeForwards;
    animation.repeatCount = FLT_MAX; //如果这里想设置成一直自旋转，可以设置为FLT_MAX，
    [self.layer addAnimation:animation forKey:@"rotatianAnimKey"];
    [self startRotateAnimating:duration];
}

-(void)stopRotateAnimating{
    if (self.layer.speed == 0) {
        return;
    }
    CFTimeInterval pausedTime = [self.layer convertTime:CACurrentMediaTime() fromLayer:nil];
    self.layer.speed = 0;
    self.layer.timeOffset = pausedTime;
}
- (void)addGradientColorWith:(NSArray *)gradientColors percentage:(NSArray *)percents{
    CAGradientLayer *gradientLayer = [CAGradientLayer layer];
    gradientLayer.frame = self.bounds;
    gradientLayer.startPoint = CGPointMake(0, 0);
    gradientLayer.endPoint = CGPointMake(1, 0);
    gradientLayer.colors = gradientColors;
    gradientLayer.locations = percents;
    [self.layer addSublayer:gradientLayer];
}

-(void)shadowPathWith:(UIColor *)shadowColor shadowOpacity:(CGFloat)shadowOpacity shadowRadius:(CGFloat)shadowRadius shadowSide:(KLCShadowPathSide)shadowPathSide shadowPathWidth:(CGFloat)shadowPathWidth{
    self.layer.masksToBounds = NO;
    
    self.layer.shadowColor = shadowColor.CGColor;
    
    self.layer.shadowOpacity = shadowOpacity;
    
    self.layer.shadowRadius =  shadowRadius;
    
    self.layer.shadowOffset = CGSizeZero;
    CGRect shadowRect;
    
    CGFloat originX = 0;
    
    CGFloat originY = 0;
    
    CGFloat originW = self.bounds.size.width;
    
    CGFloat originH = self.bounds.size.height;
    
    
    switch (shadowPathSide) {
        case KLCShadowPathTop://上
            shadowRect  = CGRectMake(originX, originY - shadowPathWidth/2, originW,  shadowPathWidth);
            break;
        case KLCShadowPathBottom://下
            shadowRect  = CGRectMake(originX, originY - shadowPathWidth/2, originW, shadowPathWidth);
            break;
        case KLCShadowPathTopBottom://上下
            shadowRect  = CGRectMake(originX, originY- shadowPathWidth/2, originW, originH + shadowPathWidth);
            break;
        case KLCShadowPathLeft://左
            shadowRect  = CGRectMake(originX - shadowPathWidth/2, originY, shadowPathWidth, originH);
            break;
        case KLCShadowPathRight://右
            shadowRect  = CGRectMake(originW - shadowPathWidth/2, originY, shadowPathWidth, originH);
            break;
        case KLCShadowPathLeftRight://左右
            shadowRect  = CGRectMake(originX - shadowPathWidth/2, originY, originW +shadowPathWidth, originH);
            break;
        case KLCShadowPathNoTop://除了上边
            shadowRect  = CGRectMake(originX -shadowPathWidth/2, originY +1, originW +shadowPathWidth,originH + shadowPathWidth/2 );
            break;
        case KLCShadowPathAllSide://四周
            shadowRect  = CGRectMake(originX - shadowPathWidth/2, originY - shadowPathWidth/2, originW +  shadowPathWidth, originH + shadowPathWidth);
            break;
       
          }
    
    UIBezierPath *path =[UIBezierPath bezierPathWithRect:shadowRect];
    
    self.layer.shadowPath = path.CGPath;
    
}

@end
