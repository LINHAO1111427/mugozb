//
//  UIButton+Style.h
//  LibTools
//
//  Created by admin on 2019/12/10.
//  Copyright © 2019 . All rights reserved.
//
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIButton (Style)

///自定义间距上图下文字
- (void)btnSetUpImgDownForSpace:(CGFloat)space;

//开始旋转动画
- (void)startRotationAnimation;

@end

NS_ASSUME_NONNULL_END
