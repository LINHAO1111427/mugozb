//
//  AccountVerifyVC.m
//  MineCenter
//
//  Created by klc on 2020/8/13.
//

#import "AccountVerifyVC.h"
#import <LibTools/NSString+Extend.h>
#import <LibProjModel/HttpApiAppLogin.h>

#import <LibProjModel/HttpApiYunthModel.h>
#import <LibProjModel/KLCUserInfo.h>
#import <LibProjModel/ApiUserInfoModel.h>

@interface AccountVerifyVC ()

kStrong(UITextField, pwdTF)
kStrong(UITextField, phoneTF)
kStrong(UITextField, codeTF)

kStrong(UIView, pwdVerifyView)
kStrong(UIView, codeVerifyView)

kStrong(UIButton, getCodeBtn)

kStrong(UIButton, commitBtn)

kAssign(int, verifyMode)

@property(nonatomic)dispatch_source_t timer;

@end

@implementation AccountVerifyVC{
    
    NSUInteger count ;
    NSMutableArray *btnArr;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setup];
    [self createUI];
}
-(void)setup{
    
    count = 60;
    btnArr = [NSMutableArray array];
}
-(void)createUI{
    
    self.view.backgroundColor = [UIColor whiteColor];
    NSArray *titles = @[kLocalizationMsg(@"登录密码验证"),kLocalizationMsg(@"手机验证码")];
    CGFloat margin = (kScreenWidth-120*2-50*2);
    for (int i = 0; i<2; i++) {
        
        UIButton * btn = [Maker BtnWithShadow:NO backColor:[UIColor clearColor] text:titles[i] textColor:[UIColor grayColor] font:kFont(14) superView:self.view constraints:^(MASConstraintMaker * _Nonnull make) {
           
            make.size.mas_equalTo(SIZE(120, 30));
            make.left.equalTo(self.view).offset(50+(120+margin)*i);
            make.top.equalTo(self.view.zh_safe_top).offset(60);
        }];
        btn.layer.cornerRadius = 15;
        [btn addTarget:self action:@selector(switchVerifyMode:) forControlEvents:UIControlEventTouchUpInside];
        [btnArr addObject:btn];
    }
    _commitBtn = [Maker BtnWithShadow:NO backColor:kRGB_COLOR(@"#8A8DFF") text:_btnTitle textColor:[UIColor whiteColor] font:kFont(15) superView:self.view constraints:^(MASConstraintMaker * _Nonnull make) {
    }];
    _commitBtn.layer.cornerRadius = 20;
    [_commitBtn addTarget:self action:@selector(commitAction:) forControlEvents:UIControlEventTouchUpInside];
    
    [self switchVerifyMode:btnArr.firstObject];
}


// 提交按钮点击
-(void)commitAction:(UIButton *)sender{
    
    if (![self isValidInput]) { return; }
    
    //code 1密码2短信验证码
    NSString * pwdStr = _verifyMode==1?_pwdTF.text:_codeTF.text;
    if ([_btnTitle isEqualToString:kLocalizationMsg(@"确认注销")]) {
        
        [HttpApiUserController userCancelAccount:pwdStr type:_verifyMode callback:^(int code, NSString *strMsg, HttpNoneModel *model) {
            [self stopTimer];
            if (code == 1) {
                HudShowSuccess(kLocalizationMsg(@"注销成功"))
                [ProjConfig logout];
            }else{
                HudShowError(strMsg)
            }
        }];
    }else if ([_btnTitle isEqualToString:kLocalizationMsg(@"设置新密码")]){//青少年模式的设置密码
        
        if (_verifyMode == 1) {
            [HttpApiYunthModel yunthAuthByAccount:pwdStr callback:^(int code, NSString *strMsg, HttpNoneModel *model) {
                [self stopTimer];
                if (code == 1) {
                    HudShowSuccess(kLocalizationMsg(@"验证成功，请重新输入"))
                    if (self.completeHandle) { self.completeHandle(); }
                    [self.navigationController popViewControllerAnimated:YES];
                }else{
                    HudShowError(strMsg)
                }
            }];
        }else{
            
            [HttpApiYunthModel yunthAuthByCode:pwdStr mobile:_phoneTF.text callback:^(int code, NSString *strMsg, HttpNoneModel *model) {
                [self stopTimer];
                if (code == 1) {
                    HudShowSuccess(kLocalizationMsg(@"验证成功，请重新输入"))
                    if (self.completeHandle) { self.completeHandle(); }
                    [self.navigationController popViewControllerAnimated:YES];
                }else{
                    HudShowError(strMsg)
                }
            }];
        }
    }
}

- (void)stopTimer{
    if (_timer) {
        dispatch_source_cancel(_timer);
        _timer = nil;
    }
}


-(BOOL)isValidInput{
    
    if (_verifyMode == 1) {
        
        if (_pwdTF.text.length == 0) {
            
            HudShowError(kLocalizationMsg(@"请输入登录密码"))
            return NO;
        }
    }else if (_verifyMode == 2){
        
        if (![[ProjConfig shareInstence].baseConfig verifyUserPhoneNumber:_phoneTF.text]) {
            return NO;
        }
        if (_codeTF.text.length == 0) {
            
            HudShowError(kLocalizationMsg(@"请输入验证码"))
            return  NO;
        }
    }
    return YES;
}
//menu title 点击
-(void)switchVerifyMode:(UIButton *)sender{
    
    for (UIButton *btn in btnArr) {
        
        BOOL chosen = sender==btn;
        [btn setTitleColor:chosen?kRGB_COLOR(@"#8A8DFF"):[UIColor grayColor] forState:0];
        btn.backgroundColor = chosen?[kRGB_COLOR(@"#8A8DFF") colorWithAlphaComponent:0.3]:[UIColor clearColor];
    }
    _verifyMode = (int)[btnArr indexOfObject:sender]+1;
    if ([sender.currentTitle isEqualToString:kLocalizationMsg(@"登录密码验证")]) {
        
        [self.view addSubview:self.pwdVerifyView];
        if(_codeVerifyView.superview) [_codeVerifyView removeFromSuperview];
        [_pwdVerifyView mas_makeConstraints:^(MASConstraintMaker *make) {
           
            make.centerX.width.equalTo(self.view);
            make.top.equalTo(self.view.zh_safe_top).offset(100);
            make.height.mas_equalTo(58);
        }];
        [_commitBtn mas_updateConstraints:^(MASConstraintMaker *make) {
           
            make.top.equalTo(_pwdVerifyView.mas_bottom).offset(80);
            make.size.mas_equalTo(SIZE(260, 40));
            make.centerX.equalTo(self.view);
        }];
    }else{
        
        [self.view addSubview:self.codeVerifyView];
        [_codeVerifyView mas_makeConstraints:^(MASConstraintMaker *make) {
           
            make.centerX.width.equalTo(self.view);
            make.top.equalTo(self.view.zh_safe_top).offset(130);
            make.height.mas_equalTo(58*2);
        }];
        if(_pwdVerifyView.superview) [_pwdVerifyView removeFromSuperview];
        [_commitBtn mas_updateConstraints:^(MASConstraintMaker *make) {
           
            make.top.equalTo(_codeVerifyView.mas_bottom).offset(80);
            make.size.mas_equalTo(SIZE(260, 40));
            make.centerX.equalTo(self.view);
        }];
    }
    [self.view layoutIfNeeded];
}
-(UIView *)pwdVerifyView{
    
    if (!_pwdVerifyView) {
        
        _pwdVerifyView = [[UIView alloc] initWithFrame:CGRectZero];
        _pwdVerifyView.backgroundColor = [UIColor whiteColor];
        
        _pwdTF = [[UITextField alloc] initWithFrame:CGRectZero];
        _pwdTF.font = kFont(14);
        _pwdTF.placeholder = kLocalizationMsg(@"请输入登录密码");
        _pwdTF.secureTextEntry = YES;
        [_pwdVerifyView addSubview:_pwdTF];
        [_pwdTF mas_makeConstraints:^(MASConstraintMaker *make) {
           
            make.height.mas_equalTo(49);
            make.centerX.equalTo(_pwdVerifyView);
            make.left.equalTo(_pwdVerifyView).offset(40);
            make.bottom.equalTo(_pwdVerifyView).inset(1);
        }];
        
        UIView *line = [[UIView alloc] initWithFrame:CGRectZero];
        line.backgroundColor = kRGB_COLOR(@"#DEDEDE");
        [_pwdVerifyView addSubview:line];
        [line mas_makeConstraints:^(MASConstraintMaker *make) {
           
            make.centerX.bottom.equalTo(_pwdVerifyView);
            make.height.mas_equalTo(1);
            make.left.equalTo(_pwdVerifyView).offset(12);
        }];
    }
    return _pwdVerifyView;
}
-(UIView *)codeVerifyView{
    
    if (!_codeVerifyView) {
        
        _codeVerifyView = [[UIView alloc] initWithFrame:CGRectZero];
        _codeVerifyView.backgroundColor = [UIColor whiteColor];
        
        NSArray *texts = @[kLocalizationMsg(@"请输入手机号"),kLocalizationMsg(@"请输入验证码")];
        for (int i=0; i<2; i++) {
            
            UITextField *tf = [[UITextField alloc] initWithFrame:CGRectZero];
            tf.font = kFont(14);
            tf.placeholder = texts[i];
            tf.keyboardType = UIKeyboardTypeNumberPad;
            if (@available(iOS 12.0, *)) { tf.textContentType = UITextContentTypeOneTimeCode;}
            
            [_codeVerifyView addSubview:tf];
            [tf mas_makeConstraints:^(MASConstraintMaker *make) {
               
                make.top.equalTo(_codeVerifyView).offset(8+58*i);
                make.height.mas_equalTo(49);
                make.width.mas_equalTo(240);
                make.left.equalTo(_codeVerifyView).offset(40);
            }];
            
            UIView *line = [[UIView alloc] initWithFrame:CGRectZero];
            line.backgroundColor = kRGB_COLOR(@"#DEDEDE");
            [_codeVerifyView addSubview:line];
            [line mas_makeConstraints:^(MASConstraintMaker *make) {
               
                make.top.equalTo(tf.mas_bottom);
                make.height.mas_equalTo(1);
                make.centerX.equalTo(_codeVerifyView);
                make.left.equalTo(_codeVerifyView).offset(12);
            }];
            if (i == 0) {
                _phoneTF=tf;
                _phoneTF.text = [KLCUserInfo getUserInfo].mobile;
                _phoneTF.userInteractionEnabled = NO;
            }else{
                _codeTF=tf;
            }
        }
        
        _getCodeBtn = [Maker BtnWithShadow:NO backColor:[UIColor clearColor] text:kLocalizationMsg(@"获取验证码") textColor:kRGB_COLOR(@"#8A8DFF") font:kFont(14) superView:_codeVerifyView constraints:^(MASConstraintMaker * _Nonnull make) {
           
            make.right.equalTo(_codeVerifyView).inset(30);
            make.bottom.equalTo(_codeVerifyView).inset(15);
        }];
        [_getCodeBtn addTarget:self action:@selector(getCodeAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _codeVerifyView;
}
//获取验证码
-(void)getCodeAction:(UIButton *)sender{
    
    if (![[ProjConfig shareInstence].baseConfig verifyUserPhoneNumber:_phoneTF.text]) {
        return;
    }

    kWeakSelf(self);
    [[ProjConfig shareInstence].baseConfig getInternationalVerifyCode:^(int platform){

        NSString *phoneNum = self.phoneTF.text;
        NSString *tm = [[NSDate date] timeStringWithDateFormat:@"yyyy-MM-dd HH:mm:ss"];
        NSString *keyStr = [kStringFormat(@"%@_jRnQh8ed_%@",phoneNum,tm) md5Encrypt];
        
        [HttpApiAppLogin getSMSCode:platform key:keyStr smsType:4 tel:phoneNum tm:tm callback:^(int code, NSString *strMsg, HttpNoneModel *model) {
            [SVProgressHUD dismiss];
            if (code == 1) {
                HudShowSuccess(kLocalizationMsg(@"已发送至您手机，请注意查收"))
                dispatch_resume(weakself.timer);
            }else{
                HudShowError(strMsg)
            }
        }];
        
    }];

}

-(void)timerAction{
    
    if (count == 0) {
        
        _getCodeBtn.enabled = YES;
        [_getCodeBtn setTitleColor:kRGB_COLOR(@"#8A8DFF") forState:0];
        [_getCodeBtn setTitle:kLocalizationMsg(@"获取验证码") forState:0];
        dispatch_suspend(_timer);
        count = 60;
        return;
    }
    [_getCodeBtn setTitleColor:[UIColor grayColor] forState:0];
    [_getCodeBtn setTitle:kStringFormat(kLocalizationMsg(@"获取验证码(%zi)s"),count) forState:0];
    _getCodeBtn.enabled = NO;
    count --;
}
-(dispatch_source_t)timer{
    
    if (!_timer) {
        
        dispatch_queue_t queue = dispatch_queue_create("timerQueue", DISPATCH_QUEUE_CONCURRENT);
        _timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, queue);
        dispatch_source_set_timer(_timer, DISPATCH_TIME_NOW, 1.0*NSEC_PER_SEC, 0);
        kWeakSelf(self);
        dispatch_source_set_event_handler(_timer, ^{
            
            dispatch_async(dispatch_get_main_queue(), ^{
            
                [weakself timerAction];
            });
        });
    }
    return _timer;
}

- (void)dealloc
{
    if (_timer) {
        
        dispatch_source_cancel(_timer);
        _timer = nil;
    }
}
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    
    [self.view endEditing:YES];
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
