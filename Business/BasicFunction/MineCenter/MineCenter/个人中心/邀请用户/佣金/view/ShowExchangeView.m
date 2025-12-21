//
//  ShowExchangeView.m
//  MineCenter
//
//  Created by shirley on 2021/12/8.
//  Copyright © 2021 KLC. All rights reserved.
//

#import "ShowExchangeView.h"
#import <LibTools/LibTools.h>
#import <LibProjBase/LibProjBase.h>
#import <LibProjModel/RechargeRulesVOModel.h>
#import "paySelectedBtn.h"
#import <LibProjModel/HttpApiAPPFinance.h>

@implementation ShowExchangeView
{
    CGFloat viewMaxH;
    CGFloat viewMaxW;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        self.hidden = YES;
        
        viewMaxW = frame.size.width;
        viewMaxH = frame.size.height;
        
        UIScrollView *scrollview = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, frame.size.width, 1)];
        scrollview.scrollEnabled = YES;
        scrollview.contentSize = CGSizeMake(0, 0);
        scrollview.showsVerticalScrollIndicator = NO;
        scrollview.bounces = NO;
        [self addSubview:scrollview];
        self.scrollVBgV = scrollview;
        
        
        UIButton *surebBtn = [[UIButton alloc]initWithFrame:CGRectMake(0,0, 130, 40)];
        surebBtn.layer.cornerRadius = 20;
        surebBtn.clipsToBounds = YES;
        [surebBtn setBackgroundImage:[UIImage createImageSize:surebBtn.bounds.size gradientColors:@[kRGB_COLOR(@"#FF6CF6"),kRGB_COLOR(@"#FF54A0")] percentage:@[@0.1,@1.0] gradientType:GradientFromTopToBottom] forState:UIControlStateNormal];
        [surebBtn setTitle:kLocalizationMsg(@"兑换金币") forState:UIControlStateNormal];
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


- (void)setRechargeRulesVOList:(NSArray<RechargeRulesVOModel *> *)rechargeRulesVOList {
    
    _rechargeRulesVOList = rechargeRulesVOList;
    
    CGFloat scale = 150/220.0;
    CGFloat magin = 15;
    CGFloat width = (viewMaxW-magin*4)/3.0;
    CGFloat height = width*scale;
    NSInteger rowAll = rechargeRulesVOList.count?((rechargeRulesVOList.count-1)/3+1):0;
    
    {
        ///整个选择view的高度
        CGFloat selectH = magin+rowAll*(height+magin+5)+10;
        self.scrollVBgV.height = MIN(selectH, viewMaxH-100);
        self.scrollVBgV.contentSize = CGSizeMake(0, selectH);
        self.height = self.scrollVBgV.height + 100;
    }
    
    for (int i = 0; i < rechargeRulesVOList.count; i++) {
        RechargeRulesVOModel *model = rechargeRulesVOList[i];
        NSInteger row = i/3;
        NSInteger col = i%3;
        UIView *backView = [[UIView alloc]initWithFrame:CGRectMake(magin+col *(width+magin), magin+row*(height+magin+5), width, height)];
        backView.backgroundColor = [UIColor clearColor];
        [self.scrollVBgV addSubview:backView];
        
        paySelectedBtn *btn = [[paySelectedBtn alloc]initWithFrame:CGRectMake(0, 0, width, height)];
        btn.ruleModel = model;
        btn.backgroundColor = [UIColor clearColor];
        btn.tag = i;
        [btn addTarget:self action:@selector(chargeBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        [backView addSubview:btn];
        
        if (i == self.selectedIndex) {
            btn.isSelected = YES;
        }
    } 
}


- (void)chargeBtnClick:(paySelectedBtn *)btn{
    btn.isSelected = YES;
    self.selectedIndex = btn.tag;
    for (UIView *view in self.scrollVBgV.subviews) {
        if ([view.subviews.firstObject isKindOfClass:[paySelectedBtn class]]) {
            paySelectedBtn *payBtn = (paySelectedBtn *)view.subviews.firstObject;
            if (btn.tag != payBtn.tag ) {
                payBtn.isSelected = NO;
            }
        }
    }
}
 

- (void)sureBtnClick:(UIButton *)btn{
    kWeakSelf(self);
    RechargeRulesVOModel *chargeModel = self.rechargeRulesVOList[(int)self.selectedIndex];
    [SVProgressHUD show];
    [HttpApiAPPFinance moneyExchangeCoin:@"ios" ruleId:chargeModel.id_field callback:^(int code, NSString *strMsg, HttpNoneModel *model) {
        if (code == 1) {
            [SVProgressHUD showSuccessWithStatus:strMsg];
            weakself.rechangeSuccessBlock?weakself.rechangeSuccessBlock():nil;
        }else{
            [SVProgressHUD showInfoWithStatus:strMsg];
        }
    }];
}



@end
