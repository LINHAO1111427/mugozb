//
//  UIhelpTools.m
//  LibTools
//
//  Created by klc_sl on 2021/9/13.
//  Copyright © 2021 KLC. All rights reserved.
//

#import "UIhelpTools.h"

@implementation UIhelpTools


+ (CGFloat)getStatusBarHight {
    float statusBarHeight = 0;
    if (@available(iOS 13.0, *)) {
        UIStatusBarManager *statusBarManager = [UIApplication sharedApplication].windows.firstObject.windowScene.statusBarManager;
        statusBarHeight = statusBarManager.statusBarFrame.size.height;
    }
    else {
        statusBarHeight = [UIApplication sharedApplication].statusBarFrame.size.height;
    }
    return statusBarHeight;
}

+ (CGFloat)getTabbarSafeAreaHeight{
    CGFloat bottom=0.0;
    if (@available(iOS 11.0, *)) {
        bottom = [[UIApplication sharedApplication] delegate].window.safeAreaInsets.bottom;
    } else {
        bottom=0.0;
    }
    return bottom;
    
}




@end
