//
//  ShopMineAddAccountView.m
//  Shopping
//
//  Created by ssssssss on 2020/8/6.
//  Copyright © 2020 klc. All rights reserved.
//

#import "ShopMineAddAccountView.h"
#import <LibProjModel/HttpApiAPPFinance.h>
#import <LibProjBase/LibProjBase.h>
#import <Masonry/Masonry.h>
#import <LibTools/LibTools.h>

@implementation ShopMineAddAccountView{
    UIView *whiteView;
    UITextField *text1;
    UITextField *text2;
    UITextField *text3;
    UILabel *selectTypeLabel;
    UIImageView *jiantouImg;
    UIView *lineView2;
    UIView *lineView1;
    UILabel *tipLabel;
    int showType;
    UIView *twoBtnView;
}
- (void)hideself{
    if (twoBtnView) {
        [twoBtnView removeFromSuperview];
        twoBtnView = nil;
    }
    if (text1.isFirstResponder) {
        [text1 resignFirstResponder];
    }
    if (text2.isFirstResponder) {
        [text2 resignFirstResponder];
    }
    if (text3.isFirstResponder) {
        [text3 resignFirstResponder];
    }
    [self removeFromSuperview];
}
- (void)hideKeyboard{
    [text1 resignFirstResponder];
    [text2 resignFirstResponder];
    [text3 resignFirstResponder];
}

- (void)show{
    showType = 1;
    UIView *superV = [UIApplication sharedApplication].keyWindow;
    self.frame = CGRectMake(0, 0, superV.frame.size.width, superV.frame.size.height);
    self.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.3];
    [superV addSubview:self];
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(hideself)];
    [self addGestureRecognizer:tap];
    [self creatUI];
}

- (void)creatUI{
    whiteView = [[UIView alloc]init];
    whiteView.backgroundColor = [UIColor whiteColor];
    whiteView.layer.masksToBounds  =YES;
    whiteView.layer.cornerRadius = 5.0;
    [self addSubview:whiteView];
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(hideKeyboard)];
    [whiteView addGestureRecognizer:tap];

    [whiteView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self).offset(self.frame.size.height*0.26);
        make.width.equalTo(self).multipliedBy(0.8);
        make.centerX.equalTo(self);
    }];
    UILabel *titleL = [[UILabel alloc]init];
    titleL.text = kLocalizationMsg(@"添加提现账户");
    titleL.font = [UIFont boldSystemFontOfSize:14];
    titleL.textAlignment = NSTextAlignmentCenter;
    [whiteView addSubview:titleL];
    [titleL mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.width.equalTo(whiteView);
        make.height.mas_equalTo(50);
    }];
    UILabel *label = [[UILabel alloc]init];
    label.text = kLocalizationMsg(@"账户类型");
    label.font = [UIFont boldSystemFontOfSize:14];
    [whiteView addSubview:label];
    [label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(whiteView).offset(20);
        make.top.equalTo(titleL.mas_bottom);
        make.height.mas_equalTo(18);
    }];
    jiantouImg = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"mine_center_profit_right"]];
    jiantouImg.userInteractionEnabled = YES;
    kWeakSelf(self);
    [jiantouImg klc_whenTapped:^{
        [weakself selectTypeBtnClick];
    }];
    [whiteView addSubview:jiantouImg];
    [jiantouImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(whiteView).offset(-20);
        make.width.height.mas_equalTo(18);
        make.centerY.equalTo(label);
    }];
    selectTypeLabel = [[UILabel alloc] init];
    selectTypeLabel.text = kLocalizationMsg(@"支付宝");
    selectTypeLabel.font = [UIFont systemFontOfSize:14];
    selectTypeLabel.textColor = kRGB_COLOR(@"#333333");
    [whiteView addSubview:selectTypeLabel];
    [selectTypeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.height.equalTo(label);
        make.right.equalTo(jiantouImg.mas_left).offset(-2);
    }];
    
    UIButton *selectTypebtn = [UIButton buttonWithType:0];
    [selectTypebtn addTarget:self action:@selector(selectTypeBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [whiteView addSubview:selectTypebtn];
    [selectTypebtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.height.equalTo(selectTypeLabel);
        make.right.equalTo(jiantouImg);
    }];
    
    lineView1 = [[UIView alloc]init];
    lineView1.backgroundColor = kRGB_COLOR(@"#f4f5f6");
    [whiteView addSubview:lineView1];
    [lineView1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(label);
        make.top.equalTo(label.mas_bottom).offset(5);
        make.right.equalTo(jiantouImg);
        make.height.mas_equalTo(1);
    }];
    
//    if (APP_DEV == 7) {
//        tipLabel = [[UILabel alloc]init];
//        tipLabel.backgroundColor = [UIColor clearColor];
//        tipLabel.font = [UIFont systemFontOfSize:12];
//        tipLabel.textColor = [UIColor redColor];
//        tipLabel.numberOfLines = 0;
//        tipLabel.textAlignment = NSTextAlignmentLeft;
//        tipLabel.text = kLocalizationMsg(@"注：必须是中国四大行（中国银行、工行、建行和农行）");
//        [whiteView addSubview:tipLabel];
//        [tipLabel mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.left.equalTo(label);
//            make.top.equalTo(lineView1.mas_bottom).offset(5);
//            make.right.equalTo(jiantouImg);
//            make.height.mas_equalTo(40);
//        }];
//    }
     
    text1 = [[UITextField alloc]init];
    text1.font = [UIFont systemFontOfSize:15];
    text1.backgroundColor = kRGB_COLOR(@"#f7f7f7");
    text1.layer.cornerRadius = 5;
    text1.layer.masksToBounds = YES;
    text1.leftView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 15, 40)];
    text1.leftViewMode = UITextFieldViewModeAlways;
    [whiteView addSubview:text1];
    [text1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(lineView1);
        make.top.equalTo(lineView1.mas_bottom).offset(10);
        make.height.mas_equalTo(40);
    }];
    
    text2 = [[UITextField alloc]init];
    text2.font = [UIFont systemFontOfSize:15];
    text2.backgroundColor = kRGB_COLOR(@"#f7f7f7");
    text2.layer.cornerRadius = 5;
    text2.layer.masksToBounds = YES;
    text2.leftView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 15, 40)];
    text2.leftViewMode = UITextFieldViewModeAlways;
    [whiteView addSubview:text2];
    [text2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(lineView1);
        make.top.equalTo(text1.mas_bottom).offset(10);
        make.height.mas_equalTo(40);
    }];

    text3 = [[UITextField alloc]init];
    text3.font = [UIFont systemFontOfSize:15];
    text3.backgroundColor = kRGB_COLOR(@"#f7f7f7");
    text3.layer.cornerRadius = 5;
    text3.layer.masksToBounds = YES;
    text3.leftView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 15, 40)];
    text3.leftViewMode = UITextFieldViewModeAlways;
    [whiteView addSubview:text3];
    [text3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(lineView1);
        make.top.equalTo(text2.mas_bottom).offset(10);
        make.height.mas_equalTo(40);
    }];
    lineView2 = [[UIView alloc]init];
    lineView2.backgroundColor = kRGB_COLOR(@"#dcddde");
    [whiteView addSubview:lineView2];
    [lineView2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(whiteView);
//        make.top.equalTo(text3.mas_bottom).offset(5);
        make.right.equalTo(whiteView);
        make.height.mas_equalTo(1);
    }];

    UIButton *sureBtn = [UIButton buttonWithType:0];
    [sureBtn setTitle:kLocalizationMsg(@"确定") forState:0];
    [sureBtn setTitleColor:[ProjConfig normalColors] forState:0];
    [sureBtn addTarget:self action:@selector(sureBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [whiteView addSubview:sureBtn];
    [sureBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(lineView2.mas_bottom);
        make.left.width.equalTo(whiteView);
        make.height.mas_equalTo(50);
    }];
    [self updateConstraintsWith:showType];
}
- (void)updateConstraintsWith:(int)type{
    if (type == 1) {
        tipLabel.hidden = YES;
        text1.placeholder = kLocalizationMsg(@"请输入支付宝账号");
        text1.keyboardType = UIKeyboardTypeDefault;
        text2.placeholder = kLocalizationMsg(@"请输入支付宝账号姓名");
        text2.keyboardType = UIKeyboardTypeDefault;
        text2.hidden = NO;
        text3.hidden = YES;
        [text1 mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(lineView1
                             .mas_bottom).offset(10);
            make.left.equalTo(lineView1);
            make.right.equalTo(jiantouImg);
            make.height.mas_equalTo(40);
        }];
        [lineView2 mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(text2.mas_bottom).offset(10);
            make.left.equalTo(whiteView);
            make.right.equalTo(whiteView);
            make.height.mas_equalTo(1);
        }];
        [whiteView mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self).offset(self.frame.size.height*0.26);
            make.width.equalTo(self).multipliedBy(0.8);
            make.centerX.equalTo(self);
            make.bottom.equalTo(lineView2.mas_bottom).offset(50);
        }];
    }
    if (type == 2) {
        tipLabel.hidden = YES;
        text1.placeholder = kLocalizationMsg(@"请输入微信账号");
        text1.keyboardType = UIKeyboardTypeDefault;
        text2.hidden = YES;
        text3.hidden = YES;
        [text1 mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(lineView1
                             .mas_bottom).offset(10);
            make.left.equalTo(lineView1);
            make.right.equalTo(jiantouImg);
            make.height.mas_equalTo(40);
        }];
        [lineView2 mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(text1.mas_bottom).offset(10);
            make.left.equalTo(whiteView);
            make.right.equalTo(whiteView);
            make.height.mas_equalTo(1);
        }];
        [whiteView mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self).offset(self.frame.size.height*0.26);
            make.width.equalTo(self).multipliedBy(0.8);
            make.centerX.equalTo(self);
            make.bottom.equalTo(lineView2.mas_bottom).offset(50);
        }];
    }
    if (type == 3) {
        text2.hidden = NO;
        text3.hidden = NO;
        tipLabel.hidden = NO;

        text1.placeholder = kLocalizationMsg(@"请输入银行名称");
        text1.keyboardType = UIKeyboardTypeDefault;
        text2.placeholder = kLocalizationMsg(@"请输入银行卡账号");
        text2.keyboardType = UIKeyboardTypeNumberPad;
        text3.placeholder = kLocalizationMsg(@"请输入持卡人姓名");
        text3.keyboardType = UIKeyboardTypeDefault;
        
//        if (APP_DEV == 7) {
//            [text1 mas_remakeConstraints:^(MASConstraintMaker *make) {
//                make.top.equalTo(tipLabel
//                                 .mas_bottom).offset(5);
//                make.left.equalTo(lineView1);
//                make.right.equalTo(jiantouImg);
//                make.height.mas_equalTo(40);
//            }];
//        }
         
        [lineView2 mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(text3.mas_bottom).offset(10);
            make.left.equalTo(whiteView);
            make.right.equalTo(whiteView);
            make.height.mas_equalTo(1);
        }];
        [whiteView mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self).offset(self.frame.size.height*0.26);
            make.width.equalTo(self).multipliedBy(0.8);
            make.centerX.equalTo(self);
            make.bottom.equalTo(lineView2.mas_bottom).offset(50);
        }];
    }
    [self layoutIfNeeded];
}
- (void)selectTypeBtnClick{
    if (!twoBtnView) {
        twoBtnView = [[UIView alloc]init];
        twoBtnView.backgroundColor = [UIColor whiteColor];
        twoBtnView.layer.cornerRadius = 5;
        twoBtnView.layer.masksToBounds = YES;
        twoBtnView.layer.shadowColor = [UIColor blackColor].CGColor;
        twoBtnView.layer.shadowOpacity = 0.8f;
        twoBtnView.layer.shadowRadius = 2.f;
        twoBtnView.layer.shadowOffset = CGSizeMake(0,2);
        [whiteView addSubview:twoBtnView];
        [twoBtnView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(selectTypeLabel.mas_bottom).offset(3);
            make.left.equalTo(selectTypeLabel.mas_left).offset(-5);
            make.right.equalTo(jiantouImg.mas_right);
            make.height.mas_equalTo(100);
        }];
        UIButton *btn1 = [UIButton buttonWithType:0];
        [btn1 addTarget:self action:@selector(changeType:) forControlEvents:UIControlEventTouchUpInside];
        btn1.titleLabel.font = [UIFont systemFontOfSize:14];
        [btn1 setTitleColor:kRGB_COLOR(@"#333333") forState:0];
        [twoBtnView addSubview:btn1];
        [btn1 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(twoBtnView).offset(5);
            make.top.equalTo(twoBtnView).mas_offset(10);
            make.height.equalTo(twoBtnView).multipliedBy(0.5);
        }];
        
        UIButton *btn2 = [UIButton buttonWithType:0];
        [btn2 addTarget:self action:@selector(changeType:) forControlEvents:UIControlEventTouchUpInside];
        btn2.titleLabel.font = [UIFont systemFontOfSize:14];
        [btn2 setTitleColor:kRGB_COLOR(@"#333333") forState:0];
        [twoBtnView addSubview:btn2];
        [btn2 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(twoBtnView).offset(5);
            make.top.equalTo(btn1.mas_bottom);
            make.height.equalTo(twoBtnView).multipliedBy(0.5);
        }];
        if (showType == 1) {
            [btn1 setTitle:kLocalizationMsg(@"微信") forState:0];
            [btn2 setTitle:kLocalizationMsg(@"银行卡") forState:0];
        }
        if (showType == 2) {
            [btn1 setTitle:kLocalizationMsg(@"支付宝") forState:0];
            [btn2 setTitle:kLocalizationMsg(@"银行卡") forState:0];
        }
        if (showType == 3) {
            [btn1 setTitle:kLocalizationMsg(@"支付宝") forState:0];
            [btn2 setTitle:kLocalizationMsg(@"微信") forState:0];
        }
        
    }

}
- (void)changeType:(UIButton *)sender{
    if ([sender.titleLabel.text isEqual:kLocalizationMsg(@"支付宝")]) {
        selectTypeLabel.text = kLocalizationMsg(@"支付宝");
        showType = 1;
    }
    if ([sender.titleLabel.text isEqual:kLocalizationMsg(@"微信")]) {
        selectTypeLabel.text = kLocalizationMsg(@"微信");
        showType = 2;
    }
    if ([sender.titleLabel.text isEqual:kLocalizationMsg(@"银行卡")]) {
        selectTypeLabel.text = kLocalizationMsg(@"银行卡");
        showType = 3;
    }
    [twoBtnView removeFromSuperview];
    twoBtnView = nil;
    [self updateConstraintsWith:showType];
}
- (void)sureBtnClick{
    
    NSString *account= @"";
    NSString *accountName = @"";
    NSString *bankName = @"";
    
    if (showType == 1) {
        if (text1.text == nil || text1.text == NULL || text1.text.length == 0) {
            [SVProgressHUD showInfoWithStatus:kLocalizationMsg(@"请输入支付宝账号")];
            return;
        }
        if (text2.text == nil || text2.text == NULL || text2.text.length == 0) {
            [SVProgressHUD showInfoWithStatus:kLocalizationMsg(@"请输入支付宝账号姓名")];
            return;
        }
        account = text1.text;
        accountName = text2.text;
    }
    if (showType == 2) {
        if (text1.text == nil || text1.text == NULL || text1.text.length == 0) {
            [SVProgressHUD showInfoWithStatus:kLocalizationMsg(@"请输入微信账号")];
            return;
        }
        account = text1.text;
    }
    if (showType == 3) {
        if (text1.text == nil || text1.text == NULL || text1.text.length == 0) {
            [SVProgressHUD showInfoWithStatus:kLocalizationMsg(@"请输入银行名称")];
            return;
        }
        if (text2.text == nil || text2.text == NULL || text2.text.length == 0) {
            [SVProgressHUD showInfoWithStatus:kLocalizationMsg(@"请输入银行卡账号")];
            return;
        }
        if (text3.text == nil || text3.text == NULL || text3.text.length == 0) {
            [SVProgressHUD showInfoWithStatus:kLocalizationMsg(@"请输入持卡人姓名")];
            return;
        }
        account = text2.text;
        accountName = text3.text;
        bankName = text1.text;
    }
}

@end
