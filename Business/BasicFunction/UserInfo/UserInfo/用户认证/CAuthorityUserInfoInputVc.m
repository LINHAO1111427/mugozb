//
//  UserInfoInputVc.m
//  LibProjController
//
//  Created by ssssssss on 2020/11/28.
//  Copyright © 2020 KLC. All rights reserved.
//  认证信息修改

#import "CAuthorityUserInfoInputVc.h"
#import <LibProjModel/KLCUserInfo.h>
#import <LibProjModel/HttpApiAnchorAuthenticationController.h>
#import <LibProjModel/ApiUserInfoModel.h>
#import <LibProjModel/AnchorAuthVOModel.h>
 
 
 
@interface CAuthorityUserInfoInputVc ()<UITextFieldDelegate>
@property(nonatomic,strong)UITextField *inputTextField;
@property(nonatomic,strong)UIButton *sureBtn;
@end

@implementation CAuthorityUserInfoInputVc

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationController.navigationBarHidden = NO;
    self.navigationController.navigationBar.translucent = NO;
    
    self.view.backgroundColor =kRGB_COLOR(@"#F4F4F4");
    
    self.navigationItem.title = self.titleStr;
    [self subViewSetup];

    UIButton *sureButton = [UIButton buttonWithType:UIButtonTypeSystem];
    [sureButton setTitle:kLocalizationMsg(@"保存") forState:UIControlStateNormal];
    [sureButton setTitleColor: kRGB_COLOR(@"#2B2C2C") forState:UIControlStateNormal];
    sureButton.titleLabel.font = [UIFont systemFontOfSize:14];
    [sureButton addTarget:self action:@selector(sureBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    self.sureBtn = sureButton;
    
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc]initWithCustomView:self.sureBtn ];
    rightItem.imageInsets = UIEdgeInsetsMake(0, -15,0, 0);//设置向左偏移
    self.navigationItem.rightBarButtonItem = rightItem;
}
- (void)subViewSetup{
    UIView *inputView = [[UIView alloc]initWithFrame:CGRectMake(0, 10, kScreenWidth, 44)];
    inputView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:inputView];
    UITextField *inputT = [[UITextField alloc]initWithFrame:CGRectMake(12, 4, kScreenWidth-24, 40)];
    inputT.textColor =kRGB_COLOR(@"#2B2C2C");
    inputT.font = [UIFont systemFontOfSize:14];
    inputT.textAlignment = NSTextAlignmentLeft;
    inputT.delegate = self;
    inputT.clearButtonMode = UITextFieldViewModeAlways;
    inputT.placeholder = self.placeholder;
    switch (self.index) {
        case 0://昵称
            inputT.text = self.authModel.nickName;
            break;
        case 1://个人签名
            inputT.text = self.authModel.signature;
            break;
        case 4://职业
            inputT.text = self.authModel.vocation;
            break;
        case 8://微信号
            inputT.text = self.authModel.wechat;
            break;
        case 10://真实姓名
            inputT.text = self.authModel.realName;
            break;
        case 11://身份证号
            inputT.text = self.authModel.cerNo;
            break;
        case 17://附加信息
            inputT.text = self.authModel.remarks;
            break;
        default:
            break;
    }
    self.inputTextField = inputT;
    [inputView addSubview:self.inputTextField];
}
 
- (void)sureBtnClick:(UIButton *)btn{
    if (self.inputTextField.text.length == 0) {
        [SVProgressHUD showInfoWithStatus:kLocalizationMsg(@"输入内容为空")];
        return;
    }
    if (self.index == 0) {//昵称
        self.authModel.nickName = self.inputTextField.text;
    }else if (self.index == 1){//签名
        self.authModel.signature = self.inputTextField.text;
    }else if (self.index == 4){//职业
        self.authModel.vocation = self.inputTextField.text;
    }else if (self.index == 8){//微信号
        self.authModel.wechat = self.inputTextField.text;
    }else if (self.index == 10){//真实姓名
        self.authModel.realName = self.inputTextField.text;
    }else if (self.index == 11){//身份证号
        if (self.inputTextField.text.length != 15 && self.inputTextField.text.length != 18) {
            [SVProgressHUD showInfoWithStatus:kLocalizationMsg(@"请填写正确的身份证号")];
            return;
        }
//        if (![self.inputTextField.text validateIDCardNumber]) {
//            [SVProgressHUD showInfoWithStatus:kLocalizationMsg(@"身份证输入有误")];
//            return;
//        }
        self.authModel.cerNo = self.inputTextField.text;
    }else if (self.index == 17){//附加信息
        self.authModel.remarks = self.inputTextField.text;
    }
    kWeakSelf(self);
    [HttpApiAnchorAuthenticationController authUpdate:self.authModel callback:^(int code, NSString *strMsg, HttpNoneModel *model) {
        if (code == 1) {
            [SVProgressHUD showSuccessWithStatus:strMsg];
            if (weakself.completeBlock) {
                weakself.completeBlock(weakself.authModel);
            }
            [weakself.navigationController popViewControllerAnimated:YES];
            [weakself.navigationController dismissViewControllerAnimated:YES completion:nil];
        }else{
            [SVProgressHUD showInfoWithStatus:strMsg];
        }
    }];
    
}
#pragma mark - UITextFieldDelegate
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
    NSString * str = [textField.text stringByReplacingCharactersInRange:range withString:string];
    BOOL retrunState = YES;
    if (self.index == 0) {//昵称
        if (str.length > 15) {
            retrunState = NO;
        }else{
            retrunState = YES;
        }
    }else if (self.index == 1){//签名
        if (str.length > 25) {
            retrunState = NO;
        }else{
            retrunState = YES;
        }
    }else if (self.index == 4){//职业
        if (str.length > 8) {
            retrunState = NO;
        }else{
            retrunState = YES;
        }
    }else if (self.index == 8){//微信号
        if (str.length > 20) {
            retrunState = NO;
        }else{
            retrunState = YES;
        }
    }else if(self.index == 10){//真实姓名
        if (str.length > 20) {
            retrunState = NO;
        }else{
            retrunState = YES;
        }
    }else if(self.index == 11){//身份证号
        if (str.length > 18) {
            retrunState = NO;
        }else{
            retrunState = YES;
        }
    }else if(self.index == 17){//附加信息
        if (str.length > 25) {
            retrunState = NO;
        }else{
            retrunState = YES;
        }
    }
     
    if (retrunState) {
        self.sureBtn.enabled = retrunState;
    }
    return retrunState;
}


@end
