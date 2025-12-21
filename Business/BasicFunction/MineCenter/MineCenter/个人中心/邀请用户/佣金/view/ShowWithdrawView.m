//
//  ShowWithdrawView.m
//  MineCenter
//
//  Created by shirley on 2021/12/8.
//  Copyright © 2021 KLC. All rights reserved.
//

#import "ShowWithdrawView.h"
#import <LibTools/LibTools.h>
#import <LibProjBase/LibProjBase.h>
#import <LibProjModel/RechargeCenterVOModel.h>
#import <LibProjModel/FixedWithdrawRuleVOModel.h>
#import "WtihdarwSelectedBtn.h"
#import <LibProjModel/HttpApiAPPFinance.h>
#import <LibProjModel/AppUsersCashAccountModel.h>

@implementation ShowWithdrawView
{
    CGFloat viewMaxH;
    CGFloat viewMaxW;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        viewMaxW = frame.size.width;
        viewMaxH = frame.size.height;
        
        self.hidden = YES;
        
        UIButton *surebBtn = [[UIButton alloc]initWithFrame:CGRectMake(0,0, 130, 40)];
        surebBtn.layer.cornerRadius = 20;
        surebBtn.clipsToBounds = YES;
        [surebBtn setBackgroundImage:[UIImage createImageSize:surebBtn.bounds.size gradientColors:@[kRGB_COLOR(@"#FF6CF6"),kRGB_COLOR(@"#FF54A0")] percentage:@[@0.1,@1.0] gradientType:GradientFromTopToBottom] forState:UIControlStateNormal];
        [surebBtn setTitle:kLocalizationMsg(@"确认提现") forState:UIControlStateNormal];
        surebBtn.titleLabel.font  =[UIFont systemFontOfSize:16];
        [surebBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [surebBtn addTarget:self action:@selector(sureBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:surebBtn];
        
        [surebBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(CGSizeMake(130, 40));
            make.centerX.equalTo(self);
            make.bottom.equalTo(self).inset(20);
        }];
    }
    return self;
}


- (void)setChargeRulesRespModel:(RechargeCenterVOModel *)chargeRulesRespModel {
    _chargeRulesRespModel = chargeRulesRespModel;
    
    CGFloat magin = 15;
    
    UIView *widthDrawView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, self.width, 80)];
    [self addSubview:widthDrawView];
    self.contentBgV = widthDrawView;
    
    UIScrollView *headerScrollV = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, widthDrawView.width, 50)];
    headerScrollV.scrollEnabled = YES;
    headerScrollV.contentSize = CGSizeMake(0, 0);
    headerScrollV.showsVerticalScrollIndicator = NO;
    headerScrollV.bounces = NO;
    [widthDrawView addSubview:headerScrollV];
    self.scrollVBgV = headerScrollV;
    
    UIView *accountBgV = [[UIView alloc] initWithFrame:CGRectMake(0, headerScrollV.maxY, widthDrawView.width, 50)];
    [widthDrawView addSubview:accountBgV];
    [accountBgV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(accountBgV.size);
        make.left.right.bottom.equalTo(widthDrawView);
    }];
    
    if (chargeRulesRespModel.withdrawalAmountManner) { ///固定
        CGFloat scale = 150/220.0;
        CGFloat width = (viewMaxW-magin*4)/3.0;
        CGFloat height = width*scale;

        NSArray<FixedWithdrawRuleVOModel *> *fixedWithdrawRuleVOList = chargeRulesRespModel.fixedWithdrawRuleVOList;
        
        NSInteger rowAll = fixedWithdrawRuleVOList.count?((fixedWithdrawRuleVOList.count-1)/3+1):0;
        {
            ///整个选择view的高度
            CGFloat selectH = magin+rowAll*(height+magin+5);
            self.scrollVBgV.height = MIN(selectH, viewMaxH-100-accountBgV.height);
            self.scrollVBgV.contentSize = CGSizeMake(0, selectH);
        }

        for (int i = 0; i < fixedWithdrawRuleVOList.count; i++) {
            
            FixedWithdrawRuleVOModel *model = fixedWithdrawRuleVOList[i];
            
            NSInteger row = i/3;
            NSInteger col = i%3;
            
            UIView *backView = [[UIView alloc]initWithFrame:CGRectMake(magin+col *(width+magin), magin+row*(height+magin+5), width, height)];
            backView.backgroundColor = [UIColor clearColor];
            [headerScrollV addSubview:backView];
            
            WtihdarwSelectedBtn *btn = [[WtihdarwSelectedBtn alloc]initWithFrame:backView.bounds];
            btn.ruleModel = model;
            btn.backgroundColor = [UIColor clearColor];
            btn.tag = i;
            [btn addTarget:self action:@selector(chargeBtnClick:) forControlEvents:UIControlEventTouchUpInside];
            [backView addSubview:btn];
            
            if (i == self.selectedIndex) {
                btn.isSelected = YES;
            }
        }
        
    }else{  ///灵活
        
        headerScrollV.height = 50;
        //提现佣金
        UILabel *moenyTitleLabel = [[UILabel alloc]initWithFrame:CGRectMake(15, 10, 30, 30)];
        moenyTitleLabel.centerY = headerScrollV.height/2.0;
        moenyTitleLabel.textAlignment = NSTextAlignmentLeft;
        moenyTitleLabel.font = [UIFont systemFontOfSize:25];
        moenyTitleLabel.textColor = kRGB_COLOR(@"#333333");
        moenyTitleLabel.text = @"¥";
        [headerScrollV addSubview:moenyTitleLabel];
        
        UITextField *commisionTextField = [[UITextField alloc]initWithFrame:CGRectMake(moenyTitleLabel.maxX, 0, headerScrollV.width-60-60, headerScrollV.height)];
        commisionTextField.backgroundColor = [UIColor clearColor];
        commisionTextField.textColor = kRGB_COLOR(@"#333333");
        commisionTextField.font = [UIFont systemFontOfSize:14];
        commisionTextField.keyboardType = UIKeyboardTypeNumberPad;
        commisionTextField.placeholder = [NSString stringWithFormat:kLocalizationMsg(@"最高可提现%.2f元"),self.totalAmount];
        commisionTextField.textAlignment = NSTextAlignmentLeft;
        self.commisionTextField = commisionTextField;
        [headerScrollV addSubview:self.commisionTextField];
        
        //全部
        UIButton *getAllBtn = [[UIButton alloc]initWithFrame:CGRectMake(commisionTextField.maxX, 0, 60, headerScrollV.height)];
        getAllBtn.backgroundColor = [UIColor clearColor];
        getAllBtn.centerY = commisionTextField.centerY;
        [getAllBtn setTitle:kLocalizationMsg(@"全部提现") forState:UIControlStateNormal];
        [getAllBtn setTitleColor:[ProjConfig normalColors] forState:UIControlStateNormal];
        getAllBtn.titleLabel.font = [UIFont systemFontOfSize:13];
        [getAllBtn addTarget:self action:@selector(getAllBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        [headerScrollV addSubview:getAllBtn];
        
        UIView *line = [[UIView alloc]initWithFrame:CGRectMake(15, headerScrollV.height-0.5, widthDrawView.width-30, 0.5)];
        line.backgroundColor = kRGBA_COLOR(@"#DEDEDE", 0.5);
        [headerScrollV addSubview:line];
        
    }
    {
        //账户
        UILabel *accountTitleLabel = [[UILabel alloc]initWithFrame:CGRectMake(15, accountBgV.height-50, 64, 50)];
        accountTitleLabel.textAlignment = NSTextAlignmentLeft;
        accountTitleLabel.font = [UIFont systemFontOfSize:14];
        accountTitleLabel.textColor = kRGB_COLOR(@"#333333");
        accountTitleLabel.text = kLocalizationMsg(@"提现到");
        [accountBgV addSubview:accountTitleLabel];
        
        ///箭头
        UIImageView *arrowV = [[UIImageView alloc] initWithFrame:CGRectMake(widthDrawView.width-8-15, 0, 8, 15)];
        arrowV.image = [UIImage imageNamed:@"mineCenter_gray_more"];
        arrowV.centerY = accountTitleLabel.centerY;
        [accountBgV addSubview:arrowV];
        
        UILabel *accountLabel = [[UILabel alloc]init];
        accountLabel.backgroundColor = [UIColor clearColor];
        accountLabel.textColor = kRGB_COLOR(@"#666666");
        accountLabel.font = [UIFont systemFontOfSize:14];
        accountLabel.textAlignment = NSTextAlignmentRight;
        accountLabel.centerY = accountTitleLabel.centerY;
        accountLabel.text = kLocalizationMsg(@"请选择提现账户");
        self.accountLabel = accountLabel;
        [accountBgV addSubview:self.accountLabel];
        [accountLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(accountTitleLabel.mas_right).inset(5);
            make.right.equalTo(arrowV.mas_left).inset(5);
            make.centerY.equalTo(accountTitleLabel);
        }];

        UIButton *accountBtn = [[UIButton alloc]initWithFrame:accountBgV.bounds];
        accountBtn.backgroundColor = [UIColor clearColor];
        [accountBtn addTarget:self action:@selector(accountBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        [accountBgV addSubview:accountBtn];
    }
    
    
    widthDrawView.height = headerScrollV.height+accountBgV.height;
    self.height = widthDrawView.height + 100;
    
}


- (void)sureBtnClick:(UIButton *)btn{
    kWeakSelf(self);
    
    double delta = 0.0;
    if (self.chargeRulesRespModel.withdrawalAmountManner) { ///固定
        NSArray<FixedWithdrawRuleVOModel *> *fixedWithdrawRuleVOList = self.chargeRulesRespModel.fixedWithdrawRuleVOList;
        FixedWithdrawRuleVOModel *chargeModel = fixedWithdrawRuleVOList[self.selectedIndex];
        delta = chargeModel.withdrawNum;
    }else{
        delta = [self.commisionTextField.text doubleValue];
    }

    if (delta == 0) {
        [SVProgressHUD showInfoWithStatus:kLocalizationMsg(@"提现佣金不能为空")];
        return;
    }
    if (!self.selectedAccountModel) {
        [SVProgressHUD showInfoWithStatus:kLocalizationMsg(@"提现账户不能为空")];
        return;
    }
    [SVProgressHUD show];
    [HttpApiAPPFinance withdrawAccountApply:self.selectedAccountModel.id_field accountName:self.selectedAccountModel.name accountType:self.selectedAccountModel.type delta:delta type:2 callback:^(int code, NSString *strMsg, HttpNoneModel *model) {
        if (code == 1) {
            [SVProgressHUD showSuccessWithStatus:strMsg];
            self.delegate?[weakself.delegate withdrawSuccess]:nil;
        }else{
            [SVProgressHUD showInfoWithStatus:strMsg];
        }
    }];
}


- (void)getAllBtnClick:(UIButton *)btn{
    self.commisionTextField.text = [NSString stringWithFormat:@"%.0f",self.amount];
}


- (void)chargeBtnClick:(WtihdarwSelectedBtn *)btn{
    btn.isSelected = YES;
    self.selectedIndex = btn.tag;
    for (UIView *view in self.scrollVBgV.subviews) {
        if ([view.subviews.firstObject isKindOfClass:[WtihdarwSelectedBtn class]]) {
            WtihdarwSelectedBtn *payBtn = (WtihdarwSelectedBtn *)view.subviews.firstObject;
            if (btn.tag != payBtn.tag ) {
                payBtn.isSelected = NO;
            }
        }
    }
}


- (void)accountBtnClick:(UIButton *)btn{
    self.delegate?[self.delegate selectAccountForWithdrawView:self]:nil;
}

@end
