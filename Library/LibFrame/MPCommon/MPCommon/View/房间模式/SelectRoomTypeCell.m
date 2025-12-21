//
//  SelectRoomTypeCell.m
//  LiveCommon
//
//  Created by klc_sl on 2020/3/20.
//  Copyright © 2020 . All rights reserved.
//

#import "SelectRoomTypeCell.h"
#import <Masonry/Masonry.h>
#import <LibTools/LibTools.h>
#import "ChangeRoomTypeView.h"

@implementation SelectRoomTypeCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.bgView.hidden = NO;
        self.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    return self;
}


- (void)selectItems:(BOOL)selected{
    [_selectBtn setImage:[UIImage imageNamed:selected?@"add_wish_xuanzhong":@"add_wish_weixuanzhong"] forState:UIControlStateNormal];
}

- (UIView *)bgView{
    if (!_bgView) {
        UIView *bgView = [[UIView alloc] init];
        [self.contentView addSubview:bgView];
        _bgView = bgView;
        
        kWeakSelf(self);
        ///选择按钮
        UIButton *selectBtn = [UIButton buttonWithType:0];
        selectBtn.imageEdgeInsets = UIEdgeInsetsMake(7, 7, 7, 7);
        [selectBtn setImage:[UIImage imageNamed:@"add_wish_weixuanzhong"] forState:UIControlStateNormal];
        [bgView addSubview:selectBtn];
        [selectBtn klc_whenTapped:^{
            if (weakself.selectItem) {
                weakself.selectItem();
            }
        }];
        _selectBtn = selectBtn;
        
        ///选项名
        UILabel *titleL = [[UILabel alloc] init];
        titleL.font = [UIFont boldSystemFontOfSize:14];
        titleL.textColor = [UIColor blackColor];
        titleL.userInteractionEnabled = YES;
        [titleL klc_whenTapped:^{
            if (weakself.selectItem) {
                weakself.selectItem();
            }
        }];
        [bgView addSubview:titleL];
        _titleL = titleL;
        
        ///说明
        UITextField *textF = [[UITextField alloc] init];
        textF.keyboardType = UIKeyboardTypeNumberPad;
        textF.font = [UIFont systemFontOfSize:14];
        textF.layer.masksToBounds = YES;
        textF.layer.cornerRadius = 4;
        [textF addTarget:self action:@selector(textFieldsValueChange:) forControlEvents:UIControlEventEditingChanged];
        textF.backgroundColor = kRGB_COLOR(@"#F5F5F5");
        [bgView addSubview:textF];
        _textFV = textF;
        
        ///单位
        UILabel *unitLab = [[UILabel alloc] init];
        unitLab.font = [UIFont boldSystemFontOfSize:14];
        unitLab.textColor = [UIColor lightGrayColor];
        [bgView addSubview:unitLab];
        _unitL = unitLab;
        
        
        [bgView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(self);
        }];
        
        [selectBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(CGSizeMake(30, 30));
            make.centerY.equalTo(bgView);
            make.left.equalTo(bgView).mas_offset(1);
            make.right.equalTo(titleL.mas_left).mas_offset(-5);
        }];
        
        [titleL mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(selectBtn);
            make.width.equalTo(@(80));
            make.right.equalTo(textF.mas_left).mas_offset(-5);
        }];
        
        [textF mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(CGSizeMake(110, 28));
            make.centerY.equalTo(selectBtn);
            make.right.equalTo(unitLab.mas_left).mas_offset(-5);
        }];
        
        [unitLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(selectBtn);
        }];
    }
    return _bgView;
    
}


- (void)textFieldsValueChange:(UITextField *)textF{
    NSString *text = textF.text;
    if (text.length > 6) {
        text = [text substringToIndex:6];
        textF.text = text;
    }
    if (self.selectItemValueDidChange) {
        self.selectItemValueDidChange(text);
    }
}

@end
