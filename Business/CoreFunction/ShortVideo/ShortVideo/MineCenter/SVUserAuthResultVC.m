//
//  SVUserAuthResultVC.m
//  ShortVideo
//
//  Created by klc_sl on 2021/4/14.
//  Copyright © 2021 KLC. All rights reserved.
//

#import "SVUserAuthResultVC.h"
#import <LibTools/LibTools.h>

@interface SVUserAuthResultVC ()

@end

@implementation SVUserAuthResultVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.navigationItem.title = kLocalizationMsg(@"认证中心");
    
    [self createUI];
}


- (void)createUI{
    
    UILabel *showTextL = [[UILabel alloc] initWithFrame:CGRectMake(15, 150, kScreenWidth-30, 20)];
    showTextL.font = [UIFont systemFontOfSize:14];
    showTextL.textAlignment = NSTextAlignmentCenter;
    showTextL.textColor = kRGBA_COLOR(@"#333333", 1.0);
    showTextL.text = kLocalizationMsg(@"恭喜，你已经成功认证");
    [self.view addSubview:showTextL];
    
}


@end
