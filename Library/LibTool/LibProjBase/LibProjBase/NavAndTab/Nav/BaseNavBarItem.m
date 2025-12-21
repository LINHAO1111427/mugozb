//
//  BaseNavBarItem.m
//  emo
//
//  Created by admin on 2019/12/6.
//  Copyright © 2019 . All rights reserved.
//

#import "BaseNavBarItem.h"
#import <LibTools/UIView+Blocks.h>
#import <LibTools/UIImage+Extend.h>
#import "ProjConfig.h"
#import <LibTools/LibTools.h>

@implementation BaseNavBarItem


+ (UIView *)navItemTitle:(NSString *)title bgColor:(UIColor *)bgColor textColor:(UIColor *)textColor clickHandle:(void (^)(void))handle{
    UIButton *btn = [UIButton buttonWithType:0];
    btn.layer.masksToBounds=YES;
    btn.layer.cornerRadius = 4.0;
    CGSize size = [title sizeWithAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:14]}];
    btn.frame = CGRectMake(0, 0, size.width+15, 18);
    btn.backgroundColor = bgColor?bgColor:[UIColor clearColor];
    [btn setTitle:title forState:UIControlStateNormal];
    [btn setTitleColor:textColor?textColor:[UIColor whiteColor] forState:UIControlStateNormal];
    btn.titleLabel.font = [UIFont systemFontOfSize:14];
    [btn klc_whenTapped:^{
        if(handle){
            handle();
        }
    }];
    return btn;
}

+ (UIView *)navItemImageName:(NSString *)imageName clickHandle:(void (^)(void))handle{
    UIButton *btn = [UIButton buttonWithType:0];
    [btn setImage:[[UIImage imageNamed:imageName] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    btn.frame = CGRectMake(0, 0, 40, 40);
    btn.imageView.contentMode = UIViewContentModeScaleAspectFit;
    [btn setImageEdgeInsets:UIEdgeInsetsMake(6, 10, 6, 2)];
    [btn klc_whenTapped:^{
        if(handle){
            handle();
        }
    }];
    return btn;
}

+ (void)navbar:(UIViewController *)vc bgImage:(UIImage *)image foregroundColor:(UIColor *)color{
    [self navbar:vc foregroundColor:color isBgClear:NO bgImage:image];
}


///设置背景图片
+ (void)navbar:(UIViewController *)vc foregroundColor:(UIColor *)color isBgClear:(BOOL)isBgClear bgImage:(UIImage *)bgImage{
    
    //    UIImage *naviBgImage = image?image:[UIImage imageWithColor:[UIColor whiteColor]];
    UIImage *naviBgImage = isBgClear?[UIImage imageNamed:@"main_navbar_transparent"]:(bgImage?bgImage:[UIImage imageWithColor:[UIColor whiteColor]]);
    
    naviBgImage = [naviBgImage resizableImageWithCapInsets:UIEdgeInsetsZero resizingMode:UIImageResizingModeStretch];
    /** 设置导航栏背景图片 */
    UINavigationController *nvc = [vc isKindOfClass:[UINavigationController class]]? (UINavigationController *)vc:vc.navigationController;
    
    [nvc.navigationBar setBackgroundImage:naviBgImage forBarMetrics:UIBarMetricsDefault];
    nvc.navigationBar.backIndicatorImage = nil;
    nvc.navigationBar.backIndicatorTransitionMaskImage = nil;
    
    nvc.navigationBar.titleTextAttributes= @{NSForegroundColorAttributeName:color?color:[ProjConfig projNavTitleColor]};
    
    if (@available(iOS 13.0, *)) {
        
        if (!isBgClear) {
            
            UINavigationBarAppearance *barAppearance = [[UINavigationBarAppearance alloc] init];
            if (vc.navigationController.navigationBar.isTranslucent) {
                UIColor *barTintColor = vc.navigationController.navigationBar.barTintColor;
                barAppearance.backgroundColor = [barTintColor colorWithAlphaComponent:0.85];
            } else {
                barAppearance.backgroundColor = vc.navigationController.navigationBar.barTintColor;
            }
            barAppearance.titleTextAttributes = vc.navigationController.navigationBar.titleTextAttributes;
            
            
            barAppearance.backgroundImage = naviBgImage;
            barAppearance.backgroundColor = [UIColor clearColor];
            [barAppearance setBackIndicatorImage:nil transitionMaskImage:nil];
            barAppearance.shadowImage = [UIImage imageWithColor:[UIColor clearColor]];
            
            
            /// 常规页面
            vc.navigationController.navigationBar.standardAppearance = barAppearance;
            /// 带scroll滑动的页面
            vc.navigationController.navigationBar.scrollEdgeAppearance = barAppearance;
        }
        
    }
}


+ (UIView *)navBackBtnImage:(UIImage *)image target:(id)target action:(SEL)action{
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = CGRectMake(0, 0, 40, 40);
    [btn setImage:image forState:UIControlStateNormal];
    [btn setContentEdgeInsets:UIEdgeInsetsMake(14, 0, 14, 28)];
    btn.imageView.contentMode = UIViewContentModeScaleAspectFit;
    [btn addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    
    return btn;
}

+(UIView*)navBarWithImages:(NSArray*)images clickHandle:(void (^)(NSInteger index))handle{
    UIView *rightButtonView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, images.count*40, 40)];
    for (int i = 0; i < images.count; i++) {
        NSDictionary *dic = images[i];
        NSInteger index = [dic[@"index"] integerValue];
        NSString *imageName = dic[@"image"];
        UIButton *btn = [[UIButton alloc]initWithFrame:CGRectMake(40*i, 0, 40, 40)];
        btn.tag = index;
        [btn setImage:[UIImage imageNamed:imageName] forState:UIControlStateNormal];
        [btn klc_whenTapped:^{
            if(handle){
                handle(btn.tag);
            }
        }];
        [btn setContentHorizontalAlignment:UIControlContentHorizontalAlignmentRight];
        [rightButtonView addSubview:btn];
    }
    return rightButtonView;
}


+ (void)navBarBgClear:(UIViewController *)navi foregroundColor:(UIColor *)color {
    [self navbar:navi foregroundColor:color isBgClear:YES bgImage:nil];
}


+ (void)setNavigationBarStyle
{
    UINavigationBar *navBar = [UINavigationBar appearance];
    UIImage *naviBgImage = [UIImage imageWithColor:[UIColor whiteColor]];
    naviBgImage = [naviBgImage resizableImageWithCapInsets:UIEdgeInsetsZero resizingMode:UIImageResizingModeStretch];
    /** 设置导航栏背景图片 */
    [navBar setBackgroundImage:naviBgImage forBarMetrics:UIBarMetricsDefault];
    /** 设置导航栏标题文字颜色 */
    NSDictionary *dict = @{
        NSForegroundColorAttributeName : [ProjConfig projNavTitleColor]
    };
    [navBar setTitleTextAttributes:dict];
    
    navBar.hidden = NO;
    navBar.shadowImage = [UIImage new];
    navBar.contentMode = UIViewContentModeScaleAspectFill;
    navBar.translucent = NO;
    
    navBar.backIndicatorImage = [UIImage new] ;
    navBar.backIndicatorTransitionMaskImage =  [UIImage new];

}

@end
