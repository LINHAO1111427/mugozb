//
//  buyGuardVc.m
//  UserInfo
//
//  Created by ssssssss on 2020/12/16.
//  Copyright © 2020 KLC. All rights reserved.
// 购买守护

#import "buyGuardVc.h"
#import "guardPayBtn.h"
#import <LibProjModel/HttpApiGuard.h>
#import <LibProjModel/GuardVOModel.h>
#import <LibProjModel/CfgPayWayDTOModel.h>
#import <LibProjModel/GuardUserVOModel.h>
#import <LibProjView/PaymentManager.h>
#import <LibProjView/PayResultView.h>
#import <LibProjModel/HttpApiGuard.h>
 
@interface buyGuardVc ()

@property (nonatomic, strong)UIScrollView *guardPayScroll;
@property (nonatomic, strong)UIButton *payBtn;
@property (nonatomic, strong)NSArray *paArray;
@property (nonatomic, assign)NSInteger selectedIndex;
@property (nonatomic, assign)NSInteger payIndex;
 
@property (nonatomic, strong)GuardUserVOModel *guardModel;

@end

@implementation buyGuardVc
- (UIScrollView *)guardPayScroll{
    if (!_guardPayScroll) {
        _guardPayScroll = [[UIScrollView alloc]initWithFrame:self.view.bounds];
        _guardPayScroll.backgroundColor = [UIColor whiteColor];
    }
    return _guardPayScroll;
}
- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    [self getGuardPayItems];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.selectedIndex = 0;
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationItem.title = kLocalizationMsg(@"开通守护");
    [self getUserGuardInfo];
    [self.view addSubview:self.guardPayScroll];
}

- (void)getGuardPayItems{
    kWeakSelf(self);
    [HttpApiGuard openGuard:^(int code, NSString *strMsg, NSArray<GuardVOModel *> *arr) {
        if (code == 1) {
            weakself.paArray = arr;
            if (arr.count > 0) {
                [weakself updateUI];
            }
        }else{
            [SVProgressHUD showInfoWithStatus:strMsg];
        }
    }];
}

- (void)getUserGuardInfo{
    kWeakSelf(self);
    [HttpApiGuard getMyGuardInfo:[self.userId longLongValue] callback:^(int code, NSString *strMsg, GuardUserVOModel *model) {
        if (code == 1) {
            weakself.guardModel = model;
            [weakself showUserPayBtnState];
        }
    }];
}


- (void)showUserPayBtnState{
    NSString *title;
    if (self.guardModel.isOverdue != -1) {
        if (self.guardModel.isOverdue > 0) {
            title = kLocalizationMsg(@"我要守护");
        }else{
            title = kLocalizationMsg(@"继续守护");
        }
    }else{
        title = kLocalizationMsg(@"开通守护");
    }
    [_payBtn setTitle:title forState:UIControlStateNormal];
}


- (void)updateUI{
    
    [self.guardPayScroll removeAllSubViews];
    CGFloat y = 20;
    UILabel *titleL_1 = [[UILabel alloc]initWithFrame:CGRectMake(15, y, kScreenWidth-30, 20)];
    titleL_1.textAlignment = NSTextAlignmentLeft;
    titleL_1.font = [UIFont boldSystemFontOfSize:13];
    titleL_1.textColor = kRGB_COLOR(@"#333333");
    titleL_1.text = kLocalizationMsg(@"选择守护天数");
    [self.guardPayScroll addSubview:titleL_1];
    y += 40;
    
    CGFloat payItemW = (kScreenWidth-30-20)/3.0;
    CGFloat payItemH = payItemW*150/220.0;
    for (int i = 0; i < self.paArray.count; i++) {
        GuardVOModel *model = self.paArray[i];
        int col = i%3;
        int row = i/3;
        guardPayBtn *payBtn = [[guardPayBtn alloc]initWithFrame:CGRectMake(15+(payItemW+10)*col, y+(payItemH+10)*row, payItemW, payItemH)];
        payBtn.layer.cornerRadius = 10;
        payBtn.model = model;
        payBtn.clipsToBounds = YES;
        if (i == self.selectedIndex) {
            payBtn.isSelected = YES;
        }
        [payBtn addTarget:self action:@selector(payItemBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        payBtn.tag = i;
        [self.guardPayScroll addSubview:payBtn];
    }
    
    y += ((self.paArray.count-1)/3+1)*(payItemH+10)+20;
    
    UILabel *titleL_2 = [[UILabel alloc]initWithFrame:CGRectMake(15, y, kScreenWidth-30, 20)];
    titleL_2.textAlignment = NSTextAlignmentLeft;
    titleL_2.font = [UIFont boldSystemFontOfSize:13];
    titleL_2.textColor = kRGB_COLOR(@"#333333");
    titleL_2.text = kLocalizationMsg(@"选择支付方式");
    [self.guardPayScroll addSubview:titleL_2];
    y += 40;
    
    GuardVOModel *payModel;
    if (self.selectedIndex < self.paArray.count) {
        payModel = self.paArray[self.selectedIndex];
    }
    for (int i = 0; i < payModel.payList.count; i++) {
        CfgPayWayDTOModel *payM = payModel.payList[i];
        UIView *selectedBackV = [[UIView alloc]initWithFrame:CGRectMake(15, y+60*i, kScreenWidth-30, 50)];
        selectedBackV.backgroundColor = [UIColor whiteColor];
        selectedBackV.layer.cornerRadius  = 10;
        selectedBackV.clipsToBounds = NO;
        selectedBackV.layer.shadowColor = [UIColor grayColor].CGColor;
        selectedBackV.layer.shadowOpacity = 0.5;
        selectedBackV.layer.shadowRadius = 3;
        selectedBackV.layer.shadowOffset = CGSizeMake(0 ,1);
        [self.guardPayScroll addSubview:selectedBackV];
        
        UIView *selectedView = [[UIView alloc]initWithFrame:selectedBackV.bounds];
        selectedView.backgroundColor = [UIColor whiteColor];
        selectedView.layer.cornerRadius = 10;
        selectedView.layer.masksToBounds = YES;
        [selectedBackV addSubview:selectedView];
        
        NSString *textS,*money;
        UIImage*payImage;
        if (payM.payChannel == 1) {//支付宝
            money = [NSString stringWithFormat:@"¥%.2f",payModel.iosPrice];
            textS = [ProjConfig getZFBstring];
            payImage= [UIImage imageNamed:@"icon_payment_allepay"];
        }else if (payM.payChannel == 2){// 微信
            money = [NSString stringWithFormat:@"¥%.2f",payModel.iosPrice];
            textS  = kLocalizationMsg(@"微信");
            payImage= [UIImage imageNamed:@"icon_payment_wechat"];
        }else if (payM.payChannel == 3){// 内购
            money = [NSString stringWithFormat:@"¥%.2f",payModel.iosPrice];
            textS  = kLocalizationMsg(@"苹果内购");
            payImage= [UIImage imageNamed:@"icon_payment_apple"];
        }else if (payM.payChannel == 4){// 金币
            money = [NSString stringWithFormat:@"¥%.0f%@",payModel.coin,[KLCAppConfig unitStr]];
            payImage =[ProjConfig getCoinImage];
            textS  = [NSString stringWithFormat:kLocalizationMsg(@"%@支付"),[KLCAppConfig unitStr]];
        }
        
        UIImageView *leftImagev = [[UIImageView alloc]initWithFrame:CGRectMake(15, 10, 30, 30)];
        leftImagev.contentMode = UIViewContentModeScaleAspectFit;
        leftImagev.image = payImage;
        [selectedView addSubview:leftImagev];
        
        UILabel *payNameL = [[UILabel alloc]initWithFrame:CGRectMake(leftImagev.maxX+5, 15, 70, 20)];
        payNameL.textAlignment = NSTextAlignmentLeft;
        payNameL.font = [UIFont systemFontOfSize:13];
        payNameL.textColor = kRGB_COLOR(@"#333333");
        payNameL.text = textS;
        [selectedView addSubview:payNameL];
        
        UILabel *moneyL = [[UILabel alloc]initWithFrame:CGRectMake(payNameL.maxX, 15, selectedView.width-payNameL.maxX-45, 20)];
        moneyL.textAlignment = NSTextAlignmentRight;
        moneyL.font = [UIFont systemFontOfSize:11];
        moneyL.textColor = kRGB_COLOR(@"#666666");
        moneyL.text = money;
        [selectedView addSubview:moneyL];
        
        UIImageView *selecteImageV = [[UIImageView alloc]initWithFrame:CGRectMake(moneyL.maxX+10, 15, 20, 20)];
        if (i == self.payIndex) {
            selecteImageV.image = [UIImage imageNamed:@"icon_svip_pay_selected"];
        }else{
            selecteImageV.image = [UIImage imageNamed:@"icon_svip_pay_normal"];
        }
        [selectedView addSubview:selecteImageV];
        
        UIButton *paySelectedBtn = [[UIButton alloc]initWithFrame:selectedBackV.bounds];
        paySelectedBtn.backgroundColor = [UIColor clearColor];
        paySelectedBtn.tag = i;
        [paySelectedBtn addTarget:self action:@selector(paySelectedBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        [selectedBackV addSubview:paySelectedBtn];
    }
    y += 60*payModel.payList.count;
    
    //购买
    UIButton *payBtn = [[UIButton alloc]initWithFrame:CGRectMake(0, y + 30, 120, 40)];
    payBtn.layer.cornerRadius = 20;
    payBtn.layer.borderWidth = 1.0;
    payBtn.centerX = (kScreenWidth-30)/2.0;
    payBtn.layer.borderColor = kRGB_COLOR(@"#FFE077").CGColor;
    payBtn.clipsToBounds = YES;
    payBtn.titleLabel.font = [UIFont systemFontOfSize:14];
    [payBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [payBtn setBackgroundImage:[UIImage createImageSize:payBtn.size gradientColors:@[kRGB_COLOR(@"#FF54A0"),kRGB_COLOR(@"#FF6CF6")] percentage:@[@0.2,@1.0] gradientType:GradientFromTopToBottom] forState:UIControlStateNormal];
    [payBtn addTarget:self action:@selector(payGuradBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.guardPayScroll addSubview:payBtn];
    _payBtn = payBtn;
     
    self.guardPayScroll.contentSize = CGSizeMake(kScreenWidth, y+kSafeAreaBottom+20);
    
    [self showUserPayBtnState];
}
 
- (void)payItemBtnClick:(UIButton *)btn{
    self.selectedIndex = btn.tag;
    self.payIndex = 0;
    [self updateUI];
}
- (void)paySelectedBtnClick:(UIButton *)btn{
    self.payIndex = btn.tag;
    [self updateUI];
}
- (void)payGuradBtnClick:(UIButton *)btn{
    kWeakSelf(self);
    GuardVOModel *payModel;
    if (self.selectedIndex < self.paArray.count) {
        payModel = self.paArray[self.selectedIndex];
    }
    CfgPayWayDTOModel *pay;
    if (self.payIndex < payModel.payList.count) {
        pay = payModel.payList[self.payIndex];
    }
    if (pay.payChannel == 4) {//金币购买
        [HttpApiGuard guardListBuy:[self.userId longLongValue] tid:payModel.id_field callback:^(int code, NSString *strMsg, HttpNoneModel *model) {
            if (code == 1) {
                [SVProgressHUD showSuccessWithStatus:strMsg];
                [weakself.navigationController popViewControllerAnimated:YES];
            }else{
                [SVProgressHUD showInfoWithStatus:kLocalizationMsg(strMsg)];
            }
            
        }];
    }else{
        PaymentParamModel *param = [[PaymentParamModel alloc] init];
        param.payId = payModel.id_field;
        param.price = payModel.iosPrice;
        param.channelId = (int)pay.id_field;
        param.pageType = pay.pageType;
        param.receiverUId = [self.userId longLongValue];
        kWeakSelf(self);
        [PaymentManager startPay:param businType:BusinessTypeGuard result:^(BOOL success, NSString * _Nullable msg) {
            if (success) {
                [weakself.navigationController popViewControllerAnimated:YES];
            }
        } cancel:nil];
    }
}
 
@end
