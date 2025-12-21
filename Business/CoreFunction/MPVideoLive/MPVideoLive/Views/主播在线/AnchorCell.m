//
//  AnchorCell.m
//  klc
//
//  Created by David on 16/5/21.
//  Copyright © 2018年 David. All rights reserved.
//

#import "AnchorCell.h"
 
#import <LibTools/LibTools.h>
#import <SDWebImage/SDWebImage.h>

#import <LibProjBase/ProjConfig.h>
#import <LibProjBase/LibProjBase.h>

#import <LibProjModel/KLCAppConfig.h>
#import <LibProjModel/ApiUsableAnchorRespModel.h>
#import <Masonry/Masonry.h>
#import <LibProjView/KlcAvatarView.h>

@implementation AnchorCell


- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{

    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self createUI];
    }
    return self;
}


- (void)createUI{
    ///用户头像
    KlcAvatarView *avaterImageView = [[KlcAvatarView alloc]init];
    [avaterImageView addTarget:self action:@selector(userInfoClick) forControlEvents:UIControlEventTouchUpInside];
    [self.contentView addSubview:avaterImageView];
    self.iconImgView = avaterImageView;
    [avaterImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(40, 40));
        make.centerY.equalTo(self.contentView);
        make.left.equalTo(self.contentView).offset(12);
    }];
    ///用户名称
    UILabel *userNameLb = [[UILabel alloc] init];
    userNameLb.font = [UIFont systemFontOfSize:14];
    userNameLb.textColor = [UIColor blackColor];
    userNameLb.textAlignment = NSTextAlignmentLeft;
    [self.contentView addSubview:userNameLb];
    self.nameL = userNameLb;
    [userNameLb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(avaterImageView.mas_right).offset(10);
        make.top.equalTo(avaterImageView).offset(1);
    }];
    
    ///性别
    SWHTapImageView *userGenderImgV = [[SWHTapImageView alloc]init];
    userGenderImgV.layer.cornerRadius = 7.5;
    userGenderImgV.layer.masksToBounds = YES;
    userGenderImgV.contentMode = UIViewContentModeScaleAspectFit;
    [self.contentView addSubview:userGenderImgV];
    self.sexImgView = userGenderImgV;
    [userGenderImgV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(30, 15));
        make.left.equalTo(userNameLb);
        make.bottom.equalTo(avaterImageView).offset(-1);
    }];
    
    ///用户等级
    UIImageView *userLevel1ImageV = [[UIImageView alloc]init];
    userLevel1ImageV.contentMode = UIViewContentModeScaleAspectFit;
    [self.contentView addSubview:userLevel1ImageV];
    _level1ImgV = userLevel1ImageV;
    [userLevel1ImageV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(30, 15));
        make.left.equalTo(userGenderImgV.mas_right).offset(5);
        make.centerY.equalTo(userGenderImgV);
    }];
    
    UIImageView *level2ImgV = [[UIImageView alloc] init];
    level2ImgV.contentMode = UIViewContentModeScaleAspectFit;
    [self.contentView addSubview:level2ImgV];
    _level2ImgV = level2ImgV;
    [level2ImgV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(30, 15));
        make.left.equalTo(userLevel1ImageV.mas_right).offset(5);
        make.centerY.equalTo(userLevel1ImageV);
    }];
    
    UIButton *btn = [UIButton buttonWithType:0];
    btn.layer.cornerRadius = 15;
    btn.layer.masksToBounds = YES;
    btn.titleLabel.font = [UIFont systemFontOfSize:13];
    [btn setTitle:kLocalizationMsg(@"邀请连麦") forState:UIControlStateNormal];
    [self.contentView addSubview:btn];
    self.linkBtn = btn;
    [btn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(80, 30));
        make.right.mas_equalTo(self.contentView).offset(-12);
        make.centerY.equalTo(self.contentView);
    }];
    
}


- (void)setModel:(ApiUsableAnchorRespModel *)model {
    _model = model;
    [_iconImgView showUserIconUrl:model.userAvatar vipBorderUrl:model.nobleAvatarFrame];
    _nameL.text = model.userName;
  
    ///性别与角色
    UIImage *image = [[ProjConfig shareInstence].baseConfig imageGender:model.sex age:model.age role:1];
    if (image) {
        self.sexImgView.image = image;
    }else{
        [self.sexImgView mas_updateConstraints:^(MASConstraintMaker *make) {
            make.width.mas_equalTo(0);
        }];
    }
    
    self.sexImgView.btnClick = ^(int type) {
        [[ProjConfig shareInstence].businessConfig showAuthAlertView:[ProjConfig currentVC].view role:1];
    };

    if (model.wealthGradeImg.length > 0) {
        [self.level1ImgV sd_setImageWithURL:[NSURL URLWithString:model.wealthGradeImg]];
        [self.level2ImgV sd_setImageWithURL:[NSURL URLWithString:model.nobleGradeImg]];
    }else{
        [self.level1ImgV sd_setImageWithURL:[NSURL URLWithString:model.nobleGradeImg]];
        [self.level2ImgV sd_setImageWithURL:[NSURL URLWithString:@""]];
    }
    
    _linkBtn.layer.borderWidth = 1.0;
    
    ///1可互动0不可互动
    if (model.ismic == 0) {
        _linkBtn.layer.borderColor = kRGB_COLOR(@"#c7c8c9").CGColor;
        [_linkBtn setTitleColor:kRGB_COLOR(@"#c7c8c9") forState:0];
        _linkBtn.userInteractionEnabled = NO;
        [_linkBtn setTitle:kLocalizationMsg(@"连麦中") forState:0];
    }else{
        _linkBtn.layer.borderColor = [ProjConfig normalColors].CGColor;
        [_linkBtn setTitleColor:[ProjConfig normalColors] forState:0];
        _linkBtn.userInteractionEnabled = NO;
        [_linkBtn setTitle:kLocalizationMsg(@"邀请连麦") forState:0];
    }
    
}

- (void)userInfoClick{

}

@end
