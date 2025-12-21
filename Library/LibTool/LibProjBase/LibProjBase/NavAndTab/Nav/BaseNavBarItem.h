//
//  BaseNavBarItem.h
//  emo
//
//  Created by admin on 2019/12/6.
//  Copyright © 2019 . All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface BaseNavBarItem : NSObject

///navigationbar上面的统一按钮
+ (UIView *)navItemTitle:(NSString *)title bgColor:(UIColor * __nullable)bgColor textColor:(UIColor * __nullable)textColor clickHandle:(void(^ __nullable)(void))handle;

///设定导航栏上带图片的按钮
+ (UIView *)navItemImageName:(NSString *)imageName clickHandle:(void(^ __nullable)(void))handle;

/// 设定导航栏背景图片
/// @param vc 控制起
/// @param image  不传图片默认为透明导航栏
/// @param color 不传文字颜色默认白色
+ (void)navbar:(UIViewController *)vc bgImage:(UIImage * _Nullable)image foregroundColor:(UIColor * __nullable)color;

///返回按钮
+ (UIView *)navBackBtnImage:(UIImage *)image target:(nullable id)target action:(SEL)action;

///右侧按钮
+ (UIView*)navBarWithImages:(NSArray*)images clickHandle:(void (^)(NSInteger index))handle;


///设置导航栏透明及前置颜色
+ (void)navBarBgClear:(UIViewController *)navi foregroundColor:(UIColor *__nullable)color;


// 统一设置导航栏外观
+ (void)setNavigationBarStyle;

@end

NS_ASSUME_NONNULL_END
