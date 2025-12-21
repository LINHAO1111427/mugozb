//
//  PrivacyAndSafeCell.m
//  MineCenter
//
//  Created by klc_sl on 2021/9/3.
//  Copyright © 2021 KLC. All rights reserved.
//

#import "PrivacyAndSafeCell.h"
#import <LibTools/LibTools.h>
#import <LibProjBase/LibProjBase.h>

@implementation PrivacyAndSafeCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}


- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self createUI];
    }
    return self;
}

- (void)createUI{
    
    UILabel *titleL = [[UILabel alloc] init];
    titleL.font = [UIFont systemFontOfSize:15];
    titleL.textColor = [UIColor blackColor];
    [self.contentView addSubview:titleL];
    self.titleL = titleL;
    
    UILabel *contentL = [[UILabel alloc] init];
    contentL.font = [UIFont systemFontOfSize:12];
    contentL.textColor = [UIColor lightGrayColor];
    [self.contentView addSubview:contentL];
    self.contentL = contentL;
    
    UISwitch *switchBtn = [[UISwitch alloc] init];
    [self.contentView addSubview:switchBtn];
    self.switchBtn = switchBtn;
    [switchBtn setOnTintColor:[ProjConfig normalColors]];
    switchBtn.on = NO;
    [switchBtn addTarget:self action:@selector(switchBtnClick:) forControlEvents:UIControlEventValueChanged];
    
    UIView *line = [[UIView alloc] init];
    line.backgroundColor = [UIColor groupTableViewBackgroundColor];
    [self.contentView addSubview:line];
    
    [titleL mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentView).offset(15);
        make.left.equalTo(self.contentView).offset(15);
    }];
    
    [contentL mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(titleL);
        make.bottom.equalTo(self.contentView).offset(-15);
        make.right.equalTo(switchBtn.mas_left).offset(-5);
    }];
    
    [switchBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.contentView).offset(-15);
        make.centerY.equalTo(self.contentView);
    }];
    
    [line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.contentView);
        make.height.mas_equalTo(0.8);
        make.bottom.mas_equalTo(self.contentView).offset(-1);
    }];
    
}

- (void)setDict:(NSDictionary *)dict{
    _dict = dict;
    self.titleL.text = dict[@"title"];
    self.contentL.text = dict[@"content"];
}

- (void)switchBtnClick:(UISwitch *)switchBtn{
    if (self.delegate && [self.delegate respondsToSelector:@selector(privacyAndSafeCell:switchBarStatus:)]) {
        [self.delegate privacyAndSafeCell:self switchBarStatus:switchBtn.on];
    }
}

@end
