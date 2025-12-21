//
//  SetUpBeautyVC.m
//  MineCenter
//
//  Created by klc on 2020/4/21.
//

#import "SetUpBeautyVC.h"

#import <LibProjBase/LibProjBase.h>
#import <AgoraExtension/AgoraExtManager.h>
#import <LibProjModel/KLCAppConfig.h>
#import <LibProjModel/AdminLiveConfigModel.h>
#import <LibProjModel/APPConfigModel.h>
#import <Masonry.h>
#import <LibTools/LibTools.h>

@interface SetUpBeautyVC ()

@end

@implementation SetUpBeautyVC


- (void)dealloc {
    [AgoraExtManager disconnect];
}

- (UIBarButtonItem *)rt_customBackItemWithTarget:(id)target action:(SEL)action{
    [BaseNavBarItem navBarBgClear:self foregroundColor:[UIColor whiteColor]];
    return [[UIBarButtonItem alloc] initWithCustomView:[BaseNavBarItem navBackBtnImage:[UIImage imageNamed:@"main_navbar_back"] target:self action:@selector(backBtnClick)]];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor blackColor];
    [self setupUI];
}


- (void)setupUI {
    
    self.navigationController.navigationBar.translucent = YES;
    
    UIImageView *bgIMageV = [[UIImageView alloc] initWithFrame:self.view.frame];
    bgIMageV.contentMode = UIViewContentModeScaleAspectFill;
    [self.view addSubview:bgIMageV];
    
    
    [[AgoraExtManager otoVideo] initO2OVideoRole:2];
    [[AgoraExtManager otoVideo] preview:bgIMageV];
    
    
    UIView *selectedView = [[UIView alloc]initWithFrame:CGRectMake(0, kScreenHeight-kSafeAreaBottom-160, kScreenWidth/2, 70)];
    selectedView.backgroundColor = [UIColor clearColor];
    selectedView.centerX = self.view.centerX;
    [self.view addSubview:selectedView];
    CGFloat magin = kScreenWidth/2-100;
    for (int i = 0; i < 2; i++) {
        UIButton *bgBtn = [[UIButton alloc]initWithFrame:CGRectMake((magin+50)*i, 0, 50, 70)];
        [bgBtn addTarget:self action:@selector(selectedBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        bgBtn.tag = i;
        [selectedView addSubview:bgBtn];
        
        UIImageView *imgV = [[UIImageView alloc] init];
        imgV.frame = CGRectMake(13, 15, 24, 24);
        NSString *imageName;
        if (i == 0 ) {
            imageName = @"live_pre_fanzhuanjingtou";
        }else{
            imageName = @"live_pre_fitter";
        }
        imgV.image = [UIImage imageNamed:imageName];
        imgV.contentMode = UIViewContentModeScaleAspectFit;
        [bgBtn addSubview:imgV];
        UILabel *titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 50, 50, 20)];
        titleLabel.textColor = [UIColor whiteColor];
        titleLabel.textAlignment = NSTextAlignmentCenter;
        titleLabel.font = [UIFont systemFontOfSize:14];
        titleLabel.centerX = imgV.centerX;
        titleLabel.text = i==0?kLocalizationMsg(@"翻转"):kLocalizationMsg(@"美颜");
        [bgBtn addSubview:titleLabel];
    }
    
    
}
- (void)selectedBtnClick:(UIButton *)btn{
    if (btn.tag == 0) {
        [[AgoraExtManager otoVideo] switchCamera];
    }else{
        [[AgoraExtManager otoVideo] showBeautyInView:nil complete:^{
        }];
    }
}
- (void)backBtnClick{
    [[AgoraExtManager otoVideo] leaveRoom];
    [self.navigationController popViewControllerAnimated:YES];
}



@end
