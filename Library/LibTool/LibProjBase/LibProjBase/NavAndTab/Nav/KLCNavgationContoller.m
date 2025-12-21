//
//  KLCNavgationContoller.m
//  TCDemo
//
//  Created by klc_tqd on 2019/8/26.
//  Copyright © 2019 CH. All rights reserved.
//

#import "KLCNavgationContoller.h"
#import "PopupTool.h"

@interface KLCNavgationContoller ()

@end

@implementation KLCNavgationContoller

- (void)viewDidLoad {
    [super viewDidLoad];
    //
    //    self.transferNavigationBarAttributes = YES;
}

- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated {
    if (self.viewControllers.count == 1) {
        viewController.hidesBottomBarWhenPushed = YES;
    } else {
        viewController.hidesBottomBarWhenPushed = NO;
    }
    
    [PopupTool closeAllPopupView];
    [super pushViewController:viewController animated:animated];
}

- (NSArray<__kindof UIViewController *> *)popToRootViewControllerAnimated:(BOOL)animated {
    // 解决iOS 14 popToRootViewController tabbar不自动显示问题
    if (animated) {
        UIViewController *popController = self.viewControllers.lastObject;
        popController.hidesBottomBarWhenPushed = NO;
    }
    return [super popToRootViewControllerAnimated:animated];
}


@end



@implementation ContainerNVC

- (void)viewDidLoad {
    [super viewDidLoad];

}


@end
