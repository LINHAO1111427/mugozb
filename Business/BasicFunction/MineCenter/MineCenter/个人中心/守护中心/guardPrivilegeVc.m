//
//  guardPrivilegeVc.m
//  MineCenter
//
//  Created by ssssssss on 2020/12/15.
//  Copyright © 2020 KLC. All rights reserved.
// 守护特权

#import "guardPrivilegeVc.h"
#import <LibProjView/guardPrivilegeView.h>

@interface guardPrivilegeVc ()
@end

@implementation guardPrivilegeVc

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = kLocalizationMsg(@"守护特权");
    self.view.backgroundColor = [UIColor whiteColor];
    guardPrivilegeView *guardV = [[guardPrivilegeView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight-kNavBarHeight) from:NO contentY:0];
    guardV.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:guardV];
}

 
@end
