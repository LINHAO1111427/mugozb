//
//  ModiftPasswordVC.m
//  3V-Project  项目登录
//
//  Created by admin on 2019/8/29.
//  Copyright © 2019 CH. All rights reserved.
//

#import "ModiftPasswordVC.h"

#import <LibTools/LibTools.h>
#import <LibProjModel/HttpApiAppLogin.h>
#import <LibProjBase/LibProjBase.h>
#import <LibProjModel/KLCUserInfo.h>
#import <LibProjModel/KLCAppConfig.h>

#import "LoginRes.h"

@interface ModiftPasswordVC ()

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *VIewH;

@property (weak, nonatomic) IBOutlet UILabel *tipLabel;
@property (weak, nonatomic) IBOutlet UITextField *phoneT;
@property (weak, nonatomic) IBOutlet UITextField *yanzhengma;
@property (weak, nonatomic) IBOutlet UIButton *yanzhengmaBtn;
@property (weak, nonatomic) IBOutlet UITextField *secretT;
@property (weak, nonatomic) IBOutlet UIButton *findNowBtn;
@property (weak, nonatomic) IBOutlet UIView *pwdView;


@property (assign, nonatomic)int messageIssssss;//短信倒计时  60s
@property (strong, nonatomic)__block NSTimer *messsageTimer;
@property (nonatomic, assign) LoginFaceType faceType;


@end

@implementation ModiftPasswordVC


- (instancetype)init
{
    NSString* nibFullName=  [LoginRes getNibFullName:@"ModiftPasswordVC"];
    //@"Frameworks/Login.framework/ModiftPasswordVC"
    self = [super initWithNibName:nibFullName bundle:[NSBundle mainBundle]];
    if (self) {
    }
    return self;
}

- (void)dealloc
{
    [_messsageTimer invalidate];
    _messsageTimer = nil;
}


- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [self.view  endEditing:YES];
}

- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationController.navigationBar.translucent = NO;
    
    _faceType = [_operationTypetype intValue];
    
    [KLCAppConfig updateAppConfig:nil];
    NSString *title,*btnTitle,*tipStr;
    if (self.faceType == LoginFaceTypeRegister) {
        title = kLocalizationMsg(@"注册");
        btnTitle = kLocalizationMsg(@"立即注册");
        tipStr = kLocalizationMsg(@"请填写以下注册信息");
    }else if(self.faceType == LoginFaceTypeLosePwd){
        title = kLocalizationMsg(@"忘记密码");
        btnTitle = kLocalizationMsg(@"立即找回");
        tipStr = kLocalizationMsg(@"请填写以下验证信息");
    }else if (self.faceType == LoginFaceTypeBindPhone){
        title = kLocalizationMsg(@"绑定手机号");
        btnTitle = kLocalizationMsg(@"立即绑定");
        tipStr = kLocalizationMsg(@"依据工信部的规定，请填写您的手机号");
        [self.pwdView removeAllSubViews];
    }
    self.navigationItem.title = title;
    _phoneT.placeholder = kLocalizationMsg(@"请填写手机号");
    _yanzhengma.placeholder = kLocalizationMsg(@"请输入验证码");
    _secretT.placeholder = kLocalizationMsg(@"请填写密码");
    [_yanzhengmaBtn setTitle:kLocalizationMsg(@"获取验证码") forState:0];
    [_findNowBtn setTitle:btnTitle forState:UIControlStateNormal];
    self.tipLabel.text = tipStr;
    self.tipLabel.textColor = [ProjConfig normalColors];
    [_findNowBtn setBackgroundColor:[ProjConfig normalColors]];
    [self.yanzhengmaBtn setTitleColor:[ProjConfig normalColors] forState:UIControlStateNormal];
    [_phoneT becomeFirstResponder];
    _messageIssssss = 60;
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(ChangeBtnBackground) name:UITextFieldTextDidChangeNotification object:nil];
    
    [self ChangeBtnBackground];
}


-(void)ChangeBtnBackground{
    if (_phoneT.text.length > 0 && _yanzhengma.text.length == 6 ){
        if (self.faceType == LoginFaceTypeBindPhone) {
            [_findNowBtn setBackgroundColor:[ProjConfig normalColors]];
            _findNowBtn.enabled = YES;
        }else{
            if (_secretT.text.length > 0) {
                [_findNowBtn setBackgroundColor:[ProjConfig normalColors]];
                _findNowBtn.enabled = YES;
            }else{
                [_findNowBtn setBackgroundColor:[UIColor colorWithRed:207/255.0 green:207/255.0 blue:207/255.0 alpha:1.0]];
                _findNowBtn.enabled = NO;
            }
        }
        
    }else{
        [_findNowBtn setBackgroundColor:[UIColor colorWithRed:207/255.0 green:207/255.0 blue:207/255.0 alpha:1.0]];
        _findNowBtn.enabled = NO;
    }
}


-(void)daojishi{
    [_yanzhengmaBtn setTitle:[NSString stringWithFormat:@"%ds",_messageIssssss] forState:UIControlStateNormal];
    _yanzhengmaBtn.userInteractionEnabled = NO;
    if (_messageIssssss<=0) {
        [_yanzhengmaBtn setTitle:kLocalizationMsg(@"发送验证码") forState:UIControlStateNormal];
        _yanzhengmaBtn.userInteractionEnabled = YES;
        [_messsageTimer invalidate];
        _messsageTimer = nil;
        _messageIssssss = 60;
    }
    _messageIssssss-=1;
}


- (IBAction)clickYanzhengma:(id)sender {
    
    if (![[ProjConfig shareInstence].baseConfig verifyUserPhoneNumber:_phoneT.text]) {
        return;
    }
    
    int smsType = 0;
    if (self.faceType == LoginFaceTypeRegister) {
        smsType = 1;
    }else if(self.faceType == LoginFaceTypeLosePwd){
        smsType = 2;
    }else if (self.faceType == LoginFaceTypeBindPhone){
        smsType = 5;
    }
    kWeakSelf(self);
    [[ProjConfig shareInstence].baseConfig getInternationalVerifyCode:^(int platform){

        weakself.yanzhengmaBtn.userInteractionEnabled = NO;
        weakself.messageIssssss = 60;

        NSString *phoneNum = self.phoneT.text;
        NSString *tm = [[NSDate date] timeStringWithDateFormat:@"yyyy-MM-dd HH:mm:ss"];
        NSString *keyStr = [kStringFormat(@"%@_jRnQh8ed_%@",phoneNum,tm) md5Encrypt];
        
        [HttpApiAppLogin getSMSCode:platform key:keyStr smsType:smsType tel:phoneNum tm:tm callback:^(int code, NSString *strMsg, HttpNoneModel *model) {
            [SVProgressHUD dismiss];
            weakself.yanzhengmaBtn.userInteractionEnabled = YES;
            if (code == 1){
                //            if ([model.no_use intValue] == 0) {
                //                [SVProgressHUD showSuccessWithStatus:@"123456"];
                //            }else{
                [SVProgressHUD showSuccessWithStatus:strMsg];
                //            }
                [weakself.messsageTimer invalidate];
                weakself.messsageTimer = nil;
                if (weakself.messsageTimer == nil) {
                    weakself.messsageTimer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(daojishi) userInfo:nil repeats:YES];
                }
                [weakself.yanzhengma becomeFirstResponder];
            }else{
                [SVProgressHUD showInfoWithStatus:strMsg];
            }
        }];
        
    }];
}


//键盘的隐藏
- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
    [self.view endEditing:YES];
}


- (IBAction)clickFindBtn:(id)sender {
    [self.view endEditing:YES];
    
    if (![[ProjConfig shareInstence].baseConfig verifyUserPhoneNumber:_phoneT.text]) {
        return;
    }
    
    if (_yanzhengma.text.length == 0){
        [SVProgressHUD showInfoWithStatus:kLocalizationMsg(@"请输入验证码")];
        return;
    }
    if (_yanzhengma.text.length < 6){
        [SVProgressHUD showInfoWithStatus:kLocalizationMsg(@"验证码输入错误")];
        return;
    }
    
    kWeakSelf(self);
    if (self.faceType == LoginFaceTypeLosePwd) {
        if (_secretT.text.length < 6) {
            [SVProgressHUD showInfoWithStatus:kLocalizationMsg(@"密码长度不能小于6位")];
            return;
        }
        if (![_secretT.text valiPassWord]) {
            [SVProgressHUD showInfoWithStatus:kLocalizationMsg(@"密码过于简单，请尝试字母和数字组合")];
            return;
        }
        _findNowBtn.userInteractionEnabled = NO;
        [SVProgressHUD showWithStatus:kLocalizationMsg(@"请等待")];
        [HttpApiAppLogin forget_pwd:_yanzhengma.text freshPwd:_secretT.text freshPwd2:_secretT.text phone:_phoneT.text callback:^(int code, NSString *strMsg, SingleStringModel *model) {
            [SVProgressHUD dismiss];
            if (code == 1) {
                [weakself login];
            }else{
                weakself.findNowBtn.userInteractionEnabled = YES;
                [SVProgressHUD showInfoWithStatus:strMsg];
            }
        }];
    }else if (self.faceType == LoginFaceTypeBindPhone){
        
        _findNowBtn.userInteractionEnabled = NO;
        [SVProgressHUD showWithStatus:kLocalizationMsg(@"正在绑定")];
        ///不需要更新用户信息重新登陆
        [HttpApiAppLogin bindMobile:_yanzhengma.text mobile:_phoneT.text smsRegion:@"86" callback:^(int code, NSString *strMsg, HttpNoneModel *model) {
            [SVProgressHUD dismiss];
            if (code == 1) {
                [SVProgressHUD showInfoWithStatus:strMsg];
                [self userLoginSuccess];
            }else{
                weakself.findNowBtn.userInteractionEnabled = YES;
                [SVProgressHUD showInfoWithStatus:strMsg];
            }
        }];
        
    }else{
        
        if (_secretT.text.length < 6) {
            [SVProgressHUD showInfoWithStatus:kLocalizationMsg(@"密码长度不能小于6位")];
            return;
        }
        if (![_secretT.text valiPassWord]) {
            [SVProgressHUD showInfoWithStatus:kLocalizationMsg(@"密码过于简单，请尝试字母和数字组合")];
            return;
        }
        _findNowBtn.userInteractionEnabled = NO;
        [SVProgressHUD showWithStatus:kLocalizationMsg(@"正在注册")];
        NSString *code = _yanzhengma.text;
        NSString *password = _secretT.text;
        NSString *mobile = _phoneT.text;
        NSString *appVersion = [IPhoneInfo appVersionNO];
        NSString *appVersionCode = [IPhoneInfo appVersionBuild];
        NSString *phoneFirm = @"Apple";
        NSString *phoneModel = [IPhoneInfo phoneType];
        NSString *phoneUuid = [IPhoneInfo phoneUUID];
         
        [HttpApiAppLogin register:appVersion appVersionCode:appVersionCode code:code mobile:mobile password:password phoneFirm:phoneFirm phoneModel:phoneModel phoneUuid:phoneUuid smsRegion:@"86" callback:^(int code, NSString *strMsg, UserTokenModel *model) {
            [SVProgressHUD dismiss];
            if (code == 1) {
                [weakself login];
            }else{
                weakself.findNowBtn.userInteractionEnabled = YES;
                [SVProgressHUD showInfoWithStatus:strMsg];
            }
        }];
    }
}


- (void)login{
    [self.view endEditing:YES];
    NSString *password = _secretT.text;
    NSString *mobile = _phoneT.text;
    NSString *appVersion = [IPhoneInfo appVersionNO];
    NSString *appVersionCode = [IPhoneInfo appVersionBuild];
    NSString *phoneFirm = @"Apple";
    NSString *phoneModel = [IPhoneInfo phoneType];
    NSString *phoneUuid = [IPhoneInfo phoneUUID];
    [HttpApiAppLogin login:appVersion appVersionCode:appVersionCode mobile:mobile password:password phoneFirm:phoneFirm phoneModel:phoneModel phoneUuid:phoneUuid  smsRegion:@"86" callback:^(int code, NSString *strMsg, ApiUserInfoLoginModel *model) {
        [SVProgressHUD dismiss];
        if (code == 1) {
            [KLCUserInfo setAppLoginedInfo:model];
            [self userLoginSuccess];
        }else{
            self.findNowBtn.userInteractionEnabled = YES;
            [SVProgressHUD showInfoWithStatus:strMsg];
        }
    }];
}


/**用户登陆成功**/
- (void)userLoginSuccess{
    self.findNowBtn.userInteractionEnabled = YES;
    ///配置三方
    [ProjConfig userlogined];
    ///是否需要形象设置
    if ([[ProjConfig shareInstence].baseConfig whetherSetUserProfile]) {
        [RouteManager routeForName:RN_login_setUserProfile currentC:self];
    }else{
        [[ProjConfig shareInstence].baseConfig showHomeMainVC];
    }
}


- (UIBarButtonItem *)rt_customBackItemWithTarget:(id)target action:(SEL)action{
    [BaseNavBarItem navbar:self bgImage:[UIImage imageWithColor:[UIColor whiteColor]] foregroundColor:[UIColor blackColor]];
    return [[UIBarButtonItem alloc] initWithCustomView:[BaseNavBarItem navBackBtnImage:[UIImage imageNamed:@"main_navbar_back_black"] target:target action:action]];
}

@end
