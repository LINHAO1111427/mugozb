//
//  UserInfoEidteInputVc.m
//  UserInfo
//
//  Created by ssssssss on 2020/12/17.
//  Copyright © 2020 KLC. All rights reserved.
//

#import "UserInfoEditeInputVc.h"
#import <LibProjModel/KLCUserInfo.h>
#import <LibProjModel/HttpApiUserController.h>
#import <LibProjModel/ApiUserInfoModel.h>
#import <LibProjModel/UserController_userUpdate.h>
 

@interface UserInfoEditeInputVc ()<UITextFieldDelegate>
@property(nonatomic,strong)UITextField *inputTextField;
@property(nonatomic,strong)UIButton *sureBtn;
@end

@implementation UserInfoEditeInputVc
- (void)viewDidLoad {
    [super viewDidLoad];
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
            inputT.text = self.userModel.username;
            break;
        case 1://个人签名
            inputT.text = self.userModel.signature;
            break;
        case 4://职业
            inputT.text = self.userModel.vocation;
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
        self.userModel.username = self.inputTextField.text;
    }else if (self.index == 1){//签名
        self.userModel.signature = self.inputTextField.text;
    }else if (self.index == 4){//职业
        self.userModel.vocation = self.inputTextField.text;
    }
    kWeakSelf(self);
    UserController_userUpdate *update = [[UserController_userUpdate alloc]init];
    ApiUserInfoModel *usermodel = self.userModel;
    update.birthday = @"";
    update.constellation = @"";
    update.height = -1;
    update.liveThumb = @"";
    update.sex = -1;
    update.wechat = @"";
    update.signature = usermodel.signature.length>0?usermodel.signature:@"";
    update.username = usermodel.username.length>0?usermodel.username:@"";
    update.vocation = usermodel.vocation.length>0?usermodel.vocation:@"";
    update.height = -1;
    update.weight = -1;
    update.sanwei = @"";
    [HttpApiUserController userUpdate:update callback:^(int code, NSString *strMsg, HttpNoneModel *model) {
        if (code == 1) {
            [SVProgressHUD showSuccessWithStatus:strMsg];
            weakself.completeBlock(YES);
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
        if (str.length > 8) {
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
    }
    if (retrunState) {
        self.sureBtn.enabled = retrunState;
    }
    return retrunState;
}
 

@end
