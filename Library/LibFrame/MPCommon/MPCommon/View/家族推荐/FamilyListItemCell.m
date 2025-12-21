//
//  FamilyListItemCell.m
//  OTMLive
//
//  Created by klc_sl on 2020/12/18.
//  Copyright © 2020 KLC. All rights reserved.
//

#import "FamilyListItemCell.h"
#import <Masonry/Masonry.h>
#import <LibTools/LibTools.h>
#import <LibProjModel/AdminUserModel.h>
#import <SDWebImage/SDWebImage.h>
#import <LibProjBase/LibProjBase.h>
#import <LibProjModel/KLCUserInfo.h>

@implementation FamilyListItemCell

- (void)awakeFromNib {
    [super awakeFromNib];
}


- (UIImageView *)userIcon{
    if (!_userIcon) {
        ///底板色
        UIView *bgColorV = [[UIImageView alloc] init];
        [self.contentView addSubview:bgColorV];
        bgColorV.backgroundColor = kRGBA_COLOR(@"#383838", 1.0);
        bgColorV.hidden = YES;
        bgColorV.userInteractionEnabled = NO;
        _bgColorV = bgColorV;
        [bgColorV mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.left.bottom.equalTo(self.contentView);
            make.right.equalTo(self.contentView).mas_offset(20);
        }];
        [bgColorV layoutSubviews];
        bgColorV.layer.cornerRadius = 10;
        
        UIImageView *userImgV = [[UIImageView alloc] init];
        userImgV.layer.masksToBounds = YES;
        userImgV.layer.cornerRadius = 20;
        userImgV.contentMode = UIViewContentModeScaleAspectFill;
        [self.contentView addSubview:userImgV];
        _userIcon = userImgV;
        [userImgV mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(CGSizeMake(40, 40));
            make.top.left.equalTo(self).mas_offset(10);
        }];

        UILabel *titleL = [[UILabel alloc] init];
        titleL.textColor = [UIColor whiteColor];
        titleL.font = [UIFont boldSystemFontOfSize:12];
        [self.contentView addSubview:titleL];
        _userNameL = titleL;
        [titleL mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(userImgV.mas_right).mas_offset(5);
            make.right.equalTo(self).mas_offset(-5);
            make.height.mas_equalTo(20);
            make.centerY.equalTo(userImgV);
        }];
        
        ///显示金币
        if ([[ProjConfig shareInstence].baseConfig liveUnionShowJoinBtn]) {
            [titleL mas_remakeConstraints:^(MASConstraintMaker *make) {
                make.left.equalTo(userImgV.mas_right).mas_offset(5);
                make.top.equalTo(userImgV);
                make.right.equalTo(self).mas_offset(-5);
                make.height.mas_equalTo(20);
            }];
            
            UILabel *coinL = [[UILabel alloc] init];
            coinL.textColor = [UIColor whiteColor];
            coinL.font = [UIFont boldSystemFontOfSize:12];
            [self.contentView addSubview:coinL];
            _coinL = coinL;
            [coinL mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.right.equalTo(titleL);
                make.bottom.equalTo(userImgV);
                make.height.mas_equalTo(14);
            }];
            
            UIButton *btn = [UIButton buttonWithType:0];
            btn.titleLabel.font = [UIFont systemFontOfSize:13];
            [self.contentView addSubview:btn];
            btn.layer.masksToBounds = YES;
            btn.layer.cornerRadius = 12.5;
            btn.layer.borderWidth = 1.0;
            _joinBtn = btn;
            [btn mas_makeConstraints:^(MASConstraintMaker *make) {
                make.size.mas_equalTo(CGSizeMake(73, 25));
                make.left.equalTo(userImgV);
                make.bottom.equalTo(self.contentView).mas_offset(-10);
            }];
        }
    }
    return _userIcon;
}

- (void)selectOneItem:(BOOL)selected {
    _bgColorV.hidden = !selected;
}

- (void)setUserModel:(AdminUserModel *)userModel{
    _userModel = userModel;
    [self.userIcon sd_setImageWithURL:[NSURL URLWithString:userModel.logo] placeholderImage:[ProjConfig getDefaultImage]];
    _userNameL.text = userModel.name;
    _coinL.attributedText = [[NSString stringWithFormat:@"%0.0lf",userModel.coinTotal] attachmentForImage:[ProjConfig getCoinImage] bounds:CGRectMake(0, -2, 13, 13) before:YES];
    
    if ([KLCUserInfo getRole] == 1 && [[ProjConfig shareInstence].baseConfig liveUnionShowJoinBtn]) {
        _joinBtn.hidden = NO;
        _coinL.hidden = NO;
        ///加入工会
        if (userModel.userState == 2) {
            [_joinBtn setTitle:kLocalizationMsg(@"已经加入") forState:UIControlStateNormal];
            _joinBtn.titleLabel.font = [UIFont systemFontOfSize:13 weight:UIFontWeightMedium];
            [_joinBtn setTitleColor:kRGBA_COLOR(@"#FF5EC6", 1.0) forState:UIControlStateNormal];
            _joinBtn.backgroundColor = kRGBA_COLOR(@"#FFE8F7", 1.0);
            _joinBtn.layer.borderColor = [UIColor clearColor].CGColor;
            _joinBtn.userInteractionEnabled = NO;
        }else if (userModel.userState == 1){ ///待加入等待审核
            [_joinBtn setTitle:kLocalizationMsg(@"待审核") forState:UIControlStateNormal];
            _joinBtn.titleLabel.font = [UIFont systemFontOfSize:13 weight:UIFontWeightMedium];
            [_joinBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            _joinBtn.backgroundColor = kRGBA_COLOR(@"#666666", 1.0);
            _joinBtn.layer.borderColor = [UIColor clearColor].CGColor;
            _joinBtn.userInteractionEnabled = NO;
        }else{
            [_joinBtn setTitle:kLocalizationMsg(@"申请加入") forState:UIControlStateNormal];
            _joinBtn.titleLabel.font = [UIFont systemFontOfSize:13];
            _joinBtn.backgroundColor = [UIColor clearColor];
            [_joinBtn setTitleColor:kRGBA_COLOR(@"#FF5EC6", 1.0) forState:UIControlStateNormal];
            _joinBtn.layer.borderColor = kRGBA_COLOR(@"#FF5EC6", 1.0).CGColor;
            _joinBtn.userInteractionEnabled = YES;
        }
        
    }else{
        _joinBtn.hidden = YES;
        _coinL.hidden = YES;
    }
    
}


@end
