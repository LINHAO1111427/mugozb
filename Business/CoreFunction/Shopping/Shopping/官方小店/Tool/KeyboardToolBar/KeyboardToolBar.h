//
//  KeyboardToolBar.h
//  JFTX_WuHanPJJY
//
//  Created by YC on 16/11/29.
//  Copyright © 2016年 jf. All rights reserved.
/* 调用方法
 
 KeyboardToolBar *bar = [[KeyboardToolBar alloc]initWithArray:@[_phoneTf,_noteTF]];
 self.phoneTf.inputAccessoryView = bar;
 self.noteTF.inputAccessoryView = bar;
 
 */

#import <UIKit/UIKit.h>

@interface KeyboardToolBar : UIToolbar

- (instancetype)initWithArray:(NSArray *)array;

- (instancetype)initWithShowChangeButton:(BOOL)show;

/** tf数组 */
@property (strong, nonatomic) NSArray *array;
/** 上一步block */
@property (copy, nonatomic) void (^backBtnClickBlock)(void);
/** 下一步block */
@property (copy, nonatomic) void (^nextBtnClickBlock)(void);
/** 完成block */
@property (copy, nonatomic) void (^finishBtnClickBlock)(void);

@end
