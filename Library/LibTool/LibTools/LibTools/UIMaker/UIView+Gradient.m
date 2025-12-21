//
//  UIView+Gradient.m
//  匿名小纸条
//
//  Created by wuhanzexun on 2020/7/21.
//  Copyright © 2020 wuhanzexun. All rights reserved.
//

#import "UIView+Gradient.h"
#import <objc/runtime.h>

@interface UIView ()

@property(nonatomic,strong)CAGradientLayer *gLayer;

@end


@implementation UIView (Gradient)




-(void)setColors:(NSArray<UIColor *> *)colors{
    
    NSMutableArray *arr = [NSMutableArray array];
    [colors enumerateObjectsUsingBlock:^(UIColor * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
       
        [arr addObject:(id)obj.CGColor];
    }];
    ((CAGradientLayer *)self.layer).locations = @[@0,@1];
    ((CAGradientLayer *)self.layer).startPoint = CGPointMake(0, 0);
    ((CAGradientLayer *)self.layer).endPoint = CGPointMake(1, 1);
    ((CAGradientLayer *)self.layer).colors = arr;
    objc_setAssociatedObject(self, @selector(colors), colors, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
-(NSArray<UIColor *> *)colors{
    
    return objc_getAssociatedObject(self, _cmd);
}

+(Class)layerClass{
    
    return [CAGradientLayer class];
}




@end
