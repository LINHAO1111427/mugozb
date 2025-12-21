//
//  ZQAlterField.m
//  ZQAlterFieldDemo
//
//  Created by 肖兆强 on 2018/2/6.
//  Copyright © 2018年 ZQ. All rights reserved.
//

#import "ZQAlterField.h"
#import "LibProjViewRes.h"

#define ZQWindow [UIApplication sharedApplication].keyWindow

@interface ZQAlterField ()<UITextFieldDelegate>

/**
 回调block
 */
@property (nonatomic, copy) ensureCallback ensureBlock;

/**
 蒙板
 */
@property (nonatomic, weak) UIView *becloudView;

@property (weak, nonatomic) IBOutlet UIButton *cancelBtn;

@end



@implementation ZQAlterField

+ (instancetype)alertView
{
    NSString *nibName= [LibProjViewRes getNibFullName:@"ZQAlterField"];
    //@"Frameworks/LibTools.framework/ZQAlterField"
    return   [[[NSBundle bundleForClass:[self class]] loadNibNamed:nibName owner:self options:nil] lastObject];
}

- (void)awakeFromNib
{
    [super awakeFromNib];
    
    [self setCornerRadius:self];
    [self setCornerRadius:self.textFieldBG];
    
    // 添加点击手势
    UITapGestureRecognizer *tapGR = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(exitKeyboard)];
    [self addGestureRecognizer:tapGR];
    self.textFieldBG.backgroundColor = [UIColor colorWithRed:240/255.0 green:240/255.0 blue:240/255.0 alpha:1];
    self.textField.delegate = self;
    self.ensureBtn.backgroundColor = [ProjConfig normalColors];
    self.mustFillBtn.backgroundColor = [ProjConfig normalColors];
}


#pragma mark - UITextFieldDelegate
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    
    if ([string isEqualToString:@""]) { // 删除字符
        
        if (_intervalNum>0) {
            if ((textField.text.length-1) % (_intervalNum+1) == 0&&textField.text.length>0) {
                textField.text = [textField.text substringToIndex:textField.text.length - 1];
            }
        }
        return YES;
    } else {
        
        if (_Maxlength>0&&textField.text.length==_Maxlength) {
//            [ZQUtil msgHint:[NSString stringWithFormat:kLocalizationMsg(@"最多输入%ld位"),_Maxlength]];
            if (self.MaxlengthBlock) {
                self.MaxlengthBlock(_Maxlength);
            }
            return NO;
        }
        if (_intervalNum>0) {
            
            if ((textField.text.length+1) % (_intervalNum+1) == 0&&textField.text.length>0) {
                
                if (_intervalStr.length>0) {
                    textField.text = [NSString stringWithFormat:@"%@%@", textField.text,_intervalStr];
                }else
                {
                    textField.text = [NSString stringWithFormat:@"%@-", textField.text];
                }
                
                return YES;
            }
            
        }
    }
    
    
    return YES;
    
}



#pragma mark - 设置控件圆角
- (void)setCornerRadius:(UIView *)view
{
    
    view.layer.cornerRadius = 8.0;
    view.layer.masksToBounds = YES;
}

- (void)setPlaceholder:(NSString *)placeholder
{
    _placeholder = [placeholder copy];
    self.textField.placeholder = self.placeholder;
}

- (void)setEnsureBgColor:(UIColor *)ensureBgColor
{
    _ensureBgColor = ensureBgColor;
    self.ensureBtn.backgroundColor = ensureBgColor;
}

- (void)setTitle:(NSString *)title
{
    _title = title;
    self.titleLabel.text = title;
}

- (void)setTextColor:(UIColor *)textColor
{
    _textColor = textColor;
    self.textField.textColor = textColor;
}


-(void)setTitleColor:(UIColor *)titleColor
{
    _titleColor = titleColor;
    self.titleLabel.textColor = titleColor;
}


- (void)setTextFieldBgColor:(UIColor *)textFieldBgColor
{
    _textFieldBgColor = textFieldBgColor;
    self.textFieldBG.backgroundColor = textFieldBgColor;
}

- (void)show
{
    // 蒙版
    UIView *becloudView = [[UIView alloc] initWithFrame:[UIScreen mainScreen].bounds];
    becloudView.backgroundColor = [UIColor blackColor];
    becloudView.layer.opacity = 0.08;
    UITapGestureRecognizer *tapGR = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(closeAlertView:)];
    [becloudView addGestureRecognizer:tapGR];
    
    [ZQWindow addSubview:becloudView];
    self.becloudView = becloudView;
    
    
    // 输入框
    self.frame = CGRectMake(0, 0, MIN(becloudView.frame.size.width * 0.7, 320), 185);
    self.center = CGPointMake(becloudView.center.x, becloudView.frame.size.height * 0.4);
    [ZQWindow addSubview:self];
    
    if (self.styleType == regCodeStyle) {
           self.cancelBtn.hidden = YES;
           self.ensureBtn.hidden = YES;
           self.mustFillBtn.hidden = NO;
       }else{
           self.mustFillBtn.hidden = YES;
           self.cancelBtn.hidden = NO;
           self.ensureBtn.hidden = NO;
       }
    
}

- (void)exitKeyboard
{
    [self endEditing:YES];
}

#pragma mark - 移除ZYInputAlertView
- (void)dismiss
{
    [self removeFromSuperview];
    [self.becloudView removeFromSuperview];
}

#pragma mark - 点击关闭按钮
- (IBAction)closeAlertView:(UIButton *)sender {
   if (self.styleType == 0) {
       [self dismiss];
       if (self.disBack) {
           self.disBack();
       }
   }
   
}

#pragma mark - 接收传过来的block

- (void)ensureClickBlock:(ensureCallback)block
{
    self.ensureBlock = block;
}


- (void)cancelClickBlock:(cancelBack)block
{
    self.disBack = block;
}

#pragma mark - 点击确认按钮
- (IBAction)ensureBtnClick:(UIButton *)sender {
     
    if (self.styleType == 0) {
        [self dismiss];
    }
    
    if (self.ensureBlock) {
        self.ensureBlock(self.textField.text);
    }
    
}

- (IBAction)cancelBtnClick:(id)sender {
    if (self.disBack) {
        self.disBack();
    }
    [self dismiss];
}

- (IBAction)mustFillBtnClick:(id)sender {
    
    if (self.ensureBlock) {
        self.ensureBlock(self.textField.text);
    }
}



@end
