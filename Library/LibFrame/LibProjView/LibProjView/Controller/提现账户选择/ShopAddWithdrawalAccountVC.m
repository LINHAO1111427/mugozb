//
//  AddWithdrawalAccountVC.m
//  CapitalMarket
//
//  Created by klc on 2020/3/26.
//  Copyright © 2020 . All rights reserved.
//

#import "ShopAddWithdrawalAccountVC.h"
#import <LibTools/LibTools.h>
#import "ShopAddWithdrawalAccountView.h"
#import <LibProjModel/HttpApiAPPFinance.h>
#import <LibProjBase/LibProjBase.h>
#import <LibProjView/EmptyView.h>

@interface ShopAddWithdrawalAccountVC ()
@property (nonatomic, weak)UIButton *selectBtn;
@property (nonatomic, assign)BOOL isEidt;//是否编辑
@property (nonatomic, assign)int showType;//类型
@property (nonatomic, strong)AppUsersCashAccountModel  *accountModel;
@property (nonatomic, strong)ShopAddWithdrawalAccountView *accountView;
@property (nonatomic, weak)EmptyView *emptyV;

@end

@implementation ShopAddWithdrawalAccountVC
- (instancetype)initWith:(BOOL)isEidt model:(AppUsersCashAccountModel *)model{
    self = [super init];
    if (self) {
        self.accountModel = model;
        self.isEidt = isEidt;
        if (isEidt) {
            if (model.type == 1) {
                self.showType = 2;
            }else if (model.type == 2){
                self.showType = 3;
            }else{
                self.showType = 1;
            }
        }else{
            self.showType = 1;
        }
    }
    return self;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = self.isEdit?kLocalizationMsg(@"编辑"):kLocalizationMsg(@"添加提现账户");
    self.view.backgroundColor = [UIColor whiteColor];
    
    EmptyView *emptyV = [[EmptyView alloc] init];
    emptyV.titleL.text = kLocalizationMsg(@"暂无提现方式～");
    emptyV.hidden = YES;
    [self.view addSubview:emptyV];
    _emptyV = emptyV;
    [emptyV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self.view);
        make.size.mas_equalTo(CGSizeMake(200, 200));
    }];
    [emptyV layoutIfNeeded];
    
    [self getWithdrawalMethod];
}

- (void)getWithdrawalMethod{
    kWeakSelf(self);
    [HttpApiAPPFinance getWithdrawalMethod:^(int code, NSString *strMsg, WithdrawalMethodModel *model) {
        if (code == 1) {
            NSMutableArray *itemArr = [[NSMutableArray alloc] init];
            if (model.haveBankCard) {
                [itemArr addObject:@{@"title":kLocalizationMsg(@" 银行卡"),@"image":@"mine_center_profit_card",@"type":@(1)}];
            }
            if (model.haveAliPay) {
                [itemArr addObject:@{@"title":kLocalizationMsg(@" 支付宝"),@"image":@"mine_center_profit_alipay",@"type":@(2)}];
            }
            if (model.haveWeiXinPay) {
                [itemArr addObject:@{@"title":kLocalizationMsg(@" 微信"),@"image":@"mine_center_profit_wx",@"type":@(3)}];
            }
            if (itemArr.count) {
                weakself.emptyV.hidden = YES;
                [weakself creatSubView:[itemArr copy]];
            }else{
                weakself.emptyV.hidden = NO;
                weakself.emptyV.detailL.text = kLocalizationMsg(@"暂未开启提现功能");
            }
        }else{
            weakself.emptyV.hidden = NO;
            weakself.emptyV.detailL.text = strMsg;
            [SVProgressHUD showInfoWithStatus:strMsg];
        }
    }];
}

-(void)creatSubView:(NSArray *)itemArr{
    
    self.accountView = [[ShopAddWithdrawalAccountView alloc] initWithFrame:CGRectMake(0, 100, kScreenWidth, 200)];
    [self.view addSubview:self.accountView];
    
    self.accountView.bankView.hidden = YES;
    self.accountView.weChatView.hidden = YES;
    self.accountView.alipayView.hidden = NO;
       
//    CGFloat space = 130-itemArr.count*30;
//    CGFloat btnW = (kScreenWidth-space*(itemArr.count+1))/(itemArr.count * 1.0);
    CGFloat btnW = 90;
    CGFloat space = (kScreenWidth- btnW*itemArr.count)/((itemArr.count+1)*1.0);
    for (int i = 0; i < itemArr.count; i++) {
        NSDictionary *item = itemArr[i];
        UIButton *btn = [UIButton buttonWithType:0];
        btn.frame = CGRectMake(space+i*(btnW+space), 20, btnW, 35);
        [btn setTitle:item[@"title"] forState:0];
        btn.titleLabel.font = [UIFont systemFontOfSize:12];
        btn.layer.cornerRadius = 17.5;
        btn.layer.masksToBounds = YES;
        btn.imageEdgeInsets = UIEdgeInsetsMake(7.5,10, 7.5, 60);
        [btn setImage:[UIImage imageNamed:item[@"image"]] forState:UIControlStateNormal];
        btn.layer.borderWidth = 1.0;
        if (i == 0) {
            btn.selected = YES;
            btn.layer.borderColor = [ProjConfig normalColors].CGColor;
        }else{
            btn.layer.borderColor = [UIColor whiteColor].CGColor;
        }
        btn.tag = 10000+[item[@"type"] intValue];
        [btn setBackgroundImage:[kRGB_COLOR(@"#F6F6F6") imageWithColor] forState:UIControlStateNormal];
        [btn setBackgroundImage:[[UIColor whiteColor] imageWithColor] forState:UIControlStateSelected];
        [btn setTitleColor: kRGB_COLOR(@"#333333") forState:UIControlStateNormal];
        [btn setTitleColor:[ProjConfig normalColors] forState:UIControlStateSelected];
        
        [btn addTarget:self action:@selector(changeRankType:) forControlEvents:UIControlEventTouchUpInside];
        if (!self.isEidt) {
            [self.view addSubview:btn];
        }
        if ([item[@"type"] intValue] == self.showType) {
            [self changeRankType:btn];
        }
    }
    

    UIButton *sureBtn = [[UIButton alloc] initWithFrame:CGRectMake((kScreenWidth - kScreenWidth*0.6)/2, CGRectGetMaxY(self.accountView.frame) + 50, kScreenWidth*0.6, 44)];
    sureBtn.layer.cornerRadius = 22;
    sureBtn.layer.masksToBounds = YES;
    sureBtn.backgroundColor = [ProjConfig normalColors];
    [sureBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [sureBtn setTitle:self.isEdit?kLocalizationMsg(@"确定修改"):kLocalizationMsg(@"确定添加") forState:UIControlStateNormal];
    sureBtn.titleLabel.font = [UIFont systemFontOfSize:14];
    [sureBtn addTarget:self action:@selector(sureBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:sureBtn];

}
- (void)changeRankType:(UIButton *)btn{
    self.selectBtn = btn;

    int btnType = (int)btn.tag -10000;
    for (UIView *view in self.view.subviews) {
        if ([view isKindOfClass:[UIButton class]] && view.tag >= 10000) {
            UIButton *btoon = (UIButton *)view;
                if (btoon.tag == btn.tag) {
                    btoon.selected = YES;
                    btoon.layer.borderColor = [ProjConfig normalColors].CGColor;
                }else{
                    btoon.selected = NO;
                    btoon.layer.borderColor = [UIColor whiteColor].CGColor;
                }
        }
    }
    
    if (self.isEidt) {
        switch (self.showType) {// 账号类型，1表示银行卡 2表示支付宝，3表示微信
            case 1:
                self.accountView.bankAccountText.text = self.accountModel.account;
                self.accountView.bankBranchText.text = self.accountModel.branch;
                self.accountView.bankNameText.text = self.accountModel.accountBank;
                self.accountView.bankAccountNameText.text = self.accountModel.name;
                 
                break;
            case 2:
                self.accountView.alipayAccountText.text = self.accountModel.account;
                self.accountView.alipayNameText.text = self.accountModel.name;
                 
                break;
            case 3:
                self.accountView.weChatAccountText.text = self.accountModel.account;
                self.accountView.weChatNameText.text = self.accountModel.name;
               break;
                
            default:
                break;
        }
    }else{
        self.showType = btnType;
    }
    switch (self.showType) {
        case 1:
            self.accountView.bankView.hidden = NO;
            self.accountView.weChatView.hidden = YES;
            self.accountView.alipayView.hidden = YES;
            break;
        case 2:
            self.accountView.bankView.hidden = YES;
            self.accountView.weChatView.hidden = YES;
            self.accountView.alipayView.hidden = NO;
            break;
        case 3:
            self.accountView.bankView.hidden = YES;
            self.accountView.weChatView.hidden = NO;
            self.accountView.alipayView.hidden = YES;
            break;
         
        default:
            break;
    }
  
}

 


- (void)sureBtnClick{
    
   [self.view endEditing:YES];
    
    NSString *account= @"";
    NSString *accountName = @"";
    NSString *bankName = @"";
    NSString *bankBranchName = @"";
    if (self.showType == 2) {
        if (self.accountView.alipayAccountText.text == nil || self.accountView.alipayAccountText.text == NULL || self.accountView.alipayAccountText.text.length == 0) {
            [SVProgressHUD showInfoWithStatus:kLocalizationMsg(@"请输入支付宝账号")];
            return;
        }
        if (self.accountView.alipayNameText.text == nil || self.accountView.alipayNameText.text == NULL || self.accountView.alipayNameText.text.length == 0) {
            [SVProgressHUD showInfoWithStatus:kLocalizationMsg(@"请输入支付宝账号姓名")];
            return;
        }
        account = self.accountView.alipayAccountText.text;
        accountName = self.accountView.alipayNameText.text;
    }
    if (self.showType == 3) {
        if (self.accountView.weChatAccountText.text == nil || self.accountView.weChatAccountText.text == NULL || self.accountView.weChatAccountText.text.length == 0) {
            [SVProgressHUD showInfoWithStatus:kLocalizationMsg(@"请输入微信账号")];
            return;
        }
        if (self.accountView.weChatNameText.text == nil || self.accountView.weChatNameText.text == NULL || self.accountView.weChatNameText.text.length == 0) {
            [SVProgressHUD showInfoWithStatus:kLocalizationMsg(@"请输入微信账号名称")];
            return;
        }
        account = self.accountView.weChatAccountText.text;
        accountName = self.accountView.weChatNameText.text;
    }
    if (self.showType == 1) {
        if (self.accountView.bankNameText.text == nil || self.accountView.bankNameText.text == NULL || self.accountView.bankNameText.text.length == 0) {
            [SVProgressHUD showInfoWithStatus:kLocalizationMsg(@"请输入银行名称")];
            return;
        }
        
        if (self.accountView.bankBranchText.text == nil || self.accountView.bankBranchText.text == NULL || self.accountView.bankBranchText.text.length == 0) {
            [SVProgressHUD showInfoWithStatus:kLocalizationMsg(@"请输入开户支行名称")];
            return;
        }
        
        if (self.accountView.bankAccountText.text == nil || self.accountView.bankAccountText.text == NULL || self.accountView.bankAccountText.text.length == 0) {
            [SVProgressHUD showInfoWithStatus:kLocalizationMsg(@"请输入银行卡账号")];
            return;
        }
        if (self.accountView.bankAccountNameText.text == nil || self.accountView.bankAccountNameText.text == NULL || self.accountView.bankAccountNameText.text.length == 0) {
            [SVProgressHUD showInfoWithStatus:kLocalizationMsg(@"请输入持卡人姓名")];
            return;
        }
       
        account = self.accountView.bankAccountText.text;
        bankBranchName = self.accountView.bankBranchText.text;
        accountName = self.accountView.bankAccountNameText.text;
        bankName = self.accountView.bankNameText.text;
    }

    kWeakSelf(self);
    [SVProgressHUD show];
    
    int64_t recordId = 0;
    
    if (self.isEidt) {
        recordId = self.accountModel.id_field;
    }
    int type = 1;
    if (self.showType == 1) {//银行
        type = 3;
    }else if(self.showType == 2){//支付宝
        type = 1;
    }else{//微信
        type = 2;
    }
        
    [HttpApiAPPFinance withdrawAccountAdd:account accountBank:bankName branch:bankBranchName name:accountName recordId:recordId type:type callback:^(int code, NSString *strMsg, HttpNoneModel *model) {
        [SVProgressHUD dismiss];
        if (code == 1) {
            [SVProgressHUD showSuccessWithStatus:self.isEidt?kLocalizationMsg(@"编辑成功"):kLocalizationMsg(@"添加成功")];
            [weakself.navigationController popViewControllerAnimated:YES];
        }else{
            [SVProgressHUD showInfoWithStatus:strMsg];
        }
    } ];
}


- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self.view endEditing:YES];
}


@end
