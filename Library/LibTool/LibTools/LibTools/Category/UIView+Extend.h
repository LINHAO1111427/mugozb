//
//  UIView+Extend.h
//  LibTools
//
//  Created by admin on 2020/1/17.
//  Copyright © 2020 . All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
//局部阴影
typedef enum :NSInteger{
    
    KLCShadowPathLeft,
    
    KLCShadowPathRight,
    
    KLCShadowPathLeftRight,//左右
    
    KLCShadowPathTop,

    KLCShadowPathBottom,
    
    KLCShadowPathTopBottom,//上下

    KLCShadowPathNoTop,
    
    KLCShadowPathAllSide

} KLCShadowPathSide;

@interface UIView (Extend)

- (void)cornerRadii:(CGSize)size byRoundingCorners:(UIRectCorner)corners;
/// 添加渐变色
- (void)addGradientColorWith:(NSArray *)gradientColors percentage:(NSArray *)percents;
/// 开始旋转动画
-(void)startRotateAnimating:(CGFloat)duration;
/// 结束旋转动画
-(void)stopRotateAnimating;

/**
 * shadowColor 阴影颜色
 *
 * shadowOpacity 阴影透明度，默认0
 *
 * shadowRadius  阴影半径，默认3
 *
 * shadowPathSide 设置哪一侧的阴影，
 
 * shadowPathWidth 阴影的宽度，

 */

-(void)shadowPathWith:(UIColor *)shadowColor shadowOpacity:(CGFloat)shadowOpacity shadowRadius:(CGFloat)shadowRadius shadowSide:(KLCShadowPathSide)shadowPathSide shadowPathWidth:(CGFloat)shadowPathWidth;
@end

NS_ASSUME_NONNULL_END
