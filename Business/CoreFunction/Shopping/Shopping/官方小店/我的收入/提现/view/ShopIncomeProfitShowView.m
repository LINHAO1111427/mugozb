//
//  ShopIncomeProfitShowView.m
//  Shopping
//
//  Created by yww on 2020/8/6.
//  Copyright © 2020 klc. All rights reserved.
//

#import "ShopIncomeProfitShowView.h"

#import <LibProjModel/ShopBusinessModel.h>
#import <LibProjModel/ShopWithdrawDTOModel.h>
#import <LibProjModel/AppUsersCashAccountModel.h>
 
@interface ShopIncomeProfitShowView()<UITextFieldDelegate,UIGestureRecognizerDelegate>
@property (strong, nonatomic) UIImageView *headBgView;
@property (strong, nonatomic) UILabel *totalCoinNameL;
@property (strong, nonatomic) UILabel *totalCoinNumberL;
@property (nonatomic, strong) UIButton *allWithdrawBtn;

@property (strong, nonatomic) UITextField *withdrawAccountTF;//提现账号
@property (strong, nonatomic) UITextField *withdrawBankrollTF;//提现资金
@property (strong, nonatomic) UITextField *deductTF;//扣除费用
@property (strong, nonatomic) UITextField *incomeBankTF;//到账资金

@end

@implementation ShopIncomeProfitShowView
- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self createUI];
    }
    return self;
}
- (void)createUI{
    self.backgroundColor = kRGB_COLOR(@"#F4F4F4");
    [self addSubview:self.headBgView];
    [self.headBgView addSubview:self.totalCoinNameL];
    [self.headBgView addSubview:self.totalCoinNumberL];
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tap)];
    tap.delegate = self;
    [self addGestureRecognizer:tap];
    //列表
    UIView *listView = [[UIView alloc]initWithFrame:CGRectMake(12, self.headBgView.maxY+10, kScreenWidth-24, 250)];
    listView.backgroundColor = [UIColor whiteColor];
    listView.layer.cornerRadius = 10;
    listView.clipsToBounds = YES;
    [self addSubview:listView];
    for (int i = 0; i < 5; i++) {
        UIView *subV = [[UIView alloc]initWithFrame:CGRectMake(0, i*50, kScreenWidth-24, 49)];
        subV.backgroundColor = [UIColor whiteColor];
        [listView addSubview:subV];
        UIView *line = [[UIView alloc]initWithFrame:CGRectMake(0, i*50+49, kScreenWidth-24, 0.5)];
        line.backgroundColor = kRGB_COLOR(@"#F4F4F4");
        [listView addSubview:line];
        UILabel *titleL = [[UILabel alloc]initWithFrame:CGRectMake(10, 15, 60, 20)];
        titleL.textColor = kRGB_COLOR(@"#333333");
        titleL.font = [UIFont systemFontOfSize:14];
        titleL.textAlignment = NSTextAlignmentLeft;
        NSString *title;
        if (i == 0) {
            title = kLocalizationMsg(@"提取金额");
        }else if (i == 1){
            title = kLocalizationMsg(@"提取账号");
        }else if (i == 2){
            title = kLocalizationMsg(@"佣金费用");
        }else if (i == 3){
            title = kLocalizationMsg(@"手续费用");
        }else if (i == 4){
            title = kLocalizationMsg(@"到账资金");
        }
        titleL.text = title;
        [subV addSubview:titleL];
        CGFloat width = kScreenWidth-24-30-60;
        if (i == 0) {
            width =  kScreenWidth-24-30-130;
        }
        UITextField *textF = [[UITextField alloc]initWithFrame:CGRectMake(titleL.maxX+10, 10, width, 30)];
        textF.textColor = kRGB_COLOR(@"#333333");
        textF.font = [UIFont systemFontOfSize:14];
        textF.textAlignment= NSTextAlignmentLeft;
        textF.enabled = NO;
        if (i== 0) {
            textF.backgroundColor = kRGB_COLOR(@"#F4F4F4");
            textF.layer.cornerRadius = 15;
            textF.clipsToBounds = YES;
            textF.enabled = YES;
            textF.textAlignment = NSTextAlignmentCenter;
            textF.placeholder = kLocalizationMsg(@"请输入提现金额");
            self.withdrawInputTF = textF;
            UIButton *allWithdrawBtn = [[UIButton alloc]initWithFrame:CGRectMake(textF.maxX+10, 10, 60, 30)];
            [allWithdrawBtn setTitle:kLocalizationMsg(@"全部提现") forState:UIControlStateNormal];
            [allWithdrawBtn setTitleColor:kRGB_COLOR(@"#FE73E1") forState:UIControlStateNormal];
            allWithdrawBtn.titleLabel.font = [UIFont systemFontOfSize:14];
            [allWithdrawBtn addTarget:self action:@selector(allWithdrawBtnClick:) forControlEvents:UIControlEventTouchUpInside];
            [subV addSubview:allWithdrawBtn];
        }else if (i== 1){
            self.withdrawAccountTF = textF;
            UIImageView *moreImgV = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 10, 18)];
            moreImgV.image = [UIImage imageNamed:@"mineCenter_gray_more"];
            textF.rightView = moreImgV;
            textF.placeholder = kLocalizationMsg(@"请选择提现账户");
            textF.rightViewMode = UITextFieldViewModeAlways;
            self.withdrawAccountTF = textF;
            UIButton *withdrawAccountBtn = [[UIButton alloc]initWithFrame:textF.frame];
            withdrawAccountBtn.backgroundColor = [UIColor clearColor];
            self.withdrawAccountBtn = withdrawAccountBtn;
            [subV insertSubview:self.withdrawAccountBtn atIndex:10];
        }else if (i== 2){
            self.withdrawBankrollTF = textF;
        }else if (i== 3){
            self.deductTF = textF;
        }else if (i== 4){
            textF.textColor = [UIColor redColor];
            self.incomeBankTF = textF;
        }
        textF.leftViewMode = UITextFieldViewModeAlways;
        [subV addSubview:textF];
    }
    [self addSubview:self.withdrawBtn];
}
- (void)tap{
    [self endEditing:YES];
}
- (void)allWithdrawBtnClick:(UIButton *)btn{
    self.withdrawInputTF.text = [NSString stringWithFormat:@"%.0f",self.shopModel.amount];
    [self textFieldValueChange:nil];
}
 
- (void)setWithdrawModel:(ShopWithdrawDTOModel *)withdrawModel{
    _withdrawModel = withdrawModel;
    self.totalCoinNumberL.text = [NSString stringWithFormat:@"%0.2lf",self.shopModel.amount];
    [self.withdrawBtn setBackgroundColor:kRGB_COLOR(@"#dcdcdc")];
    self.accountModel = withdrawModel.account;
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textFieldValueChange:) name:UITextFieldTextDidChangeNotification object:nil];
    
}
 
- (void)setShopModel:(ShopBusinessModel *)shopModel{
    _shopModel = shopModel;
    self.withdrawInputTF.text = @"";
    self.totalCoinNumberL.text = [NSString stringWithFormat:@"%0.2lf",self.shopModel.amount];
    self.withdrawBankrollTF.text = @"";
    self.deductTF.text = @"";
    self.withdrawAccountTF.text = @"";
    self.withdrawAccountTF.leftView = nil;
    self.incomeBankTF.text = @"";
    self.withdrawBtn.userInteractionEnabled = NO;
    [self.withdrawBtn setBackgroundColor:kRGB_COLOR(@"#dcdcdc")];
}
- (void)textFieldValueChange:(NSNotification *)notify{
    //可提现金额
    if ([self.withdrawInputTF.text floatValue] > self.shopModel.amount) {
        self.withdrawInputTF.text = [NSString stringWithFormat:@"%.2f",self.shopModel.amount];
    }
    ///提现金额
    CGFloat withdrawNum = [self.withdrawInputTF.text floatValue];
    //佣金费用
    double commissionCost = withdrawNum*self.withdrawModel.sellRate/100.0;
    self.withdrawBankrollTF.text = [NSString stringWithFormat:@"¥ %.2f",commissionCost];
    
    //手续费用
    CGFloat serverCost =  withdrawNum*self.withdrawModel.service/100.0;
    self.deductTF.text = [NSString stringWithFormat:@"¥ %.2f",serverCost];
    
    //到账资金
    CGFloat resultNum = withdrawNum -commissionCost-serverCost;
    NSString *resultStr = [NSString stringWithFormat:@"%.2f",resultNum];
     
    if (resultNum > 0) {
        _withdrawBtn.userInteractionEnabled = YES;
        [_withdrawBtn setBackgroundColor:[ProjConfig normalColors]];
    }else{
        _withdrawBtn.userInteractionEnabled = NO;
        [_withdrawBtn setBackgroundColor:kRGB_COLOR(@"#dcdcdc")];
    }

    [self.withdrawAccountTF bringSubviewToFront:self.withdrawAccountBtn];
    
    if (resultNum <= 0) {
        self.incomeBankTF.text = @"¥ 0.00";
    }else{
        self.incomeBankTF.text = resultStr;
    }
    
 
}

- (void)setAccountModel:(AppUsersCashAccountModel *)accountModel{
    if (accountModel) {
        _accountModel = accountModel;
        self.withdrawAccountTF.text = accountModel.account;
        //1表示支付宝，2表示微信，3表示银行卡
        UIImage *image;
        switch (accountModel.type) {
            case 1:{
                image= [UIImage imageNamed:@"mine_center_profit_alipay"];
            }
                break;
            case 2:{
                image = [UIImage imageNamed:@"mine_center_profit_wx"];
            }
                break;
            case 3:{
                image = [UIImage imageNamed:@"mine_center_profit_card"];
            }
                break;
            default:
                break;
        }
        UIView *leftV = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 50, 30)];
        UIImageView *leftImageV = [[UIImageView alloc]initWithFrame:CGRectMake(10, 0, leftV.height, leftV.height)];
        leftImageV.image = image;
        leftImageV.contentMode = UIViewContentModeScaleAspectFit;
        [leftV addSubview:leftImageV];
        
        self.withdrawAccountTF.leftView = leftV;
        
    }
}

- (void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UITextFieldTextDidChangeNotification object:nil];
}



#pragma mark - lazy load
- (UIImageView *)headBgView{
    if (!_headBgView) {
        CGFloat scale = 302/1009.0;
        CGFloat height = (kScreenWidth-24)*scale;
        _headBgView = [[UIImageView alloc]initWithFrame:CGRectMake(12, 12, kScreenWidth-24, height)];
        _headBgView.image = [UIImage imageNamed:@"mine_center_profit_bg"];
        _headBgView.contentMode = UIViewContentModeScaleAspectFill;
    }
    return _headBgView;
}
- (UILabel *)totalCoinNameL{
    if (!_totalCoinNameL) {
        CGFloat margin = (_headBgView.height-50)/2.0;
        _totalCoinNameL = [[UILabel alloc]initWithFrame:CGRectMake(0, margin, _headBgView.width, 20)];
        _totalCoinNameL.textColor = [UIColor whiteColor];
        _totalCoinNameL.textAlignment = NSTextAlignmentCenter;
        _totalCoinNameL.text = kLocalizationMsg(@"可提现金额");
        _totalCoinNameL.font = [UIFont systemFontOfSize:14];
    }
    return _totalCoinNameL;
}
- (UILabel *)totalCoinNumberL{
    if (!_totalCoinNumberL) {
        _totalCoinNumberL = [[UILabel alloc]initWithFrame:CGRectMake(0, _totalCoinNameL.maxY+10, _totalCoinNameL.width, 20)];
        _totalCoinNumberL.textColor = [UIColor whiteColor];
        _totalCoinNumberL.font = [UIFont systemFontOfSize:18];
        _totalCoinNumberL.textAlignment = NSTextAlignmentCenter;
    }
    return _totalCoinNumberL;
}
- (UIButton *)withdrawBtn{
    if (!_withdrawBtn) {
        UIButton *withdrawbtn = [[UIButton alloc]initWithFrame:CGRectMake(40, _headBgView.maxY+300, kScreenWidth-80, 40)];
        withdrawbtn.layer.cornerRadius = 20;
        withdrawbtn.clipsToBounds = YES;
        withdrawbtn.backgroundColor = kRGB_COLOR(@"#dcdcdc");
        [withdrawbtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [withdrawbtn setTitle:kLocalizationMsg(@"确定提现") forState:UIControlStateNormal];
        _withdrawBtn = withdrawbtn;
    }
    return _withdrawBtn;
}
#pragma mark - UIGestureRecognizerDelegate
#pragma mark - UIGestureRecognizerDelegate
- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch{
    if ([touch.view isKindOfClass:[UIButton class]]) {
        return NO;
    }else{
        return YES;
    }
}
@end
