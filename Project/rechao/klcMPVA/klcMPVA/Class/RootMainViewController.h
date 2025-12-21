//
//  RootMainViewController.h
//  TCDemo
//
//  Created by klc_tqd on 2019/8/26.
//  Copyright © 2019 CH. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface RootMainViewController : UIViewController <UIImagePickerControllerDelegate,UINavigationControllerDelegate>


- (UITabBarController *)createNewTabBar;

- (UIViewController *)rootLogin;


@end

NS_ASSUME_NONNULL_END
