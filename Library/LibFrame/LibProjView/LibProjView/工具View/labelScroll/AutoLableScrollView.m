//
//  AutoLableScrollView.m
//  LibProjView
//
//  Created by klc_sl on 2021/5/21.
//  Copyright © 2021 KLC. All rights reserved.
//

#import "AutoLableScrollView.h"
#import <LibTools/LibTools.h>

@interface AutoLableScrollView ()<UIScrollViewDelegate>

@property (nonatomic, weak)UIScrollView *scrollV;

@property (nonatomic, assign) BOOL isScroll;  ///是否正在滚动运行中（暂停也算运行中）

@property (nonatomic, copy) NSString *showText;

@property (nonatomic, weak)UILabel *textL;

@end

@implementation AutoLableScrollView

- (void)dealloc
{
    [self stopScroll];
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self initView];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self initView];
    }
    return self;
}

- (void)initView{
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(sss) name:UIApplicationWillEnterForegroundNotification object:nil];
    self.backgroundColor = [UIColor yellowColor];
    self.font = [UIFont systemFontOfSize:14];
    self.textColor = [UIColor darkGrayColor];
    self.scrollSpeed = 4.0;
}

- (void)sss{
    if (self.isScroll) {
        [self startTimer];
    }
}

- (UIView *)getSpaceView:(CGRect)frame superView:(UIView *)superView{
    UIView *space1 = [[UIView alloc] initWithFrame:frame];
    space1.backgroundColor = [UIColor clearColor];
    [superView addSubview:space1];
    return space1;
}

///显示文本
- (void)showTextView{
    
    [self layoutIfNeeded];
    
    UIScrollView *scrollV = [[UIScrollView alloc] init];
    [self addSubview:scrollV];
    scrollV.scrollEnabled = YES;
    scrollV.delegate = self;
    scrollV.userInteractionEnabled = NO;
    scrollV.showsVerticalScrollIndicator = NO;
    if (@available(iOS 11.0, *)) {
        scrollV.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    }
    if (@available(iOS 13.0, *)) {
        scrollV.automaticallyAdjustsScrollIndicatorInsets = YES;
    }

    [scrollV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self);
    }];
    
    UIView *container = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.width, 0)];
    [scrollV addSubview:container];
    
    UIView *space1 = [self getSpaceView:CGRectMake(0, 0, self.width, 1) superView:container];
    
    UILabel *label = [[UILabel alloc] init];
    label.textColor = self.textColor;
    label.font = self.font;
    label.text = self.showText;
    label.textAlignment = NSTextAlignmentCenter;
    [container addSubview:label];
    self.textL = label;
    [label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.equalTo(container);
        make.left.equalTo(space1.mas_right);
    }];
    [label layoutIfNeeded];
    
    UIView *space2 = [self getSpaceView:CGRectMake(space1.width+label.width, 0, self.width, 1) superView:container];
    
    [container mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(scrollV);
        make.height.equalTo(self.mas_height);
        make.width.mas_equalTo(space2.maxX);
    }];
    ///计算scrollV的尺寸
    [scrollV layoutIfNeeded];
    self.scrollV = scrollV;
    
}


- (void)startScroll:(NSString *)text{
    
    self.showText = text;
    
    [self stopScroll];
            
    [self showTextView];
            
    [self startTimer];
}


- (void)startTimer{
    if (self.scrollSpeed > 0 && self.showText.length > 0) {
        self.isScroll = YES;
        self.scrollV.contentOffset = CGPointMake(0, 0);
        [self scrollForTimer];
    }
}


- (void)pauseScroll{
    [self pauseLayer:self.scrollV.layer];
}

- (void)resumeScroll{
    [self resumeLayer:self.scrollV.layer];
}

- (void)stopScroll{
    
    self.isScroll = NO;
    [_scrollV.layer removeAllAnimations];
    [_scrollV removeFromSuperview];
    _scrollV = nil;
    
}

/// 视图开始动了
- (void)scrollForTimer{
    
    kWeakSelf(self);
    
    CGFloat scrollW = weakself.scrollV.contentSize.width-self.width;
    
    [UIView animateWithDuration:scrollW/(_scrollSpeed*8.0)  delay:0 options:(UIViewAnimationOptionCurveLinear | UIViewAnimationOptionAllowAnimatedContent) animations:^{
        
        weakself.scrollV.contentOffset = CGPointMake(scrollW, 0);
        
    } completion:^(BOOL finished) {
        
        [weakself initViewAnimation:finished];
        
    }];
}

/// 动画结果后，准备再次运行
- (void)initViewAnimation:(BOOL)finished{
    self.scrollV.contentOffset = CGPointMake(0, 0);
    ///动画是否正常停止
    if (self.isScroll == YES) {
        [self scrollForTimer];
    }
}


- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    //    if (scrollView.contentOffset.x >= scrollView.contentSize.width-self.width) {
    //        scrollView.contentOffset = CGPointMake(0, 0);
    //    }
}



- (void)pauseLayer:(CALayer *)layer{
    
    NSTimeInterval pausedTime = [layer convertTime:CACurrentMediaTime() fromLayer:nil];
    layer.speed = 0.0;
    layer.timeOffset = pausedTime;

}


- (void)resumeLayer:(CALayer *)layer{
    
    NSTimeInterval pausedTime = layer.timeOffset;
    layer.speed = 1.0;
    layer.timeOffset = 0.0;
    layer.beginTime = 0.0;
    NSTimeInterval timeSincePause = [layer convertTime:CACurrentMediaTime() fromLayer:nil] - pausedTime;
    layer.beginTime = timeSincePause;
    
}


@end
