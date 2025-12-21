//
//  ModifyOrBindPhoneVC.m
//  MineCenter
//
//  Created by ssssssss on 2020/8/21.
//

#import "ModifyOrBindPhoneVC.h"
#import <LibProjModel/KLCUserInfo.h>
#import <LibProjModel/HttpApiAppLogin.h>
#import <LibProjModel/HttpApiBingAccount.h>
#import <LibProjModel/KLCAppConfig.h>

@interface ModifyOrBindPhoneVC ()
@property (nonatomic, strong)UITextField *phoneTF;
@property (nonatomic, strong)UITextField *codeTF;
@property (nonatomic, strong)UILabel *codeL;
@property (nonatomic, strong)UIButton *codeBtn;
@property (nonatomic, strong)NSTimer *downTimer;
@property (nonatomic, assign)int num;
@end

@implementation ModifyOrBindPhoneVC
- (NSTimer *)downTimer{
    if (!_downTimer) {
        _downTimer = [NSTimer  scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(timeDown) userInfo:nil repeats:YES];
        [[NSRunLoop currentRunLoop]addTimer:_downTimer forMode:NSRunLoopCommonModes];
    }
    return _downTimer;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = kRGB_COLOR(@"#F5F5F5");
    self.navigationItem.title = self.navTitle;
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tap)];
    [self.view addGestureRecognizer:tap];
    self.num = 60;
    [self createUI];
}
- (void)tap{
    [self.view endEditing:YES];
}
- (void)createUI{
    CGFloat heightMargin = (kScreenHeight-kNavBarHeight-kSafeAreaBottom)/4.0;
    CGFloat margin = (heightMargin-100)/2.0;
    //手机号
    UILabel *phoneTitleL = [[UILabel alloc]initWithFrame:CGRectMake(40, heightMargin/2.0+margin+15, 50, 20)];
    phoneTitleL.textColor = kRGB_COLOR(@"#555555");
    phoneTitleL.font = [UIFont systemFontOfSize:15 weight:0.1];
    phoneTitleL.textAlignment = NSTextAlignmentLeft;
    phoneTitleL.text = kLocalizationMsg(@"手机号");
    [self.view addSubview:phoneTitleL];
    UITextField *phoneTextF = [[UITextField alloc]initWithFrame:CGRectMake(phoneTitleL.maxX+10, 0, kScreenWidth-80-60, 30)];
    phoneTextF.centerY = phoneTitleL.centerY;
    phoneTextF.textColor = kRGB_COLOR(@"#555555");
    phoneTextF.textAlignment = NSTextAlignmentLeft;
    phoneTextF.font = [UIFont systemFontOfSize:15 weight:0.1];
    phoneTextF.clearButtonMode = UITextFieldViewModeAlways;
    phoneTextF.keyboardType = UIKeyboardTypePhonePad;
    if (self.type == VcTypeModifyPhone) {
        phoneTextF.text =  [KLCUserInfo getUserInfo].mobile;
        phoneTextF.placeholder = kLocalizationMsg(@"请输入新手机号");
    }else{
        phoneTextF.placeholder = kLocalizationMsg(@"请输入手机号");
    }
    self.phoneTF = phoneTextF;
    [self.view addSubview:phoneTextF];
    UIView *line1 = [[UIView alloc]initWithFrame:CGRectMake(40, heightMargin/2.0+margin+49, kScreenWidth-80, 0.5)];
    line1.backgroundColor = kRGB_COLOR(@"#DEDEDE");
    [self.view addSubview:line1];
    
    //验证码
    UILabel *codeTitleL = [[UILabel alloc]initWithFrame:CGRectMake(40, heightMargin/2.0+margin+50+15, 50, 20)];
    codeTitleL.textColor = kRGB_COLOR(@"#555555");
    codeTitleL.font = [UIFont systemFontOfSize:15 weight:0.1];
    codeTitleL.textAlignment = NSTextAlignmentLeft;
    codeTitleL.text = kLocalizationMsg(@"验证码");
    [self.view addSubview:codeTitleL];
    UITextField *codeTextF = [[UITextField alloc]initWithFrame:CGRectMake(phoneTitleL.maxX+10, 0, kScreenWidth-80-60-70, 30)];
    codeTextF.centerY = codeTitleL.centerY;
    codeTextF.textColor = kRGB_COLOR(@"#555555");
    codeTextF.textAlignment = NSTextAlignmentLeft;
    codeTextF.font = [UIFont systemFontOfSize:15 weight:0.1];
    codeTextF.keyboardType = UIKeyboardTypePhonePad;
    codeTextF.placeholder = kLocalizationMsg(@"请输入验证码");
    self.codeTF = codeTextF;
    [self.view addSubview:codeTextF];
    
    UILabel *codeLabel = [[UILabel alloc]initWithFrame:CGRectMake(codeTextF.maxX, 0, 70, 20)];
    codeLabel.font = [UIFont systemFontOfSize:12];
    codeLabel.textColor = kRGB_COLOR(@"#9A58FF");
    codeLabel.centerY = codeTextF.centerY;
    codeLabel.text = kLocalizationMsg(@"获取验证码");
    codeLabel.textAlignment = NSTextAlignmentCenter;
    self.codeL = codeLabel;
    [self.view addSubview:codeLabel];
    UIButton *codeBtn = [[UIButton alloc]initWithFrame:CGRectMake(codeTextF.maxX, 0, codeLabel.width, 32)];
    codeBtn.centerY = codeLabel.centerY;
    codeBtn.backgroundColor = [UIColor clearColor];
    [codeBtn addTarget:self action:@selector(codeBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    self.codeBtn = codeBtn;
    [self.view addSubview:codeBtn];
    
    UIView *line2 = [[UIView alloc]initWithFrame:CGRectMake(40, heightMargin/2.0+margin+99, kScreenWidth-80, 0.5)];
    line2.backgroundColor = kRGB_COLOR(@"#DEDEDE");
    [self.view addSubview:line2];
    
    //确定
    UIButton *sureBtn = [[UIButton alloc]initWithFrame:CGRectMake(50, heightMargin*1.5+(heightMargin-40)/2.0, kScreenWidth-100, 40)];
    sureBtn.backgroundColor = kRGB_COLOR(@"#9A58FF");
    sureBtn.titleLabel.font = [UIFont systemFontOfSize:14];
    sureBtn.layer.cornerRadius = 20;
    sureBtn.clipsToBounds = YES;
    [sureBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [sureBtn setTitle:kLocalizationMsg(@"确定") forState:UIControlStateNormal];
    [sureBtn addTarget:self action:@selector(sureBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:sureBtn];
     
}
 
- (void)codeBtnClick:(UIButton *)btn{
    
    if (![[ProjConfig shareInstence].baseConfig verifyUserPhoneNumber:self.phoneTF.text]) {
        return;
    }
    
    int smsType = 0;
    if (self.type == VcTypeBindPhone) {
        smsType = 5;
    }else {
        smsType = 7;
    }
    kWeakSelf(self);
    [[ProjConfig shareInstence].baseConfig getInternationalVerifyCode:^(int platform){
    
        NSString *phoneNum = self.phoneTF.text;
        NSString *tm = [[NSDate date] timeStringWithDateFormat:@"yyyy-MM-dd HH:mm:ss"];
        NSString *keyStr = [kStringFormat(@"%@_jRnQh8ed_%@",phoneNum,tm) md5Encrypt];
        
        [HttpApiAppLogin getSMSCode:platform key:keyStr smsType:smsType tel:phoneNum tm:tm callback:^(int code, NSString *strMsg, HttpNoneModel *model) {
            [SVProgressHUD dismiss];
            weakself.codeBtn.enabled = YES;
            if (code == 1){
                [SVProgressHUD showSuccessWithStatus:strMsg];
                [weakself.downTimer setFireDate:[NSDate distantPast]];
                [weakself.codeTF becomeFirstResponder];
            }else{
                [SVProgressHUD showInfoWithStatus:strMsg];
            }
        }];
        
    }];
}

- (void)timeDown{
    self.num --;
    self.codeBtn.enabled = !self.num;
    if (self.num > 0) {
        self.codeL.text = [NSString stringWithFormat:@"%ds",self.num];
    }else{
        self.num = 60;
        [self.downTimer setFireDate:[NSDate distantFuture]];
        [self.downTimer invalidate];
        self.downTimer = nil;
        self.codeL.text = kLocalizationMsg(@"获取验证码");
    }
}
- (void)sureBtnClick:(UIButton *)btn{
    
    if (![[ProjConfig shareInstence].baseConfig verifyUserPhoneNumber:self.phoneTF.text]) {
        return;
    }
    if (self.codeTF.text.length == 0) {
        [SVProgressHUD showInfoWithStatus:kLocalizationMsg(@"请输入验证码")];
        return;
    }
    kWeakSelf(self);
    if (self.type == VcTypeBindPhone) {//绑定手机号
        [SVProgressHUD showWithStatus:kLocalizationMsg(@"正在绑定")];
        [HttpApiAppLogin bindMobile:self.codeTF.text mobile:self.phoneTF.text smsRegion:@"86" callback:^(int code, NSString *strMsg, HttpNoneModel *model) {
            [SVProgressHUD dismiss];
            if (code == 1) {
                [KLCUserInfo updateUserPhone:weakself.phoneTF.text];
                [weakself.downTimer invalidate];
                weakself.downTimer = nil;
                [SVProgressHUD showSuccessWithStatus:strMsg];
                [weakself.navigationController popViewControllerAnimated:YES];
            }else{
                [SVProgressHUD showInfoWithStatus:strMsg];
            }
        }];
        
    }else{//修改手机号
        [SVProgressHUD showWithStatus:kLocalizationMsg(@"正在修改")];
        [HttpApiBingAccount updateBindMobile:self.codeTF.text mobile:self.phoneTF.text smsRegion:@"86" source:@"ios" callback:^(int code, NSString *strMsg, UserTokenModel *model) {
            [SVProgressHUD dismiss];
            if (code == 1) {
                [KLCUserInfo updateUserPhone:weakself.phoneTF.text];
                [KLCUserInfo updateUserToken:model.UserToken];
                [weakself.downTimer invalidate];
                weakself.downTimer = nil;
                [SVProgressHUD showSuccessWithStatus:strMsg];
                [weakself.navigationController popViewControllerAnimated:YES];
            }else{
                [SVProgressHUD showInfoWithStatus:strMsg];
            }
        }];
         
    }
}
- (void)dealloc{
    [self.downTimer invalidate];
    self.downTimer = nil;
}
@end
