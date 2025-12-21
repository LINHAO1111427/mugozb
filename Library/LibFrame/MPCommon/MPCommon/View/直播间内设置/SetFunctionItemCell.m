//
//  SetFunctionItemCell.m
//  LiveCommon
//
//  Created by klc_sl on 2020/3/19.
//  Copyright © 2020 . All rights reserved.
//

#import "SetFunctionItemCell.h"
#import <Masonry/Masonry.h>

@implementation SetFunctionItemCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.bgView.hidden = NO;
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

- (UIView *)bgView{
    if (!_bgView) {
        UIView *bgView = [[UIView alloc] init];
        [self.contentView addSubview:bgView];
        _bgView = bgView;
        
        ///右侧箭头
        UIImageView *imgV = [[UIImageView alloc] init];
        imgV.layer.masksToBounds = YES;
        imgV.image = [UIImage imageNamed:@"next_zhankai_gray"];
        imgV.contentMode = UIViewContentModeScaleAspectFit;
        [bgView addSubview:imgV];
        _imageV = imgV;
        
        ///用户名
        UILabel *titleL = [[UILabel alloc] init];
        titleL.font = [UIFont boldSystemFontOfSize:14];
        titleL.textColor = [UIColor darkGrayColor];
        [bgView addSubview:titleL];
        _titleL = titleL;
        
        ///说明
        UILabel *detailL = [[UILabel alloc] init];
        detailL.font = [UIFont systemFontOfSize:12];
        detailL.textAlignment = NSTextAlignmentRight;
        detailL.textColor = [UIColor lightGrayColor];
        [bgView addSubview:detailL];
        _detailL = detailL;
        
        UISwitch *shopSwitch = [[UISwitch alloc]init];
        shopSwitch.hidden = YES;
        [shopSwitch addTarget:self action:@selector(shopSwitch:) forControlEvents:UIControlEventValueChanged];
        [bgView addSubview:shopSwitch];
        _shopSwitch = shopSwitch;
        
        [bgView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(self);
        }];
        
        [titleL mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(bgView);
            make.left.equalTo(bgView).mas_offset(12);
            make.width.mas_equalTo(200);
            make.right.equalTo(detailL.mas_left).mas_offset(-10);
        }];

        [detailL mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(bgView);
            make.right.equalTo(imgV.mas_left).mas_offset(-5);
        }];
        [shopSwitch mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(bgView);
            make.size.mas_equalTo(CGSizeMake(50, 26));
            make.right.equalTo(bgView).mas_offset(-12);
        }];
            
        [imgV mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(bgView);
            make.size.mas_equalTo(CGSizeMake(15, 15));
            make.right.equalTo(bgView).mas_offset(-12);
        }];
        
    }
    return _bgView;
    
}

- (void)shopSwitch:(UISwitch *)switchShop{
    if (self.delegate && [self.delegate respondsToSelector:@selector(SetFunctionItemCell:switchShopChange:)]) {
        [self.delegate SetFunctionItemCell:self switchShopChange:switchShop.on];
    }
}
@end

