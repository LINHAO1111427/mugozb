//
//  ZQAlterField.h
//  ZQAlterFieldDemo
//
//  Created by 肖兆强 on 2018/2/6.
//  Copyright © 2018年 ZQ. All rights reserved.
//

#import <UIKit/UIKit.h>


typedef NS_ENUM(NSUInteger, styleType) {
    ///默认
    defaultStyle,
    ///邀请码 （必填样式）
    regCodeStyle,
    ///邀请码 （非必填样式）
    noRegCodeStyle,
  
};

//输入内容回调
typedef void(^ensureCallback)(NSString *inputString);
typedef void(^cancelBack)(void);


@interface ZQAlterField : UIView

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UIView *textFieldBG;

@property (weak, nonatomic) IBOutlet UITextField *textField;

@property (weak, nonatomic) IBOutlet UIButton *ensureBtn;

@property (weak, nonatomic) IBOutlet UIButton *mustFillBtn;

/**
 按钮颜色
 */
@property (nonatomic, strong) UIColor *ensureBgColor;

/**
 输入框背景色
 */
@property (nonatomic, strong) UIColor *textFieldBgColor;


/**
 字体颜色
 */
@property (nonatomic, strong) UIColor *textColor;

/**
 标题颜色
 */
@property (nonatomic, strong) UIColor *titleColor;

/**
 标题
 */
@property (nonatomic,copy)NSString *title;

/**
 placeholder
 */
@property (nonatomic, strong) NSString *placeholder;


/**
 间隔
 */
@property (nonatomic,assign)NSInteger intervalNum;


/**
 间隔符，需设置intervalNum后生效
 */
@property (nonatomic,copy)NSString *intervalStr;


/**
 最大输入字符
 */
@property (nonatomic,assign)NSInteger Maxlength;


@property (nonatomic,copy)void(^MaxlengthBlock)(NSInteger maxlength);

/**
 是否必填
 */
@property (nonatomic,assign)NSInteger isRegCode;

/**
 类型
 */
@property (nonatomic,assign)NSInteger styleType;


@property (nonatomic, copy)cancelBack disBack;

/**
 初始化
 */
+ (instancetype)alertView;


/**
 显示
 */
- (void)show;
/**
 隐藏
 */
- (void)dismiss;

/**
 结果回调
 */
- (void)ensureClickBlock:(ensureCallback) block;


//取消
- (void)cancelClickBlock:(cancelBack)block;

@end
