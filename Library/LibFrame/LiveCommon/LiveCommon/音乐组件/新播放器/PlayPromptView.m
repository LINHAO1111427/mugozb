//
//  PlayPromptView.m
//
//  Created by Mac on 2018/12/12.
//  Copyright © 2018年 ytsr. All rights reserved.
//

#import "PlayPromptView.h"
#import <LibTools/LibTools.h>

#define selfHeight   self.frame.size.height
#define selfWidth    self.frame.size.width

@interface PlayPromptView ()

@property(nonatomic,strong)NSTimer *timer;
@property(nonatomic,strong)UIColor *lineColor;
@end

@implementation PlayPromptView

- (instancetype)initWithFrame:(CGRect)frame lineColor:(UIColor *)color
{
    self = [super initWithFrame:frame];
    if (self) {
        
        _lineColor = color;
        [self setup];
    }
    return self;
}
-(void)setup{
 
    CGFloat width=2;
    CGFloat gap=(selfWidth-2*4)/3;
    
    NSArray *startPosition=@[@0.8,@0.6,@0.9,@0.5];
    for (int i=0; i<4; i++) {
        
        CGFloat number=[startPosition[i] floatValue];
        CGFloat origin_y=(1-number)*selfHeight;
        CGFloat height=selfHeight-origin_y;
        UIView *line=[[UIView alloc] initWithFrame:CGRectMake((width+gap)*i, origin_y, width, height)];
        line.backgroundColor=_lineColor;
        
        [self addSubview:line];
    }
}
-(void)playLoop{
 
    NSArray *startPosition=@[@0.8,@0.6,@0.9,@0.5];
    NSArray *endPosition=@[@0.4,@0.95,@0.6,@0.8];
    for (int i=0; i<self.subviews.count; i++) {
        
        UIView *sub=self.subviews[i];
        
        CGFloat startNum=[startPosition[i] floatValue];
        CGFloat endNum=[endPosition[i] floatValue];
        
        CGFloat origin_y=(1-startNum)*selfHeight;
        CGFloat end_y=(1-endNum)*selfHeight;
        
        CGFloat origin_height=selfHeight-origin_y;
        CGFloat end_height=selfHeight-end_y;
        
        CGFloat origin_x=sub.frame.origin.x;
        CGFloat width=sub.frame.size.width;
        [UIView animateWithDuration:0.2 animations:^{
            
            sub.frame=RECT(origin_x, end_y, width, end_height);
        } completion:^(BOOL finished) {
           
            [UIView animateWithDuration:0.2 animations:^{
               
                sub.frame=RECT(origin_x, origin_y, width, origin_height);
            }];
        }];
    }
}

-(void)statAnimation{
 
    [self.timer setFireDate:[NSDate distantPast]];
}
-(void)endAnimation{
 
    [_timer setFireDate:[NSDate distantFuture]];
    [self invalidateTimer];
}
-(void)dealloc{
 
    [self invalidateTimer];
}
-(void)invalidateTimer{
    
    [_timer invalidate];
    _timer=nil;
}


- (NSTimer *)timer{
    
    if (!_timer) {
        
        _timer=[NSTimer timerWithTimeInterval:0.4 target:self selector:@selector(playLoop) userInfo:nil repeats:YES];
        [[NSRunLoop currentRunLoop] addTimer:_timer forMode:NSRunLoopCommonModes];
    }
    return _timer;
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
