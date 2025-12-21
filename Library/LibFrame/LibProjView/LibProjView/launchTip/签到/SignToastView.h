//
//  SignToastView.h
//  HomePage
//
//  Created by klc on 2020/7/31.
//  Copyright © 2020 KLC. All rights reserved.
//

#import <UIKit/UIKit.h>
NS_ASSUME_NONNULL_BEGIN

typedef void (^_Nullable toastDissmissBlock)(BOOL isSignIn);


@interface SignToastView : UIView

/**手动点击签到按钮弹出I*/
+ (void)showSignViewWithComplition:(toastDissmissBlock)complition;

///自动显示签到页面（首页启动专用）
+ (void)launchAutoShowSign:(toastDissmissBlock)complition;

///个人中心判断是否签到过
+ (void)getUserIsSign:(toastDissmissBlock)complition;

@end

NS_ASSUME_NONNULL_END
