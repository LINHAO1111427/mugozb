//
//  CustomNavBar.m
//  TCDemo
//
//  Created by admin on 2019/9/20.
//  Copyright © 2019 CH. All rights reserved.
//

#import "CustomNavBar.h"
#import "BaseNavBarItem.h"
#import <LibTools/LibTools.h>

@interface CustomNavBar ()

@end

@implementation CustomNavBar

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)dismissViewControllerAnimated:(BOOL)flag completion:(void (^)(void))completion{
    
    
}

- (void)presentViewController:(UIViewController *)viewControllerToPresent animated:(BOOL)flag completion:(void (^)(void))completion{
    
}


@end


@implementation UIViewController (CostomNavBar)


- (UIBarButtonItem *)rt_customBackItemWithTarget:(id)target action:(SEL)action{
    
    [BaseNavBarItem navbar:self bgImage:[UIImage imageWithColor:[UIColor whiteColor]] foregroundColor:nil];
    return [[UIBarButtonItem alloc] initWithCustomView:[BaseNavBarItem navBackBtnImage:[UIImage imageNamed:@"main_navbar_back_black"] target:target action:action]];

}


 
@end
