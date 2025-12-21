//
//  KeyboardToolBar.m
//  JFTX_WuHanPJJY
//
//  Created by YC on 16/11/29.
//  Copyright © 2016年 jf. All rights reserved.
//

#import "KeyboardToolBar.h"

#define RGB_COLOR(r, g, b)       [UIColor colorWithRed:(r)/255.0f green:(g)/255.0f blue:(b)/255.0f alpha:1.0]
#define RGBA_COLOR(r, g, b, a)   [UIColor colorWithRed:r/255.0f green:g/255.0f blue:b/255.0f alpha:a]

#define kSCREEN_WIDTH    ([UIScreen mainScreen].bounds.size.width)
#define kSCREEN_HEIGHT   ([UIScreen mainScreen].bounds.size.height)

@interface KeyboardToolBar()


@end

@implementation KeyboardToolBar

- (instancetype)initWithShowChangeButton:(BOOL)show {
    
    self = [[KeyboardToolBar alloc]initWithFrame:CGRectMake(0,0, kSCREEN_WIDTH,35)];
    [self layoutIfNeeded];
    UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(kSCREEN_WIDTH - 60, 5,50, 25)];
    button.titleLabel.font = [UIFont systemFontOfSize:17];
    [button setTitle:kLocalizationMsg(@"完成") forState:UIControlStateNormal];
    [button setTitleColor:RGB_COLOR(26, 141, 248) forState:UIControlStateNormal];
    button.layer.borderColor = RGB_COLOR(26, 141, 248).CGColor;
//    button.layer.borderWidth = 1;
//    button.layer.cornerRadius = 3;
    [button addTarget:self action:@selector(finishBtnClick)forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:button];
    
    if (show) {
//        UIButton *backBtn = [[UIButton alloc]initWithFrame:CGRectMake(20, 5, 50, 25)];
//        backBtn.titleLabel.font = [UIFont systemFontOfSize:14];
//        [backBtn setTitle:kLocalizationMsg(@"上一步") forState:UIControlStateNormal];
//        [backBtn setTitleColor:RGB_COLOR(26, 141, 248) forState:UIControlStateNormal];
//        [self addSubview:backBtn];
//        [backBtn addTarget:self action:@selector(backBtnClick)forControlEvents:UIControlEventTouchUpInside];
        
        UIButton *nextBtn = [[UIButton alloc]initWithFrame:CGRectMake(kSCREEN_WIDTH - 160, 5, 80, 25)];
        nextBtn.titleLabel.font = [UIFont systemFontOfSize:14];
        nextBtn.titleLabel.textAlignment = NSTextAlignmentRight;
        [nextBtn setTitle:kLocalizationMsg(@"下一步") forState:UIControlStateNormal];
        [nextBtn setTitleColor:RGB_COLOR(26, 141, 248) forState:UIControlStateNormal];
        [self addSubview:nextBtn];
        [nextBtn addTarget:self action:@selector(nextBtnClick)forControlEvents:UIControlEventTouchUpInside];
    }
    
    return self;
}

- (instancetype)initWithArray:(NSArray *)array {
    self = [[KeyboardToolBar alloc]initWithFrame:CGRectMake(0,0, kSCREEN_WIDTH,35)];
    [self layoutIfNeeded];
    _array = array;
    UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(kSCREEN_WIDTH - 60, 0,50, 35)];
    button.titleLabel.font = [UIFont systemFontOfSize:18];
    [button setTitle:kLocalizationMsg(@"完成") forState:UIControlStateNormal];
    [button setTitleColor:RGB_COLOR(26, 141, 248) forState:UIControlStateNormal];
//    button.layer.borderColor = RGB_COLOR(26, 141, 248).CGColor;
//    button.layer.borderWidth = 1;
//    button.layer.cornerRadius = 3;
    [button addTarget:self action:@selector(finishBtnClick)forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:button];
    
    if (array.count >= 2) {
//        UIButton *backBtn = [[UIButton alloc]initWithFrame:CGRectMake(20, 5, 50, 25)];
//        backBtn.titleLabel.font = [UIFont systemFontOfSize:14];
//        [backBtn setTitle:kLocalizationMsg(@"上一步") forState:UIControlStateNormal];
//        [backBtn setTitleColor:RGB_COLOR(26, 141, 248) forState:UIControlStateNormal];
//        [self addSubview:backBtn];
//        [backBtn addTarget:self action:@selector(backBtnClick)forControlEvents:UIControlEventTouchUpInside];
        
        UIButton *nextBtn = [[UIButton alloc]initWithFrame:CGRectMake(kSCREEN_WIDTH - 160, 5, 80, 25)];
        nextBtn.titleLabel.font = [UIFont systemFontOfSize:14];
        nextBtn.titleLabel.textAlignment = NSTextAlignmentRight;
        [nextBtn setTitle:kLocalizationMsg(@"下一步") forState:UIControlStateNormal];
        [nextBtn setTitleColor:RGB_COLOR(26, 141, 248) forState:UIControlStateNormal];
        [self addSubview:nextBtn];
        [nextBtn addTarget:self action:@selector(nextBtnClick)forControlEvents:UIControlEventTouchUpInside];
    }
    return self;
}

- (void)finishBtnClick {
    [_array enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        UITextField *tf = self->_array[idx];
        [tf resignFirstResponder];
    }];
    if (self.finishBtnClickBlock) {
        self.finishBtnClickBlock();
    }
}

- (void)backBtnClick {
    [_array enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        UITextField *tf = self->_array[idx];
        if ([tf isFirstResponder] && tf != self->_array.firstObject) {
            UITextField *nextTf = self->_array[idx - 1];
            [nextTf becomeFirstResponder];
            *stop = YES;
        } else {
            [tf resignFirstResponder];
        }
    }];
    if (self.backBtnClickBlock) {
        self.backBtnClickBlock();
    }
}

- (void)nextBtnClick {
    [_array enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        UITextField *tf = self->_array[idx];
        if ([tf isFirstResponder] && tf != self->_array.lastObject) {
            UITextField *nextTf = self->_array[idx + 1];
            [nextTf becomeFirstResponder];
            *stop = YES;
        } else {
            [tf resignFirstResponder];
        }
    }];
    if (self.nextBtnClickBlock) {
        self.nextBtnClickBlock();
    }
}

@end
