//
//  MineSettingItemCell.m
//  klcProject
//
//  Created by ssssssss on 2020/7/25.
//  Copyright © 2020 KLC. All rights reserved.
//

#import "MineSettingItemCell.h"

@interface MineSettingItemCell()

@property (nonatomic, strong)UILabel *titleL;
@property (nonatomic, strong)UILabel *contentL;
@property (nonatomic, strong)UIImageView *arrowImageV;
@property (nonatomic, strong)UISwitch *switchBar;

@end

@implementation MineSettingItemCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style  reuseIdentifier:reuseIdentifier];
    if (self) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self createUI];
    }
    return self;
}

- (void)createUI{

    self.backgroundColor = [UIColor whiteColor];
    
    self.titleL = [[UILabel alloc] init];
    self.titleL.textColor = kRGB_COLOR(@"#444444");
    self.titleL.textAlignment = NSTextAlignmentLeft;
    self.titleL.font = [UIFont systemFontOfSize:14];
    [self.titleL setContentHuggingPriority:UILayoutPriorityDefaultHigh forAxis:UILayoutConstraintAxisHorizontal];
    [self.contentView addSubview:self.titleL];
    
    self.contentL = [[UILabel alloc] init];
    self.contentL.textAlignment = NSTextAlignmentRight;
    self.contentL.textColor = kRGB_COLOR(@"#AAAAAA");
    self.contentL.font = [UIFont systemFontOfSize:14];
    [self.contentL setContentHuggingPriority:UILayoutPriorityDefaultLow forAxis:UILayoutConstraintAxisHorizontal];
    [self.contentView addSubview:self.contentL];
    
    self.arrowImageV = [[UIImageView alloc] init];
    self.arrowImageV.image = [UIImage imageNamed:@"mineCenter_gray_more"];
    [self.contentView addSubview:self.arrowImageV];
    
    self.switchBar = [[UISwitch alloc] init];
    [self.switchBar setOnTintColor:[ProjConfig normalColors]];
    self.switchBar.hidden = YES;
    self.switchBar.on = NO;
    [self.switchBar addTarget:self action:@selector(switchBar:) forControlEvents:UIControlEventValueChanged];
    [self.contentView addSubview:self.switchBar];
    

    UIView *line = [[UIView alloc] init];
    line.backgroundColor = kRGB_COLOR(@"#F2F2F2");
    [self.contentView addSubview:line];
    
    [self.titleL mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView).inset(12);
        make.centerY.equalTo(self.contentView);
    }];
    [self.arrowImageV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(8, 15));
        make.centerY.equalTo(self.contentView);
        make.right.equalTo(self.contentView).inset(12);
    }];
    [self.contentL mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.titleL.mas_right).inset(10);
        make.right.equalTo(self.arrowImageV.mas_left).inset(5);
        make.centerY.equalTo(self.titleL);
    }];
    
    [self.switchBar mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(60, 32));
        make.centerY.equalTo(self.contentView);
        make.right.equalTo(self.contentView).inset(12);
    }];
    
    [line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(0.5);
        make.left.right.equalTo(self.contentView);
        make.bottom.equalTo(self.contentView).inset(0.5);
    }];
}




//type 0退出 1更多 2 开关 3更多带值
- (void)showInfoType:(int)type titleStr:(NSString *)titleStr contentStr:(NSString *)contentStr{

    self.titleL.text = titleStr;
    self.contentL.text = contentStr;
    
    self.arrowImageV.hidden = YES;
    self.contentL.hidden = YES;
    self.switchBar.hidden = YES;

    [self.titleL mas_remakeConstraints:^(MASConstraintMaker *make) {
        if (type == 0) {
            make.center.equalTo(self.titleL.superview);
        }else{
            make.left.equalTo(self.titleL.superview).inset(12);
            make.centerY.equalTo(self.titleL.superview);
        }
    }];

    switch (type) {
        case 1:
            self.arrowImageV.hidden = NO;
            break;
        case 2:
            self.switchBar.hidden = NO;
            self.switchBar.on = self.swithStatus;
            break;
        case 3:
        {
            self.arrowImageV.hidden = NO;
            self.contentL.hidden = NO;
        }
            break;
        default:
            break;
    }
}


- (void)switchBar:(UISwitch *)bar{
    if (self.delegate && [self.delegate respondsToSelector:@selector(MineSettingItemCell:switchBarStatus:)]) {
        [self.delegate MineSettingItemCell:self switchBarStatus:bar.on];
    }
}

  
@end
