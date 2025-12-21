//
//  SetGoodsShowView.m
//  Shopping
//
//  Created by klc_sl on 2020/7/3.
//  Copyright © 2020 klc. All rights reserved.
//

#import "SetGoodsShowView.h"
#import <LibTools/LibTools.h>
#import <Masonry/Masonry.h>
@interface SetGoodsShowView()<UITextFieldDelegate>
@property (nonatomic, strong)UITextField *textFiled;
@end
@implementation SetGoodsShowView

- (instancetype)initWithFrame:(CGRect)frame isAdd:(BOOL)isAdd{
    self = [super initWithFrame:frame];
    if (self) {
        [self createUI:isAdd];
    }
    return self;
}

- (void)createUI:(BOOL)isAdd{
    
    UIButton *bgBtn = [UIButton buttonWithType:0];
    bgBtn.layer.masksToBounds = YES;
    bgBtn.layer.cornerRadius = 4.0;
    bgBtn.layer.borderWidth = 1.0;
    [self addSubview:bgBtn];
    
    UITextField *textF = [[UITextField alloc] init];
    textF.textAlignment = NSTextAlignmentCenter;
    textF.font = [UIFont systemFontOfSize:13];
    textF.delegate = self;
    textF.placeholder = kLocalizationMsg(@"请输入属性名称");
    textF.returnKeyType = UIReturnKeyDone;
    [textF addTarget:self action:@selector(textValueChange:) forControlEvents:UIControlEventEditingChanged];
    self.textFiled = textF;
    [self addSubview:self.textFiled];
    
    if (isAdd) {
        
        textF.userInteractionEnabled = NO;
        textF.textColor= kRGB_COLOR(@"#999999");
        textF.text = kLocalizationMsg(@"自定义");
        
        bgBtn.layer.borderColor = kRGB_COLOR(@"#EEEEEE").CGColor;
        [bgBtn setBackgroundColor:kRGB_COLOR(@"#EEEEEE")];
        bgBtn.userInteractionEnabled = YES;
        [bgBtn addTarget:self action:@selector(addBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        
    }else{
        
        textF.userInteractionEnabled = YES;
        textF.textColor= kRGB_COLOR(@"#FF5500");
        textF.text = nil;
        
        bgBtn.userInteractionEnabled = NO;
        bgBtn.layer.borderColor = kRGB_COLOR(@"#FF5500").CGColor;
        [bgBtn setBackgroundColor:[UIColor whiteColor]];
        
        UIButton *deleteBtn = [UIButton buttonWithType:0];
        [deleteBtn setImage:[UIImage imageNamed:@"shop_shanchu"] forState:UIControlStateNormal];
        [deleteBtn setImageEdgeInsets:UIEdgeInsetsMake(7, 7, 7, 7)];
        [deleteBtn addTarget:self action:@selector(deleteBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:deleteBtn];
        [deleteBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(CGSizeMake(30, 30));
            make.top.right.equalTo(self);
        }];
        [deleteBtn layoutIfNeeded];
    }
    
    [bgBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.bottom.equalTo(self);
        make.top.equalTo(self).mas_offset(10);
        make.right.equalTo(self).mas_offset(-10);
    }];
    [bgBtn layoutIfNeeded];
    
    [textF mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(bgBtn.height);
        make.left.equalTo(bgBtn).mas_offset(12);
        make.right.equalTo(bgBtn).mas_offset(-12);
        make.centerY.equalTo(bgBtn);
    }];
}

- (void)textValueChange:(UITextField *)textF{
    _attrStr = textF.text;
}
- (void)setAttrStr:(NSString *)attrStr{
    _attrStr = attrStr;
    self.textFiled.text = attrStr;
}
- (void)deleteBtnClick:(UIButton *)btn{
    if (_delBtnClick) {
        _delBtnClick();
    }
}
- (void)addBtnClick:(UIButton *)btn{
    if (_addBtnClick) {
        _addBtnClick();
    }
}
#pragma mark - UITextFieldDelegate
-(BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
    if(range.length + range.location > textField.text.length){
        return NO;
    }
    NSUInteger newLength = [textField.text length] + [string length] - range.length;
    return newLength <= 20;//限制字数

}

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField{
    self.textFShouldBeginEditing?self.textFShouldBeginEditing(self):nil;
    return YES;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    [self endEditing:YES];
    return YES;
}

@end
