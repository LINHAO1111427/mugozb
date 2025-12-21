//
//  UIhelpTools.h
//  LibTools
//
//  Created by klc_sl on 2021/9/13.
//  Copyright © 2021 KLC. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <CoreGraphics/CoreGraphics.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIhelpTools : NSObject
///状态栏高度
+ (CGFloat)getStatusBarHight;
///tabbar安全距离
+ (CGFloat)getTabbarSafeAreaHeight;



@end

NS_ASSUME_NONNULL_END
