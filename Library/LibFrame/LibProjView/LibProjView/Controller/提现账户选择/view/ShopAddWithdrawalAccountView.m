//
//  AddWithdrawalAccountView.m
//  CapitalMarket
//
//  Created by klc on 2020/3/26.
//  Copyright © 2020 . All rights reserved.
//

#import "ShopAddWithdrawalAccountView.h"
#import <LibProjModel/HttpApiAPPFinance.h>
#import <LibTools/LibTools.h>
#import <Masonry/Masonry.h>

#import <LibProjBase/LibProjBase.h>
@interface ShopAddWithdrawalAccountView ()<UITextFieldDelegate>
@end
@implementation ShopAddWithdrawalAccountView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self creatUI];
    }
    return self;
}

- (void)creatUI{
    
    [self creatBankView];
    [self creatWeChatView];
    [self creatAlipayView];
}

-(void)creatAlipayView{
    self.alipayView = [[UIView alloc] initWithFrame:self.bounds];
    [self addSubview:self.alipayView];
    {
        UILabel *nameL = [[UILabel alloc] initWithFrame:CGRectMake(15, 5, 110, 40)];
        nameL.text = kLocalizationMsg(@"支付宝账号姓名");
        nameL.textColor =kRGB_COLOR(@"#555555");
        nameL.font = [UIFont systemFontOfSize:14];
        [self.alipayView addSubview:nameL];
        
        self.alipayNameText = [[UITextField alloc] initWithFrame:CGRectMake(130, 5, self.bounds.size.width - 145, 40)];
        self.alipayNameText.font = [UIFont systemFontOfSize:14];
        self.alipayNameText.tintColor = [UIColor lightGrayColor];
        self.alipayNameText.returnKeyType = UIReturnKeyDone;
        self.alipayNameText.delegate = self;
        self.alipayNameText.placeholder = kLocalizationMsg(@"请输入支付宝账号姓名");
        
        [self.alipayView addSubview:self.alipayNameText];
        
        UIView *linkNameView = [[UIView alloc] initWithFrame:CGRectMake(15, self.alipayNameText.maxY+4, self.bounds.size.width - 30, 0.5)];
        linkNameView.backgroundColor =kRGB_COLOR(@"#DEDEDE");
        [self.alipayView addSubview:linkNameView];
    }
    
    
    
    
    {
        UILabel *accountL = [[UILabel alloc] initWithFrame:CGRectMake(15, 55, 80, 40)];
        accountL.text = kLocalizationMsg(@"支付宝账号");
        accountL.textColor =kRGB_COLOR(@"#555555");
        accountL.font = [UIFont systemFontOfSize:14];
        [self.alipayView addSubview:accountL];
        
        self.alipayAccountText = [[UITextField alloc] initWithFrame:CGRectMake(130, 55, self.bounds.size.width - 145, 40)];
        self.alipayAccountText.font = [UIFont systemFontOfSize:14];
        self.alipayAccountText.tintColor = [UIColor lightGrayColor];
        self.alipayAccountText.returnKeyType = UIReturnKeyDone;
        self.alipayAccountText.delegate = self;
        self.alipayAccountText.placeholder = kLocalizationMsg(@"请输入支付宝账号");
        [self.alipayView addSubview:self.alipayAccountText];
        
        UIView *linkAccountView = [[UIView alloc] initWithFrame:CGRectMake(15, self.alipayAccountText.maxY+4, self.bounds.size.width - 30, 0.5)];
        linkAccountView.backgroundColor =kRGB_COLOR(@"#DEDEDE");
        [self.alipayView addSubview:linkAccountView];
    }
    
    
}


-(void)creatWeChatView{
    
    self.weChatView = [[UIView alloc] initWithFrame:self.bounds];
    [self addSubview:self.weChatView];
    {
        UILabel *nameL = [[UILabel alloc] initWithFrame:CGRectMake(15, 5, 110, 40)];
        nameL.text = kLocalizationMsg(@"微信账号名称");
        nameL.textColor =kRGB_COLOR(@"#555555");
        nameL.font = [UIFont systemFontOfSize:14];
        [self.weChatView addSubview:nameL];
        
        self.weChatNameText = [[UITextField alloc] initWithFrame:CGRectMake(130, 5, self.bounds.size.width - 145, 40)];
        self.weChatNameText.font = [UIFont systemFontOfSize:14];
        self.weChatNameText.tintColor = [UIColor lightGrayColor];
        self.weChatNameText.returnKeyType = UIReturnKeyDone;
        self.weChatNameText.delegate = self;
        self.weChatNameText.placeholder = kLocalizationMsg(@"请输入微信账号名称");
        [self.weChatView addSubview:self.weChatNameText];
        
        UIView *linkNameView = [[UIView alloc] initWithFrame:CGRectMake(15, self.weChatNameText.maxY+4, self.bounds.size.width - 30, 0.5)];
        linkNameView.backgroundColor =kRGB_COLOR(@"#DEDEDE");
        [self.weChatView addSubview:linkNameView];
        
    }
    
    {
        UILabel *accountL = [[UILabel alloc] initWithFrame:CGRectMake(15, 55, 80, 40)];
        accountL.text = kLocalizationMsg(@"微信账号");
        accountL.textColor =kRGB_COLOR(@"#555555");
        accountL.font = [UIFont systemFontOfSize:14];
        [self.weChatView addSubview:accountL];
        
        self.weChatAccountText = [[UITextField alloc] initWithFrame:CGRectMake(130, 55, self.bounds.size.width - 145, 40)];
        self.weChatAccountText.font = [UIFont systemFontOfSize:14];
        self.weChatAccountText.tintColor = [UIColor lightGrayColor];
        self.weChatAccountText.returnKeyType = UIReturnKeyDone;
        self.weChatAccountText.delegate = self;
        self.weChatAccountText.placeholder = kLocalizationMsg(@"请输入微信账号");
        [self.weChatView addSubview:self.weChatAccountText];
        
        UIView *linkAccountView = [[UIView alloc] initWithFrame:CGRectMake(15,self.weChatAccountText.maxY+4, self.bounds.size.width - 30, 0.5)];
        linkAccountView.backgroundColor =kRGB_COLOR(@"#DEDEDE");
        [self.weChatView addSubview:linkAccountView];
    }
}


-(void)creatBankView{
    
    self.bankView = [[UIView alloc] initWithFrame:self.bounds];
    
    [self addSubview:self.bankView];
    
    UILabel *bankNameL = [[UILabel alloc] initWithFrame:CGRectMake(15, 5, 80, 40)];
    bankNameL.text = kLocalizationMsg(@"银行名称");
    bankNameL.textColor =kRGB_COLOR(@"#555555");
    bankNameL.font = [UIFont systemFontOfSize:14];
    [self.bankView addSubview:bankNameL];
    
    self.bankNameText = [[UITextField alloc] initWithFrame:CGRectMake(110, 5, self.bounds.size.width - 130, 40)];
    self.bankNameText.font = [UIFont systemFontOfSize:14];
    self.bankNameText.tintColor = [UIColor lightGrayColor];
    self.bankNameText.returnKeyType = UIReturnKeyDone;
    self.bankNameText.delegate = self;
    self.bankNameText.placeholder = kLocalizationMsg(@"请输入银行名称");
    [self.bankView addSubview:self.bankNameText];
    
    UIView *linkAccountView = [[UIView alloc] initWithFrame:CGRectMake(15, 45, self.bounds.size.width - 30, 0.5)];
    linkAccountView.backgroundColor =kRGB_COLOR(@"#DEDEDE");
    [self.bankView addSubview:linkAccountView];
    
    
    
    UILabel *bankBranchL = [[UILabel alloc] initWithFrame:CGRectMake(15, 50, 80, 40)];
    bankBranchL.text = kLocalizationMsg(@"开户支行");
    bankBranchL.textColor =kRGB_COLOR(@"#555555");
    bankBranchL.font = [UIFont systemFontOfSize:14];
    [self.bankView addSubview:bankBranchL];
    
    self.bankBranchText = [[UITextField alloc] initWithFrame:CGRectMake(110, 50, self.bounds.size.width - 130, 40)];
    self.bankBranchText.font = [UIFont systemFontOfSize:14];
    self.bankBranchText.tintColor = [UIColor lightGrayColor];
    self.bankBranchText.returnKeyType = UIReturnKeyDone;
    self.bankBranchText.delegate = self;
    self.bankBranchText.placeholder = kLocalizationMsg(@"请输入开户支行");
    [self.bankView addSubview:self.bankBranchText];
    
    UIView *bankBranchView = [[UIView alloc] initWithFrame:CGRectMake(15,90, self.bounds.size.width - 30, 0.5)];
    bankBranchView.backgroundColor =kRGB_COLOR(@"#DEDEDE");
    [self.bankView addSubview:bankBranchView];
    
    
    
    
    
    UILabel *accountL = [[UILabel alloc] initWithFrame:CGRectMake(15, 95, 80, 40)];
    accountL.text = kLocalizationMsg(@"银行卡号");
    accountL.textColor =kRGB_COLOR(@"#555555");
    accountL.font = [UIFont systemFontOfSize:14];
    [self.bankView addSubview:accountL];
    
    self.bankAccountText = [[UITextField alloc] initWithFrame:CGRectMake(110, 95, self.bounds.size.width - 145, 40)];
    self.bankAccountText.font = [UIFont systemFontOfSize:14];
    self.bankAccountText.tintColor = [UIColor lightGrayColor];
    self.bankAccountText.returnKeyType = UIReturnKeyDone;
    self.bankAccountText.delegate = self;
    self.bankAccountText.placeholder = kLocalizationMsg(@"请输入银行卡号");
    
    [self.bankView addSubview:self.bankAccountText];
    
    UIView *linkNameView = [[UIView alloc] initWithFrame:CGRectMake(15, 135, self.bounds.size.width - 30, 0.5)];
    linkNameView.backgroundColor =kRGB_COLOR(@"#DEDEDE");
    [self.bankView addSubview:linkNameView];
    
    
    UILabel *nameL = [[UILabel alloc] initWithFrame:CGRectMake(15, CGRectGetMaxY(linkNameView.frame)+5, 80, 40)];
    nameL.text = kLocalizationMsg(@"账号姓名");
    nameL.textColor =kRGB_COLOR(@"#555555");
    nameL.font = [UIFont systemFontOfSize:14];
    [self.bankView addSubview:nameL];
    
    self.bankAccountNameText = [[UITextField alloc] initWithFrame:CGRectMake(110, CGRectGetMaxY(linkNameView.frame)+5, self.bounds.size.width - 145, 40)];
    self.bankAccountNameText.font = [UIFont systemFontOfSize:14];
    self.bankAccountNameText.tintColor = [UIColor lightGrayColor];
    self.bankAccountNameText.returnKeyType = UIReturnKeyDone;
    self.bankAccountNameText.delegate = self;
    self.bankAccountNameText.placeholder = kLocalizationMsg(@"请输入账号姓名");
    
    [self.bankView addSubview:self.bankAccountNameText];
    
    UIView *linkBankNameV = [[UIView alloc] initWithFrame:CGRectMake(15, CGRectGetMaxY(linkNameView.frame) + 50, self.bounds.size.width - 30, 0.5)];
    linkBankNameV.backgroundColor =kRGB_COLOR(@"#DEDEDE");
    [self.bankView addSubview:linkBankNameV];
    
}




- (BOOL)textFieldShouldReturn:(UITextField*)textField{
    
    [textField resignFirstResponder];
    
    return YES;
    
}

@end
