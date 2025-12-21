//
//  Maker.h
//  匿名小纸条
//
//  Created by wuhanzexun on 2020/7/4.
//  Copyright © 2020 wuhanzexun. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <Masonry/Masonry.h>
#import "UIView+Gradient.h"




NS_ASSUME_NONNULL_BEGIN

typedef void(^ZHSheetAlertActionHandler)(UIAlertAction * _Nullable action,NSUInteger index);



@interface Maker : NSObject

+(UIView *)viewWithShadow:(BOOL)isShadow backColor:(UIColor*)color  superView:(nullable UIView *)superView constraints:(void(NS_NOESCAPE ^)(MASConstraintMaker *make))block;

+(UILabel *)labelWithShadow:(BOOL)isShadow alignment:(NSTextAlignment)alignment backColor:(UIColor*)color text:(NSString *)text textColor:(UIColor *)textColor font:(UIFont *)font  superView:(nullable UIView *)superView constraints:(void(NS_NOESCAPE ^)(MASConstraintMaker *make))block;

+(UIButton *)BtnWithShadow:(BOOL)isShadow backColor:(UIColor*)color text:(NSString *)text textColor:(UIColor *)textColor font:(UIFont *)font  superView:(nullable UIView *)superView constraints:(void(NS_NOESCAPE ^)(MASConstraintMaker *make))block;

+(UIImageView *)Imv:(nullable UIImage*)img layerCorner:(CGFloat)cornerRadius superView:(nullable UIView *)superView constraints:(void(NS_NOESCAPE ^)(MASConstraintMaker *make))block;

+(UIStackView *)stackViewAxis:(UILayoutConstraintAxis)axis distribution:(UIStackViewDistribution)distribution alignment:(UIStackViewAlignment)alignment space:(CGFloat)space superView:(nullable UIView *)superView constraints:(void(NS_NOESCAPE ^)(MASConstraintMaker *make))block;

/**生成二维码*/
+(UIImage *)generateQRCodeWithString:(NSString *)string Size:(CGFloat)size;

/**截图*/
+(UIImage *)screenShotView:(UIView *)view;


+(UIAlertController *_Nullable)sheetAlertWith:(NSArray *_Nullable)actionTitiles actionHandle:(ZHSheetAlertActionHandler _Nullable )actionHandle;


+(UIAlertController *_Nullable)alertWith:(NSString *_Nullable)title msg:(NSString *_Nonnull)msg actionHandle:( void (^ _Nullable )(UIAlertAction *action))actionHandle;




@end

NS_ASSUME_NONNULL_END
