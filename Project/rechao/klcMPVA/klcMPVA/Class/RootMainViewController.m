//
//  RootMainViewController.m
//  TCDemo
//
//  Created by klc_tqd on 2019/8/26.
//  Copyright © 2019 CH. All rights reserved.
//

#import "RootMainViewController.h"

#import <LibProjBase/LibProjBase.h>
#import <LibProjBase/KLCTabBarControl.h>
#import <LibProjBase/KLCNavgationContoller.h>

#import "HomeMainViewController.h"
#import <MessageInfo/MessageMainVC.h>
#import <MineCenter/MineCenterViewController.h>

#import "DemoRouteRegister.h"

@interface RootMainViewController ()

@end

@implementation RootMainViewController

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.view.backgroundColor = [UIColor whiteColor];
        [DemoRouteRegister registerRoute];
    }
    return self;
}

- (UITabBarController *)createNewTabBar{
    
    HomeMainViewController *homeVC = [[HomeMainViewController alloc] init];
    homeVC.typeArr = [self homeTitleTypeArr];
    homeVC.homeDefaultSelectedIndex = 0;
    KLCNavgationContoller *firstNavigationController = [[KLCNavgationContoller alloc] initWithRootViewController:homeVC];
    
    MessageMainVC *messageVC = [[MessageMainVC alloc] init];
    KLCNavgationContoller *secondNavigationController = [[KLCNavgationContoller alloc] initWithRootViewController:messageVC];
    
    MineCenterViewController *fifthViewController = [[MineCenterViewController alloc] init];
    fifthViewController.hasPublishBtn = NO;
    KLCNavgationContoller *thirdNavigationController = [[KLCNavgationContoller alloc] initWithRootViewController:fifthViewController];
    
    
    KLCTabBarControl *tabBarC = [KLCTabBarControl share];
    
    [tabBarC clearItem];
    
    tabBarC.hidden_shadow_line = NO;
    tabBarC.translucent_tabbar = NO;
    tabBarC.item_click_status = CYLTabBarClickForScale;
    tabBarC.colorRGB_normal_text = kRGB_COLOR(@"#7F8389");
    tabBarC.colorRGB_select_text = kRGB_COLOR(@"#FF5EC6");
    
    tabBarC.plus_status = CYLTabBarPlusNone;
    
    [tabBarC addController:firstNavigationController title:kLocalizationMsg(@"房间")
                  imageStr:@"tabbar_live_normal" selectImageStr:@"tabbar_live_selected"];
    
    [tabBarC addController:secondNavigationController title:kLocalizationMsg(@"消息")
                  imageStr:@"tabbar_message_normal" selectImageStr:@"tabbar_message_selected"];
    
    [tabBarC addController:thirdNavigationController title:kLocalizationMsg(@"我的")
                  imageStr:@"tabbar_mine_normal" selectImageStr:@"tabbar_mine_selected"];
    
    

    tabBarC.tabBarDidSelect = ^(NSInteger item, UIViewController * _Nonnull vc) {
        [[NSNotificationCenter defaultCenter] postNotificationName:NotificationUpdateStatus object:nil];
    };

    [BaseNavBarItem setNavigationBarStyle];
    
    return [tabBarC getTabBarC];
}

- (KLCNavgationContoller *)rootLogin{
    LoginViewController *loginVC = [[LoginViewController alloc] init];
    KLCNavgationContoller *loginNVC =  [[KLCNavgationContoller alloc] initWithRootViewController:loginVC];
    return loginNVC;
}

- (void)viewDidLoad{
    [super viewDidLoad];
}


- (NSArray *)homeTitleTypeArr{
    NSMutableArray *mutArr = [NSMutableArray array];
    [mutArr addObject:@{@"homeType":@"0",@"title":kLocalizationMsg(@"推荐")}];
    // 分类浏览（语音房广场）
    [mutArr addObject:@{@"homeType":@"2",@"title":kLocalizationMsg(@"分类")}];
    return [NSArray arrayWithArray:mutArr];
}


@end
