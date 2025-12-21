//
//  DynacmicEULAView.m
//  DynamicCircle
//
//  Created by ssssssss on 2020/10/12.
//  Copyright © 2020 KLC. All rights reserved.
//

#import "KLCUserEULAView.h"
#import <LibProjBase/PopupTool.h>
#import <LibProjBase/HttpClient.h>
#import <WebKit/WebKit.h>
@interface KLCUserEULAView()<WKNavigationDelegate>
@property (nonatomic, strong)WKWebView *textV;
@end
@implementation KLCUserEULAView
+ (void)showUserEULAView{
    KLCUserEULAView *EULAView = [[KLCUserEULAView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight)];
    EULAView.backgroundColor = [UIColor colorWithWhite:0 alpha:0.5];
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:EULAView action:@selector(tap)];
    [EULAView addGestureRecognizer:tap];
    
    UIView *backView = [[UIView alloc]initWithFrame:CGRectMake(40, kScreenHeight/6.0, kScreenWidth-80, 2.0*kScreenHeight/3.0)];
    [EULAView addSubview:backView];
    
    UIButton *closeBtn = [[UIButton alloc]initWithFrame:CGRectMake(kScreenWidth-80-32, 0, 32, 32)];
    [closeBtn setImage:[UIImage imageNamed:@"tip_close"] forState:UIControlStateNormal];
    [closeBtn addTarget:EULAView action:@selector(closeBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [backView addSubview:closeBtn];
    UIView *showView = [[UIView alloc]initWithFrame:CGRectMake(0, 40, kScreenWidth-80, 2.0*kScreenHeight/3.0-40)];
    showView.backgroundColor = [UIColor whiteColor];
    showView.layer.cornerRadius = 10.0;
    showView.clipsToBounds = YES;
    [backView addSubview:showView];
    
    UILabel *titlel = [[UILabel alloc]initWithFrame:CGRectMake(0, 10, kScreenWidth-80, 20)];
    titlel.text = kLocalizationMsg(@"最终用户许可协议(EULA)");
    titlel.font = [UIFont systemFontOfSize:14];
    titlel.textColor = kRGB_COLOR(@"#333333");
    titlel.textAlignment = NSTextAlignmentCenter;
    [showView addSubview:titlel];
    
    WKWebView *textV = [[WKWebView alloc]initWithFrame:CGRectMake(10, 30, kScreenWidth-100, 2.0*kScreenHeight/3.0-40-40-50)];
    textV.backgroundColor = [UIColor whiteColor];
    textV.hidden = YES;
    EULAView.textV = textV;
    textV.navigationDelegate = EULAView;
    NSString *strUrl = [ProjConfig baseUrl];
    strUrl = [strUrl stringByAppendingString:@"/api/login/appSite?type=11"];
    [textV loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:strUrl]]];
    [showView addSubview:textV];
    
    UIButton *agreeBtn = [[UIButton alloc]initWithFrame:CGRectMake(0, 2.0*kScreenHeight/3.0-40-50, 260, 40)];
    agreeBtn.layer.cornerRadius = 20;
    agreeBtn.clipsToBounds = YES;
    agreeBtn.centerX = textV.centerX;
    [agreeBtn setBackgroundImage:[UIImage createImageSize:agreeBtn.size gradientColors:@[kRGB_COLOR(@"#FE73E1"),kRGB_COLOR(@"#9A58FF")] percentage:@[@0.3,@1.0] gradientType:GradientFromLeftToRight] forState:UIControlStateNormal];
    [agreeBtn setTitle:kLocalizationMsg(@"同意并已阅读协议") forState:UIControlStateNormal];
    [agreeBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    agreeBtn.titleLabel.font = [UIFont systemFontOfSize:14];
    [agreeBtn addTarget:EULAView action:@selector(agreeBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [showView addSubview:agreeBtn];
    
    [[PopupTool share] createPopupViewWithLinkView:EULAView allowTapOutside:YES];
}
- (void)closeBtnClick:(UIButton*)btn{
    [[PopupTool share] closePopupView:self];
}
- (void)agreeBtnClick:(UIButton*)btn{
    [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"agreeEULA"];
    [[PopupTool share] closePopupView:self];
}
 
- (void)webView:(WKWebView *)webView didFinishNavigation:(null_unspecified WKNavigation *)navigation{
    [webView evaluateJavaScript:@"document.body.style.backgroundColor=\"#ffffff\"" completionHandler:nil];
     [self performSelector:@selector(showWebView) withObject:self afterDelay:0.2];
}
- (void)tap{
    [[PopupTool share] closePopupView:self];
}
- (void)showWebView{
    self.textV.hidden = NO;
}
@end
