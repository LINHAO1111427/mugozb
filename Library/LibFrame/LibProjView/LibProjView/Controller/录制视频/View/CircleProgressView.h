//
//  CircleProgressView.h
//  LibProjView
//
//  Created by klc on 2020/6/13.
//  Copyright © 2020 . All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface CircleProgressView : UIView
@property(nonatomic,assign)CGFloat progress; // 进度值


-(instancetype)initWithFrame:(CGRect)frame withRadius:(CGFloat)radius withLineWidth:(CGFloat)lineWidth defaultColor:(UIColor*)defaultColor progressColor:(UIColor *)progressColor;

-(void)updateProgress:(CGFloat)progress;

@end

NS_ASSUME_NONNULL_END
