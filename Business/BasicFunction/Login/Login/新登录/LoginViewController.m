//
//  LoginViewController.m
//  Login
//
//  Created by klc on 2020/4/25.
//

#import "LoginViewController.h"

#import <UIKit/UIKit.h>
#import <LibTools/LibTools.h>
#import "PolicyTipsView.h"
#import <LibProjView/AppleLoginObj.h>
#import <LibProjView/VersionTipView.h>

#import <LibProjBase/MobManager.h>
#import <LibProjBase/LibProjBase.h>

#import <LibProjModel/KLCUserInfo.h>
#import <LibProjModel/KLCAppConfig.h>
#import <LibProjModel/APPConfigModel.h>
#import <LibProjModel/AdminLiveConfigModel.h>
#import <LibProjModel/AdminLoginSwitchModel.h>
 
#import <LibProjModel/HttpApiAppLogin.h>
#import <LibProjModel/ApiUserInfoModel.h>

#define Bg_animate_Scale 0.0
typedef enum {
    loginTypePassword = 0,
    loginTypeCode
}loginType;

@interface LoginViewController ()<UIGestureRecognizerDelegate>
@property (nonatomic, strong)UIView *bottomLine;
@property (nonatomic, strong)UILabel *leftLabel;
@property (nonatomic, strong)UILabel *rightLabel;
@property (nonatomic, strong)UIImageView *bgImageV;

@property (nonatomic, strong)UITextField *phoneTextField;
@property (nonatomic, strong)UITextField *passWordTextField;
@property (nonatomic, strong)UITextField *codeTextField;
@property (nonatomic, strong)UILabel *timeLabel;

@property (nonatomic, strong)UIView *passWordView;
@property (nonatomic, strong)UIView *codeView;
@property (nonatomic, strong)UIView *timeView;
@property (nonatomic, strong)NSArray *thirdArr;

@property (nonatomic, strong)NSTimer *timer;
@property (nonatomic, assign)NSInteger  timeDown;
@property (nonatomic, strong)UIButton *codeBtn;

@property (nonatomic, assign)loginType loginType;
@property (nonatomic, strong)UIView *bottomView;

///登录按钮
@property (nonatomic, weak)UIButton *loginBtn;

//三方登录与注册
@end

@implementation LoginViewController

- (NSTimer *)timer{
    if (!_timer) {
        _timer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(timerComeDown) userInfo:nil repeats:YES];
        [[NSRunLoop currentRunLoop] addTimer:_timer forMode:NSRunLoopCommonModes];
    }
    return _timer;
}
- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [self.view  endEditing:YES];
}
 
- (void)viewDidLoad {
    kWeakSelf(self);
    
    [super viewDidLoad];
    self.navigationController.navigationBarHidden = YES;
    self.timeDown = 60;
    self.view.backgroundColor = [UIColor whiteColor];

    [self createView];
    
    [self clearUserInfo];
    
    [weakself getLoginThird];
    
}
///显示视图
- (void)createView{
    UIImageView *bgImageV = [[UIImageView alloc]initWithFrame:self.view.bounds];
    bgImageV.image = [ProjConfig getLoginBgImage];
    bgImageV.contentMode = UIViewContentModeScaleAspectFill;
    bgImageV.userInteractionEnabled = YES;
    self.bgImageV = bgImageV;
    [self.view addSubview:self.bgImageV];
    
    CGFloat ww = 60*kScreenWidth/360.0;
    UIImageView *logoImageV = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, ww, ww)];
    logoImageV.centerX = kScreenWidth/2.0;
    logoImageV.centerY = (kScreenHeight-200)/4.0-20;
    logoImageV.image = [UIImage imageNamed:@"login_logo"];
    [bgImageV addSubview:logoImageV];
    
    UIView *topView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, (kScreenHeight-200)/2.0)];
    topView.backgroundColor = [UIColor clearColor];
    [self.view addSubview:topView];
    [self subTopView:topView];
    
    UIView *midView = [[UIView alloc]initWithFrame:CGRectMake(0, (kScreenHeight-200)/2.0, kScreenWidth, 200)];
    midView.backgroundColor = [UIColor clearColor];
    [self.view addSubview:midView];
    [self subMidView:midView];
    
    UIView *bottomView = [[UIView alloc]initWithFrame:CGRectMake(0,200+(kScreenHeight-200)/2.0, kScreenWidth, ((kScreenHeight-200)/2.0)-(kSafeAreaBottom+50))];
    bottomView.backgroundColor = [UIColor clearColor];
    self.bottomView = bottomView;
    [self.view addSubview:self.bottomView];
    
    //注册
    CGFloat width = 250*kScreenWidth/360.0;
    UIButton *registerBtn = [[UIButton alloc]initWithFrame:CGRectMake((kScreenWidth-width)/2.0, kScreenHeight-kSafeAreaBottom-50, width, 30)];
    [registerBtn addTarget:self action:@selector(registerBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    NSDictionary * underAttribtDic  = @{NSUnderlineStyleAttributeName:[NSNumber numberWithInteger:NSUnderlineStyleSingle],NSForegroundColorAttributeName:[UIColor whiteColor]};
    NSMutableAttributedString * underAttr = [[NSMutableAttributedString alloc] initWithString:kLocalizationMsg(@"还没有账号？立即注册！") attributes:underAttribtDic];
    [registerBtn setAttributedTitle:underAttr forState:UIControlStateNormal];
    [registerBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    registerBtn.titleLabel.font = [UIFont systemFontOfSize:13];
    registerBtn.contentHorizontalAlignment =  UIControlContentHorizontalAlignmentCenter;
    [self.view addSubview:registerBtn];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapgesture)];
    tap.delegate = self;
    [self.view addGestureRecognizer:tap];
    
    if (self.hasBack) {
        UIButton *backBtn = [UIButton buttonWithType:0];
        [backBtn setImage:[UIImage imageNamed:@"dynamic_close"] forState:UIControlStateNormal];
        backBtn.contentEdgeInsets = UIEdgeInsetsMake(10, 10, 10, 10);
        backBtn.frame = CGRectMake(kScreenWidth-44-20, kStatusBarHeight, 44, 44);
        [backBtn addTarget:self action:@selector(backBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:backBtn];
    }

}



- (void)clearUserInfo{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    //清除首充奖励
    [defaults setBool:NO forKey:@"isShowFirstRechargeReward"];
    //清除svip
    [defaults setBool:NO forKey:@"hasShowSvipTip"];
    //来自登录页面
    [defaults setBool:YES forKey:@"isFromLoginVc"];
    
    //展示隐私政策
    kWeakSelf(self);
    [PolicyTipsView showInVC:self closeBlock:^{
        [weakself getLoginThird];
    }];

    ///版本判断
    [VersionTipView showVersionTip:^(BOOL isCancel, NSString * _Nonnull openUrl) {
    }];
    
    ///清除免费短视频
    NSString *docPath=[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)lastObject];
    NSString *arrPath =[docPath stringByAppendingPathComponent:@"shortVideoId.arr"];
    NSFileManager *manager = [NSFileManager defaultManager];
    BOOL isDelete = [manager removeItemAtPath:arrPath error:nil];
    if (isDelete) {
       // NSLog(@"过滤文字清除免费短视频成功"));
    }
}


- (void)timerComeDown{
    if (self.timeDown == 0) {
        self.codeBtn.userInteractionEnabled = YES;
        self.timeDown = 60;
        self.timeLabel.text = [NSString stringWithFormat:kLocalizationMsg(@"获取验证码")];
        [self.timer setFireDate:[NSDate distantFuture]];
    }else{
        self.timeLabel.text = [NSString stringWithFormat:kLocalizationMsg(@"获取验证码(%ld)s"),(long)self.timeDown];
        self.timeDown -- ;
    }
    
}
-(void)getLoginThird{
    self.thirdArr = [KLCAppConfig loginArray];
    [self subBottomView:self.bottomView];
}

- (void)dealloc{
    [self.timer invalidate];
    self.timer = nil;
}
#pragma mark- 按钮 手势
- (void)tapgesture{
    [self.view endEditing:YES];
}

- (void)leftBtnClick:(UIButton *)btn{
    CGFloat width = 250*kScreenWidth/360.0;
    self.bottomLine.x = 3*width/16.0;
    self.leftLabel.textColor = [UIColor whiteColor];
    self.rightLabel.textColor =  kRGBA_COLOR(@"#FFFFFF", 0.5);
    self.loginType = loginTypePassword;
    [self showLoginViewForType];
}
- (void)rightBtnClick:(UIButton *)btn{
    CGFloat width = 250*kScreenWidth/360.0;
    self.bottomLine.x = 11*width/16.0;
    self.leftLabel.textColor = kRGBA_COLOR(@"#FFFFFF", 0.5);
    self.rightLabel.textColor =  [UIColor whiteColor];
    self.loginType = loginTypeCode;
    [self showLoginViewForType];
}

- (void)backBtnClick:(UIButton *)btn{
    [self dismissViewControllerAnimated:YES completion:nil];
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)showLoginViewForType{
    if (_loginType == loginTypePassword) {//密码
        self.passWordView.hidden = NO;
        self.codeView.hidden = YES;
        self.codeTextField.text =@"";
        self.timeView.hidden = YES;
    }else{//验证码
        self.passWordView.hidden = YES;
        self.passWordTextField.text = @"";
        self.codeView.hidden = NO;
        self.timeView.hidden = NO;
    }
}

- (void)forgetBtnClick:(UIButton *)btn{
    [self.view  endEditing:YES];
    [RouteManager routeForName:RN_login_losePassword currentC:self];
}
- (void)codeBtnClick:(UIButton *)btn{
    [self.view  endEditing:YES];
    
    if (![[ProjConfig shareInstence].baseConfig verifyUserPhoneNumber:self.phoneTextField.text]) {
        return;
    }
    kWeakSelf(self);
    [[ProjConfig shareInstence].baseConfig getInternationalVerifyCode:^(int platform){
        
        weakself.timeDown = 60;
        weakself.codeBtn.userInteractionEnabled = NO;

        NSString *phoneNum = self.phoneTextField.text;
        NSString *tm = [[NSDate date] timeStringWithDateFormat:@"yyyy-MM-dd HH:mm:ss"];
        NSString *keyStr = [kStringFormat(@"%@_jRnQh8ed_%@",phoneNum,tm) md5Encrypt];
        
        [HttpApiAppLogin getSMSCode:platform key:keyStr smsType:3 tel:phoneNum tm:tm callback:^(int code, NSString *strMsg, HttpNoneModel *model) {
            [SVProgressHUD dismiss];
            if (code == 1){
                [SVProgressHUD showSuccessWithStatus:strMsg];
                [weakself.timer setFireDate:[NSDate distantPast]];
            }else{
                weakself.codeBtn.userInteractionEnabled = YES;
                [SVProgressHUD showInfoWithStatus:strMsg];
            }
        }];
    }];
}



- (void)loginBtnClick:(UIButton *)btn{
    [self.view endEditing:YES];

    if (![[ProjConfig shareInstence].baseConfig verifyUserPhoneNumber:self.phoneTextField.text]) {
        return;
    }
    
    if (self.loginType == loginTypePassword) {
        if (self.passWordTextField.text.length == 0) {
            [SVProgressHUD showInfoWithStatus:kLocalizationMsg(@"请输入密码")];
            return;
        }
        _loginBtn.userInteractionEnabled = NO;
        [SVProgressHUD show];
        NSString *password = self.passWordTextField.text;
        NSString *mobile = self.phoneTextField.text;
        NSString *appVersion = [IPhoneInfo appVersionNO];
        NSString *phoneFirm = @"Apple";
        NSString *phoneModel = [IPhoneInfo phoneType];
        NSString *phoneUuid = [IPhoneInfo phoneUUID];
        NSString *appVersionCode = [IPhoneInfo appVersionBuild];
        [HttpApiAppLogin login:appVersion appVersionCode:appVersionCode mobile:mobile password:password phoneFirm:phoneFirm phoneModel:phoneModel phoneUuid:phoneUuid smsRegion:@"86" callback:^(int code, NSString *strMsg, ApiUserInfoLoginModel *model) {
            [SVProgressHUD dismiss];
            if (code == 1) {
                [self userLoginSuccess:model];
            }else{
                self.loginBtn.userInteractionEnabled = YES;
                [SVProgressHUD showInfoWithStatus:strMsg];
            }
        }];
    }else{
        if (self.codeTextField.text.length == 0) {
            [SVProgressHUD showInfoWithStatus:kLocalizationMsg(@"请输入验证码")];
            return;
        }
        _loginBtn.userInteractionEnabled = NO;
        NSString *code = self.codeTextField.text;
        NSString *mobile = self.phoneTextField.text;
        NSString *appVersion = [IPhoneInfo appVersionNO];
        NSString *phoneFirm = @"Apple";
        NSString *phoneModel = [IPhoneInfo phoneType];
        NSString *phoneUuid = [IPhoneInfo phoneUUID];
        NSString *appVersionCode = [IPhoneInfo appVersionBuild];
        [HttpApiAppLogin phoneCodeLogin:appVersion appVersionCode:appVersionCode code:code mobile:mobile phoneFirm:phoneFirm phoneModel:phoneModel phoneUuid:phoneUuid smsRegion:@"86" callback:^(int code, NSString *strMsg, ApiUserInfoLoginModel *model) {
            [SVProgressHUD dismiss];
            if (code == 1) {
                [self userLoginSuccess:model];
            }else{
                self.loginBtn.userInteractionEnabled = YES;
                [SVProgressHUD showInfoWithStatus:strMsg];
            }
        }];
        
    }
}

/**用户登陆成功**/
- (void)userLoginSuccess:(ApiUserInfoLoginModel *)model{
    
    self.loginBtn.userInteractionEnabled = YES;
    [KLCUserInfo setAppLoginedInfo:model];
    if ([KLCAppConfig appConfig].adminLiveConfig.isBindPhone == 0 && model.userInfo.mobileLength == 0) {
        [RouteManager routeForName:RN_login_userBindPhone currentC:self];
    }else{
        ///三方配置
        [ProjConfig userlogined];
        ///是否需要形象设置
        if ([[ProjConfig shareInstence].baseConfig whetherSetUserProfile]) {
            [RouteManager routeForName:RN_login_setUserProfile currentC:self];
        }else{
            [[ProjConfig shareInstence].baseConfig showHomeMainVC];
        }
    }
}

- (void)registerBtnClick:(UIButton *)btn{
    [self.view  endEditing:YES];
    [RouteManager routeForName:RN_login_userRegister currentC:self];
}


-(void)thirdlogin:(NSDictionary *)thirdDic{
    kWeakSelf(self);
    if ([thirdDic[@"id"] intValue] == 3) { ///苹果登录
        [AppleLoginObj authAppleID:^(BOOL success, AppleUserInfoModel * _Nonnull userInfo) {
            if (success) {
                [weakself appleLogin:userInfo];
            }else{
                [SVProgressHUD dismiss];
            }
        }];
    }else{
        [MobManager loginType:[thirdDic[@"shareType"] integerValue] resultHandle:^(BOOL success, SSDKUser * _Nonnull user) {
            if (success) {
                [weakself RequestLogin:user thirdLoginType:[thirdDic[@"id"] intValue]];
            }else{
                [SVProgressHUD dismiss];
            }
        }];
    }
}


- (void)appleLogin:(AppleUserInfoModel *)userinfo{
    SSDKUser *user = [[SSDKUser alloc] init];
    user.uid = userinfo.userId;
    user.nickname = userinfo.userName;
    [self RequestLogin:user thirdLoginType:3];
}

-(void)RequestLogin:(SSDKUser *)user thirdLoginType:(int)thirdType
{
    ///登录方式1:QQ 2:微信3apple
    [SVProgressHUD dismiss];
    NSString *icon = nil;
    NSString *unionID;//unionid
    switch (thirdType) {
        case 3:  //apple
        {
            icon = @"";
            unionID = user.uid;
        }
            break;
        case 1:
        {
            icon = [user.rawData valueForKey:@"figureurl_qq_2"];//qq
            unionID = user.uid;
        }
            break;
        case 2:
        {
            icon = user.icon;
            unionID = [user.rawData valueForKey:@"unionid"];//微信
        }
            break;
        default:
        {
            icon = user.icon;
            unionID = user.uid;
        }
            break;
    }
    if (!icon || !unionID) {
        [SVProgressHUD showInfoWithStatus:kLocalizationMsg(@"未获取到授权，请重试")];
        return;
    }
    [SVProgressHUD show];
    NSString *nickName = @"";
    if (user.nickname.length == 0 && thirdType == 3) {
        nickName = @"Apple";
    }else{
        nickName =[user.nickname stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
    }
    NSString *pic = @"";
    if (icon.length == 0 && thirdType == 3) {
        pic = @"Apple";
    }else{
        pic = [icon stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
    }

    kWeakSelf(self);
    [HttpApiAppLogin ChartLogin:[IPhoneInfo appVersionNO] appVersionCode:[IPhoneInfo appVersionBuild] nickname:nickName openid:[NSString stringWithFormat:@"%@",unionID] phoneFirm:@"Apple" phoneModel:[IPhoneInfo phoneType] phoneUuid:[IPhoneInfo phoneUUID] pic:pic sex:0 type:thirdType callback:^(int code, NSString *strMsg, ApiUserInfoLoginModel *model) {
        [SVProgressHUD dismiss];
        if (code == 1) {
            [weakself userLoginSuccess:model];
        }else{
            [SVProgressHUD showInfoWithStatus:strMsg];
        }
    }];
}


#pragma mark UI
- (void)subTopView:(UIView *)topView{
    CGFloat width = 250*kScreenWidth/360.0;
    UIView *titleView = [[UIView alloc]initWithFrame:CGRectMake((kScreenWidth-width)/2.0, topView.maxY-80, width, 40)];
    titleView.backgroundColor = [UIColor clearColor];
    [topView addSubview:titleView];
    
    
    UILabel *leftLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 10, width/2.0, 20)];
    leftLabel.textColor = [UIColor whiteColor];
    leftLabel.backgroundColor = [UIColor clearColor];
    leftLabel.text = kLocalizationMsg(@"账号登录");
    leftLabel.font = [UIFont systemFontOfSize:16];
    leftLabel.textAlignment = NSTextAlignmentCenter;
    self.leftLabel = leftLabel;
    [titleView addSubview:self.leftLabel];
    
    UILabel *rightLabel = [[UILabel alloc]initWithFrame:CGRectMake(width/2.0, 10, width/2.0, 20)];
    rightLabel.textColor = kRGBA_COLOR(@"#FFFFFF", 0.5);
    rightLabel.backgroundColor = [UIColor clearColor];
    rightLabel.text = kLocalizationMsg(@"验证码登录");
    rightLabel.font = [UIFont systemFontOfSize:16];
    rightLabel.textAlignment = NSTextAlignmentCenter;
    self.rightLabel = rightLabel;
    [titleView addSubview:self.rightLabel];
    
    
    UIView *bottomLine = [[UIView alloc]initWithFrame:CGRectMake(3*width/16.0, 39, width/8.0, 1)];
    bottomLine.backgroundColor = [UIColor lightTextColor];
    self.bottomLine = bottomLine;
    [titleView addSubview:self.bottomLine];
    
    UIButton *leftBtn = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, width/2.0, 40)];
    [leftBtn addTarget:self action:@selector(leftBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    leftBtn.backgroundColor = [UIColor clearColor];
    [titleView addSubview:leftBtn];
    
    UIButton *rightBtn = [[UIButton alloc]initWithFrame:CGRectMake(width/2.0, 0, width/2.0, 40)];
    [rightBtn addTarget:self action:@selector(rightBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    rightBtn.backgroundColor = [UIColor clearColor];
    [titleView addSubview:rightBtn];
    
    UIView *line1 = [[UIView alloc]initWithFrame:CGRectMake(0, 10, 1.0, 20)];
    line1.backgroundColor = [UIColor lightTextColor];
    line1.centerX = width/2.0;
    [titleView addSubview:line1];
    
}


- (void)subMidView:(UIView *)midView{
    midView.backgroundColor = [UIColor clearColor];
    CGFloat width = 250*kScreenWidth/360.0;
    
    //手机号
    UIView *phoneView = [[UIView alloc]initWithFrame:CGRectMake((kScreenWidth-width)/2.0, 10, width, 40)];
    phoneView.backgroundColor = [UIColor colorWithWhite:1 alpha:0.3];
    phoneView.layer.cornerRadius = 20;
    phoneView.clipsToBounds = YES;
    [midView addSubview:phoneView];
    
    UITextField *phoneTextField = [[UITextField alloc]initWithFrame:CGRectMake(15,0, width-30, 40)];
    phoneTextField.backgroundColor = [UIColor clearColor];
    phoneTextField.attributedPlaceholder = [[NSAttributedString alloc] initWithString:kLocalizationMsg(@"请输入您的手机号")attributes:@{NSForegroundColorAttributeName: [UIColor whiteColor],NSFontAttributeName:[UIFont systemFontOfSize:14]}];
    phoneTextField.clearButtonMode = UITextFieldViewModeWhileEditing;
    phoneTextField.font = [UIFont systemFontOfSize:14];
    phoneTextField.textColor = [UIColor whiteColor];
    phoneTextField.keyboardType = UIKeyboardTypePhonePad;
    [phoneTextField addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
    self.phoneTextField = phoneTextField;
    [phoneView addSubview:self.phoneTextField];
    
    //密码
    UIView *passWordView = [[UIView alloc]initWithFrame:CGRectMake((kScreenWidth-width)/2.0, 70, width, 40)];
    passWordView.backgroundColor = [UIColor colorWithWhite:1 alpha:0.3];
    passWordView.layer.cornerRadius = 20;
    passWordView.clipsToBounds = YES;
    self.passWordView = passWordView;
    [midView addSubview:self.passWordView];
    
    UITextField *passWordTextField = [[UITextField alloc]initWithFrame:CGRectMake(15,0, width-30, 40)];
    passWordTextField.backgroundColor = [UIColor clearColor];
    passWordTextField.secureTextEntry = YES;
    passWordTextField.attributedPlaceholder = [[NSAttributedString alloc] initWithString:kLocalizationMsg(@"请输入密码")attributes:@{NSForegroundColorAttributeName: [UIColor whiteColor],NSFontAttributeName:[UIFont systemFontOfSize:14]}];
    passWordTextField.clearButtonMode = UITextFieldViewModeWhileEditing;
    passWordTextField.font = [UIFont systemFontOfSize:14];
    passWordTextField.textColor = [UIColor whiteColor];
    passWordTextField.keyboardType = UIKeyboardTypeNumbersAndPunctuation;
    self.passWordTextField = passWordTextField;
    [passWordView addSubview:self.passWordTextField];
    
    //验证码
    UIView *codeView = [[UIView alloc]initWithFrame:CGRectMake((kScreenWidth-width)/2.0, 70, 5*width/9.0, 40)];
    codeView.backgroundColor = [UIColor colorWithWhite:1 alpha:0.3];
    codeView.layer.cornerRadius = 20;
    codeView.clipsToBounds = YES;
    self.codeView = codeView;
    self.codeView.hidden = YES;
    [midView addSubview:self.codeView];
    
    UITextField *codeTextField = [[UITextField alloc]initWithFrame:CGRectMake(15,0, width-30, 40)];
    codeTextField.backgroundColor = [UIColor clearColor];
    codeTextField.attributedPlaceholder = [[NSAttributedString alloc] initWithString:kLocalizationMsg(@"请输入验证码")attributes:@{NSForegroundColorAttributeName: [UIColor whiteColor],NSFontAttributeName:[UIFont systemFontOfSize:14]}];
    codeTextField.clearButtonMode = UITextFieldViewModeWhileEditing;
    codeTextField.font = [UIFont systemFontOfSize:14];
    codeTextField.textColor = [UIColor whiteColor];
    codeTextField.keyboardType = UIKeyboardTypeNumberPad;
    self.codeTextField = codeTextField;
    [codeView addSubview:self.codeTextField];
    
    
    UIView *timeView = [[UIView alloc]initWithFrame:CGRectMake((kScreenWidth-width)/2.0 + 5*width/9.0, 70, 4*width/9.0, 40)];
    timeView.backgroundColor = [UIColor clearColor];
    timeView.hidden = YES;
    self.timeView = timeView;
    [midView addSubview:self.timeView];
    
    UILabel *timeLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 4*width/9.0, 40)];
    timeLabel.backgroundColor = [UIColor clearColor];
    timeLabel.font = [UIFont systemFontOfSize:12];
    timeLabel.textColor = [UIColor whiteColor];
    timeLabel.textAlignment = NSTextAlignmentCenter;
    self.timeLabel = timeLabel;
    self.timeLabel.text = kLocalizationMsg(@"获取验证码");
    [timeView addSubview:self.timeLabel];
    
    UIButton *codeBtn = [[UIButton alloc]initWithFrame:timeLabel.bounds];
    codeBtn.backgroundColor = [UIColor clearColor];
    [codeBtn addTarget:self action:@selector(codeBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    self.codeBtn = codeBtn;
    [timeView addSubview:self.codeBtn];
    
    //登录按钮
    UIButton *loginBtn = [[UIButton alloc]initWithFrame:CGRectMake((kScreenWidth-width)/2.0, 130, width, 40)];
    loginBtn.layer.cornerRadius = 20;
    loginBtn.clipsToBounds = YES;
    loginBtn.backgroundColor = [UIColor whiteColor];
    [loginBtn setTitleColor:[ProjConfig normalColors] forState:UIControlStateNormal];
    loginBtn.titleLabel.font = [UIFont systemFontOfSize:16];
    [loginBtn addTarget:self action:@selector(loginBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [loginBtn setTitle:kLocalizationMsg(@"登录") forState:UIControlStateNormal];
    [midView addSubview:loginBtn];
    self.loginBtn = loginBtn;
    
    //忘记密码
    UIButton *forgetBtn = [[UIButton alloc]initWithFrame:CGRectMake((kScreenWidth-width)/2.0+2*width/3.0, 170, width/3.0, 30)];
    [forgetBtn setTitle:kLocalizationMsg(@"忘记密码？") forState:UIControlStateNormal];
    [forgetBtn addTarget:self action:@selector(forgetBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    forgetBtn.titleLabel.font = [UIFont systemFontOfSize:13];
    [forgetBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [midView addSubview:forgetBtn];
}


- (void)subBottomView:(UIView *)bottomView{
    
    [bottomView removeAllSubViews];
    
    CGFloat width = 250*kScreenWidth/360.0;
    if (self.thirdArr.count > 0) {
        
        UILabel *otherLoginLabel = [[UILabel alloc]initWithFrame:CGRectMake((kScreenWidth-width)/2.0, 20, width, 20)];
        otherLoginLabel.font = [UIFont systemFontOfSize:13];
        otherLoginLabel.textAlignment = NSTextAlignmentCenter;
        otherLoginLabel.textColor = [UIColor whiteColor];
        otherLoginLabel.text = kLocalizationMsg(@"选择其他登录方式");
        [bottomView addSubview:otherLoginLabel];
        
        UIView *thirdLoginView = [[UIView alloc]initWithFrame:CGRectMake((kScreenWidth-width)/2.0, 70, width, 40)];
        thirdLoginView.backgroundColor = [UIColor clearColor];
        [bottomView addSubview:thirdLoginView];
        CGFloat space = (width-self.thirdArr.count *40.0)/(self.thirdArr.count+1);
        for (int i=0; i<self.thirdArr.count; i++ ){
            NSDictionary *dic = self.thirdArr[i];
            int type = [dic[@"id"] intValue];
            UIButton *btn = [UIButton buttonWithType:0];
            btn.frame = CGRectMake(space+i*(space+40),0,40,40);
            btn.layer.masksToBounds = YES;
            btn.layer.cornerRadius = btn.height/2.0;
            [thirdLoginView addSubview:btn];
            
            NSString *imgStr = @"";
            ///登录方式1:QQ 2:微信3apple
            switch (type) {
                case 3: //apple
                {
                    imgStr = @"login_apple";
                }
                    break;
                case 1: //qq
                {
                    imgStr = @"login_qq";
                }
                    break;
                case 2: //微信
                {
                    imgStr = @"login_wechat";
                }
                    break;
                default:
                    break;
            }
            UIImageView *imgV = [[UIImageView alloc] initWithFrame:btn.bounds];
            imgV.contentMode = UIViewContentModeScaleAspectFill;
            imgV.image = [UIImage imageNamed:imgStr];
            [btn addSubview:imgV];
            kWeakSelf(self);
            [btn klc_whenTapped:^{
                [weakself thirdlogin:dic];
            }];
        }
    }
}

#pragma mark - UIGestureRecognizerDelegate
- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch{
    if ([touch.view isKindOfClass:[UIButton class]]) {
        return NO;
    }else{
        return YES;
    }
}

#pragma mark - textFieldEditChanged
-(void)textFieldDidChange:(UITextField *)textField{
    if (textField == self.phoneTextField) {
        if (textField.text.length > 11) {
             textField.text = [textField.text substringToIndex:11];
         }
    }
}
@end
