//
//  GiftSendView.m
//  MPVideoLive
//
//  Created by admin on 2019/8/5.
//  Copyright © 2019 cat. All rights reserved.
//

#import "GiftSendView.h"
#import "SelectGiftNumObj.h"
#import <objc/runtime.h>
#import <LibTools/LibTools.h>
#import <Masonry/Masonry.h>
#import <LibProjBase/LibProjBase.h>
#import <LibProjModel/KLCAppConfig.h>

@interface GiftSendView ()

@property (nonatomic, weak)UILabel *coinLab;        //金币lab
@property (nonatomic, weak)UIButton *giftCountBgBtn;   //选择数量按钮
@property (nonatomic, weak)UIButton *continuBtn;    //连发按钮
@property (nonatomic, weak)UIView *sendBgView;   //发送按钮的背景视图
@property (nonatomic, weak)UILabel *rechangeLab;   //充值按钮文字
@property (nonatomic, weak)UIButton *rechangeBtn;    //充值按钮


@property (nonatomic, strong)SelectGiftNumObj *selectNumObj;

@property (nonatomic, copy)TimerBlock *timerBlock;  //连发计时器

@property (nonatomic, assign)BOOL isShowNum;   //是否可选择多数量


@end

@implementation GiftSendView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self createView];
    }
    return self;
}

- (TimerBlock *)timerBlock{
    if (!_timerBlock) {
        _timerBlock = [[TimerBlock alloc] init];
    }
    return _timerBlock;
}

- (void)dealloc
{
    _selectNumObj = nil;
    [_timerBlock stopTimer];
    _timerBlock = nil;
    objc_removeAssociatedObjects(_giftCountBgBtn);
}

- (void)createView{
    [self.selectNumObj loadGiftNumberList];
    //价钱
    UILabel *price = [[UILabel alloc] init];
    price.text = @"0";
    price.font = [UIFont systemFontOfSize:14];
    price.textColor = [UIColor whiteColor];
    [self addSubview:price];
    _coinLab = price;
    
    //充值
    UIButton *rechangeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    rechangeBtn.layer.masksToBounds = YES;
    [rechangeBtn addTarget:self action:@selector(chongzhiClick:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:rechangeBtn];
    _rechangeBtn = rechangeBtn;
    
    // Background Code
    CAGradientLayer *gl = [CAGradientLayer layer];
    gl.frame = CGRectMake(0, 0, 90, 30);
    gl.startPoint = CGPointMake(0.50, 0.00);
    gl.endPoint = CGPointMake(0.50, 1.00);
    gl.colors = @[
    (__bridge id)[UIColor colorWithRed:254/255.0 green:215/255.0 blue:49/255.0 alpha:1.0].CGColor,
    (__bridge id)[UIColor colorWithRed:254/255.0 green:143/255.0 blue:58/255.0 alpha:1.0].CGColor,
    ];
    gl.locations = @[@(0),@(1.0f)];
    [rechangeBtn.layer addSublayer:gl];
    
    //连发文字
    UILabel *rechangeLab = [[UILabel alloc] init];
    rechangeLab.textAlignment = NSTextAlignmentCenter;
    rechangeLab.textColor = [UIColor whiteColor];
    rechangeLab.text = kLocalizationMsg(@"充值");
    rechangeLab.adjustsFontSizeToFitWidth = YES;
    rechangeLab.minimumScaleFactor = 6;
    rechangeLab.font = [UIFont systemFontOfSize:12];
    [rechangeBtn addSubview:rechangeLab];
    _rechangeLab = rechangeLab;
    
    ///做隐藏用 赠送背景view
    UIView *sengBgView = [[UIView alloc] init];
    sengBgView.backgroundColor = kRGBA_COLOR(@"#4D324C", 1.0);
    sengBgView.layer.masksToBounds = YES;
    [self addSubview:sengBgView];
    _sendBgView = sengBgView;
    
    //赠送按钮
    UIButton *sendBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    sendBtn.layer.masksToBounds = YES;
    [sendBtn setTitle:kLocalizationMsg(@"赠送") forState:UIControlStateNormal];
    sendBtn.titleLabel.font = [UIFont systemFontOfSize:13];
    [sendBtn setBackgroundImage:[UIImage imageNamed:@"btn_bg_pink"] forState:UIControlStateNormal];
    [sendBtn addTarget:self action:@selector(btnClickSendData:) forControlEvents:UIControlEventTouchUpInside];
    [sengBgView addSubview:sendBtn];
    
    
    UIImageView *imgV = [[UIImageView alloc] init];
    imgV.image = [UIImage imageNamed:@"right_jiantou_white"];
    [sengBgView addSubview:imgV];
    
    //数量
    UIButton *selectGiftCountBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [selectGiftCountBtn addTarget:self action:@selector(giftCountBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    selectGiftCountBtn.hidden = YES;
    [sengBgView addSubview:selectGiftCountBtn];
    selectGiftCountBtn.layer.masksToBounds = YES;
    selectGiftCountBtn.layer.cornerRadius = 5;
    [selectGiftCountBtn setContentEdgeInsets:UIEdgeInsetsMake(0, 5, 0, 5)];
    selectGiftCountBtn.titleLabel.font = [UIFont systemFontOfSize:13];
    [selectGiftCountBtn setTitle:@"1" forState:UIControlStateNormal];
    [selectGiftCountBtn setBackgroundColor:[UIColor clearColor]];
    _giftCountBgBtn = selectGiftCountBtn;
    
    
    //连发
    UIButton *lianfaBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [lianfaBtn setBackgroundImage:[UIImage imageNamed:@"gift_continue_btn"] forState:UIControlStateNormal];
    lianfaBtn.hidden = YES;
    lianfaBtn.titleLabel.font = [UIFont systemFontOfSize:14 weight:UIFontWeightMedium];
    [lianfaBtn addTarget:self action:@selector(btnClickSendData:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:lianfaBtn];
    _continuBtn = lianfaBtn;
    
    [price mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self);
        make.left.equalTo(self).mas_offset(15);
    }];
    [rechangeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(60, 30));
        make.centerY.equalTo(self);
        make.left.equalTo(price.mas_right).mas_offset(15);
    }];
    [rechangeBtn layoutIfNeeded];
    rechangeBtn.layer.cornerRadius = 15;
    [rechangeLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(rechangeBtn);
        make.right.equalTo(rechangeBtn).offset(-5);
        make.left.equalTo(rechangeBtn).offset(5);
    }];
    
    [sengBgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self).mas_offset(-15);
        make.centerY.equalTo(rechangeBtn);
    }];
    
    [sendBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(60, 30));
        make.centerY.equalTo(sengBgView);
        make.right.equalTo(sengBgView).mas_offset(0);
        make.top.bottom.equalTo(sengBgView);
    }];
    
    [sendBtn layoutIfNeeded];
    sendBtn.layer.cornerRadius = sendBtn.height/2.0;
    sengBgView.layer.cornerRadius = sendBtn.height/2.0;
    
    [imgV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(10, 10));
        make.centerY.equalTo(sengBgView);
        make.right.equalTo(sendBtn.mas_left).offset(-10);
    }];
    
    [selectGiftCountBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.equalTo(sengBgView);
        make.width.greaterThanOrEqualTo(@20);
        make.centerY.equalTo(sengBgView);
        make.right.equalTo(imgV.mas_left).mas_offset(-0);
        make.left.equalTo(sengBgView).offset(10);
    }];

    [lianfaBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(115, 45));
        make.right.equalTo(self).mas_offset(-11);
        make.centerY.equalTo(self);
    }];
}


- (void)selectOneGift:(int)giftType{
    if (giftType < 1000) {
        self.isShowNum = YES;
    }else{
        self.isShowNum = NO;
    }
//    self.isShowNum = (giftType == 1)?NO:YES;
    self.selectNumObj.selectIndex = 0;
}

- (void)setIsShowNum:(BOOL)isShowNum{
    _isShowNum = isShowNum;
    _giftCountBgBtn.hidden = !isShowNum;
    _continuBtn.hidden = YES;
    _sendBgView.hidden = NO;
}

- (void)sendGiftResult:(BOOL)success{
    _sendBgView.userInteractionEnabled = YES;
    _continuBtn.userInteractionEnabled = YES;
    ///所有礼物都显示连送按钮
    if (_isContinue && success) {
        _continuBtn.hidden = NO;
        _sendBgView.hidden = YES;
        [self showLianfaTime];
    }
}

- (void)reShowPackTotalCoin:(double)totalCoin lastCoin:(double)lastCoin giftType:(int)giftType{
   // NSLog(@"过滤文字%0.0lf     %0.0lf"), lastCoin,totalCoin);
    
    NSString *showStr = @"";
    NSString *btnTitleStr = @"";
    if (giftType == 4) {
        showStr = [NSString stringWithFormat:kLocalizationMsg(@"价值:%.0f"),totalCoin];
        btnTitleStr = kLocalizationMsg(@"一键赠送所有");
        self.rechangeBtn.tag = 99782;
        [self.rechangeBtn mas_updateConstraints:^(MASConstraintMaker *make) {
            make.width.mas_equalTo(90);
        }];
    }else{
        showStr = [NSString stringWithFormat:kLocalizationMsg(@"余额:%.0f"),lastCoin];
        btnTitleStr = kLocalizationMsg(@"充值");
        self.rechangeBtn.tag = 99781;
        [self.rechangeBtn mas_updateConstraints:^(MASConstraintMaker *make) {
            make.width.mas_equalTo(60);
        }];
    }
    _coinLab.attributedText = [showStr attachmentForImage:[ProjConfig getCoinImage] bounds:CGRectMake(0, -2, 13, 13) before:YES];
    self.rechangeLab.text = btnTitleStr;
}


- (void)btnClickSendData:(UIButton *)btn{
    _sendBgView.userInteractionEnabled = NO;
    _continuBtn.userInteractionEnabled = NO;
    self.sendBtnClick?self.sendBtnClick([_giftCountBgBtn.titleLabel.text intValue]):nil;
}

- (SelectGiftNumObj *)selectNumObj{
    if (!_selectNumObj) {
        _selectNumObj = [[SelectGiftNumObj alloc] init];
        kWeakSelf(self);
        _selectNumObj.selectBlock = ^(NSString * _Nonnull count) {
            [weakself.giftCountBgBtn setTitle:count forState:UIControlStateNormal];
        };
    }
    return _selectNumObj;
}

//显示连发时间
-(void)showLianfaTime{
    int lianfanTotalNum = [[ProjConfig shareInstence].baseConfig sendGiftContinueTime];
    __block int lianfanNum = lianfanTotalNum;
    [self.timerBlock stopTimer];
    kWeakSelf(self);
    [self.timerBlock startTimerForSecondBlock:^(CGFloat progress) {
        if (lianfanNum == 0) {
            [weakself.timerBlock stopTimer];
            weakself.timerBlock = nil;
            weakself.continuBtn.hidden = YES;
            weakself.sendBgView.hidden = NO;
            [weakself.continuBtn setTitle:[NSString stringWithFormat:kLocalizationMsg(@"连发(%ds)"),lianfanTotalNum] forState:UIControlStateNormal];
        }
        [weakself.continuBtn setTitle:[NSString stringWithFormat:kLocalizationMsg(@"连发(%ds)"),lianfanNum] forState:UIControlStateNormal];
        --lianfanNum;
    }];
}


//点击选择选择数量
- (void)giftCountBtnClick:(UIButton *)sender{
    [self.selectNumObj show];
}


- (void)chongzhiClick:(UIButton *)btn{
    self.rechangeBtnClick?self.rechangeBtnClick(btn.tag == 99781?YES:NO):nil;
}

// 在自定义UITabBar中重写以下方法，其中self.button就是那个希望被触发点击事件的按钮
- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event {
    UIView *view = [super hitTest:point withEvent:event];
    if (view == nil) {
        // 转换坐标系
        CGPoint newPoint = [_continuBtn convertPoint:point fromView:self];
        // 判断触摸点是否在button上
        if (CGRectContainsPoint(_continuBtn.bounds, newPoint)) {
            view = _continuBtn;
        }
    }
    return view;
}

@end
