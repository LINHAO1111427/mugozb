//
//  LiveInViolationHintView.m
//  LibProjView
//
//  Created by ssssssss on 2020/11/9.
//  Copyright © 2020 KLC. All rights reserved.
//

#import "LiveInViolationHintView.h"
#import <LibProjBase/PopupTool.h>
#import <LibTools/TimerBlock.h>
#import <LibTools/LibTools.h>
#import <LibProjBase/LibProjBase.h>
#import <Masonry/Masonry.h>

@interface LiveInViolationHintView()

@property (nonatomic, copy)TimerBlock *timeBlock;

@property (nonatomic, weak)UILabel *showTimeL;

@end

@implementation LiveInViolationHintView



+ (void)showForbidTipView:(NSString *)hint showTime:(int)time {
    
    LiveInViolationHintView *showView = [[LiveInViolationHintView alloc]initWithFrame:[UIScreen mainScreen].bounds];
    [showView createUI:hint showTime:time];
    [[PopupTool share] createPopupViewWithLinkView:showView allowTapOutside:NO];
    
}


- (TimerBlock *)timeBlock{
    if (!_timeBlock) {
        _timeBlock = [[TimerBlock alloc] init];
    }
    return _timeBlock;
}


- (void)createUI:(NSString *)hint showTime:(int)time {
    
    self.backgroundColor = [UIColor blackColor];
    
    UIView *tipBgCenterV = [[UIView alloc] init];
    [self addSubview:tipBgCenterV];
    [tipBgCenterV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self);
        make.left.equalTo(self).offset(15);
        make.right.equalTo(self).offset(-15);
    }];
    
    
    ///提示文字
    UILabel *tipL = [[UILabel alloc]initWithFrame:CGRectMake(12, 0, kScreenWidth-24, 40)];
    tipL.textColor = [UIColor whiteColor];
    tipL.numberOfLines = 0;
    tipL.font = [UIFont systemFontOfSize:16];
    tipL.textAlignment = NSTextAlignmentCenter;
    tipL.text = hint;
    [tipBgCenterV addSubview:tipL];
    
    ///提示时间
    UILabel *timeL = [[UILabel alloc]init];
    timeL.textColor = [UIColor lightTextColor];
    timeL.font = [UIFont systemFontOfSize:14];
    [tipBgCenterV addSubview:timeL];
    self.showTimeL = timeL;
    [tipL mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.equalTo(tipBgCenterV);
    }];
    
    [timeL mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(tipBgCenterV);
        make.centerX.equalTo(tipBgCenterV);
        make.height.mas_equalTo(20);
        make.top.equalTo(tipL.mas_bottom).offset(30);
    }];
    
    kWeakSelf(self);
    [self.timeBlock startTimerForTotalTime:time IntervalTime:1.0 progress:^(CGFloat progress) {
        weakself.showTimeL.text = [NSString stringWithFormat:kLocalizationMsg(@"%0.0lfs后自动关闭"),time-progress];
    } finish:^{
        [weakself dismissForbidTipView];
    }];
    
}


- (void)dismissForbidTipView{
    [self.timeBlock stopTimer];
    self.timeBlock = nil;
    [[PopupTool share] closePopupView:self];
    [self removeAllSubViews];
    
}


@end
