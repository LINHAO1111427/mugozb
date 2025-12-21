//
//  Maker.m
//  匿名小纸条
//
//  Created by wuhanzexun on 2020/7/4.
//  Copyright © 2020 wuhanzexun. All rights reserved.
//

#import "Maker.h"

#import <CoreImage/CoreImage.h>

#import "LibTools.h"



@implementation Maker


+(UIView *)viewWithShadow:(BOOL)isShadow backColor:(UIColor*)color  superView:(nullable UIView *)superView constraints:(void(NS_NOESCAPE ^)(MASConstraintMaker *make))block{
    
    
    UIView *view = [[UIView alloc ] initWithFrame:CGRectZero];
    view.backgroundColor= color;
    if (superView) {
        
        [superView addSubview:view];
        [view mas_makeConstraints:block];
    }
    if (isShadow) {
        
        view.layer.shadowColor = [UIColor lightGrayColor].CGColor;
        view.layer.shadowOffset = CGSizeMake(10, 10);
        view.layer.shadowRadius = 5;
        view.layer.shadowOpacity = 0.8;
    }
    return  view;
    
}

+(UILabel *)labelWithShadow:(BOOL)isShadow alignment:(NSTextAlignment)alignment backColor:(UIColor*)color text:(NSString *)text textColor:(UIColor *)textColor font:(UIFont *)font  superView:(nullable UIView *)superView constraints:(void(NS_NOESCAPE ^)(MASConstraintMaker *make))block{
    
    
    UILabel *lab = [[UILabel alloc ] initWithFrame:CGRectZero];
    lab.backgroundColor= color;
    lab.text = text;
    lab.textColor = textColor;
    lab.font = font;
    lab.textAlignment = alignment;
    lab.clipsToBounds = YES;
    lab.numberOfLines = 0;
    if(superView) {
        
        [superView addSubview:lab];
        [lab mas_makeConstraints:block];
    }
    
    if (isShadow) {
        
        lab.layer.masksToBounds = YES;
        lab.layer.shadowColor = [UIColor lightGrayColor].CGColor;
        lab.layer.shadowOffset = CGSizeMake(10, 10);
        lab.layer.shadowRadius = 5;
        lab.layer.shadowOpacity = 1;
    }
    return  lab;
    
}
+(UIButton *)BtnWithShadow:(BOOL)isShadow backColor:(UIColor*)color text:(NSString *)text textColor:(UIColor *)textColor font:(UIFont *)font  superView:(nullable UIView *)superView constraints:(void(NS_NOESCAPE ^)(MASConstraintMaker *make))block{
    
    
    UIButton *lab = [[UIButton alloc ] initWithFrame:CGRectZero];
    lab.backgroundColor= color;
    [lab setTitle:text forState:0];
    [lab setTitleColor:textColor forState:0];
    lab.titleLabel.font = font;
    
    if(superView) {
        
        [superView addSubview:lab];
        [lab mas_makeConstraints:block];
    }
    if (isShadow) {
        
        lab.layer.masksToBounds = YES;
        lab.layer.shadowColor = [UIColor lightGrayColor].CGColor;
        lab.layer.shadowOffset = CGSizeMake(10, 10);
        lab.layer.shadowRadius = 5;
        lab.layer.shadowOpacity = 1;
    }
    return  lab;
}
+(UIImageView *)Imv:(nullable UIImage*)img layerCorner:(CGFloat)cornerRadius superView:(nullable UIView *)superView constraints:(void(NS_NOESCAPE ^)(MASConstraintMaker *make))block{
    
    UIImageView *imv = [[UIImageView alloc] init];
    imv.backgroundColor = kRGB_COLOR(@"#F6F7F9");
    imv.image = img;
    imv.layer.masksToBounds = YES;
    imv.layer.cornerRadius = cornerRadius;
    imv.contentMode = UIViewContentModeScaleAspectFill;
    if(superView) {
        
        [superView addSubview:imv];
        [imv mas_makeConstraints:block];
    }
    return imv;
}

+(UIImage *)generateQRCodeWithString:(NSString *)string Size:(CGFloat)size
{
    //创建过滤器
    CIFilter *filter = [CIFilter filterWithName:@"CIQRCodeGenerator"];
    //过滤器恢复默认
    [filter setDefaults];
    //给过滤器添加数据<字符串长度893>
    NSData *data = [string dataUsingEncoding:NSUTF8StringEncoding allowLossyConversion:YES];
    [filter setValue:data forKey:@"inputMessage"];
    //获取二维码过滤器生成二维码
    CIImage *image = [filter outputImage];
    UIImage *img = [self createNonInterpolatedUIImageFromCIImage:image WithSize:size];
    return img;
}
//二维码清晰
+(UIImage *)createNonInterpolatedUIImageFromCIImage:(CIImage *)image WithSize:(CGFloat)size
{
    CGRect extent = CGRectIntegral(image.extent);
    CGFloat scale = MIN(size/CGRectGetWidth(extent), size/CGRectGetHeight(extent));
    
    //创建bitmap
    size_t width = CGRectGetWidth(extent)*scale;
    size_t height = CGRectGetHeight(extent)*scale;
    CGColorSpaceRef cs = CGColorSpaceCreateDeviceGray();
    CGContextRef bitmapRef = CGBitmapContextCreate(nil, width, height, 8, 0, cs, (CGBitmapInfo)kCGImageAlphaNone);
    CIContext *context = [CIContext contextWithOptions:nil];
    CGImageRef bitmapImage = [context createCGImage:image fromRect:extent];
    CGContextSetInterpolationQuality(bitmapRef, kCGInterpolationNone);
    CGContextScaleCTM(bitmapRef, scale, scale);
    CGContextDrawImage(bitmapRef, extent, bitmapImage);
    
    //保存图片
    CGImageRef scaledImage = CGBitmapContextCreateImage(bitmapRef);
    CGColorSpaceRelease(cs);
    CGContextRelease(bitmapRef);
    CGImageRelease(bitmapImage);
    UIImage *returnImage = [UIImage imageWithCGImage:scaledImage];
    CGImageRelease(scaledImage);
    return returnImage;
}


+(UIImage *)screenShotView:(UIView *)view{
    
   UIGraphicsBeginImageContextWithOptions(view.frame.size, false, 0.0);
   [view.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *imageRet = UIGraphicsGetImageFromCurrentImageContext();
   UIGraphicsEndImageContext();

   return imageRet;
}

+(UIAlertController *)sheetAlertWith:(NSArray *)actionTitiles actionHandle:(ZHSheetAlertActionHandler)actionHandle{
    
    UIAlertController *alert=[UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    for (int i=0; i<actionTitiles.count; i++) {
        
        
        UIAlertAction *action = [UIAlertAction actionWithTitle:actionTitiles[i] style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            
            actionHandle(action,i);
        }];
        [alert addAction:action];
    }
    UIAlertAction *cancelAction=[UIAlertAction actionWithTitle:kLocalizationMsg(@"取消") style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        
        [alert dismissViewControllerAnimated:YES completion:nil];
    }];
    [alert addAction:cancelAction];
    return alert;
}
+(UIAlertController *_Nullable)alertWith:(NSString *_Nullable)title msg:(NSString *_Nonnull)msg actionHandle:( void (^ _Nullable )(UIAlertAction *action))actionHandle{
    
    UIAlertController *alert=[UIAlertController alertControllerWithTitle:title message:msg preferredStyle:UIAlertControllerStyleAlert];
    if (actionHandle) {
        
        UIAlertAction *cancelAction=[UIAlertAction actionWithTitle:kLocalizationMsg(@"取消") style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
            
            [alert dismissViewControllerAnimated:YES completion:nil];
        }];
        
        UIAlertAction *defaultAction = [UIAlertAction actionWithTitle:kLocalizationMsg(@"确定") style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            
            actionHandle(action);
        }];
        [alert addAction:cancelAction];
        [alert addAction:defaultAction];
    }else{
        
        UIAlertAction *defaultAction = [UIAlertAction actionWithTitle:kLocalizationMsg(@"知道了") style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            
            [alert dismissViewControllerAnimated:YES completion:nil];
        }];
        [alert addAction:defaultAction];
    }
    return  alert;
}



+ (UIStackView *)stackViewAxis:(UILayoutConstraintAxis)axis distribution:(UIStackViewDistribution)distribution alignment:(UIStackViewAlignment)alignment space:(CGFloat)space superView:(UIView *)superView constraints:(void (NS_NOESCAPE^)(MASConstraintMaker * _Nonnull))block{
    
    UIStackView *view = [UIStackView new];
    view.alignment = alignment;
    view.axis = axis;
    view.distribution = distribution;
    view.spacing = space;
    if (superView) {
        
        [superView addSubview:view];
        [view mas_makeConstraints:block];
    }
    return view;
}
@end
