//
//  AnchorWaitAlert.m
//  klc
//
//  Created by David on 16/5/21.
//  Copyright © 2018年 David. All rights reserved.
//

#import "AnchorWaitAlert.h"
#import <LibTools/LibTools.h>
#import <LiveCommon/LiveManager.h>
#import <LibProjBase/LibProjBase.h>
#import <LibProjView/KlcAvatarView.h>

@interface AnchorWaitAlert ()

@property (nonatomic, weak)UIView *alertV;

@property (nonatomic, weak)UILabel *timeL;

@property (nonatomic, copy)TimerBlock *timer;

@end

@implementation AnchorWaitAlert

- (instancetype)initWithUserName:(NSString *)uname avatar:(nonnull NSString *)avatar content:(nonnull NSString *)content timeCount:(int)timeCount
{
    self = [super init];
    if (self) {
        int count = timeCount == 0 ? 10 : timeCount;
        [self creatUIWithUname:uname avatar:avatar content:content timeCount:count];
    }
    return self;
}


- (void)creatUIWithUname:(NSString *)uname avatar:(NSString *)avatar content:(NSString *)content timeCount:(int)count{
    CGFloat alertW = kScreenWidth/3.0*2.0;
    CGFloat alertH = 170;
    
    UIView *alertView = [[UIView alloc] initWithFrame:CGRectMake((kScreenWidth-alertW)/2.0, (kScreenHeight-alertH)/2.0, alertW, alertH)];
    alertView.layer.masksToBounds = YES;
    alertView.layer.cornerRadius = 8.0;
    _alertV = alertView;
    
    alertView.backgroundColor = [UIColor whiteColor];
    
    KlcAvatarView *userIcon = [[KlcAvatarView alloc] initWithFrame:CGRectMake(0, 20, 40, 40)];
    [alertView addSubview:userIcon];
    userIcon.centerX = alertView.width/2.0;
    [userIcon showUserIconUrl:avatar vipBorderUrl:nil];
    
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(0, userIcon.maxY+10, alertW, 20)];
    label.text = uname;
    label.textAlignment = NSTextAlignmentCenter;
    label.font = [UIFont systemFontOfSize:15];
    [alertView addSubview:label];
    
    UILabel *timeL = [[UILabel alloc] initWithFrame:CGRectMake(0, alertH-40-15-10, alertW, 15)];
    timeL.font = [UIFont systemFontOfSize:12];
    timeL.textAlignment = NSTextAlignmentCenter;
    timeL.textColor = [UIColor blackColor];
    [alertView addSubview:timeL];
    _timeL = timeL;
    
    NSArray *arr = @[kLocalizationMsg(@"拒绝"),kLocalizationMsg(@"接受")];
    for (int i = 0; i < arr.count; i++) {
        UIButton *btn = [UIButton buttonWithType:0];
        btn.frame = CGRectMake(i*alertW/2, alertH-40, alertW/2, 40);
        btn.tag = 1000+i;
        [btn setTitle:arr[i] forState:0];
        if (i == 0) {
            [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        }else{
            [btn setTitleColor:[ProjConfig normalColors] forState:UIControlStateNormal];
        }
        btn.titleLabel.font = [UIFont systemFontOfSize:12];
        [btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
        [alertView addSubview:btn];
    }
    
    UIView *line1 = [[UIView alloc] initWithFrame:CGRectMake(0, alertH-40, alertW, 0.8)];
    line1.backgroundColor = [UIColor lightGrayColor];
    [alertView addSubview:line1];
    
    UIView *line2 = [[UIView alloc] initWithFrame:CGRectMake(alertW/2.0, alertH-40, 0.8, 40)];
    line2.backgroundColor = [UIColor lightGrayColor];
    [alertView addSubview:line2];
    
    
    [[PopupTool share] createPopupViewWithLinkView:alertView allowTapOutside:NO];
    
    if (!_timer) {
        _timer = [[TimerBlock alloc] init];
        kWeakSelf(self);
        [_timer startTimerForTotalTime:count IntervalTime:1.0 progress:^(CGFloat progress) {
            
            weakself.timeL.text = [NSString stringWithFormat:@"%@(%0.0fs)...", content, count - progress];
            
        } finish:^{
            
            [weakself.timer stopTimer];
            weakself.timer = nil;
            [weakself dismissView];
            if (weakself.timeIsEndHandle) {
                weakself.timeIsEndHandle();
            }
        }];
    }
}


- (void)dismiss{
    [self dismissView];
}

- (void)dismissView{
    [[PopupTool share] closePopupView:self.alertV];
}

- (void)btnClick:(UIButton *)sender{
    [_timer stopTimer];
    _timer = nil;
    [self dismissView];
    if (sender.tag == 1000) {
        //不同意
        if (self.selectIndexHandle) {
            self.selectIndexHandle(2);
        }
    }else{
        if (self.selectIndexHandle) {
            self.selectIndexHandle(1);
        }
        //同意
    }
}



@end
