//
//  HostOrderMoreSelectedView.m
//  Shopping
//
//  Created by tctd on 2020/8/4.
//  Copyright © 2020 klc. All rights reserved.
//

#import "HostOrderSourceSelectedView.h"

@interface KTriangleView : UIView

@end


@implementation KTriangleView
- (void)drawRect:(CGRect)rect {
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextBeginPath(context);
    CGContextMoveToPoint(context, rect.size.width*0.5, 0);
    CGContextAddLineToPoint(context,0, rect.size.height);
    CGContextAddLineToPoint(context,rect.size.width, rect.size.height);
    CGContextClosePath(context);
    [[UIColor whiteColor] setFill];
    [[UIColor whiteColor] setStroke];
    CGContextDrawPath(context, kCGPathFillStroke);
}
 
@end


@interface HostOrderSourceSelectedView()<UIGestureRecognizerDelegate>
@property (nonatomic, copy)OrderMoreSelectedBlock callBack;
@property (nonatomic, strong)UIView *backView;
@property (nonatomic, strong)UIView *contentV;
@property (nonatomic, strong)KTriangleView *triangleView;
@end

@implementation HostOrderSourceSelectedView

+ (void)showInSuperView:(UIView *)superV callBack:(OrderMoreSelectedBlock)callBack{
    HostOrderSourceSelectedView *selectedView = [[HostOrderSourceSelectedView alloc] initWithFrame:CGRectMake(0, 8, 110, 312)];
    selectedView.layer.cornerRadius = 8;
    selectedView.clipsToBounds = YES;
    selectedView.backgroundColor = [UIColor whiteColor];
    selectedView.layer.borderWidth = 1.5;
    selectedView.layer.borderColor = kRGB_COLOR(@"#DDDDDD", 0.4).CGColor;
    selectedView.callBack = callBack;
    [selectedView.contentV addSubview:selectedView];
    [selectedView.contentV addSubview:selectedView.triangleView];
    [selectedView.backView addSubview:selectedView.contentV];
    [[UIApplication sharedApplication].keyWindow addSubview:selectedView.backView];
    
    NSArray *titles = @[@"全部",@"淘宝订单",@"京东订单",@"拼多多订单",@"有赞订单",@"有赞订单",@"官方小店订单"];
    for (int i = 0; i < titles.count; i++) {
        UIButton *btn = [[UIButton alloc]initWithFrame:CGRectMake(8, 10+42*i, 94, 40)];
        btn.tag = i;
        btn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        btn.titleLabel.font = [UIFont systemFontOfSize:14];
        [btn setTitleColor:kRGB_COLOR(@"#555555", 1.0) forState:UIControlStateNormal];
        [btn setTitle:titles[i] forState:UIControlStateNormal];
        [btn addTarget:selectedView action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
        [selectedView addSubview:btn];
        UIView *line = [[UIView alloc]initWithFrame:CGRectMake(8, btn.maxY+1, btn.width, 0.5)];
        line.backgroundColor = kRGB_COLOR(@"#DDDDDD", 1.0);
        if (i != titles.count-1) {
             [selectedView addSubview:line];
        }
    }
}
- (void)btnClick:(UIButton *)btn{
    [self removeAll];
    self.callBack(YES, btn.tag, self);
}
- (void)tap{
    [self removeAll];
    self.callBack(NO, 0, self);
}

- (void)removeAll{
    [self.triangleView removeFromSuperview];
    [self removeAllSubViews];
    self.triangleView = nil;
    [self removeFromSuperview];
    [self.contentV removeAllSubViews];
    [self.contentV removeFromSuperview];
    self.contentV = nil;
    [self.backView removeFromSuperview];
    self.backView = nil;
}



#pragma mark - lazy load
- (UIView *)backView{
    if (!_backView) {
        _backView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight)];
        _backView.backgroundColor = [UIColor clearColor];
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tap)];
        tap.delegate = self;
        [_backView addGestureRecognizer:tap];
    }
    return _backView;
}
- (UIView *)contentV{
    if (!_contentV) {
        _contentV = [[UIView alloc]initWithFrame:CGRectMake(kScreenWidth-122, kNavBarHeight, 110, 322)];
        _contentV.backgroundColor = [UIColor clearColor];
    }
    return _contentV;
}
- (KTriangleView *)triangleView{
    if (!_triangleView) {
        _triangleView = [[KTriangleView alloc]initWithFrame:CGRectMake(_contentV.width-28, 0, 14, 10)];
        _triangleView.backgroundColor = [UIColor clearColor];
    }
    return _triangleView;
}

#pragma mark - UIGestureRecognizerDelegate
-(BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch{
    if ([touch.view isKindOfClass:[UIButton class]]) {
        return NO;
    }else{
        return YES;
    }
}

@end
