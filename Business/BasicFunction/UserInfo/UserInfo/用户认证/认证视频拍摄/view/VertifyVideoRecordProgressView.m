//
//  VertifyVideoRecordProgressView.m
//  MineCenter
//
//  Created by ssssssss on 2020/1/6.
//

#import "VertifyVideoRecordProgressView.h"

@implementation VertifyVideoRecordProgressView
-(instancetype)init{
    if (self = [super init]) {
        self.backgroundColor = [UIColor clearColor];
    }
    return self;
}

-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor clearColor];
        self.clipsToBounds = NO;
    }
    return self;
}

-(instancetype)initWithCoder:(NSCoder *)aDecoder{
    if (self = [super initWithCoder:aDecoder]) {
        self.backgroundColor = [UIColor clearColor];
    }
    return self;
}

- (void)drawRect:(CGRect)rect {
    [super drawRect:rect];
    CGContextRef ctx = UIGraphicsGetCurrentContext();//获取上下文
    
    CGPoint center = CGPointMake(self.width/2, self.height/2); //设置圆心位置
    CGFloat radius = self.width/2 - 4; //设置半径
    CGFloat startA = - M_PI_2; //圆起点位置
    CGFloat endA = -M_PI_2 + M_PI * 2 * _progress/self.totolProgress; //圆终点位置
    
    UIBezierPath *path = [UIBezierPath bezierPathWithArcCenter:center radius:radius startAngle:startA endAngle:endA clockwise:YES];
    
    CGContextSetLineWidth(ctx, 7); //设置线条宽度
    [[[ProjConfig normalColors] colorWithAlphaComponent:0.8] setStroke];//设置描边颜色0xe60044
    CGContextAddPath(ctx, path.CGPath);//把路径添加到上下文
    
    CGContextStrokePath(ctx); //渲染
}

-(void)setProgress:(CGFloat)progress{
    _progress = progress;
    [self setNeedsDisplay];
}

@end
