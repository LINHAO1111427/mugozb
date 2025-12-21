//
//  AddWishItemCell.m
//  LiveCommon
//
//  Created by klc_sl on 2020/3/17.
//  Copyright © 2020 . All rights reserved.
//

#import "AddWishItemCell.h"
#import <LibProjModel/ApiUsersLiveWishModel.h>
#import <LibProjModel/KLCAppConfig.h>
#import <LibTools/LibTools.h>
#import <LibProjBase/LibProjBase.h>
#import <SDWebImage/SDWebImage.h>

@implementation AddWishItemCell

- (void)awakeFromNib {
    [super awakeFromNib];
}


- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    [_numTextF resignFirstResponder];
    return YES;
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
    if (string.length == 0) {
        return YES;
    }
    
    if (textField.text.length<3 && [string validPureInt]) {
        return YES;
    }else{
        return NO;
    }
}

///数据减法
- (IBAction)subBtnClick:(id)sender {
    NSInteger number = [_numTextF.text integerValue];
    if (number>0) {
        --number;
        [self selectNum:number];
    }
}

- (IBAction)textFieldValueDidChange:(UITextField *)sender {
    [self selectNum:[sender.text integerValue]];
}

///数字加法
- (IBAction)addBtnClick:(id)sender {
    NSInteger number = [_numTextF.text integerValue];
    if (number<999) {
        ++number;
        [self selectNum:number];
    }

}

- (void)selectNum:(NSInteger)num{
    _wishModel.num = (int)num;
    if (num>0) {
        _numTextF.text = [NSString stringWithFormat:@"%zi",num];
    }else{
        _numTextF.text = @"";
    }
}

- (void)setWishModel:(ApiUsersLiveWishModel *)wishModel{
    _wishModel = wishModel;
    
    _numTextF.delegate = self;
    _bgView.layer.borderColor = [UIColor lightGrayColor].CGColor;
    [_giftIcon sd_setImageWithURL:[NSURL URLWithString:wishModel.gifticon]];
    _giftNameL.text = wishModel.giftname;
    [_numTextF.placeholder attachmentForImage:nil bounds:CGRectMake(0, 0, 0, 0) before:YES];
    NSAttributedString *attrStr = [[NSAttributedString alloc] initWithString:@"0" attributes:@{NSForegroundColorAttributeName:[UIColor blackColor]}];
    _numTextF.attributedPlaceholder = attrStr;
    if (wishModel.num>0) {
        _numTextF.text = [NSString stringWithFormat:@"%d",wishModel.num];
    }else{
        _numTextF.text = @"1";
    }
}

- (void)setIsAdd:(BOOL)isAdd{
    _isAdd = isAdd;
    self.addBgView.hidden = !isAdd;
    self.showBgView.hidden = isAdd;
}

///删除按钮点击事件
- (IBAction)removeGiftBtnClick:(UIButton *)sender {
    if (self.removeGiftBtnBlock) {
        self.removeGiftBtnBlock(_wishModel);
    }
}

///添加礼物按钮
- (IBAction)addGiftBtnClick:(id)sender {
    if (self.addGiftBtnBlock) {
        self.addGiftBtnBlock();
    }
}
@end
