//
//  OfficialMessageItemCell.m
//  Message
//
//  Created by klc_sl on 2020/8/25.
//  Copyright © 2020 KLC. All rights reserved.
//

#import "OfficialMessageItemCell.h"
#import <Masonry/Masonry.h>
#import <LibTools/LibTools.h>
#import <SDWebImage/SDWebImage.h>
#import <LibProjModel/AppOfficialNewsDTOModel.h>

@implementation OfficialMessageItemCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        self.bgView.hidden = NO;
        self.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    return self;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}


- (UIView *)bgView{
    if (!_bgView) {
        UIView *bgV = [[UIView alloc] init];
        [self addSubview:bgV];
        _bgView = bgV;
        [bgV mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.left.right.bottom.equalTo(self);
        }];
        
        ///时间
        UILabel *timeL = [[UILabel alloc] init];
        timeL.font = [UIFont systemFontOfSize:12];
        timeL.textColor = kRGB_COLOR(@"#999999");
        [bgV addSubview:timeL];
        _timeL = timeL;
        
        UIView *contentV = [[UIView alloc] init];
        contentV.backgroundColor = [UIColor whiteColor];
        contentV.layer.masksToBounds = YES;
        [bgV addSubview:contentV];
        
        ///logo
        UIImageView *imageV = [[UIImageView alloc] init];
        imageV.contentMode = UIViewContentModeScaleAspectFill;
        imageV.clipsToBounds = YES;
        [contentV addSubview:imageV];
        _logo = imageV;

        ///标题
        UILabel *titleL = [[UILabel alloc] init];
        titleL.font = [UIFont systemFontOfSize:14];
        titleL.numberOfLines = 0;
        titleL.textColor = kRGB_COLOR(@"#333333");
        [contentV addSubview:titleL];
        _titleL = titleL;
        
        ///内容
        UILabel *contentL = [[UILabel alloc] init];
        contentL.font = [UIFont systemFontOfSize:12];
        contentL.numberOfLines = 0;
        contentL.textColor = kRGB_COLOR(@"#999999");
        [contentV addSubview:contentL];
        _contentL = contentL;
        
        [timeL mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(bgV).mas_offset(15);
            make.centerX.equalTo(bgV);
            make.bottom.equalTo(contentV.mas_top).mas_offset(-10);
            make.height.mas_equalTo(15);
        }];
        
        [contentV mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(bgV).mas_offset(15);
            make.right.equalTo(bgV).mas_offset(-15);
            make.bottom.equalTo(bgV);
        }];
        
        [imageV mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.left.right.equalTo(contentV);
            make.height.mas_equalTo(imageV.mas_width).multipliedBy(130.0/345.0);
            make.bottom.equalTo(titleL.mas_top).mas_offset(-10);
        }];

        [titleL mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(contentV).mas_offset(10);
            make.right.equalTo(contentV).mas_offset(-10);
            make.bottom.equalTo(contentL.mas_top).mas_offset(-10);
        }];
        [contentL mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.equalTo(titleL);
            make.bottom.equalTo(contentV).mas_offset(-15);
        }];
        
        [contentV layoutIfNeeded];
        contentV.layer.cornerRadius = 4.0;
    }
    return _bgView;
}


- (void)setModel:(AppOfficialNewsDTOModel *)model{
    _model = model;
    [self.logo sd_setImageWithURL:[NSURL URLWithString:model.logo]];
    self.timeL.text = [model.publishTime timeStringWithDateFormat:kLocalizationMsg(@"MM月dd日 hh:mm")];
    self.titleL.text = model.title;
    self.contentL.text = model.introduction; 
}

@end
