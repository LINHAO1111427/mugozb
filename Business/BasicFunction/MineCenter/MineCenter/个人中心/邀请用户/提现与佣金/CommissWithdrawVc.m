//
//  CommissWithdrawViewController.m
//  MineCenter
//
//  Created by klc on 2020/5/23.
//

#import "CommissWithdrawVc.h"
#import "paySelectedBtn.h"

#import <LibTools/LibTools.h>
#import <LibProjBase/LibProjBase.h>

#import <LibProjModel/KLCUserInfo.h>
#import <LibProjModel/HttpApiAPPFinance.h>
#import <LibProjModel/RechargeRulesVOModel.h>
#import <LibProjModel/RechargeCenterVOModel.h>
#import <LibProjModel/HttpApiApiRechargeRules.h>
#import <LibProjModel/AppUsersCashAccountModel.h>

#import <LibProjView/ForceAlertController.h>
#import <LibProjView/SelectedWithdrawTypeView.h>

#import <LibProjView/ShopWithdrawAccountVC.h>
 
@interface CommissWithdrawVc ()
@property (nonatomic, strong)UIScrollView *scrollview;
@property (nonatomic, strong)UILabel *tipLabel;//提示

@property (nonatomic, strong)UIView *contentBackV;//包含以下
@property (nonatomic, strong)UIView *contentView;
@property (nonatomic, strong)UIButton *widthDrawCashBtn;//提现现金
@property (nonatomic, strong)UIButton *exchangeCoinBtn;//兑换金币
@property (nonatomic, strong)UITextField *commisionTextField;//佣金
@property (nonatomic, strong)UILabel *accountLabel;//提现方式
@property (nonatomic, strong)UIImageView *rightArrowImageV;//箭头
 
@property (nonatomic, strong)UIView *line;//线
@property (nonatomic, strong)UIButton *sureBtn;//确认
 

@property (nonatomic, assign)BOOL isExchangeCash;
@property (nonatomic, assign)NSInteger withDrawType;


@property (nonatomic, strong)UIView *widthDrawCashView;
@property (nonatomic, strong)UIView *exchangeCoinView;

@property (nonatomic, assign)NSInteger selectedIndex;
@property(nonatomic,strong)RechargeCenterVOModel *chargeRulesRespModel;
@property (nonatomic, strong,nullable)AppUsersCashAccountModel *selectedAccountModel;//提现账户
@end

@implementation CommissWithdrawVc
- (UIScrollView *)scrollview{
    if (!_scrollview) {
        _scrollview = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight-kSafeAreaBottom-kNavBarHeight)];
        _scrollview.scrollEnabled = YES;
        _scrollview.showsVerticalScrollIndicator = NO;
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tap)];
        [_scrollview addGestureRecognizer:tap];
    }
    return _scrollview;
}
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    // 开启侧滑
    if ([self.navigationController respondsToSelector:@selector(interactivePopGestureRecognizer)]) {
        self.navigationController.interactivePopGestureRecognizer.enabled = YES;
    }
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"提现";
    self.view.backgroundColor = [UIColor whiteColor];
    
    UIView *line = [[UIView alloc] initWithFrame:CGRectMake(0, self.navigationController.navigationBar.height-1, kScreenWidth, 0.5)];
    line.backgroundColor = kRGB_COLOR(@"#D8D8D8");
    [self.navigationController.navigationBar addSubview:line];
    
    UIButton *withdrawListBtn = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 50, 32)];
    [withdrawListBtn setTitleColor: kRGB_COLOR(@"#999999") forState:UIControlStateNormal];
    [withdrawListBtn setTitle:@"提现记录" forState:UIControlStateNormal];
    withdrawListBtn.titleLabel.font = [UIFont systemFontOfSize:12];
    [withdrawListBtn addTarget:self action:@selector(withdrawListBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *item = [[UIBarButtonItem alloc]initWithCustomView:withdrawListBtn];;
    self.navigationItem.rightBarButtonItem = item;
    
    [self.view addSubview:self.scrollview];
    
    self.selectedIndex = 0;
    [self getChargeRules];
}
- (void)getChargeRules{
    kWeakSelf(self);
    [HttpApiApiRechargeRules rulesList:^(int code, NSString *strMsg, RechargeCenterVOModel *model) {
        if (code == 1) {
            weakself.chargeRulesRespModel = model;
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [weakself createUI];
            });
            
        }else{
            [SVProgressHUD showErrorWithStatus:strMsg];
        }
    }];
     
      
}
- (void)createUI{
    //header
    CGFloat scaleH = 750/400.0;
    CGFloat widthH = kScreenWidth;
    CGFloat heightH = widthH/scaleH;
    UIImageView *headerImgv = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, widthH, heightH)];
    headerImgv.userInteractionEnabled = YES;
    headerImgv.image = [UIImage createImageSize:headerImgv.size gradientColors:@[kRGB_COLOR(@"#FF54A0"),kRGB_COLOR(@"#FF96DB")] percentage:@[@0.3,@1.0] gradientType:GradientFromLeftToRight];
    [self.scrollview addSubview:headerImgv];
    //标题
    UILabel *headerTitleLabel = [[UILabel alloc]initWithFrame:CGRectMake(20, 35, widthH-40, 20)];
    headerTitleLabel.textColor = [UIColor whiteColor];
    headerTitleLabel.font = [UIFont systemFontOfSize:14];
    headerTitleLabel.textAlignment = NSTextAlignmentLeft;
    headerTitleLabel.text = @"佣金余额(元)";
    [headerImgv addSubview:headerTitleLabel];
    
    //余额
    UILabel *moneyLabel = [[UILabel alloc]initWithFrame:CGRectMake(20, headerTitleLabel.maxY+15, widthH-40, 30)];
    moneyLabel.textAlignment = NSTextAlignmentLeft;
    moneyLabel.font = [UIFont boldSystemFontOfSize:26];
    moneyLabel.textColor = [UIColor whiteColor];
    NSString *moneyStr = [NSString stringWithFormat:@"¥%.2f",self.inviteModel.amount];
    NSMutableAttributedString *moneyAtt = [[NSMutableAttributedString  alloc]initWithString:moneyStr];
    [moneyAtt addAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:11]} range:[moneyStr rangeOfString:@"¥"]];
    moneyLabel.attributedText = moneyAtt;
    [headerImgv addSubview:moneyLabel];
    
    
    //内容
    CGFloat contentH = [self getContentHeightWith:1];
    UIView *contentBackV = [[UIView alloc]initWithFrame:CGRectMake(15, 130, kScreenWidth-30, contentH)];
    contentBackV.backgroundColor = [UIColor whiteColor];
    contentBackV.layer.cornerRadius  = 10;
    contentBackV.clipsToBounds = NO;
    contentBackV.layer.shadowColor = kRGB_COLOR(@"#FF5EC6").CGColor;
    contentBackV.layer.shadowOpacity = 0.5;
    contentBackV.layer.shadowRadius = 2;
    contentBackV.layer.shadowOffset = CGSizeMake(0 ,1);
    self.contentBackV = contentBackV;
    [self.scrollview addSubview:contentBackV];
    
    UIView *contentView = [[UIView alloc]initWithFrame:contentBackV.bounds];
    contentView.backgroundColor = [UIColor whiteColor];
    contentView.layer.cornerRadius  = 10;
    contentView.clipsToBounds = YES;
    self.contentView = contentView;
    [contentBackV addSubview:self.contentView];
    //初始化contentView
    [self createContentViewSubviews];
    
    CGFloat totalH = self.contentBackV.maxY;
    if (totalH < kScreenHeight-kSafeAreaBottom-kNavBarHeight) {
        totalH = kScreenHeight-kSafeAreaBottom-kNavBarHeight;
    }
    // 提示
    UILabel *tipLabel = [[UILabel alloc]initWithFrame:CGRectMake(12, totalH-50, kScreenWidth-24, 20)];
    tipLabel.textColor = kRGB_COLOR(@"#999999");
    tipLabel.text = @"( 每日只能发起一笔提现 )";
    tipLabel.font = [UIFont systemFontOfSize:12];
    tipLabel.textAlignment = NSTextAlignmentCenter;
    self.tipLabel = tipLabel;
    [self.scrollview addSubview:self.tipLabel];

    self.scrollview.contentSize = CGSizeMake(kScreenWidth, totalH+kSafeAreaBottom);
}
- (void)createContentViewSubviews{
    //切换
    CGFloat btnW = self.contentView.width/2.0;
    for (int i = 0; i<2; i++) {
        UIButton *btn = [[UIButton alloc]initWithFrame:CGRectMake(i*btnW,10, btnW, 40)];
        if (i == 0) {
            [btn setTitle:@"提现现金" forState:UIControlStateNormal];
        }else{
            NSString *showTitle = [NSString stringWithFormat:@"兑换%@",[KLCAppConfig unitStr]];
            [btn setTitle:showTitle forState:UIControlStateNormal];
        }
        
        [btn setTitleColor:kRGB_COLOR(@"#FF5EC6") forState:UIControlStateSelected];
        [btn setTitleColor:kRGB_COLOR(@"#666666") forState:UIControlStateNormal];
        btn.titleLabel.font = [UIFont systemFontOfSize:14];
        btn.tag = i;
        [btn addTarget:self action:@selector(switchBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        if (i == 0) {
            btn.selected = YES;
            self.widthDrawCashBtn = btn;
        }else{
            btn.selected = NO;
            self.exchangeCoinBtn = btn;
        }
        [self.contentView addSubview:btn];
    }
    
    [self addWidthDrawView];//提现
    [self addExchangeView];// 兑换
    
    UIButton *surebBtn = [[UIButton alloc]initWithFrame:CGRectMake((self.contentView.width-130)/2.0, self.contentView.height-60, 130, 40)];
    surebBtn.layer.cornerRadius = 20;
    surebBtn.clipsToBounds = YES;
    [surebBtn setBackgroundImage:[UIImage createImageSize:surebBtn.bounds.size gradientColors:@[kRGB_COLOR(@"#FF6CF6"),kRGB_COLOR(@"#FF54A0")] percentage:@[@0.1,@1.0] gradientType:GradientFromTopToBottom] forState:UIControlStateNormal];
    [surebBtn setTitle:@"确认提现" forState:UIControlStateNormal];
    surebBtn.titleLabel.font  =[UIFont systemFontOfSize:16];
    [surebBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [surebBtn addTarget:self action:@selector(surebBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    self.sureBtn = surebBtn;
    [self.contentView addSubview:self.sureBtn];
    
}
- (CGFloat)getContentHeightWith:(int)type{
    CGFloat height =90;
    if (type == 1) {
        height += 170;
    }else{
        CGFloat scale = 150.0/190.0;
        CGFloat width = (kScreenWidth-30-15*4)/3.0;
        CGFloat height = width *scale+10;
        height += ((self.chargeRulesRespModel.rechargeRulesVOList.count-1)/4+1)*(height+15);
    }
    return height;
}
- (void)addWidthDrawView{
    UIView *widthDrawView = [[UIView alloc]initWithFrame:CGRectMake(0, self.widthDrawCashBtn.maxY+10,self.contentView.width, 80)];
       widthDrawView.backgroundColor = [UIColor whiteColor];
       self.widthDrawCashView = widthDrawView;
       [self.contentView addSubview:self.widthDrawCashView];
    
    //提现佣金
    UILabel *moenyTitleLabel = [[UILabel alloc]initWithFrame:CGRectMake(15, 5, 30, 30)];
    moenyTitleLabel.textAlignment = NSTextAlignmentLeft;
    moenyTitleLabel.font = [UIFont systemFontOfSize:25];
    moenyTitleLabel.textColor = kRGB_COLOR(@"#333333");
    moenyTitleLabel.text = @"¥";
    [widthDrawView addSubview:moenyTitleLabel];
    
    UITextField *commisionTextField = [[UITextField alloc]initWithFrame:CGRectMake(moenyTitleLabel.maxX, 0, self.contentView.width-60-60, 40)];
    commisionTextField.backgroundColor = [UIColor clearColor];
    commisionTextField.textColor = kRGB_COLOR(@"#333333");
    commisionTextField.font = [UIFont systemFontOfSize:14];
    commisionTextField.keyboardType = UIKeyboardTypeNumberPad;
    commisionTextField.placeholder = [NSString stringWithFormat:@"最高可提现%.2f元",self.inviteModel.totalAmount];
    commisionTextField.textAlignment = NSTextAlignmentLeft;
    self.commisionTextField = commisionTextField;
    [widthDrawView addSubview:self.commisionTextField];
    
    //全部
    UIButton *getAllBtn = [[UIButton alloc]initWithFrame:CGRectMake(commisionTextField.maxX, 0, 60, 30)];
    getAllBtn.backgroundColor = [UIColor clearColor];
    getAllBtn.centerY = commisionTextField.centerY;
    [getAllBtn setTitle:@"全部提现" forState:UIControlStateNormal];
    [getAllBtn setTitleColor:[ProjConfig normalColors] forState:UIControlStateNormal];
    getAllBtn.titleLabel.font = [UIFont systemFontOfSize:13];
    [getAllBtn addTarget:self action:@selector(getAllBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [widthDrawView addSubview:getAllBtn];
    
    
     
    //提现账户
    UILabel *accountTitleLabel = [[UILabel alloc]initWithFrame:CGRectMake(15, commisionTextField.maxY, 64, 40)];
    accountTitleLabel.textAlignment = NSTextAlignmentLeft;
    accountTitleLabel.font = [UIFont systemFontOfSize:14];
    accountTitleLabel.textColor = kRGB_COLOR(@"#333333");
    accountTitleLabel.text = @"提现到";
    [widthDrawView addSubview:accountTitleLabel];
    
    UILabel *accountLabel = [[UILabel alloc]initWithFrame:CGRectMake(accountTitleLabel.maxX, 0, widthDrawView.width-64-30, 30)];
    accountLabel.backgroundColor = [UIColor clearColor];
    accountLabel.textColor = kRGB_COLOR(@"#666666");
    accountLabel.font = [UIFont systemFontOfSize:14];
    accountLabel.textAlignment = NSTextAlignmentRight;
    accountLabel.centerY = accountTitleLabel.centerY;
    NSString *accountText = @"请选择提现账户";
    NSMutableAttributedString *accountAtt = [[NSMutableAttributedString alloc]initWithString:accountText];
    NSTextAttachment *attach = [[NSTextAttachment alloc]init];
    attach.image = [UIImage imageNamed:@"mineCenter_gray_more"];
    attach.bounds = CGRectMake(0, -2, 8, 15);
    NSAttributedString *stringImage = [NSAttributedString attributedStringWithAttachment:attach];
    [accountAtt insertAttributedString:stringImage atIndex:accountText.length];
    accountLabel.attributedText = accountAtt;
    self.accountLabel = accountLabel;
    [widthDrawView addSubview:self.accountLabel];
    
    UIButton *accountBtn = [[UIButton alloc]initWithFrame:CGRectMake(15, commisionTextField.maxY, widthDrawView.width-30, 40)];
    accountBtn.backgroundColor = [UIColor clearColor];
    [accountBtn addTarget:self action:@selector(accountBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [widthDrawView addSubview:accountBtn];
    
    UIView *line = [[UIView alloc]initWithFrame:CGRectMake(15, 39, widthDrawView.width-30, 0.5)];
    line.backgroundColor = kRGBA_COLOR(@"#DEDEDE", 0.5);
    self.line = line;
    [widthDrawView addSubview:self.line];
}


- (void)addExchangeView{
       CGFloat scale = 150/190.0;
       CGFloat width = (kScreenWidth-30-15*4)/3.0;
       CGFloat height = width*scale;
       CGFloat magin = 15;
       NSInteger rowAll = (self.chargeRulesRespModel.rechargeRulesVOList.count-1)/3+1;
    
       UIView *exchangeView = [[UIView alloc]initWithFrame:CGRectMake(0, self.exchangeCoinBtn.maxY+10, self.contentView.width,(height+magin)*rowAll)];
       exchangeView.backgroundColor = [UIColor clearColor];
       self.exchangeCoinView = exchangeView;
       [self.contentView addSubview:exchangeView];
       for (int i = 0; i < self.chargeRulesRespModel.rechargeRulesVOList.count; i++) {
           RechargeRulesVOModel *model = self.chargeRulesRespModel.rechargeRulesVOList[i];
           NSInteger row = i/3;
           NSInteger col = i%3;
           UIView *backView = [[UIView alloc]initWithFrame:CGRectMake(magin+col *(width+magin), 10+row*(height+magin+10), width, height)];
           backView.backgroundColor = [UIColor clearColor];
           [exchangeView addSubview:backView];
           
           paySelectedBtn *btn = [[paySelectedBtn alloc]initWithFrame:CGRectMake(0, 0, width, height)];
           btn.model = model;
           btn.backgroundColor = [UIColor clearColor];
           btn.tag = i;
           if (i == self.selectedIndex) {
               btn.selected = YES;
           }
           [btn addTarget:self action:@selector(chargeBtnClick:) forControlEvents:UIControlEventTouchUpInside];
           [backView addSubview:btn];
       }
    self.exchangeCoinView.hidden = YES;
}
- (void)chargeBtnClick:(paySelectedBtn *)btn{
    btn.isSelected = YES;
    self.selectedIndex = btn.tag;
    for (UIView *view in self.exchangeCoinView.subviews) {
        if ([view.subviews.firstObject isKindOfClass:[paySelectedBtn class]]) {
            paySelectedBtn *payBtn = (paySelectedBtn *)view.subviews.firstObject;
            if (btn.tag != payBtn.tag ) {
                payBtn.isSelected = NO;
            }
        }
    }
}
- (void)tap{
    [self.commisionTextField resignFirstResponder];
}
- (void)switchBtnClick:(UIButton *)btn{
    btn.selected = YES;
    if (btn.tag == 0) {//提现现金
        self.isExchangeCash = NO;
        [self.sureBtn setTitle:@"确认提现" forState:UIControlStateNormal];
        self.exchangeCoinBtn.selected = NO;
        self.exchangeCoinView.hidden = YES;
        self.widthDrawCashView.hidden = NO;
        self.tipLabel.hidden = NO;
        self.line.hidden = NO;
    }else{//兑换金币
        self.isExchangeCash = YES;
        [self.sureBtn setTitle:[NSString stringWithFormat:@"兑换%@",[KLCAppConfig unitStr]] forState:UIControlStateNormal];
        self.widthDrawCashBtn.selected = NO;
        self.exchangeCoinView.hidden = NO;
        self.widthDrawCashView.hidden = YES;
        self.tipLabel.hidden = YES;
        self.line.hidden = YES;
    }
}
-(void)withdrawListBtnClick:(UIButton*)btn{
    NSString *strUrl = [ProjConfig baseUrl];
       strUrl = [strUrl stringByAppendingString:@"/api/h5/userMoneyDetails?type=2"];
       [RouteManager routeForName:RN_general_webView currentC:self parameters:@{@"url":strUrl}];
}
- (void)getAllBtnClick:(UIButton *)btn{
    self.commisionTextField.text = [NSString stringWithFormat:@"%.0f",self.inviteModel.amount];
}
- (void)surebBtnClick:(UIButton *)btn{
    kWeakSelf(self);
    if (self.isExchangeCash) {//兑换金币
        RechargeRulesVOModel *chargeModel = self.chargeRulesRespModel.rechargeRulesVOList[(int)self.selectedIndex];
        [SVProgressHUD show];
        AppUser_exchangeCoin *exchangeCoin = [[AppUser_exchangeCoin alloc] init];
        exchangeCoin.payTerminal = @"ios";
        exchangeCoin.ruleId = chargeModel.id_field;
        kWeakSelf(self);
        [HttpApiAppUser exchangeCoin:exchangeCoin callback:^(int code, NSString *strMsg, HttpNoneModel *model) {
            if (code == 1) {
                [SVProgressHUD showSuccessWithStatus:strMsg];
                [weakself.navigationController popViewControllerAnimated:YES];
            }else{
                [SVProgressHUD showErrorWithStatus:strMsg];
            }
        }];
         
    }else{//提现
        if (self.commisionTextField.text.length == 0) {
            [SVProgressHUD showErrorWithStatus:@"提现佣金不能为空"];
            return;
        }
        if (!self.selectedAccountModel) {
            [SVProgressHUD showErrorWithStatus:@"提现账户不能为空"];
            return;
        }
        [SVProgressHUD show];
        APPFinance_withdrawAccountApply *apply = [[APPFinance_withdrawAccountApply alloc] init];
        apply.delta = [self.commisionTextField.text intValue];
        apply.type = 2;
        apply.accountId = self.selectedAccountModel.id_field;
        apply.accountType = self.selectedAccountModel.type;
        apply.accountName = self.selectedAccountModel.name;
        kWeakSelf(self);
        [HttpApiAPPFinance withdrawAccountApply:apply callback:^(int code, NSString *strMsg, HttpNoneModel *model) {
            if (code == 1) {
                [SVProgressHUD showSuccessWithStatus:strMsg];
                [weakself.navigationController popViewControllerAnimated:YES];
            }else{
                [SVProgressHUD showErrorWithStatus:strMsg];
            }
        }];
    }
}

- (void)accountBtnClick:(UIButton *)btn{
    NSLog(@"账户选择");
    kWeakSelf(self);
    ShopWithdrawAccountVC *accountVc = [[ShopWithdrawAccountVC alloc]init];
    accountVc.defaultModel = self.selectedAccountModel;
    accountVc.selectHandle = ^(AppUsersCashAccountModel * _Nullable model) {
        weakself.selectedAccountModel = model;
         
        NSString *str;
        if (model) {
            str =  model.name;
        }else{
            str = @"请选择提现账户";
        }
        NSMutableAttributedString *attr = [[NSMutableAttributedString alloc]initWithString:str];
        NSTextAttachment *attachMore = [[NSTextAttachment alloc]init];
        attachMore.image = [UIImage imageNamed:@"mineCenter_gray_more"];
        attachMore.bounds = CGRectMake(0, -2, 8, 15);
        NSAttributedString *stringMore = [NSAttributedString attributedStringWithAttachment:attachMore];
        [attr insertAttributedString:stringMore atIndex:model.name.length];
        if (model) {
            NSString *imageStr;
            if (model.type == 1) {//支付宝
                imageStr = @"icon_payment_allepay";
            }else if(model.type == 2){//微信
                imageStr = @"icon_payment_wechat";
            }else{//银行卡
                imageStr = @"icon_payment_card";
            }
            NSTextAttachment *attach = [[NSTextAttachment alloc]init];
            attach.image = [UIImage imageNamed:imageStr];
            attach.bounds = CGRectMake(0, -5, 20, 20);
            NSAttributedString *stringImage = [NSAttributedString attributedStringWithAttachment:attach];
            [attr insertAttributedString:stringImage atIndex:0];
            weakself.accountLabel.textColor = kRGB_COLOR(@"#333333");
        }else{
            weakself.accountLabel.textColor = kRGB_COLOR(@"#666666");
        }
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            weakself.accountLabel.attributedText = attr;
        }); 
    };
    [self.navigationController pushViewController:accountVc animated:YES];
    
}
 
@end
