//
//  UIColor+Extend.h
//  LibTools
//
//  Created by klc on 2020/6/1.
//  Copyright © 2020 . All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIColor (Extend)

- (UIImage *)imageWithColor;


- (NSString *)hexFromColor;

+ (UIColor *)colorWithHexStr:(NSString *)color;

+ (UIColor *)colorWithHexStr:(NSString *)color alpha:(CGFloat)alpha;

@end

NS_ASSUME_NONNULL_END
