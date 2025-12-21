//
//  BasicViewController.m
//  UserInfo
//
//  Created by ssssssss on 2020/1/3.
//

#import "BasicViewController.h"

@interface BasicViewController ()

@end

@implementation BasicViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
   
}
- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    [self showNavBarBottomLine];
}
- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [self hideNavBarBottomLine];
}
#pragma mark - 导航栏底部线
- (UIImageView *)foundNavigationBarBottomLine:(UIView *)view {
    if ([view isKindOfClass:UIImageView.class] && view.bounds.size.height <= 1.0) {
        return (UIImageView *)view;
    }
    for (UIView *subview in view.subviews) {
        UIImageView *imageView = [self foundNavigationBarBottomLine:subview];
        if (imageView) {
            return imageView;
        }
    }
    return nil;
}

 
- (void)showNavBarBottomLine {
    UIImageView *bottomLine = [self foundNavigationBarBottomLine:self.navigationController.navigationBar];
    if (bottomLine) {
        bottomLine.hidden = YES;
    }
   
    UIImageView *navLine = [self.navigationController.navigationBar.subviews[0] viewWithTag:5757];
    if (navLine) {
        navLine.hidden = NO;
        CGRect bottomLineFrame = bottomLine.frame;
        bottomLineFrame.origin.y = CGRectGetMaxY(self.navigationController.navigationBar.frame);
        navLine.frame = bottomLineFrame;
    }else {
        CGRect bottomLineFrame = bottomLine.frame;
        bottomLineFrame.origin.y = CGRectGetMaxY(self.navigationController.navigationBar.frame);
        UIImageView *navLine = [[UIImageView alloc] initWithFrame:bottomLineFrame];
        navLine.tag = 5757;
        navLine.height = 0.5;
        navLine.backgroundColor = [UIColor colorWithRed:222/255.0 green:222/255.0 blue:222/255.0 alpha:1.0];
        if (self.navigationController.navigationBar.subviews.count) {
            [self.navigationController.navigationBar.subviews[0] addSubview:navLine];
        }else{
            bottomLine.hidden = NO;
        }
    }
}
 
- (void)hideNavBarBottomLine {
    UIImageView *bottomLine = [self foundNavigationBarBottomLine:self.navigationController.navigationBar];
    if (bottomLine) {
        bottomLine.hidden = YES;
    }
    UIImageView *navLine = [self.navigationController.navigationBar.subviews[0] viewWithTag:5757];
    if (navLine) {
        navLine.hidden = YES;
    }
}


@end
