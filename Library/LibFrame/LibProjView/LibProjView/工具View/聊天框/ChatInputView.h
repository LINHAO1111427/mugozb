//
//  ChatInputView.h
//  TCDemo
//
//  Created by admin on 2019/11/8.
//  Copyright © 2019 CH. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface ChatInputView : UIView


/// 获得显示视图
+ (UIView *)getInputViewWithPlaceholder:(NSString *)placeholder;



///设置完基本参数后调用此方法显示
+ (void)showInput:(NSString *)placeholder inputText:(void (^)(NSString *__nullable inputText))inputText;




@end

NS_ASSUME_NONNULL_END
