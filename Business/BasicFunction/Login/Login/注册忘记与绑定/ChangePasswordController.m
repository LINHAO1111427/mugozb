#import "ChangePasswordController.h"
 
#import "LoginRes.h"
#import <LibTools/LibTools.h>
#import <LibProjBase/LibProjBase.h>
#import <LibProjModel/HttpApiUserController.h>

@interface ChangePasswordController ()

@property (weak, nonatomic) IBOutlet UILabel *xinPwdLabel;
@property (weak, nonatomic) IBOutlet UILabel *surePwdLabel;


@property (weak, nonatomic) IBOutlet UITextField *futurePassWord;
@property (weak, nonatomic) IBOutlet UITextField *futurePassWord2;

@property (weak, nonatomic) IBOutlet UIButton *dochange;

@end
@implementation ChangePasswordController

- (instancetype)init
{
    NSString* nibFullName=  [LoginRes getNibFullName:@"ChangePasswordController"];
    //@"Frameworks/Login.framework/ChangePasswordController"
    self = [super initWithNibName:nibFullName bundle:[NSBundle mainBundle]];
    if (self) {
    }
    return self;
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UITextFieldTextDidChangeNotification object:nil];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = _navtitle;
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(ChangeBtnBackground) name:UITextFieldTextDidChangeNotification object:nil];
}



-(void)ChangeBtnBackground{
    
    if (_futurePassWord.text.length >0 && _futurePassWord2.text.length > 0 )
    {
        [_dochange setBackgroundColor:[ProjConfig normalColors]];
        _dochange.enabled = YES;
    }
    else
    {
        [_dochange setBackgroundColor:[UIColor colorWithRed:207/255.0 green:207/255.0 blue:207/255.0 alpha:1.0]];
        _dochange.enabled = NO;
    }
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
    [self.view endEditing:YES];
}


- (IBAction)doChangePassWord:(id)sender {
    
    if (_futurePassWord.text.length <= 0) {
        [SVProgressHUD showInfoWithStatus:kLocalizationMsg(@"请输入新密码")];
        return;
    }
    if (_futurePassWord2.text.length <= 0) {
        [SVProgressHUD showInfoWithStatus:kLocalizationMsg(@"请再次输入新密码")];
        return;
    }
    
    if (_futurePassWord.text.length < 6 || _futurePassWord2.text.length < 6) {
        [SVProgressHUD showInfoWithStatus:kLocalizationMsg(@"密码长度不能小于6位")];
        return;
    }
    if (![_futurePassWord.text valiPassWord] || ![_futurePassWord.text valiPassWord]) {
        [SVProgressHUD showInfoWithStatus:kLocalizationMsg(@"密码过于简单，请尝试字母和数字组合")];
        return;
    }
    if (![_futurePassWord.text isEqualToString:_futurePassWord2.text]) {
        [SVProgressHUD showInfoWithStatus:kLocalizationMsg(@"两次输入的密码不一致")];
        return;
    }

    [SVProgressHUD showWithStatus:kLocalizationMsg(@"请等待")];
    [HttpApiUserController updatePwd:_futurePassWord.text freshPwd2:_futurePassWord2.text callback:^(int code, NSString *strMsg, SingleStringModel *model) {
        [SVProgressHUD dismiss];
        if (code == 1) {
            [SVProgressHUD showInfoWithStatus:strMsg];
            [self.navigationController popViewControllerAnimated:YES];
        }else{
            [SVProgressHUD showInfoWithStatus:strMsg];
        }
    }];
}


@end
