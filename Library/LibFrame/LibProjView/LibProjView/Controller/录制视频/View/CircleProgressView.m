//
//  CircleProgressView.m
//  LibProjView
//
//  Created by klc on 2020/6/13.
//  Copyright © 2020 . All rights reserved.
//

#import "CircleProgressView.h"
@interface CircleProgressView()
@property(nonatomic,strong)CAShapeLayer *progressLayer;
@property(nonatomic,assign)CGFloat radius; // 环半径
@end

@implementation CircleProgressView
-(instancetype)initWithFrame:(CGRect)frame withRadius:(CGFloat)radius withLineWidth:(CGFloat)lineWidth defaultColor:(UIColor*)defaultColor progressColor:(UIColor *)progressColor
{
    self = [super initWithFrame:frame];
    if (self) {
        
        self.backgroundColor = [UIColor clearColor];
        
        self.progress = 0.0f;
        self.radius = radius;

        // 环形layer
        UIBezierPath *circlePath = [UIBezierPath bezierPathWithArcCenter:CGPointMake(self.frame.size.width/2.0, self.frame.size.height/2.0) radius:radius startAngle:(-1/2.0*M_PI) endAngle:3/2.0*M_PI clockwise:YES];
        CAShapeLayer *circleLayer = [CAShapeLayer layer];
        circleLayer.fillColor = [UIColor clearColor].CGColor;
        circleLayer.strokeColor = defaultColor.CGColor;
        circleLayer.lineWidth = lineWidth;
        circleLayer.path = circlePath.CGPath;
        circleLayer.strokeEnd = 1;
        [self.layer addSublayer:circleLayer];

        // 进度layer
        self.progressLayer = [CAShapeLayer layer];
        self.progressLayer.fillColor = [UIColor clearColor].CGColor;
        self.progressLayer.strokeColor = progressColor.CGColor;
        self.progressLayer.lineCap = kCALineCapRound;
        self.progressLayer.lineWidth = lineWidth;
        self.progressLayer.path = circlePath.CGPath;
        self.progressLayer.strokeEnd = 0;
        [self.layer addSublayer:self.progressLayer];
    }
    return self;
}
  
#pragma mark - private method
-(void)updateProgress:(CGFloat)progress{
    self.progress = progress;
    self.progressLayer.strokeEnd = progress;
}


@end
