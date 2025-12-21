//
//  YouthProtectPwdVC.m
//  MineCenter
//
//  Created by klc on 2020/8/13.
//

#import "YouthProtectPwdVC.h"
#import <LibProjModel/HttpApiYunthModel.h>
#import <LibProjModel/KLCUserInfo.h>


@interface YouthProtectPwdVC ()<UITextFieldDelegate>


kStrong(UITextField, tf)
kStrong(UILabel, tipsLab)

kStrong(UIButton, forgetBtn)

kAssign(NSUInteger, pwdFigures)//密码位数

kAssign(BOOL, isPwdUpdate)//是否为更新密码
@end

@implementation YouthProtectPwdVC{
    
    NSMutableArray * figuresArray;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setup];
    [self createUI];
}
-(void)setup{
    
    _pwdFigures = 4;
    figuresArray = [NSMutableArray array];
}

-(void)createUI{
    
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationItem.title = kLocalizationMsg(@"青少年模式");
    
    UILabel *lab = [Maker labelWithShadow:NO alignment:NSTextAlignmentCenter backColor:[UIColor clearColor] text:kLocalizationMsg(@"请输入密码") textColor:[UIColor blackColor] font:kFont(16) superView:self.view constraints:^(MASConstraintMaker * _Nonnull make) {
       
        make.top.equalTo(self.view.zh_safe_top).offset(60);
        make.centerX.equalTo(self.view);
    }];
    
    _tf = [[UITextField alloc] initWithFrame:CGRectZero];
    _tf.tintColor = [UIColor clearColor];
    _tf.keyboardType = UIKeyboardTypeNumberPad;
    _tf.textColor = [UIColor clearColor];
    _tf.delegate = self;
    [self.view addSubview:_tf];
    [_tf becomeFirstResponder];
    [_tf mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.equalTo(self.view).offset(65);
        make.centerX.equalTo(self.view);
        make.top.equalTo(lab.mas_bottom).offset(30);
        make.height.mas_equalTo(50);
    }];
    [_tf addTarget:self action:@selector(tfValueChanged:) forControlEvents:UIControlEventEditingChanged];
    
    CGFloat gap = (kScreenWidth-_pwdFigures*50-65*2)/(_pwdFigures-1);
    for ( int i = 0; i<_pwdFigures; i++) {
        
        UIView * figureView = [Maker viewWithShadow:NO backColor:kRGB_COLOR(@"#F6F6F6") superView:self.view constraints:^(MASConstraintMaker * _Nonnull make) {
           
            make.size.mas_equalTo(SIZE(50, 50));
            make.left.equalTo(_tf).offset((50+gap)*i);
            make.centerY.equalTo(_tf);
        }];
        
        figureView.layer.cornerRadius =  4;
        [figuresArray addObject:figureView];
    }
    [self.view bringSubviewToFront:_tf];
    
    NSString *tips = _isModeOpen?kLocalizationMsg(@"输入正确密码后将关闭青少年模式"):kLocalizationMsg(@"启动青少年模式，需要设置独立密码");
    _tipsLab = [Maker labelWithShadow:NO alignment:NSTextAlignmentCenter backColor:[UIColor clearColor] text:tips textColor:[UIColor grayColor] font:kFont(12) superView:self.view constraints:^(MASConstraintMaker * _Nonnull make) {
       
        make.top.equalTo(_tf.mas_bottom).offset(18);
        make.centerX.equalTo(self.view);
    }];
    if (self.isModeOpen) {
        
        [self.view addSubview:self.forgetBtn];
        [self.forgetBtn mas_makeConstraints:^(MASConstraintMaker *make) {
           
            make.bottom.mas_equalTo(self.view.zh_safe_bottom).inset(50);
            make.centerX.equalTo(self.view);
        }];
    }
    
    
}

-(UIButton *)forgetBtn{
    
    if (!_forgetBtn) {
        
        _forgetBtn = [Maker BtnWithShadow:NO backColor:[UIColor clearColor] text:kLocalizationMsg(@"忘记密码？") textColor:kRGB_COLOR(@"#8A8DFF") font:kFont(14) superView:nil constraints:^(MASConstraintMaker * _Nonnull make) {
        }];
        [_forgetBtn addTarget:self action:@selector(forgetThePwd:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _forgetBtn;
}
-(void)forgetThePwd:(UIButton *)sender{
    
    //去忘记密码页面
    kWeakSelf(self);
    void (^didPwdResetBlock)(void) = ^{
        
//        self->_isPwdUpdate = YES;
        weakself.tf.text = @"";
        [weakself tfValueChanged:weakself.tf];
    };
    [RouteManager routeForName:RN_center_setting_verifyAccount currentC:self parameters:@{@"title":kLocalizationMsg(@"忘记密码"),@"btnTitle":kLocalizationMsg(@"设置新密码"),@"completeHandle":didPwdResetBlock}];
}

-(void)tfValueChanged:(UITextField *)sender{
    
    [self showPwdPointCount:sender.text.length];
    NSString * pwd = sender.text;
    if (pwd.length == 4) {
        
        if (_isPwdUpdate) {
            [HttpApiYunthModel updateYunthPwd:pwd callback:^(int code, NSString *strMsg, HttpNoneModel *model) {
                if (code == 1) {
                    HudShowSuccess(kLocalizationMsg(@"更新成功"))
                    [self.navigationController popToRootViewControllerAnimated:YES];
                }
            }];
        }else{

            //      1开启，2关闭
            int setNumber = self.isModeOpen?2:1;
            [HttpApiYunthModel setYunthModel:setNumber pwd:pwd callback:^(int code, NSString *strMsg, HttpNoneModel *model) {
            
                HudShowString(strMsg)
                if (code == 1) {
                    ApiUserInfoModel *userModel = [KLCUserInfo getUserInfo];
                    userModel.isYouthModel = setNumber; //1开启 2未开启
                    [KLCUserInfo setUserInfo:userModel];
                    [self.navigationController popToRootViewControllerAnimated:YES];
                }
            }];
        }
        
    }
}

-(void)showPwdPointCount:(NSUInteger)count{
    
    
    for (UIView *figureView in figuresArray) {
        
        [figureView removeAllSubViews];
    }
    for (NSUInteger i = 0; i<count; i++) {
        
        UIView * figureView = figuresArray[i];
        UIView *point= [Maker viewWithShadow:NO backColor:[UIColor blackColor] superView:figureView constraints:^(MASConstraintMaker * _Nonnull make) {
           
            make.size.mas_equalTo(SIZE(10, 10));
            make.center.equalTo(figureView);
        }];
        point.layer.cornerRadius = 5;
    }
    [figuresArray enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
       
        UIView *figureView = (UIView *)obj;
        BOOL isLast = count>0?(idx==count-1):NO;
        figureView.layer.borderWidth = isLast?1:0;
        figureView.layer.borderColor = (isLast?kRGB_COLOR(@"#8A8DFF"):[UIColor clearColor]).CGColor;
    }];
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    // Prevent crashing undo bug – see note below.
    if(range.length + range.location > textField.text.length)
    {
        return NO;
    }

    NSUInteger newLength = textField.text.length + string.length - range.length;
    return newLength <= _pwdFigures;
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    
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
