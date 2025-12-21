//
//  CoinInsufficientTipView.m
//  OneVideoLive
//
//  Created by CH on 2019/12/31.
//  Copyright © 2019 Orely. All rights reserved.
//

#import "CoinInsufficientTipView.h"
#import <Masonry/Masonry.h>
#import <LibTools/LibTools.h>
#import <LiveCommon/LiveManager.h>
#import <LiveCommon/LiveComponentMsgListener.h>
#import <LiveCommon/LiveComponentMsgMgr.h>
#import <LibTools/LibTools.h>
#import <LibProjBase/ProjConfig.h>

@interface CoinInsufficientTipView ()

/// 关闭按钮
@property(nonatomic,weak) UIButton *closeBtn;

/// 提示框壁纸
@property(nonatomic,weak) UIImageView *tipsImgView;

/// 标题lb
@property(nonatomic,weak) UILabel *tipsTitle;

/// 第一条提示
@property(nonatomic,weak) UILabel *firstTitle;

/// 第二条提示
@property(nonatomic,weak) UILabel *secondTitle;

/// 确认按钮
@property(nonatomic,weak) UIButton *confirmBtn;


@property (nonatomic, copy)TimerBlock *timer;

@end

@implementation CoinInsufficientTipView


- (void)dealloc
{
    [_timer stopTimer];
    _timer = nil;
}

// MARK: - Public

- (void)showFromDic:(NSDictionary *)dic{
    NSInteger type = [dic[@"type"] integerValue];
    
    if (type == 1) { // 提示

        
    }
    else{   // 结算
        [_tipsImgView setImage:nil];
        _tipsTitle.text = kLocalizationMsg(@"通话结束");
    }
}


+ (void)showLastTime:(int)second{
    UIView *tipV = [PopupTool getPopupViewForClass:[self class]];
    if (!tipV) {
        CoinInsufficientTipView *tipV = [[CoinInsufficientTipView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight)];
        [tipV showLastTime:second];
        [tipV showSelf];
    }
}

///显示剩余时间
- (void)showLastTime:(int)second{
    if (_timer == nil) {
        _timer = [[TimerBlock alloc] init];
    }
    self.tipsTitle.text = kLocalizationMsg(@"提示");
    [self.tipsImgView setImage:[UIImage imageNamed:@"oto_lijichongzhi_bg"]];

    kWeakSelf(self);
    [_timer startTimerForTotalTime:5.0 IntervalTime:1.0 progress:^(CGFloat progress) {
        if (second >= progress) {
            int timeCount = second - (int)progress;
            int hh = timeCount / 60;
            int ss = timeCount % 60;
            weakself.secondTitle.text = [NSString stringWithFormat:kLocalizationMsg(@"剩余时间 %02d:%02d"),hh,ss];
        }
    } finish:^{
        [weakself removeSelf];
    }];
    
    if ([LiveManager liveInfo].roomRole != RoomRoleForAnchor) {///其他人
        self.firstTitle.text = kLocalizationMsg(@"你的余额不足");
        [self.confirmBtn setTitle:kLocalizationMsg(@"立即充值") forState:UIControlStateNormal];
        [self.confirmBtn setTitleColor: kRGB_COLOR(@"#F76750") forState:UIControlStateNormal];
    }else{    ///主播

    }
    [self.confirmBtn addTarget:self action:@selector(sureBtnClick) forControlEvents:UIControlEventTouchUpInside];
    
}



///结果显示的时间和金币
- (void)showResultWithTotalTime:(int64_t)time coin:(int)coin{
    self.tipsTitle.text = kLocalizationMsg(@"通话结束");
    [self.tipsImgView setImage:[UIImage imageNamed:@"oto_finish_bg"]];
    
    self.firstTitle.text = [NSString stringWithFormat:kLocalizationMsg(@"通话时长 %@"),[NSString changeShowTimeForSecond:time]];
    [self.closeBtn addTarget:self action:@selector(cancelBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [self.confirmBtn setTitle:kLocalizationMsg(@"确定") forState:UIControlStateNormal];
    [self.confirmBtn setTitleColor: kRGB_COLOR(@"#F76750") forState:UIControlStateNormal];
    [self.confirmBtn addTarget:self action:@selector(exitRoomClick) forControlEvents:UIControlEventTouchUpInside];
    
    if ([LiveManager liveInfo].roomRole == RoomRoleForAnchor) { ///主播
        NSTextAttachment *countImgAtt = [[NSTextAttachment alloc] init];
        countImgAtt.image = [ProjConfig getCoinImage];
        countImgAtt.bounds = CGRectMake(0, -1, 14, 14);
        NSAttributedString *collegeStr = [NSAttributedString attributedStringWithAttachment:countImgAtt];
        NSAttributedString *collegeStr2 = [[NSAttributedString alloc] initWithString:[NSString stringWithFormat:@" %d",coin] attributes:@{NSFontAttributeName : [UIFont systemFontOfSize:12],NSForegroundColorAttributeName:[UIColor whiteColor]}];
        NSMutableAttributedString *countAttM = [[NSMutableAttributedString alloc] initWithAttributedString:collegeStr];
        [countAttM appendAttributedString:collegeStr2];
        [countAttM insertAttributedString:[[NSAttributedString alloc] initWithString:kLocalizationMsg(@"获得收入 ")] atIndex:0];
        _secondTitle.attributedText = countAttM;
    }
    
    [self showSelf];
}

- (void)showSelf{
    [[PopupTool share] createPopupViewWithLinkView:self allowTapOutside:NO];
    kWeakSelf(self);
    [UIView animateWithDuration:0.3 animations:^{
        weakself.backgroundColor =kRGBA_COLOR(@"#000000", 0.4);
        CGRect rc = weakself.tipsImgView.frame;
        rc.origin.y = (kScreenHeight-rc.size.height)/2.0;
        weakself.tipsImgView.frame = rc;
    }];
}

- (void)removeSelf{
    [[PopupTool share] closePopupView:self];
    [self removeFromSuperview];
}

- (void)cancelBtnClick{
    [self removeSelf];
}

- (void)sureBtnClick{
    if ([LiveManager liveInfo].roomRole == RoomRoleForAnchor) { ///删除自己
        
    }else{   ///充值
        [LiveComponentMsgMgr sendMsg:LM_GotoRecharge msgDic:nil];
    }
    [self removeSelf];
}

- (void)exitRoomClick{
    [LiveComponentMsgMgr sendMsg:LM_ExitRoom msgDic:nil];
    [self removeSelf];
}


// MARK: - Private
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        self.backgroundColor =kRGBA_COLOR(@"#000000", 0.0);
        
        ///背景视图
        UIImageView *tipsImgView = [[UIImageView alloc] init];
        tipsImgView.userInteractionEnabled = YES;
        tipsImgView.frame = CGRectMake((kScreenWidth-270)/2.0, kScreenHeight, 270, 166);
        [tipsImgView setImage:nil];
        [self addSubview:tipsImgView];
        _tipsImgView = tipsImgView;
        
        ///关闭按钮
        UIButton *closeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [closeBtn setImage:[UIImage imageNamed:@"live_guanbi_circle"] forState:UIControlStateNormal];
        [self addSubview:closeBtn];
        _closeBtn = closeBtn;
        
        ///确认按钮
        UIButton *confirmBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        confirmBtn.backgroundColor = [UIColor whiteColor];
        confirmBtn.layer.masksToBounds = YES;
        [tipsImgView addSubview:confirmBtn];
        _confirmBtn = confirmBtn;
        
        ///提示文字
        UILabel *tipsTitle = [[UILabel alloc] init];
        [tipsTitle setFont:[UIFont systemFontOfSize:15]];
        [tipsTitle setTextColor:[UIColor whiteColor]];
        [tipsImgView addSubview:tipsTitle];
        _tipsTitle = tipsTitle;
        
        ///第一行文字
        UILabel *firstTitle = [[UILabel alloc] init];
        [firstTitle setFont:[UIFont systemFontOfSize:14]];
        [firstTitle setTextColor:[UIColor whiteColor]];
        [tipsImgView addSubview:firstTitle];
        _firstTitle = firstTitle;
        
        ///第二行文字
        UILabel *secondTitle = [[UILabel alloc] init];
        [secondTitle setFont:[UIFont systemFontOfSize:14]];
        [secondTitle setTextColor:[UIColor whiteColor]];
        [tipsImgView addSubview:secondTitle];
        _secondTitle = secondTitle;
        
        [_closeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.equalTo(_tipsImgView.mas_top).mas_offset(-10);
            make.right.equalTo(_tipsImgView.mas_right);
            make.size.mas_equalTo(CGSizeMake(24, 24));
        }];
        
        [_confirmBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(_tipsImgView.mas_right).mas_offset(-24);
            make.bottom.equalTo(_tipsImgView.mas_bottom).mas_offset(-22);
            make.size.mas_equalTo(CGSizeMake(110, 34));
        }];
        
        [_tipsTitle mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(_tipsImgView).mas_offset(22);
            make.centerX.equalTo(_confirmBtn);
        }];
        
        [_firstTitle mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(_tipsTitle.mas_bottom).mas_offset(18);
            make.centerX.equalTo(_confirmBtn);
        }];
        
        [_secondTitle mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(_firstTitle.mas_bottom).mas_offset(8);
            make.centerX.equalTo(_confirmBtn);
        }];
        
        [self.confirmBtn layoutIfNeeded];
        self.confirmBtn.layer.cornerRadius = self.confirmBtn.frame.size.height / 2;
    
    }
    return self;
}



@end
