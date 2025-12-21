//
//  MineCenterItemCell.m
//  TCDemo
//
//  Created by admin on 2019/10/19.
//  Copyright © 2019 CH. All rights reserved.
//

#import "MineCenterItemCell.h"
#import <Masonry/Masonry.h>

NSString *const MineCenterItemCellIdentifier = @"MineCenterItemCellIdentifier";

@interface MineCenterItemCell ()

@property (nonatomic, weak)UIView *bgV;

@property (nonatomic, weak)UIView *logoutBgV;

@property (nonatomic, weak)UIImageView *arrowImgV;

@end

@implementation MineCenterItemCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.bgV.backgroundColor = [UIColor whiteColor];
        self.bgV.hidden = NO;
        self.logoutBgV.hidden = YES;
    }
    return self;
}

- (UIView *)bgV{
    if (_bgV == nil) {
        UIView *bgView = [[UIView alloc] init];
        [self.contentView addSubview:bgView];
        _bgV = bgView;
        [bgView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.bottom.left.right.equalTo(self);
        }];
        
        //向右箭头
        UIImageView *imgV = [[UIImageView alloc] init];
        imgV.contentMode = UIViewContentModeScaleAspectFit;
        imgV.image = [UIImage imageNamed:@"mineCenter_gray_more"];
        [bgView addSubview:imgV];
        _arrowImgV = imgV;
        
        //文字
        UILabel *titleL = [[UILabel alloc] init];
        titleL.textColor = [UIColor blackColor];
        titleL.font = [UIFont systemFontOfSize:15];
        [bgView addSubview:titleL];
        _funcionLab = titleL;
        
        //详细信息
        UILabel *detailLab = [[UILabel alloc] init];
        detailLab.textColor = [UIColor lightGrayColor];
        detailLab.font = [UIFont systemFontOfSize:13];
        [bgView addSubview:detailLab];
        _detailLab = detailLab;
        
        //线
        UIView *line = [[UIView alloc] init];
        line.backgroundColor = [UIColor groupTableViewBackgroundColor];
        [bgView addSubview:line];
        
        [imgV mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(CGSizeMake(8, 14));
            make.centerY.equalTo(bgView);
            make.right.equalTo(bgView).mas_offset(-8);
            make.left.equalTo(detailLab.mas_right).mas_offset(15);
        }];
        
        [titleL mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(imgV);
            make.left.equalTo(bgView).mas_offset(15);
        }];
        
        [detailLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(imgV);
        }];
        
        [line mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.equalTo(bgView).mas_offset(1.0);
            make.height.mas_equalTo(1.0);
            make.left.right.equalTo(bgView);
        }];
    }
    return _bgV;
}

-(UIView *)logoutBgV{
    if (_logoutBgV == nil) {
        
        UIView *bgView = [[UIView alloc] init];
        [self.contentView addSubview:bgView];
        
        _logoutBgV = bgView;
        [bgView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.bottom.left.right.equalTo(self);
        }];
        
        //文字
        UILabel *titleL = [[UILabel alloc] init];
        titleL.textColor = [UIColor purpleColor];
        titleL.font = [UIFont systemFontOfSize:17];
        [bgView addSubview:titleL];
        _logoutLab = titleL;
        
        [titleL mas_makeConstraints:^(MASConstraintMaker *make) {
            make.center.equalTo(bgView);
        }];
    }
    return _logoutBgV;
}

- (void)setIsLogout:(BOOL)isLogout{
    _logoutBgV.hidden = !isLogout;
    _bgV.hidden = isLogout;
}

@end
