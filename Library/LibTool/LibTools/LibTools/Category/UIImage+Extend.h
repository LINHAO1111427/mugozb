//
//  UIImage+Extend.h
//  TCDemo
//
//  Created by admin on 2019/11/5.
//  Copyright © 2019 CH. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSInteger, GradientType) {
    GradientFromTopToBottom = 1,            //从上到下
    GradientFromLeftToRight,                //从左到右
    GradientFromLeftTopToRightBottom,       //从上到下
    GradientFromLeftBottomToRightTop        //从上到下
};


@interface UIImage (Extend)

+ (UIImage *)imageGifNamed:(NSString *)name;

+ (UIImage *)imageGifWithData:(NSData *)data;


/// 根据颜色创建渐变色图片
/// @param imageSize size
/// @param colors 渐变颜色列表
/// @param percents 渐变色改变位置
/// @param gradientType 类型
+ (UIImage *)createImageSize:(CGSize)imageSize gradientColors:(NSArray *)colors percentage:(NSArray *)percents gradientType:(GradientType)gradientType;

 
+ (UIImage *)imageWithColor:(UIColor *)color;


///NSString转换为UIImage
+ (UIImage *)stringToImage:(NSString *)string;


///按形状切割图像
- (UIImage *)roundedRectWith:(CGFloat)radius;


/// 获取网络图片尺寸(耗时操作)
/// @param URL url地址
+ (CGSize)getImageSizeWithURL:(id)URL;


/// 将图片压缩到指定大小内(非模糊)
/// @param maxLength 压缩目标大小(NSData的大小，单位：byte)
- (NSData *)compressWithMaxLength:(NSUInteger)maxLength;


+ (UIImage *)imageConvertFromView:(UIView *)view;


- (UIImage *)imageAlpha:(CGFloat)alpha;

@end

NS_ASSUME_NONNULL_END
