//
//  AccountCancelVC.m
//  MineCenter
//
//  Created by klc on 2020/8/13.
//

#import "AccountCancelVC.h"
#import <LibProjModel/KLCAppConfig.h>
#import <LibProjModel/AppConfigModel.h>
#import <LibProjModel/AdminLiveConfigModel.h>



@interface AccountCancelVC ()

@end

@implementation AccountCancelVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.title = kLocalizationMsg(@"账号注销");
    self.view.backgroundColor = [UIColor whiteColor];
    
    NSString *content = [[[KLCAppConfig appConfig] adminLiveConfig] userCancel];
    UILabel *contentLab= [Maker labelWithShadow:NO alignment:NSTextAlignmentLeft backColor:[UIColor clearColor] text:@"" textColor:[UIColor blackColor] font:kFont(14) superView:self.view constraints:^(MASConstraintMaker * _Nonnull make) {
       
        make.left.top.equalTo(self.view).offset(20);
        make.centerX.equalTo(self.view);
    }];
    contentLab.attributedText = [[NSAttributedString alloc] initWithData:[content dataUsingEncoding:NSUnicodeStringEncoding] options:@{NSDocumentTypeDocumentAttribute:NSHTMLTextDocumentType} documentAttributes:nil error:nil];
    
    UIButton * cancelBtn = [Maker BtnWithShadow:NO backColor:[UIColor clearColor] text:kLocalizationMsg(@"申请注销") textColor:[UIColor whiteColor] font:kFont(15) superView:self.view constraints:^(MASConstraintMaker * _Nonnull make) {
        
        make.size.mas_equalTo(SIZE(260, 40));
        make.centerX.equalTo(self.view);
        make.bottom.equalTo(self.view.zh_safe_bottom).inset(100);
    }];
    cancelBtn.colors = @[kRGB_COLOR(@"#7CB9FF"),kRGB_COLOR(@"#CF6DFF")];
    cancelBtn.layer.cornerRadius = 20;
    [cancelBtn addTarget:self action:@selector(cancelAccountAction:) forControlEvents:UIControlEventTouchUpInside];
    
}

-(void)cancelAccountAction:(UIButton *)sender{
        
    //去验证页面
    [RouteManager routeForName:RN_center_setting_verifyAccount currentC:self parameters:@{@"title":kLocalizationMsg(@"账户注销"),@"btnTitle":kLocalizationMsg(@"确认注销")}];
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
