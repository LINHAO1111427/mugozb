//
//  OfficialMessageDetailVC.m
//  Message
//
//  Created by klc_sl on 2020/8/24.
//  Copyright © 2020 KLC. All rights reserved.
//

#import "OfficialMessageDetailVC.h"

#import <LibTools/LibTools.h>
#import <LibProjBase/LibProjBase.h>
#import <LibProjModel/AppOfficialNewsDTOModel.h>
 
#import <LibProjView/KLCNetworkShowView.h>
#import <LibProjView/LiveShareView.h>

@interface OfficialMessageDetailVC ()

@property (nonatomic, weak) UIProgressView *weakProgressV;

@end

@implementation OfficialMessageDetailVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [ProjConfig projBgColor];
    self.navigationController.navigationBar.tintColor = [ProjConfig projNavTitleColor];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"dynamic_list_mini_share"] style:UIBarButtonItemStylePlain target:self action:@selector(shareBtnClick)];
    
    [self createUI];
}


- (void)shareBtnClick{
    [LiveShareView showShareViewForType:3 shareId:0 moreFunction:nil];
}


- (void)createUI{
    
    UIProgressView *progressV = [[UIProgressView alloc] initWithProgressViewStyle:(UIProgressViewStyleDefault)];
    progressV.frame = CGRectMake(0, 0, kScreenWidth, 0);
    progressV.clipsToBounds = YES;
    progressV.trackTintColor = [UIColor clearColor];
    [self.view addSubview:progressV];
    _weakProgressV = progressV;
    
    kWeakSelf(self);
    KLCNetworkShowView *webV = [[KLCNetworkShowView alloc] initWithFrame:CGRectMake(15, 0, kScreenWidth-30, self.view.height-kNavBarHeight)];
    webV.showProgressLine = NO;
    [self.view addSubview:webV];
    [self.view sendSubviewToBack:webV];
    webV.progressBlock = ^(CGFloat progress) {
        if (progress >= 1.0) {
            [weakself.weakProgressV setProgress:1 animated:NO];
            [UIView animateWithDuration:0.3f delay:0.3f options:UIViewAnimationOptionCurveEaseOut animations:^{
                weakself.weakProgressV.alpha = 0.0f;
            } completion:^(BOOL finished) {
                [weakself.weakProgressV setProgress:0 animated:NO];
            }];
        }else{
            weakself.weakProgressV.alpha = 1.0f;
            [weakself.weakProgressV setProgress:progress animated:YES];
        }
    };
    
    [webV loadLocalHTML:self.dtoModel.content];
}

@end
