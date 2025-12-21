//
//  MyBirthdaySplashView.h
//  LibProjView
//
//  Created by ssssssss on 2020/8/27.
//  Copyright © 2020 KLC. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef void (^BirthdaySplashBlock)(BOOL isSucess);
@interface MyBirthdaySplashView : UIView

+ (void)showBirthdaySplashComplete:(BirthdaySplashBlock)complete;

@end

NS_ASSUME_NONNULL_END
