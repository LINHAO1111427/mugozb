//
//  NSString+AttriString.m
//  LibTools
//
//  Created by klc_sl on 2020/3/18.
//  Copyright © 2020 . All rights reserved.
//

#import "NSString+AttriString.h"
#import "NSString+Extend.h"

@implementation NSString (AttriString)

- (NSAttributedString *)attachmentForImage:(UIImage *)image bounds:(CGRect)rc before:(BOOL)before{
    return [self attachmentForImage:image bounds:rc before:before textFont:nil textColor:nil];
}

- (NSAttributedString *)attachmentForImage:(UIImage *)image bounds:(CGRect)rc before:(BOOL)before textFont:(UIFont *)font textColor:(UIColor *)color{
    
    ///图片
    NSTextAttachment *ImgAtt = [[NSTextAttachment alloc] init];
    ImgAtt.image = image;
    ImgAtt.bounds = rc;
    NSAttributedString *imgStr = [NSAttributedString attributedStringWithAttachment:ImgAtt];
    
    ///文字
    NSString *showStr = before?[NSString stringWithFormat:@" %@",self]:[NSString stringWithFormat:@"%@ ",self];
    NSAttributedString *attStr = [[NSAttributedString alloc] initWithString:showStr];
    
    ///拼接
    NSMutableAttributedString *muAttM = [[NSMutableAttributedString alloc] init];
    [muAttM appendAttributedString:attStr];
    
    if (font) {
        [muAttM setAttributes:@{NSFontAttributeName : font} range:NSMakeRange(0, showStr.length)];
    }
    if (color) {
        [muAttM setAttributes:@{NSForegroundColorAttributeName:color} range:NSMakeRange(0, showStr.length)];
    }
    
    before? [muAttM insertAttributedString:imgStr atIndex:0]:[muAttM appendAttributedString:imgStr];
    return [[NSAttributedString alloc] initWithAttributedString:muAttM];
}


- (NSAttributedString *)HTMLTextWithTextColor:(UIColor *)color{
    if (self.length>0 && ![self isKindOfClass:[NSNull class]]) {
        NSMutableAttributedString *muAttStr = [[NSMutableAttributedString alloc] initWithData:[self dataUsingEncoding:NSUnicodeStringEncoding] options:@{NSDocumentTypeDocumentAttribute: NSHTMLTextDocumentType,} documentAttributes:nil error:nil];
        [muAttStr setAttributes:@{NSForegroundColorAttributeName:color} range:NSMakeRange(0, muAttStr.length)];
        return muAttStr;
    }else{
        return [[NSAttributedString alloc] initWithString:self];
    }
}


- (NSAttributedString *)changeTextForCostomEmojiAndBounds:(CGRect)bounds{
    
    NSArray *resultArr  = [self machesWithEmoji];
    NSMutableAttributedString *attstr = [[NSMutableAttributedString alloc] initWithString:self];
    
    if (!resultArr) return attstr;
    
    NSUInteger lengthDetail = 0;
    //遍历所有的result 取出range
    for (NSTextCheckingResult *result in resultArr) {
        //取出图片名
        NSString *imageName =   [self substringWithRange:NSMakeRange(result.range.location, result.range.length)];
        NSTextAttachment *attach = [[NSTextAttachment alloc] init];
        NSString *imgPath= [[[NSBundle mainBundle] pathForResource:@"customEmoji" ofType:@"bundle"] stringByAppendingPathComponent:imageName];
        UIImage *emojiImage = [UIImage imageWithContentsOfFile:imgPath];
        NSAttributedString *imageString;
        if (emojiImage) {
            attach.image = emojiImage;
            //            CGRectMake(0, -2, 15, 15)
            attach.bounds = bounds;
            imageString =   [NSAttributedString attributedStringWithAttachment:attach];
        }else{
            if (imageName.length == 0) {
                imageName = @"";
            }
            imageString =   [[NSMutableAttributedString alloc]initWithString:imageName];
        }
        //图片附件的文本长度是1
        NSUInteger alength = attstr.length;
        NSRange newRange = NSMakeRange(result.range.location - lengthDetail, result.range.length);
        [attstr replaceCharactersInRange:newRange withAttributedString:imageString];
        
        lengthDetail += alength - attstr.length;
    }
    return attstr;
}

- (NSAttributedString *)strikethroughStyle{
    NSMutableAttributedString *newAttr = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"%@",self]];
    [newAttr addAttribute:NSStrikethroughStyleAttributeName value:@(NSUnderlinePatternSolid | NSUnderlineStyleSingle) range:NSMakeRange(0, self.length)];
    return newAttr;
}


/**
 空心字体
 @param textColor 文本颜色
 @param textBorderColor 文本边框颜色
 @param strokeWidth 文件边框宽度
 */
- (NSAttributedString *)textColor:(UIColor *)textColor textBorderColor:(UIColor *)textBorderColor strokeWidth:(CGFloat)strokeWidth
{
    NSDictionary *dict = @{
        NSStrokeColorAttributeName:textBorderColor,
        NSStrokeWidthAttributeName : [NSNumber numberWithFloat:strokeWidth],
        NSForegroundColorAttributeName:textColor
    };
    NSMutableAttributedString *attribtStr = [[NSMutableAttributedString alloc] initWithString:self attributes:dict];
    return attribtStr;
    
}



/// 设置文件间距
/// @param lineSpace 行间距
- (NSAttributedString *)lineSpace:(CGFloat)lineSpace{
    NSString *text = self;
    if (text.length == 0 || lineSpace < 0.01) {
        return [[NSAttributedString alloc] initWithString:@""];
    }

    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:text];
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    [paragraphStyle setLineSpacing:lineSpace];
    [paragraphStyle setLineBreakMode:NSLineBreakByCharWrapping];
    [attributedString addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, [text length])];
    
    return attributedString;
}

- (NSAttributedString *)lineSpace:(CGFloat)lineSpace wordSpace:(CGFloat)wordSpace{
    NSString *text = self;
    if (text.length == 0 || lineSpace < 0.01) {
        return [[NSAttributedString alloc] initWithString:@""];
    }
    
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:text attributes:@{NSKernAttributeName:@(wordSpace)}];
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    [paragraphStyle setLineBreakMode:NSLineBreakByCharWrapping];
    [paragraphStyle setLineSpacing:lineSpace];
    [paragraphStyle setParagraphSpacing:wordSpace];
    [attributedString addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, [text length])];
     
    return attributedString;
}

@end
