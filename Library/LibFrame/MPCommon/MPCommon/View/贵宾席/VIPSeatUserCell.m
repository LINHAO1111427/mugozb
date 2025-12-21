//
//  VIPSeatUserCell.m
//  LiveCommon
//
//  Created by klc on 2020/6/9.
//  Copyright © 2020 . All rights reserved.
//

#import "VIPSeatUserCell.h"
#import <LibTools/LibTools.h>
#import <Masonry/Masonry.h>
#import <LibProjModel/ApiUserBasicInfoModel.h>
#import <SDWebImage.h>
#import <LibProjBase/LibProjBase.h>


@implementation VIPSeatUserCell

- (void)awakeFromNib {
    [super awakeFromNib];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

- (KlcAvatarView *)userIcon{
    if (!_userIcon) {
        
        KlcAvatarView *imgV = [[KlcAvatarView alloc] init];
        [self.contentView addSubview:imgV];
        _userIcon = imgV;
        
        UILabel *numL = [[UILabel alloc] init];
        numL.textColor = kRGB_COLOR(@"#999999");
        numL.font = [UIFont boldSystemFontOfSize:20];
        numL.textAlignment = NSTextAlignmentCenter;
        [self.contentView addSubview:numL];
        _numL = numL;
        
        UIView *centerV = [[UIView alloc] init];
        [self.contentView addSubview:centerV];
        
        UILabel *titleL = [[UILabel alloc] init];
        titleL.font = [UIFont systemFontOfSize:14];
        titleL.textColor = [UIColor blackColor];
        [centerV addSubview:titleL];
        _nameL = titleL;
        
        SWHTapImageView *genderImgV = [[SWHTapImageView alloc] init];
        genderImgV.layer.masksToBounds = YES;
        genderImgV.layer.cornerRadius = 7.5;
        genderImgV.contentMode = UIViewContentModeScaleAspectFit;
        [centerV addSubview:genderImgV];
        _genderImgV = genderImgV;
        
        UIImageView *levelImgV = [[UIImageView alloc] init];
        levelImgV.contentMode = UIViewContentModeScaleAspectFit;
        [centerV addSubview:levelImgV];
        _levelImgV = levelImgV;
        
        UIImageView *vipImgV = [[UIImageView alloc] init];
        vipImgV.contentMode = UIViewContentModeScaleAspectFit;
        [centerV addSubview:vipImgV];
        _vipImgV = vipImgV;
        
        UILabel *coinL = [[UILabel alloc] init];
        coinL.textColor = kRGB_COLOR(@"#999999");
        coinL.font = [UIFont systemFontOfSize:14];
        [self.contentView addSubview:coinL];
        _coinL = coinL;
        
        
        [imgV mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(CGSizeMake(46, 46));
            make.left.equalTo(self).mas_offset(45);
            make.centerY.equalTo(self);
            make.right.equalTo(centerV.mas_left).mas_offset(-5);
        }];
        
        [numL mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self);
            make.right.equalTo(imgV.mas_left);
            make.centerY.equalTo(imgV);
        }];
        
        [coinL mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self);
            make.right.equalTo(self).mas_offset(-12);
        }];
        
        [centerV mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self);
        }];
        
        [titleL mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.left.right.equalTo(centerV);
            make.bottom.equalTo(genderImgV.mas_top).mas_offset(-4);
        }];
        
        [genderImgV mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.bottom.equalTo(centerV);
            make.right.equalTo(levelImgV.mas_left).mas_offset(-4);
            make.size.mas_equalTo(CGSizeMake(30, 15));
        }];
        
        [levelImgV mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(vipImgV.mas_left).mas_offset(-4);
            make.size.mas_equalTo(CGSizeMake(30, 15));
            make.centerY.equalTo(genderImgV);
        }];
        
        [vipImgV mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(centerV);
            make.size.mas_equalTo(CGSizeMake(30, 15));
            make.centerY.equalTo(levelImgV);
        }];
        
        [imgV layoutIfNeeded];
        imgV.layer.cornerRadius = imgV.height/2.0;
    }
    return _userIcon;
}

- (void)setModel:(ApiUserBasicInfoModel *)model{
    _model = model;
    
    [self.userIcon showUserIconUrl:model.avatar vipBorderUrl:model.nobleAvatarFrame];

    self.nameL.text = model.username;
    ///性别与角色
    UIImage *image = [[ProjConfig shareInstence].baseConfig imageGender:model.sex age:model.age role:model.role];
    if (image) {
        self.genderImgV.image = image;
    }else{
        [self.genderImgV mas_updateConstraints:^(MASConstraintMaker *make) {
            make.width.mas_equalTo(0);
        }];
    }
    self.genderImgV.btnClick = ^(int type) {
        [[ProjConfig shareInstence].businessConfig showAuthAlertView:[ProjConfig currentVC].view role:model.role];
    };
    
    if (model.wealthGradeImg.length > 0) {
        [_levelImgV sd_setImageWithURL:[NSURL URLWithString:model.wealthGradeImg]];
        [_vipImgV sd_setImageWithURL:[NSURL URLWithString:model.nobleGradeImg]];
    }else{
        [_levelImgV sd_setImageWithURL:[NSURL URLWithString:model.nobleGradeImg]];
        [_vipImgV sd_setImageWithURL:[NSURL URLWithString:@""]];
    }

    NSString *coin = [NSString stringWithFormat:@"%0.1f",model.currContValue];
    _coinL.attributedText = [coin attachmentForImage:[ProjConfig getCoinImage] bounds:CGRectMake(0, -2, 15, 15) before:YES];
}



@end
