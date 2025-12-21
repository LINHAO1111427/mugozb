//
//  EditGoodsPriceView.m
//  Shopping
//
//  Created by klc_sl on 2020/7/4.
//  Copyright © 2020 klc. All rights reserved.
//

#import "EditGoodsPriceView.h"
#import <LibProjModel/ShopAttrComposeModel.h>

@interface EditGoodsPriceView ()<UITextFieldDelegate>
@property (nonatomic, weak)UILabel *attriLabel;

@end
@implementation EditGoodsPriceView
- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self creatUI];
    }
    return self;
}
- (void)creatUI{
    
    CGFloat margin = 12;
    CGFloat width = (self.width-4*margin)/3.0;
    UILabel *attriLabel = [[UILabel alloc]initWithFrame:CGRectMake(margin, 20, self.width-2*margin, 20)];
    attriLabel.textAlignment = NSTextAlignmentLeft;
    attriLabel.font = [UIFont systemFontOfSize:13];
    attriLabel.textColor = kRGB_COLOR(@"#666666");
    [self addSubview:attriLabel];
    self.attriLabel = attriLabel;
    
    for (int i = 0; i < 3; i ++) {
        UITextField *textF = [[UITextField alloc]initWithFrame:CGRectMake(margin+i*(width+margin), attriLabel.maxY+5, width, 34)];
        textF.backgroundColor = kRGB_COLOR(@"#EEEEEE");
        textF.textColor = kRGB_COLOR(@"#666666");
        textF.font = [UIFont systemFontOfSize:13];
        textF.textAlignment = NSTextAlignmentCenter;
        textF.delegate = self;
        [self addSubview:textF];
        if ( i == 0) {
            textF.placeholder = kLocalizationMsg(@"请输入价格");
            textF.keyboardType = UIKeyboardTypeDecimalPad;
            self.priceTextF = textF;
        }else if (i == 1){
            textF.placeholder = kLocalizationMsg(@"请输入优惠价格");
            textF.keyboardType = UIKeyboardTypeDecimalPad;
            self.discountPriceTextF = textF;
        }else if (i == 2){
            textF.placeholder = kLocalizationMsg(@"请输入库存");
            textF.keyboardType = UIKeyboardTypeNumberPad;
            self.capacityTextF = textF;
        }
    }
    
    UIView *line = [[UIView alloc]initWithFrame:CGRectMake(12, self.height-1, self.width-24, 1.0)];
    line.backgroundColor = kRGB_COLOR(@"#DEDEDE");
    [self addSubview:line];
}

 
- (void)setAttrModel:(ShopAttrComposeModel *)attrModel{
    _attrModel = attrModel;
    if (_attrModel.name2.length > 0) {
        self.attriLabel.text = [NSString stringWithFormat:@"\"%@\"  \"%@\"",attrModel.name1,attrModel.name2];
    }else{
        self.attriLabel.text = [NSString stringWithFormat:@"\"%@\"",attrModel.name1];
    }
     
    if (attrModel.price > 0) {
         self.priceTextF.text = [NSString stringWithFormat:@"%.1f",attrModel.price];
    }
    if (attrModel.favorablePrice > 0) {
         self.discountPriceTextF.text = [NSString stringWithFormat:@"%.1f",attrModel.favorablePrice];
    }
    if (attrModel.stock > 0) {
         self.capacityTextF.text = [NSString stringWithFormat:@"%d",attrModel.stock];
    }
     
     
     
}
#pragma mark - UITextFieldDelegate
- (void)textFieldDidEndEditing:(UITextField *)textField{
    if (textField == self.priceTextF) {
        self.attrModel.price = [self.priceTextF.text floatValue];
    }else if (textField == self.discountPriceTextF){
        self.attrModel.favorablePrice = [self.discountPriceTextF.text floatValue];
    }else if(textField == self.capacityTextF){
        self.attrModel.stock = [self.capacityTextF.text intValue];
    }
}
-(BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{

    NSString *toString = [textField.text stringByReplacingCharactersInRange:range withString:string];

    if (toString.length > 0) {

        //NSString *stringRegex = @"(\\+|\\-)?(([0]|(0[.]\\d{0,2}))|([1-9]\\d{0,8}(([.]\\d{0,2})?)))?";//(带正负号的)

        NSString *stringRegex = @"(([0]|(0[.]\\d{0,2}))|([1-9]\\d{0,19}(([.]\\d{0,2})?)))?";//一般格式 d{0,8} 控制位数

        NSPredicate *money = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", stringRegex];

        BOOL flag = [money evaluateWithObject:toString];

        if (!flag) return NO;
    }
    return YES;
}

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField{
    self.textFShouldBeginEditing?self.textFShouldBeginEditing(self):nil;
    return YES;
}

@end
