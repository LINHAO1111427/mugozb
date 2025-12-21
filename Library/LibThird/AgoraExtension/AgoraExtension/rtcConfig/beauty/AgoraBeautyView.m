//
//  AgoraBeautyView.m
//  AgoraExtension
//
//  Created by kalacheng on 2020/6/13.
//  Copyright © 2020 kalacheng. All rights reserved.
//

#import "AgoraBeautyView.h"
#import <LibTools/LibTools.h>

const int agoraBeautySliderTag = 5556;

@interface AgoraBeautyView ()

@property (nonatomic, assign) CGFloat brightLevel; // 亮度
@property (nonatomic, assign) CGFloat smoothnessLevel; // 磨皮
@property (nonatomic, assign) CGFloat rednessLevel; // 红润

@property (nonatomic, copy)void (^complete)(void);
@property (nonatomic, copy)void (^selectHandle)(CGFloat,CGFloat, CGFloat);
@property (nonatomic, weak)UIView *bgView;
@property (nonatomic, weak)UIControl *coverBgView;

@end

@implementation AgoraBeautyView

- (void)dealloc
{
    _complete = nil;
    _selectHandle = nil;
    _bgView = nil;
    _coverBgView = nil;
    [self removeFromSuperview];
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self createView];
    }
    return self;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self createView];
    }
    return self;
}

- (void)showWithSelectHandle:(void (^)(CGFloat,CGFloat, CGFloat))handle complete:(void (^)(void))complete{
    _complete = complete;
    _selectHandle = handle;
    self.hidden = NO;
    [self viewIsShow:YES];
}

- (void)createView{
    _rednessLevel = 0;
    _smoothnessLevel = 0;
    _brightLevel = 0;
    
    UIWindow *win = [UIApplication sharedApplication].keyWindow;
    self.frame = win.bounds;
    self.hidden = YES;
    [win addSubview:self];
    
    if (!_bgView && !_coverBgView) {
        [self createSubView];
    }
}

-(void)createSubView{
    
    NSArray *arr = @[kLocalizationMsg(@"红润"),kLocalizationMsg(@"美肤"),kLocalizationMsg(@"亮度")];
    float top = 20.0;
    float height = 50.0;
    
    UIView *bgV = [[UIView alloc] initWithFrame:CGRectMake(0, kScreenHeight, kScreenWidth, arr.count*height+top*2)];
    [self addSubview:bgV];
    _bgView = bgV;
    
    UIControl *tapBgView = [[UIControl alloc] initWithFrame:self.bounds];
    tapBgView.hidden = YES;
    tapBgView.backgroundColor = [UIColor clearColor];
    [tapBgView addTarget:self action:@selector(tapView) forControlEvents:UIControlEventTouchUpInside];
    [self insertSubview:tapBgView atIndex:0];
    _coverBgView = tapBgView;

    UIView *coverV = [[UIView alloc] initWithFrame:self.bounds];
    coverV.backgroundColor = [UIColor blackColor];
    coverV.alpha = 0.5;
    [bgV addSubview:coverV];
    
    for (int i = 0; i < arr.count; i++) {
        UIView * lineBgV = [[UIView alloc] initWithFrame:CGRectMake(0, top+i*height, bgV.frame.size.width, height)];
        [bgV addSubview:lineBgV];
        
        //文字
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(20, 0, 60, lineBgV.frame.size.height)];
        label.text = arr[i];
        label.textColor = [UIColor whiteColor];
        label.font = [UIFont systemFontOfSize:15];
        [lineBgV addSubview:label];
        
        //滑块
        UISlider *slider = [[UISlider alloc] initWithFrame:CGRectMake(80, 0 ,lineBgV.frame.size.width - 80 - 60, lineBgV.frame.size.height)];
        slider.tag = agoraBeautySliderTag+i;
        slider.minimumValue = 0.0;
        slider.maximumValue = 100.0;
        slider.value = 50.0;
        slider.maximumTrackTintColor = [[UIColor whiteColor] colorWithAlphaComponent:0.4];
        slider.minimumTrackTintColor = [UIColor colorWithRed:220.0/255.0 green:146.0/255.0 blue:245.0/255.0 alpha:1.0];
        [slider setThumbImage:[UIImage imageNamed:@"slider"] forState:UIControlStateNormal];
        [slider addTarget:self action:@selector(sliderValueDidChanged:) forControlEvents:UIControlEventValueChanged];
        [lineBgV addSubview:slider];

        //数值
        UILabel *valueLabel = [[UILabel alloc] initWithFrame:CGRectMake(lineBgV.frame.size.width - 60, 0, 60, lineBgV.frame.size.height)];
        valueLabel.textColor = [UIColor whiteColor];
        valueLabel.font = [UIFont systemFontOfSize:15];
        valueLabel.textAlignment = NSTextAlignmentCenter;
        valueLabel.text = [NSString stringWithFormat:@"%0.f",slider.value];
        valueLabel.tag = agoraBeautySliderTag+i+5;
        [lineBgV addSubview:valueLabel];
    }
    
}

-(void)sliderValueDidChanged:(UISlider *)slider{

    UILabel *lab = (UILabel *)[slider.superview viewWithTag:slider.tag+5];
    
    lab.text = [NSString stringWithFormat:@"%0.f",slider.value];
    
    switch (slider.tag - agoraBeautySliderTag) {
        case 0:
            _rednessLevel = slider.value/100.0;
            break;
        case 1:
            _smoothnessLevel = slider.value/100.0;
            break;
        case 2:
            _brightLevel = slider.value/100.0;
            break;
        default:
            break;
    }
    
    if (_selectHandle) {
        _selectHandle(_rednessLevel,_smoothnessLevel,_brightLevel);
    }

}

- (void)viewIsShow:(BOOL)isShow{
    _coverBgView.hidden = !isShow;
    kWeakSelf(self);
    [UIView animateWithDuration:0.3 animations:^{
        
        CGRect rc = weakself.bgView.frame;
        rc.origin.y =  kScreenHeight - (isShow?rc.size.height:0);
        weakself.bgView.frame = rc;
        
    } completion:^(BOOL finished) {
        if (!isShow) {
            self.hidden = YES;
            if (weakself.complete) {
                weakself.complete();
            }
            weakself.complete = nil;
            weakself.selectHandle = nil;
        }
    }];
}

-(void)tapView{
    [self viewIsShow:NO];
}

@end
