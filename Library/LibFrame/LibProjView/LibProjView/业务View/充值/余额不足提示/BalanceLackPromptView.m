//
//  BalanceLackPromptView.m
//  LibProjView
//
//  Created by klc_sl on 2020/11/3.
//  Copyright © 2020 KLC. All rights reserved.
//

#import "BalanceLackPromptView.h"
#import <LibProjBase/PopupTool.h>
#import <Masonry/Masonry.h>
#import <LibProjModel/KLCAppConfig.h>
#import <LibProjBase/LibProjBase.h>

@interface BalanceLackPromptView ()

@property (nonatomic, copy)void (^goToRechargeBlcok)(BOOL);

@end

@implementation BalanceLackPromptView

+ (void)gotoRecharge:(void (^)(BOOL))block {
    UIView *resultV = [PopupTool getPopupViewForClass:self];
    if (!resultV) {
        BalanceLackPromptView *resultV = [[BalanceLackPromptView alloc] init];
        resultV.goToRechargeBlcok = block;
        [resultV createView];
    }
}

- (void)createView{
    [[PopupTool share] createPopupViewWithLinkView:self allowTapOutside:NO cover:YES];
    [self mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(275, 275));
        make.center.equalTo(self.superview);
    }];
    [self layoutIfNeeded];
    self.layer.masksToBounds = YES;
    self.layer.cornerRadius = 10.0;
    
    self.backgroundColor = [UIColor whiteColor];
    
    ///状态图片
    UIImageView *stateImg = [[UIImageView alloc] initWithFrame:CGRectMake(0,32, 110, 110)];
    stateImg.centerX = self.width/2.0;
    stateImg.image = [UIImage imageNamed:@"balance_lack_coin"];
    [self addSubview:stateImg];
    ///状态文字
    UILabel *stateLab = [[UILabel alloc] initWithFrame:CGRectMake(10, stateImg.maxY+7, self.width-20, 28)];
    stateLab.font = [UIFont systemFontOfSize:14];
    stateLab.textColor = kRGBA_COLOR(@"#333333", 1.0);
    stateLab.textAlignment = NSTextAlignmentCenter;
    stateLab.text = [NSString stringWithFormat:kLocalizationMsg(@"您的%@余额不足啦!"),[KLCAppConfig unitStr]];
    [self addSubview:stateLab];

    UIButton *closeBtn = [[UIButton alloc] initWithFrame:CGRectMake(self.width-30-10, 10, 30, 30)];
    [closeBtn setImage:[UIImage imageNamed:@"live_guanbi_gray"] forState:UIControlStateNormal];
    [closeBtn setImageEdgeInsets:UIEdgeInsetsMake(4, 4, 4, 4)];
    [closeBtn addTarget:self action:@selector(cancelClick) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:closeBtn];
    
    ///去充值
    UIButton *sureBtn = [UIButton buttonWithType:0];
    sureBtn.frame = CGRectMake(60, self.height-40-32, 155, 40);
    [sureBtn setTitle:kLocalizationMsg(@"去充值") forState:UIControlStateNormal];
    sureBtn.titleLabel.font = [UIFont systemFontOfSize:14];
    [sureBtn setTitleColor:kRGBA_COLOR(@"#ffffff", 1.0) forState:UIControlStateNormal];
    [self addSubview:sureBtn];
    [sureBtn setBackgroundImage:[UIImage imageNamed:@"btn_bg_pink"] forState:UIControlStateNormal];
    [sureBtn addTarget:self action:@selector(sureBtnClick) forControlEvents:UIControlEventTouchUpInside];
    sureBtn.layer.masksToBounds = YES;
    sureBtn.layer.cornerRadius = 20.0;
}


- (void)cancelClick{
    if (_goToRechargeBlcok) {
        _goToRechargeBlcok(NO);
    }
    [[PopupTool share] closePopupView:self];
}

///点击去充值
- (void)sureBtnClick{
    if (_goToRechargeBlcok) {
        _goToRechargeBlcok(YES);
    }
    [RouteManager routeForName:RN_center_myAccountAC currentC:[ProjConfig currentVC]];
    [[PopupTool share] closePopupView:self];
}


@end
