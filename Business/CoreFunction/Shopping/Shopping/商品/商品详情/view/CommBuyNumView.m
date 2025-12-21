//
//  CommBuyNumView.m
//  Shopping
//
//  Created by tctd on 2020/7/7.
//  Copyright © 2020 klc. All rights reserved.
//

#import "CommBuyNumView.h"
@interface CommBuyNumView()<UITextFieldDelegate>
@property (nonatomic, strong)UITextField *textField;
@end
@implementation CommBuyNumView
- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self createUI];
    }
    return self;
}
- (void)createUI{
    UILabel *titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(14, 20, 60, 20)];
    titleLabel.text = @"购买数量";
    titleLabel.font = [UIFont systemFontOfSize:14];
    titleLabel.textColor = kRGB_COLOR(@"#333333", 1.0);
    titleLabel.textAlignment = NSTextAlignmentLeft;
    [self addSubview:titleLabel];
    
    UIButton *addBtn = [[UIButton alloc]initWithFrame:CGRectMake(self.width-14-40, 0, 40, 40)];
    [addBtn setTitle:@"+" forState:UIControlStateNormal];
    addBtn.centerY = titleLabel.centerY;
    [addBtn addTarget:self action:@selector(addBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [addBtn setTitleColor:kRGB_COLOR(@"#333333", 1.0) forState:UIControlStateNormal];
    [self addSubview:addBtn];
    
    UITextField *textField = [[UITextField alloc]initWithFrame:CGRectMake(addBtn.x-55, 0, 50, 30)];
    textField.backgroundColor = kRGB_COLOR(@"#F2F2F2", 1.0);
    textField.textColor = kRGB_COLOR(@"#666666", 1.0);
    textField.delegate = self;
    textField.centerY = titleLabel.centerY;
    textField.font = [UIFont systemFontOfSize:14];
    textField.layer.cornerRadius = 5;
    textField.clipsToBounds = YES;
    textField.textAlignment = NSTextAlignmentCenter;
    textField.text = @"1";
    textField.keyboardType = UIKeyboardTypeNumberPad;
    [textField addTarget:self action:@selector(changedTextField:) forControlEvents:UIControlEventEditingChanged];
    self.textField = textField;
    [self addSubview:self.textField];
    
    UIButton *subtractionBtn = [[UIButton alloc]initWithFrame:CGRectMake(textField.x-45, 0, 40, 40)];
    [subtractionBtn setTitle:@"-" forState:UIControlStateNormal];
    subtractionBtn.centerY = titleLabel.centerY;
    [subtractionBtn addTarget:self action:@selector(subtractionBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [subtractionBtn setTitleColor:kRGB_COLOR(@"#EAEAEA", 1.0) forState:UIControlStateNormal];
    [self addSubview:subtractionBtn];
    
    UIView *line = [[UIView alloc]initWithFrame:CGRectMake(14, self.height-1, self.width-28, 0.5)];
    line.backgroundColor = kRGB_COLOR(@"#DEDEDE", 1.0);
    [self addSubview:line];
}
 
- (void)changedTextField:(UITextField *)textField{
    self.callBack([textField.text intValue]);
}
- (void)addBtnClick:(UIButton *)btn{
    int num = [self.textField.text intValue];
    self.textField.text = [NSString stringWithFormat:@"%d",num+1];
    self.callBack(num+1);
}
- (void)subtractionBtnClick:(UIButton *)btn{
    int num = [self.textField.text intValue];
    if (num > 0) {
        num --;
    }else{
        num = 0;
    }
    self.textField.text = [NSString stringWithFormat:@"%d",num];
    self.callBack(num);
}
@end
