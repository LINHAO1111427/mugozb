//
//  TimeCountDownView.m
//  TCDemo
//
//  Created by admin on 2019/9/27.
//  Copyright © 2019 CH. All rights reserved.
//

#import "TimeCountDownView.h"
#import <objc/runtime.h>
#import <LibTools/LibTools.h>
@interface TimeCountDownView()
@property(nonatomic,strong)UILabel* numLab;
@property(nonatomic,assign)int fontSize;
@end

@implementation TimeCountDownView
+ (void)showInView:(UIView *)superV times:(int)times complete:(void (^)(void))complete{
    TimeCountDownView *countDownView = [[TimeCountDownView alloc] initWithFrame:superV.bounds];
    [superV addSubview:countDownView];
    objc_setAssociatedObject(countDownView, @"TimeCountDownComplete", complete, OBJC_ASSOCIATION_COPY_NONATOMIC);
    int font = superV.bounds.size.height*0.8;
    if (font < 200) {
        countDownView.fontSize = font;
    }else{
        countDownView.fontSize = 200;
    }
    [countDownView createUIWithTime:times];
}

- (void)createUIWithTime:(int)times{

    self.clipsToBounds = YES;
    self.opaque = YES;
    self.userInteractionEnabled = NO;
    self.backgroundColor = [UIColor clearColor];
    
    [self createLable:times];
}


- (void)createLable:(int)num{
    if (num > 0) {
        int fontSize = self.fontSize;
        UILabel *numLab = [[UILabel alloc]initWithFrame:CGRectMake((self.frame.size.width-fontSize)/2, (self.frame.size.height-fontSize)/2, fontSize, fontSize)];
        numLab.textColor = [UIColor whiteColor];
        numLab.font=[UIFont boldSystemFontOfSize:fontSize];
        numLab.text = [NSString stringWithFormat:@"%d",num];
        numLab.textAlignment = NSTextAlignmentCenter;
        numLab.center = self.center;
        numLab.adjustsFontSizeToFitWidth=YES;
        numLab.minimumScaleFactor=0.01;
        self.numLab = numLab;
        __weak typeof(self) weakSelf = self;
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [weakSelf addSubview:numLab];
            [weakSelf kaishidonghua:numLab currentNum:num];
        });
    }else{
        void (^complete)(void) = objc_getAssociatedObject(self, @"TimeCountDownComplete");
        if (complete) {
            complete();
        }
        [self removeFromSuperview];
    }
}


//开始321
-(void)kaishidonghua:(UILabel *)lab currentNum:(int)num{
    kWeakSelf(self);
    __block int currentNum = num;
    [UIView animateWithDuration:1.0 animations:^{
        lab.transform = CGAffineTransformMakeScale(0.01, 0.01);
    } completion:^(BOOL finished) {
        [lab removeFromSuperview];
        [weakself createLable:--currentNum];
    }];
}

- (void)removeAnimationNow{
    [self.numLab.layer removeAllAnimations];
    [self.layer removeAllAnimations];
    [self removeAllSubViews];
    [self removeFromSuperview];
     
}

@end
