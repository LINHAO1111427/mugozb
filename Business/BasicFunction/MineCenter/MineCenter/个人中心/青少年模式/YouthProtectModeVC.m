//
//  YouthProtectModeVC.m
//  MineCenter
//
//  Created by klc on 2020/8/13.
//

#import "YouthProtectModeVC.h"
#import "YouthProtectPwdVC.h"
#import <LibProjModel/KLCUserInfo.h>

@interface YouthProtectModeVC ()

kAssign(BOOL, isModeOpen)//模式是否开启

kStrong(UIImageView, protectImv)
kStrong(UILabel, statusTipsLab)
kStrong(UIButton, bottomBtn)

@end

@implementation YouthProtectModeVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self createUI];
    [self updateUI];
}
-(void)updateUI{
    
    BOOL isOpen = [KLCUserInfo getUserInfo].isYouthModel == 1;
    self.isModeOpen = isOpen;
}
-(void)createUI{
    
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationItem.title = kLocalizationMsg(@"青少年模式");
    
    _protectImv = [Maker Imv:nil layerCorner:0 superView:self.view constraints:^(MASConstraintMaker * _Nonnull make) {
       
        make.size.mas_equalTo(SIZE(126, 80));
        make.top.equalTo(self.view.zh_safe_top).offset(56);
        make.centerX.equalTo(self.view);
    }];
    
    _statusTipsLab = [Maker labelWithShadow:NO alignment:NSTextAlignmentCenter backColor:[UIColor clearColor] text:@"" textColor:[UIColor grayColor] font:kFont(16) superView:self.view constraints:^(MASConstraintMaker * _Nonnull make) {
       
        make.top.equalTo(_protectImv.mas_bottom).offset(30);
        make.centerX.equalTo(self.view);
    }];
    
    NSArray *content = @[kLocalizationMsg(@"为呵护未成年人健康成长，我们将针对未成年人推出更优化的内容"),kLocalizationMsg(@"该模式下部分功能无法正常使用"),kLocalizationMsg(@"请监护人主动选择，并设置监护密码。"),kLocalizationMsg(@"部分功能无法使用，包含充值、评论、发布动态、开启直播、送礼物等")];
    
    UIStackView *stack = [Maker stackViewAxis:UILayoutConstraintAxisVertical distribution:UIStackViewDistributionEqualSpacing alignment:UIStackViewAlignmentLeading space:20 superView:self.view constraints:^(MASConstraintMaker * _Nonnull make) {
       
        make.left.equalTo(self.view).offset(60);
        make.centerX.equalTo(self.view);
        make.top.equalTo(_statusTipsLab.mas_bottom).offset(30);
    }];
    
    for (int i = 0; i<content.count; i++) {
        
        UIView * itemView = [Maker viewWithShadow:NO backColor:[UIColor clearColor] superView:nil constraints:^(MASConstraintMaker * _Nonnull make) {
        }];
        
        UIView *point = [Maker viewWithShadow:NO backColor:kRGB_COLOR(@"#8A8DFF") superView:itemView constraints:^(MASConstraintMaker * _Nonnull make) {
           
            make.centerY.left.equalTo(itemView);
            make.size.mas_equalTo(SIZE(6, 6));
        }];
        point.layer.cornerRadius = 3;
        
        [Maker labelWithShadow:NO alignment:NSTextAlignmentLeft backColor:[UIColor clearColor] text:content[i] textColor:[UIColor blackColor] font:kFont(12) superView:itemView constraints:^(MASConstraintMaker * _Nonnull make) {
            
            make.edges.equalTo(itemView).insets(UIEdgeInsetsMake(0, 18, 0, 0));
        }];
        [stack addArrangedSubview:itemView];
    }
    
    _bottomBtn = [Maker BtnWithShadow:NO backColor:kRGB_COLOR(@"#8A8DFF") text:@"" textColor:[UIColor whiteColor] font:kFont(15) superView:self.view constraints:^(MASConstraintMaker * _Nonnull make) {
       
        make.size.mas_equalTo(SIZE(260, 40));
        make.centerX.equalTo(self.view);
        make.bottom.equalTo(self.view.zh_safe_bottom).inset(40);
    }];
    _bottomBtn.layer.cornerRadius = 20;
    [_bottomBtn addTarget:self action:@selector(changeModeAction:) forControlEvents:UIControlEventTouchUpInside];
    
}
-(void)setIsModeOpen:(BOOL)isModeOpen{
    
    _isModeOpen = isModeOpen;
    _protectImv.image = ImgNamed(isModeOpen?@"youthProtect_open":@"youthProtect_close");
    _statusTipsLab.text = kStringFormat(kLocalizationMsg(@"青少年模式 - %@开启"),isModeOpen?kLocalizationMsg(@"已"):kLocalizationMsg(@"未"));
    _statusTipsLab.textColor = isModeOpen?kRGB_COLOR(@"#8A8DFF"):[UIColor grayColor];
    NSString *title = kStringFormat(kLocalizationMsg(@"%@青少年模式"),isModeOpen?kLocalizationMsg(@"关闭"):kLocalizationMsg(@"开启"));
    [_bottomBtn setTitle:title forState: 0];
}
-(void)changeModeAction:(UIButton *)sender{
    
    YouthProtectPwdVC *vc = [YouthProtectPwdVC new];
    vc.isModeOpen = self.isModeOpen;
    [self.navigationController pushViewController:vc animated:YES];
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
