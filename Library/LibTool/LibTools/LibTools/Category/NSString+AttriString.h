//
//  NSString+AttriString.h
//  LibTools
//
//  Created by klc_sl on 2020/3/18.
//  Copyright © 2020 . All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSString (AttriString)


/// 文字前后添加图片 一字一图
/// @param image 图片
/// @param rc 图片尺寸
/// @param before 图片的位置是前是后
- (NSAttributedString *)attachmentForImage:(UIImage *)image bounds:(CGRect)rc before:(BOOL)before;


/// 文字前后添加图片 一字一图
/// @param image 图片
/// @param rc 图片尺寸
/// @param before 图片的前后位置
/// @param font 文字
/// @param color 颜色
- (NSAttributedString *)attachmentForImage:(UIImage *)image bounds:(CGRect)rc before:(BOOL)before textFont:(UIFont * __nullable)font textColor:(UIColor * __nullable)color;


///转换html标签
- (NSAttributedString *)HTMLTextWithTextColor:(UIColor *)color;

///匹配emoji图标
- (NSAttributedString *)changeTextForCostomEmojiAndBounds:(CGRect)bounds;


///文字中间添加横线(删除线)
- (NSAttributedString *)strikethroughStyle;


/**
 空心字体
 @param textColor 文本颜色
 @param textBorderColor 文本边框颜色
 @param strokeWidth 文件边框宽度 (strokeWidth 要设置为负数，设置正数没有效果。)
 */
- (NSAttributedString *)textColor:(UIColor *)textColor textBorderColor:(UIColor *)textBorderColor strokeWidth:(CGFloat)strokeWidth;



/// 设置文字的行间距
/// @param lineSpace 行间距
- (NSAttributedString *)lineSpace:(CGFloat)lineSpace;


/// 设置文字行间距和文字间距
/// @param lineSpace 行间距
/// @param wordSpace 文字间距
- (NSAttributedString *)lineSpace:(CGFloat)lineSpace wordSpace:(CGFloat)wordSpace;


@end

NS_ASSUME_NONNULL_END
