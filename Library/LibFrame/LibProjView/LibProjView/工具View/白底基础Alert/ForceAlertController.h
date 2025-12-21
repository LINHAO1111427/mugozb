//
//  ForceAlertController.h
//  TCDemo
//
//  Created by admin on 2019/10/24.
//  Copyright © 2019 CH. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN


typedef NS_ENUM(NSUInteger, ForceAlertBtnTextColor) {
    ForceAlert_BlackColor,  ///黑色
    ForceAlert_NormalColor,   ///系统通用颜色
    ForceAlert_OrangeColor,  ///橙色
    ForceAlert_CustomColor  ///其他自定义颜色
    
};


@interface ForceAlertController : UIViewController

@property (nonatomic, assign)BOOL force;  //是否强制
@property (nullable, nonatomic, readonly) NSArray<UITextField *> *textFields;


+ (id)alertTitle:(NSString *__nullable)title message:(NSString *__nullable)message;



- (void)addTextFieldWithConfigurationHandler:(void (^ __nullable)(UITextField *textField))configurationHandler;



- (void)addOptions:(NSString *)option textColor:(ForceAlertBtnTextColor)color clickHandle:(void(^ __nullable)(void))handle;


/// 自定义颜色
/// @param option 选项
/// @param color 颜色
/// @param handle 回调
- (void)addOptions:(NSString *)option textUIColor:(UIColor *)color clickHandle:(void(^ __nullable)(void))handle;

@end

NS_ASSUME_NONNULL_END
