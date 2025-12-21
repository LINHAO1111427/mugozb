//
//  ForceAlertController.h
//  TCDemo
//
//  Created by admin on 2019/10/24.
//  Copyright © 2019 CH. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface ForceAlertController : UIViewController

@property (nonatomic, assign)BOOL force;  //是否强制
@property (nullable, nonatomic, readonly) NSArray<UITextField *> *textFields;


+ (id)alertTitle:(NSString *__nullable)title message:(NSString *__nullable)message;



- (void)addTextFieldWithConfigurationHandler:(void (^ __nullable)(UITextField *textField))configurationHandler;



- (void)addOptions:(NSString *)option textColor:(UIColor * __nullable)color clickHandle:(void(^ __nullable)(void))handle;

@end

NS_ASSUME_NONNULL_END
