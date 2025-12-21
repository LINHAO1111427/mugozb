//
//  PrivilegeLevelVC.m
//  MineCenter
//
//  Created by klc_sl on 2020/8/28.
//

#import "PrivilegeLevelVC.h"
#import <LibProjView/KLCNetworkShowView.h>
#import <LibProjModel/KLCUserInfo.h>
#import <LibProjBase/LibProjBase.h>

@interface PrivilegeLevelVC ()

@end

@implementation PrivilegeLevelVC

- (void)viewDidLoad {
    [super viewDidLoad];

    self.view.backgroundColor = [UIColor whiteColor];
    kWeakSelf(self);
    KLCNetworkShowView *webV = [[KLCNetworkShowView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight-kNavBarHeight)];
    webV.showProgressLine = YES;
    [self.view addSubview:webV];
    webV.titleBlock = ^(NSString * _Nonnull title) {
        weakself.navigationItem.title = title;
    };
    [webV loadRequestUrl:@"/pub/h5page/index.html#/privilege"];

    UIButton *levelDesBtn = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 50, 32)];
    [levelDesBtn setTitleColor: kRGB_COLOR(@"#999999") forState:UIControlStateNormal];
    [levelDesBtn setTitle:kLocalizationMsg(@"等级说明") forState:UIControlStateNormal];
    levelDesBtn.titleLabel.font = [UIFont systemFontOfSize:12];
    [levelDesBtn addTarget:self action:@selector(levelExplain) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *item = [[UIBarButtonItem alloc]initWithCustomView:levelDesBtn];;
    self.navigationItem.rightBarButtonItem = item;

}

///等级说明
- (void)levelExplain{
    NSString *strUrl = @"/api/h5/gradeDesr?type=1";
    [RouteManager routeForName:RN_general_webView currentC:self parameters:@{@"url":strUrl}];
}


@end
