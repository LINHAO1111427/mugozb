//
//  UIColor+Extend.m
//  LibTools
//
//  Created by klc on 2020/6/1.
//  Copyright © 2020 . All rights reserved.
//

#import "UIColor+Extend.h"

@implementation UIColor (Extend)


- (UIImage *)imageWithColor{
    
    CGRect rect = CGRectMake(0.0f, 0.0f, 1.0f, 1.0f);
    UIGraphicsBeginImageContextWithOptions(rect.size, NO, [UIScreen mainScreen].scale);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context,self.CGColor);
    CGContextFillRect(context, rect);
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
    
}


- (NSString *)hexFromColor{
    
    UIColor *color = self;
    
    if(CGColorGetNumberOfComponents(color.CGColor) < 4) {
        
        const CGFloat *components =CGColorGetComponents(color.CGColor);
        
        color = [UIColor colorWithRed:components[0]
                 
                               green:components[0]
                 
                                blue:components[0]
                 
                               alpha:components[1]];
        
    }
    
    if(CGColorSpaceGetModel(CGColorGetColorSpace(color.CGColor)) !=kCGColorSpaceModelRGB) {
        
        return [NSString stringWithFormat:@"#FFFFFF"];
        
    }
    
    NSString *r,*g,*b;
    
    (int)((CGColorGetComponents(color.CGColor))[0]*255.0) == 0?(r =[NSString stringWithFormat:@"0%x",(int)((CGColorGetComponents(color.CGColor))[0]*255.0)]):(r= [NSString stringWithFormat:@"%x",(int)((CGColorGetComponents(color.CGColor))[0]*255.0)]);
    
    (int)((CGColorGetComponents(color.CGColor))[1]*255.0)== 0?(g = [NSString stringWithFormat:@"0%x",(int)((CGColorGetComponents(color.CGColor))[1]*255.0)]):(g= [NSString stringWithFormat:@"%x",(int)((CGColorGetComponents(color.CGColor))[1]*255.0)]);
    
    (int)((CGColorGetComponents(color.CGColor))[2]*255.0)== 0?(b = [NSString stringWithFormat:@"0%x",(int)((CGColorGetComponents(color.CGColor))[2]*255.0)]):(b= [NSString stringWithFormat:@"%x",(int)((CGColorGetComponents(color.CGColor))[2]*255.0)]);
    
    return [NSString stringWithFormat:@"#%@%@%@",r,g,b];
    
    
}

// 內联函数，
static inline NSUInteger hexStrToInt(NSString *colorStr) {
    unsigned int result;
    [[NSScanner scannerWithString:colorStr] scanHexInt:&result];
    return result;
}

+ (UIColor *)colorWithHexStr:(NSString *)color {
    return [[self class] colorWithHexStr:color alpha:1.0f];
}

+ (UIColor *)colorWithHexStr:(NSString *)color alpha:(CGFloat)alpha {
    CGFloat red;
    CGFloat green;
    CGFloat blue;
    // 删除字符串中的空格，并转化为大写字母
    NSString *cString = [[color stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] uppercaseString];
    // 如果是 # 开头的，那么截取字符串，字符串从索引为 1 的位置开始，一直到末尾
    if ([cString hasPrefix:@"#"]) {
        cString = [cString substringFromIndex:1];
    }
    // 如果是 0x 开头的，那么截取字符串，字符串从索引为 2 的位置开始，一直到末尾
    if ([cString hasPrefix:@"0X"]) {
        cString = [cString substringFromIndex:2];
    }
    
    NSUInteger lenght = [cString length];
    // RGB  RGBA  RRGGBB  RRGGBBAA
    if (lenght != 3 &&
        lenght != 4 &&
        lenght != 6 &&
        lenght != 8) {
        return [UIColor clearColor];
    }
    
    // 将相应的字符串转换为数字
    if (lenght < 5) {
        red = hexStrToInt([cString substringWithRange:NSMakeRange(0, 1)]) / 255.0f;
        green = hexStrToInt([cString substringWithRange:NSMakeRange(1, 1)]) / 255.0f;
        blue = hexStrToInt([cString substringWithRange:NSMakeRange(2, 1)]) / 255.0f;
    } else {
        red = hexStrToInt([cString substringWithRange:NSMakeRange(0, 2)]) / 255.0f;
        green = hexStrToInt([cString substringWithRange:NSMakeRange(2, 2)]) / 255.0f;
        blue = hexStrToInt([cString substringWithRange:NSMakeRange(4, 2)]) / 255.0f;
    }
    return [UIColor colorWithRed:red green:green blue:blue alpha:alpha];
}

@end
