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

#import <LibProjView/ShopWithdrawAccountVC.h>

#import "ShowExchangeView.h"
#import "ShowWithdrawView.h"


@interface CommissWithdrawVc () <ShowWithdrawViewDelegate>

@property (nonatomic, strong)UILabel *tipLabel;//提示

@property (nonatomic, strong)UIView *contentBackV;//包含以下

@property (nonatomic, strong)UIButton *selectItemBtn;///选择某一个类型


@property (nonatomic, strong)UIImageView *rightArrowImageV;//箭头
 
@property (nonatomic, assign)NSInteger withDrawType;


@property (nonatomic, strong)UIView *widthDrawCashView;
@property (nonatomic, strong)UIView *exchangeCoinView;

@end

@implementation CommissWithdrawVc

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    // 开启侧滑
    if ([self.navigationController respondsToSelector:@selector(interactivePopGestureRecognizer)]) {
        self.navigationController.interactivePopGestureRecognizer.enabled = YES;
    }
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = kLocalizationMsg(@"提现");
    self.view.backgroundColor = [UIColor whiteColor];
    
    UIView *line = [[UIView alloc] initWithFrame:CGRectMake(0, self.navigationController.navigationBar.height-1, kScreenWidth, 0.5)];
    line.backgroundColor = kRGB_COLOR(@"#D8D8D8");
    [self.navigationController.navigationBar addSubview:line];
    
    UIButton *withdrawListBtn = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 50, 32)];
    [withdrawListBtn setTitleColor: kRGB_COLOR(@"#999999") forState:UIControlStateNormal];
    [withdrawListBtn setTitle:kLocalizationMsg(@"提现记录") forState:UIControlStateNormal];
    withdrawListBtn.titleLabel.font = [UIFont systemFontOfSize:12];
    [withdrawListBtn addTarget:self action:@selector(withdrawListBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *item = [[UIBarButtonItem alloc]initWithCustomView:withdrawListBtn];;
    self.navigationItem.rightBarButtonItem = item;
    
    [self getChargeRules];
}


- (void)getChargeRules{
    kWeakSelf(self);
    [HttpApiApiRechargeRules rulesList:^(int code, NSString *strMsg, RechargeCenterVOModel *model) {
        if (code == 1) {
            [weakself createUI:model];
        }else{
            [SVProgressHUD showInfoWithStatus:strMsg];
        }
    }];
}



- (void)createUI:(RechargeCenterVOModel *)voModel{
    
    //header
    CGFloat scaleH = 750/540.0;
    CGFloat widthH = kScreenWidth;
    CGFloat heightH = widthH/scaleH;
    UIImageView *headerImgv = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, widthH, heightH)];
    headerImgv.userInteractionEnabled = YES;
    headerImgv.image = [UIImage createImageSize:headerImgv.size gradientColors:@[kRGB_COLOR(@"#FF54A0"),kRGB_COLOR(@"#FF96DB")] percentage:@[@0.3,@1.0] gradientType:GradientFromLeftToRight];
    [self.view addSubview:headerImgv];
    {
        //标题
        UILabel *headerTitleLabel = [[UILabel alloc]initWithFrame:CGRectMake(20, 35, widthH-40, 20)];
        headerTitleLabel.textColor = [UIColor whiteColor];
        headerTitleLabel.font = [UIFont systemFontOfSize:14];
        headerTitleLabel.textAlignment = NSTextAlignmentLeft;
        headerTitleLabel.text = kLocalizationMsg(@"佣金余额(元)");
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
    }
    
    // 提示
    UILabel *tipLabel = [[UILabel alloc]initWithFrame:CGRectMake(12, kScreenHeight-kNavBarHeight-kSafeAreaBottom-50, kScreenWidth-24, 20)];
    tipLabel.textColor = kRGB_COLOR(@"#999999");
    tipLabel.text = kLocalizationMsg(@"( 每日只能发起一笔提现 )");
    tipLabel.font = [UIFont systemFontOfSize:12];
    tipLabel.textAlignment = NSTextAlignmentCenter;
    self.tipLabel = tipLabel;
    [self.view addSubview:self.tipLabel];
    
    
    {
        ///中间内容
        UIView *contentBackV = [[UIView alloc] initWithFrame:CGRectMake(15, 130, kScreenWidth-30, tipLabel.y - 150)];
        [self.view addSubview:contentBackV];
        contentBackV.backgroundColor = [UIColor whiteColor];
        contentBackV.layer.cornerRadius  = 10;
        contentBackV.clipsToBounds = NO;
        contentBackV.layer.shadowColor = [ProjConfig normalColors].CGColor;
        contentBackV.layer.shadowOpacity = 0.5;
        contentBackV.layer.shadowRadius = 2;
        contentBackV.layer.shadowOffset = CGSizeMake(0 ,1);
        self.contentBackV = contentBackV;
        
        ///几个功能
        NSMutableArray *itemArr = [NSMutableArray arrayWithCapacity:1];
        [itemArr addObject:@{@"title":kLocalizationMsg(@"提现现金"),@"type":@"1"}];
        if (voModel.coinExchange == 1) {
            [itemArr addObject:@{@"title":[NSString stringWithFormat:kLocalizationMsg(@"兑换%@"),[KLCAppConfig unitStr]],@"type":@"2"}];
        }
        
        ///头部
        UIView *headerBgV = [[UIView alloc] initWithFrame:CGRectMake(0, 0, contentBackV.width, 0)];
        headerBgV.clipsToBounds = YES;
        [contentBackV addSubview:headerBgV];
        
        
        if (itemArr.count > 1) {
            headerBgV.height = 50;
        }
        ///内容
        kWeakSelf(self);
        
        CGFloat btnW = headerBgV.width/(itemArr.count*1.0);
        for (int i = 0; i<itemArr.count; i++) {
            
            NSDictionary *items = itemArr[i];
            UIButton *btn = [[UIButton alloc]initWithFrame:CGRectMake(i*btnW,10, btnW, 40)];
            [btn setTitle:items[@"title"] forState:UIControlStateNormal];
            [btn setTitleColor:[ProjConfig normalColors] forState:UIControlStateSelected];
            [btn setTitleColor:kRGB_COLOR(@"#666666") forState:UIControlStateNormal];
            btn.titleLabel.font = [UIFont systemFontOfSize:14];
            int type = [items[@"type"] intValue];
            btn.tag = type;
            [btn addTarget:self action:@selector(switchBtnClick:) forControlEvents:UIControlEventTouchUpInside];
            btn.selected = NO;
            [headerBgV addSubview:btn];
            
            
            ///第一个显示的view
            UIView *ShowV = nil;
            ///类型
            switch (type) {
                case 1: ///提取
                {
                    ShowWithdrawView *drawV = [[ShowWithdrawView alloc] initWithFrame:CGRectMake(0, headerBgV.height, contentBackV.width, contentBackV.height-headerBgV.height)];
                    drawV.delegate = self;
                    drawV.totalAmount = self.inviteModel.totalAmount;
                    drawV.amount = self.inviteModel.amount;
                    drawV.chargeRulesRespModel = voModel;
                    [contentBackV addSubview:drawV];
                    self.widthDrawCashView = drawV;
                    ShowV = drawV;
                }
                    break;
                case 2: ///兑换
                {
                    ///先设定初始frame(最大的高)
                    ShowExchangeView *exchangeV = [[ShowExchangeView alloc] initWithFrame:CGRectMake(0, headerBgV.height, contentBackV.width, contentBackV.height-headerBgV.height)];
                    exchangeV.rechargeRulesVOList = voModel.rechargeRulesVOList;
                    [contentBackV addSubview:exchangeV];
                    exchangeV.rechangeSuccessBlock = ^{
                        [weakself withdrawSuccess];
                    };
                    self.exchangeCoinView = exchangeV;
                    ShowV = exchangeV;
                }
                    break;
                default:
                    break;
            }
            
            if (i == 0) {
                [self switchBtnClick:btn];
            }
        }
    }
}


- (void)switchBtnClick:(UIButton *)btn{
    if (self.selectItemBtn == btn) {
        return;
    }
    btn.selected = YES;
    self.selectItemBtn.selected = NO;
    self.selectItemBtn = btn;
    
    if (btn.tag == 1) {//提现现金
        self.exchangeCoinView.hidden = YES;
        self.widthDrawCashView.hidden = NO;
        self.tipLabel.hidden = NO;
        ///变更高度
        self.contentBackV.height = self.widthDrawCashView.maxY;
        
    }
    if (btn.tag == 2) {//兑换金币
        self.exchangeCoinView.hidden = NO;
        self.widthDrawCashView.hidden = YES;
        self.tipLabel.hidden = YES;
        ///变更高度
        self.contentBackV.height = self.exchangeCoinView.maxY;
    }
}


///提现记录
-(void)withdrawListBtnClick:(UIButton*)btn{
    NSString *strUrl = [ProjConfig baseUrl];
       strUrl = [strUrl stringByAppendingString:@"/api/h5/userMoneyDetails?type=2"];
       [RouteManager routeForName:RN_general_webView currentC:self parameters:@{@"url":strUrl}];
}


///点击scrollview
- (void)tapSrollView{
    [self.view endEditing:YES];
}


#pragma mark - ShowWithdrawViewDelegate -

- (void)selectAccountForWithdrawView:(ShowWithdrawView *)showV{
   // NSLog(@"过滤文字账户选择"));

    ShopWithdrawAccountVC *accountVc = [[ShopWithdrawAccountVC alloc]init];
    accountVc.defaultModel = showV.selectedAccountModel;
    accountVc.selectHandle = ^(AppUsersCashAccountModel * _Nullable model) {
        
        showV.selectedAccountModel = model;
         
        NSString *str = kLocalizationMsg(@"请选择提现账户");
        NSString *imageStr = @"";
        UIColor *textColor = kRGB_COLOR(@"#666666");
        
        if (model) {
            str =  model.name;
            if (model.type == 1) {//支付宝
                imageStr = @"icon_payment_allepay";
            }else if(model.type == 2){//微信
                imageStr = @"icon_payment_wechat";
            }else{//银行卡
                imageStr = @"icon_payment_card";
            }
        }
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            showV.accountLabel.textColor = textColor;
            showV.accountLabel.attributedText = [str attachmentForImage:[UIImage imageNamed:imageStr] bounds:CGRectMake(0, -5, 20, 20) before:YES];
        }); 
    };
    [self.navigationController pushViewController:accountVc animated:YES];
    
}

///成功
- (void)withdrawSuccess{
    [self.navigationController popViewControllerAnimated:YES];
}
 
@end
