//
//  UIButton+Style.m
//  LibTools
//
//  Created by admin on 2019/12/10.
//  Copyright © 2019 . All rights reserved.
//

#import "UIButton+Style.h"
@implementation UIButton (Style)

//自定义间距上图下文字

- (void)btnSetUpImgDownForSpace:(CGFloat)space{
    
    CGFloat totalH = self.imageView.frame.size.height + self.titleLabel.intrinsicContentSize.height;
    CGFloat spaceH = space;
    //设置按钮图片偏移
    [self setImageEdgeInsets:UIEdgeInsetsMake(-(totalH - self.imageView.frame.size.height),0.0, 0.0, -self.titleLabel.intrinsicContentSize.width)];
    //设置按钮标题偏移
    [self setTitleEdgeInsets:UIEdgeInsetsMake(spaceH, -self.imageView.frame.size.width, -(totalH - self.titleLabel.intrinsicContentSize.height),0.0)];
    
}
- (void)startRotationAnimation{
    CABasicAnimation* rotationAnimation;
    rotationAnimation = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
    rotationAnimation.toValue = [NSNumber numberWithFloat: M_PI*5];
    rotationAnimation.duration = 1.5;
    // rotationAnimation.cumulative = YES;
    // rotationAnimation.autoreverses=NO;
    //防止动画结束回到原始位置
    rotationAnimation.removedOnCompletion = YES;
    rotationAnimation.fillMode = kCAFillModeForwards;
    rotationAnimation.repeatCount = 1;//重复次数
    [self.imageView.layer addAnimation:rotationAnimation forKey:@"rotationAnimation"];
}
 
 


@end
