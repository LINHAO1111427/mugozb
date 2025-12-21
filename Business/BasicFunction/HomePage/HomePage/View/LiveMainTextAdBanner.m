//
//  LiveMainTextAdBanner.m
//  ShortVideo
//
//  Created by klc_sl on 2021/5/24.
//  Copyright © 2021 KLC. All rights reserved.
//

#import "LiveMainTextAdBanner.h"
#import <LibProjView/AutoLableScrollView.h>
#import <Masonry/Masonry.h>

@interface LiveMainTextAdBanner ()
///文字滚动
@property(nonatomic, weak)AutoLableScrollView *labelScollV;

@property(nonatomic, weak)UIButton *titleBtn;

@end

@implementation LiveMainTextAdBanner

- (void)dealloc
{
    [_labelScollV stopScroll];
    [_labelScollV removeFromSuperview];
    _labelScollV = nil;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self createUIView];
    }
    return self;
}

- (void)createUIView{
    
    UIButton *btn = [UIButton buttonWithType:0];
    btn.userInteractionEnabled = NO;
    [btn setBackgroundImage:[UIImage imageNamed:@"focus_labbanner_title"] forState:UIControlStateNormal];
    [self addSubview:btn];
    [btn setTitle:kLocalizationMsg(@"系统公告") forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    btn.titleLabel.font = [UIFont systemFontOfSize:15];
    _titleBtn = btn;
    [btn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.equalTo(self);
        make.left.equalTo(self).offset(5);
        make.width.mas_equalTo(100);
    }];
    self.labelScollV.hidden = NO;
    
}

- (AutoLableScrollView *)labelScollV{
    if (!_labelScollV) {
        AutoLableScrollView *labelScollV = [[AutoLableScrollView alloc] init];
        labelScollV.textColor = [UIColor redColor];
        labelScollV.font = [UIFont systemFontOfSize:15];
        labelScollV.backgroundColor = [UIColor clearColor];
        [self addSubview:labelScollV];
        _labelScollV = labelScollV;
        [self sendSubviewToBack:labelScollV];
        [labelScollV mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.bottom.equalTo(self);
            make.right.equalTo(self).offset(0);
            make.left.equalTo(self.titleBtn.mas_right).offset(-3);
        }];
    }
    return _labelScollV;
}


///显示广告文字
- (void)showAdText:(NSString *)adText{
    if (adText.length > 0) {
        [self.labelScollV stopScroll];
        [self.labelScollV removeFromSuperview];
        self.labelScollV = nil;
        [self.labelScollV startScroll:adText];
    }else{
        [_labelScollV stopScroll];
        [_labelScollV removeFromSuperview];
        _labelScollV = nil;
    }
}

///是否滚动
- (void)adBannerisScroll:(BOOL)scroll{
    scroll?[_labelScollV resumeScroll]:[_labelScollV pauseScroll];
}


@end
