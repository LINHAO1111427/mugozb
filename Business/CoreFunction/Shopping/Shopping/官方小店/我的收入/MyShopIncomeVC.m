//
//  MyShopIncomeVC.m
//  Shopping
//
//  Created by yww on 2020/8/6.
//  Copyright © 2020 klc. All rights reserved.
//  我的收入

#import "MyShopIncomeVC.h"
 
#import <LibProjModel/KLCUserInfo.h>
#import <LibProjModel/HttpApiShopBusiness.h>
 
@interface MyShopIncomeVC ()
@property (nonatomic, strong)ShopBusinessModel *shopModel;
 
@property (nonatomic, strong)UIImageView *headerView;
@property (nonatomic, strong)UILabel *balanceTitleL;
@property (nonatomic, strong)UILabel *balanceL;//余额
@property (nonatomic, strong)UIButton *widthdrawBtn;//提现
@property (nonatomic, strong)UIButton *incomeDetailBtn;//收入明细

@property (nonatomic, strong)UIView *totalDealView;//交易
@property (nonatomic, strong)UILabel *totalIncomeL;
@property (nonatomic, strong)UILabel *totalWithdrawL;
 
@end

@implementation MyShopIncomeVC

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self getShopInfo];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = kRGB_COLOR(@"#DEDEDE");
    self.navigationItem.title = kLocalizationMsg(@"我的收入");
    [self.view addSubview:self.headerView];
    [self.view addSubview:self.totalDealView];
    [self addSubView];

}
- (void)addSubView{
    //header
    [self.headerView addSubview:self.balanceTitleL];
    [self.headerView addSubview:self.balanceL];
    UIView *line1 = [[UIView alloc] initWithFrame:CGRectMake(20, _headerView.height - 45, _headerView.width-40, 0.5)];
    line1.backgroundColor = kRGBA_COLOR(@"#FFFFFF", 0.6);
    [self.headerView addSubview:line1];
    [self.headerView addSubview:self.widthdrawBtn];
    [self.headerView addSubview:self.incomeDetailBtn];
    UIView *line2 = [[UIView alloc] initWithFrame:CGRectMake(self.widthdrawBtn.maxX+4.5, _headerView.height - 32, 0.5, 20)];
    line2.backgroundColor = kRGBA_COLOR(@"#FFFFFF", 0.6);
    [self.headerView addSubview:line2];
    
    //footer
    CGFloat width = (kScreenWidth-24-10)/2.0;
    CGFloat marginH = 40/3.0;
    for (int i = 0; i < 2; i++) {
        UIView *subV = [[UIView alloc]initWithFrame:CGRectMake(i*(width+10), 0, width, 80)];
        subV.backgroundColor = [UIColor whiteColor];
        subV.layer.cornerRadius = 10;
        [self.totalDealView addSubview:subV];
        UILabel *contentL = [[UILabel alloc]initWithFrame:CGRectMake(0, marginH, width, 20)];
        contentL.font = [UIFont systemFontOfSize:12];
        contentL.textColor = kRGB_COLOR(@"#FF5500");
        contentL.textAlignment = NSTextAlignmentCenter;
        contentL.text = @"¥ 0.00";
        if (i == 0) {
            self.totalIncomeL = contentL;
        }else{
            self.totalWithdrawL = contentL;
        }
        [subV addSubview:contentL];
        
        UILabel *contentTitleL = [[UILabel alloc]initWithFrame:CGRectMake(0, contentL.maxY+marginH, width, 20)];
        contentTitleL.font = [UIFont systemFontOfSize:12];
        contentTitleL.textColor = kRGB_COLOR(@"#333333");
        contentTitleL.textAlignment = NSTextAlignmentCenter;
        if (i == 0) {
            contentTitleL.text = kLocalizationMsg(@"累计收入(¥)");
        }else{
            contentTitleL.text = kLocalizationMsg(@"累计提现(¥)");
        }
        [subV addSubview:contentTitleL];
    }
}

- (void)getShopInfo{
    kWeakSelf(self);
    [HttpApiShopBusiness getOne:^(int code, NSString *strMsg, ShopBusinessModel *model) {
        if (code == 1) {
            weakself.shopModel = model;
            [weakself updateFace];
        }else{
            [SVProgressHUD showInfoWithStatus:strMsg];
        }
    }];
}

- (void)updateFace{
    NSString *balance = [NSString stringWithFormat:@"%.2f",self.shopModel.amount];
    NSMutableAttributedString *balaceAtt = [[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@"¥ %@",balance]];
    [balaceAtt addAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:24]} range:[balaceAtt.string rangeOfString:balance]];
    self.balanceL.attributedText = balaceAtt;
    
    NSString *income = [NSString stringWithFormat:@"%.2f",self.shopModel.totalAmount];
    NSMutableAttributedString *incomeAtt = [[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@"¥ %@",income]];
    [incomeAtt addAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:18]} range:[incomeAtt.string rangeOfString:income]];
    self.totalIncomeL.attributedText = incomeAtt;
    
    NSString *widthdraw = [NSString stringWithFormat:@"%.2f",self.shopModel.totalCash];
    NSMutableAttributedString *widthdrawAtt = [[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@"¥ %@",widthdraw]];
    [widthdrawAtt addAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:18]} range:[widthdrawAtt.string rangeOfString:widthdraw]];
    self.totalWithdrawL.attributedText = widthdrawAtt;
}


#pragma mark - 按钮
- (void)incomeDetailBtnClick:(UIButton *)btn{
    ///注意 这里如果是原生界面 备用控制器名称为 MyShopIncomeDetailListVC                 
//    NSString *strUrl = @"/api/business/incomeList?pageSize=10&pageIndex=0&type=1";

    NSString *strUrl = @"/api/h5/toIncomeList";
    [RouteManager routeForName:RN_general_webView currentC:self parameters:@{@"url":strUrl}];
}

- (void)widthdrawBtnClick:(UIButton *)btn{
   [RouteManager routeForName:RN_Shopping_Order_myShopWithdrawVC currentC:self];
}
#pragma mark - lazy load
- (UILabel *)balanceTitleL{
    if (!_balanceTitleL) {
        CGFloat margin = (_headerView.height- 44-55)/2.0;
        _balanceTitleL = [[UILabel alloc]initWithFrame:CGRectMake(20, margin, _headerView.width-40, 20)];
        _balanceTitleL.textColor = kRGB_COLOR(@"#FFFFFF");
        _balanceTitleL.textAlignment = NSTextAlignmentLeft;
        _balanceTitleL.font = [UIFont systemFontOfSize:14];
        _balanceTitleL.text = kLocalizationMsg(@"小店余额");
    }
    return _balanceTitleL;
}
- (UIButton *)incomeDetailBtn{
    if (!_incomeDetailBtn) {
        _incomeDetailBtn = [[UIButton alloc]initWithFrame:CGRectMake(_widthdrawBtn.maxX+10, _headerView.height - 44, (_headerView.width-30)/2.0, 44)];
        [_incomeDetailBtn setTitle:kLocalizationMsg(@"收入明细") forState:UIControlStateNormal];
        [_incomeDetailBtn setTitleColor:kRGB_COLOR(@"#FFFFFF") forState:UIControlStateNormal];
        _incomeDetailBtn.titleLabel.font = [UIFont systemFontOfSize:14];
        [_incomeDetailBtn addTarget:self action:@selector(incomeDetailBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _incomeDetailBtn;
}

- (UIButton *)widthdrawBtn{
    if (!_widthdrawBtn) {
        _widthdrawBtn = [[UIButton alloc]initWithFrame:CGRectMake(10, _headerView.height - 44, (_headerView.width-30)/2.0, 44)];
        [_widthdrawBtn setTitle:kLocalizationMsg(@"立即提现") forState:UIControlStateNormal];
        [_widthdrawBtn setTitleColor:kRGB_COLOR(@"#FFFFFF") forState:UIControlStateNormal];
        _widthdrawBtn.titleLabel.font = [UIFont systemFontOfSize:14];
        [_widthdrawBtn addTarget:self action:@selector(widthdrawBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _widthdrawBtn;
}
- (UILabel *)balanceL{
    if (!_balanceL) {
        _balanceL = [[UILabel alloc]initWithFrame:CGRectMake(20, _balanceTitleL.maxY+5, _headerView.width-40,30)];
        _balanceL.textAlignment = NSTextAlignmentLeft;
        _balanceL.textColor = kRGB_COLOR(@"#FFFFFF");
        _balanceL.font = [UIFont systemFontOfSize:12];
    }
    return _balanceL;
}
- (UIImageView *)headerView{
    if (!_headerView) {
        CGFloat scale = 160.0/336.0;
        CGFloat height = kScreenWidth*scale;
        _headerView = [[UIImageView alloc]initWithFrame:CGRectMake(12, 10, kScreenWidth-24, height)];
        _headerView.userInteractionEnabled = YES;
        _headerView.image = [UIImage imageNamed:@"shop_income_header_bg"];
    }
    return _headerView;
}
- (UIView *)totalDealView{
    if (!_totalDealView) {
        _totalDealView = [[UIView alloc]initWithFrame:CGRectMake(12, _headerView.maxY+12, _headerView.width, 80)];
        _totalDealView.backgroundColor = [UIColor clearColor];
    }
    return _totalDealView;
}
@end
