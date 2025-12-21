//
//  LiveUserListCell.m
//  LiveCommon
//
//  Created by klc_sl on 2020/3/23.
//  Copyright © 2020 . All rights reserved.
//

#import "LiveUserListCell.h"
#import <Masonry/Masonry.h>
#import <LibTools/LibTools.h>
#import <SDWebImage/SDWebImage.h>
#import <LibProjBase/LibProjBase.h>
#import <LibProjView/KlcAvatarView.h>
#import <LibProjView/SWHTapImageView.h>
#import <LibProjModel/ApiUserBasicInfoModel.h>
#import <LibProjModel/RanksDtoModel.h>

#import <LiveCommon/LiveComponentMsgMgr.h>
#import <LiveCommon/LiveComponentMsgListener.h>

@interface LiveUserListCell ()

///占位视图
@property (nonatomic, weak) UIView *bgView;


@property (weak, nonatomic) KlcAvatarView *userIcon;  ///用户头像
 
@property (weak, nonatomic) UILabel *titleL;  ///用户名称

@property (weak, nonatomic) UIImageView *level1ImgV;  ///用户等级1

@property (weak, nonatomic) UIImageView *level2ImgV;  ///用户等级2

@property (weak, nonatomic) UILabel *coinL;  ///金币数

@property (weak, nonatomic) SWHTapImageView *genderImgV;  ///性别+年龄

@property (nonatomic, assign)int64_t userId;

@end

@implementation LiveUserListCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.bgView.hidden = NO;
    }
    return self;
    
}

- (void)layoutSubviews{
    [super layoutSubviews];
    _userIcon.layer.cornerRadius = _userIcon.height/2.0;
}

- (void)awakeFromNib {
    [super awakeFromNib];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
}

- (UIView *)bgView{
    if (!_bgView) {
        UIView *bgView = [[UIView alloc] init];
        [self.contentView addSubview:bgView];
        _bgView = bgView;
        
        ///排行
        UILabel *numberLab = [[UILabel alloc] init];
        numberLab.font = [UIFont boldSystemFontOfSize:15];
        numberLab.textColor = [UIColor darkGrayColor];
        numberLab.textAlignment = NSTextAlignmentCenter;
        [bgView addSubview:numberLab];
        _numberL = numberLab;
        
        ///用户头像
        KlcAvatarView *imgV = [[KlcAvatarView alloc] init];
        [bgView addSubview:imgV];
        [imgV addTarget:self action:@selector(userIconClick:) forControlEvents:UIControlEventTouchUpInside];
        _userIcon = imgV;
        
        ///用户名
        UILabel *titleL = [[UILabel alloc] init];
        titleL.font = [UIFont boldSystemFontOfSize:13];
        titleL.textColor = [UIColor blackColor];
        [bgView addSubview:titleL];
        _titleL = titleL;
        
        SWHTapImageView *genderImgV = [[SWHTapImageView alloc] init];
        genderImgV.contentMode = UIViewContentModeScaleAspectFill;
        [bgView addSubview:genderImgV];
        genderImgV.layer.masksToBounds = YES;
        genderImgV.layer.cornerRadius = 7.5;
        _genderImgV = genderImgV;
        
        ///等级图标
        UIImageView *levelImg = [[UIImageView alloc] init];
        levelImg.contentMode = UIViewContentModeScaleAspectFit;
        [bgView addSubview:levelImg];
        _level1ImgV = levelImg;
        
        UIImageView *level2Img = [[UIImageView alloc] init];
        level2Img.contentMode = UIViewContentModeScaleAspectFit;
        [bgView addSubview:level2Img];
        _level2ImgV = level2Img;
        
        ///金币
        UILabel *coinLab = [[UILabel alloc] init];
        coinLab.font = [UIFont systemFontOfSize:12];
        coinLab.textColor = [UIColor blackColor];
        [bgView addSubview:coinLab];
        _coinL = coinLab;
        
        
        [bgView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(self);
        }];
        
        ///图标
        [imgV mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(bgView);
            make.left.equalTo(bgView).mas_offset(48);
            make.size.mas_equalTo(CGSizeMake(40, 40));
            make.right.equalTo(titleL.mas_left).mas_offset(-10);
        }];
        
        ///金币lab
        [coinLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(bgView).mas_offset(-12);
            make.centerY.equalTo(bgView);
        }];
        
        ///用户名称
        [titleL mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(imgV).offset(2);
            make.width.mas_lessThanOrEqualTo(kScreenWidth/4.0);
        }];
        
        [genderImgV mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.equalTo(imgV).offset(-2);
            make.size.mas_equalTo(CGSizeMake(30, 15));
            make.left.equalTo(titleL);
            make.right.equalTo(levelImg.mas_left).offset(-5);
        }];
        
        ///等级
        [levelImg mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(CGSizeMake(30, 15));
            make.centerY.equalTo(genderImgV);
            make.right.equalTo(level2Img.mas_left).offset(-5);
        }];
        
        [level2Img mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(CGSizeMake(30, 15));
            make.centerY.equalTo(genderImgV);
        }];
        
        ///排名
        [numberLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(bgView);
            make.left.equalTo(bgView);
            make.right.equalTo(imgV.mas_left);
        }];
        
        [bgView layoutIfNeeded];
    }
    return _bgView;
    
}


- (void)userIconClick:(UIButton *)btn{
    if (self.userId > 0) {
        [LiveComponentMsgMgr sendMsg:LM_ShowUserInfo msgDic:@{@"userID":@(self.userId)}];
    }
}


- (void)setUserModel:(ApiUserBasicInfoModel *)userModel{
    _userModel = userModel;
    
    self.userId = userModel.uid;
    
    NSString *coin = [NSString stringWithFormat:@"%0.0lf",userModel.currContValue];

    ///金币
    self.coinL.attributedText = [coin attachmentForImage:[ProjConfig getCoinImage] bounds:CGRectMake(0, -5, 18, 18) before:YES];
    ///图标
    [self.userIcon showUserIconUrl:userModel.avatar vipBorderUrl:userModel.nobleAvatarFrame];
    
    self.titleL.text = userModel.username.length?userModel.username:@"";
    
    ///性别与角色
    UIImage *image = [[ProjConfig shareInstence].baseConfig imageGender:userModel.sex age:userModel.age role:userModel.role];
    if (image) {
        self.genderImgV.image = image;
    }else{
        [self.genderImgV mas_updateConstraints:^(MASConstraintMaker *make) {
            make.width.mas_equalTo(0);
        }];
    }
    self.genderImgV.btnClick = ^(int type) {
        [[ProjConfig shareInstence].businessConfig showAuthAlertView:[ProjConfig currentVC].view role:userModel.role];
    };
     
    
    if (userModel.wealthGradeImg.length > 0) {
        [self.level1ImgV sd_setImageWithURL:[NSURL URLWithString:userModel.wealthGradeImg]];
        [self.level2ImgV sd_setImageWithURL:[NSURL URLWithString:userModel.nobleGradeImg]];
    }else{
        [self.level1ImgV sd_setImageWithURL:[NSURL URLWithString:userModel.nobleGradeImg]];
        [self.level2ImgV sd_setImageWithURL:[NSURL URLWithString:@""]];
    }
}



- (void)setRanksModel:(RanksDtoModel *)ranksModel{
    _ranksModel = ranksModel;
    
    self.userId = ranksModel.userId;
    
    NSString *coin = [NSString stringWithFormat:@"%0.0lf",ranksModel.delta];
    
    ///金币
    self.coinL.attributedText = [coin attachmentForImage:[ProjConfig getCoinImage] bounds:CGRectMake(0, -5, 18, 18) before:YES];
    ///图标
    [self.userIcon showUserIconUrl:ranksModel.avatar vipBorderUrl:ranksModel.nobleAvatarFrame];
    
    self.titleL.text = ranksModel.username.length?ranksModel.username:@"";
    
    ///性别与角色
    UIImage *image = [[ProjConfig shareInstence].baseConfig imageGender:ranksModel.sex age:ranksModel.age role:ranksModel.role];
    if (image) {
        self.genderImgV.image = image;
    }else{
        [self.genderImgV mas_updateConstraints:^(MASConstraintMaker *make) {
            make.width.mas_equalTo(0);
        }];
    }
    self.genderImgV.btnClick = ^(int type) {
        [[ProjConfig shareInstence].businessConfig showAuthAlertView:[ProjConfig currentVC].view role:ranksModel.role];
    };
     
    
    if (ranksModel.wealthGradeImg.length > 0) {
        [self.level1ImgV sd_setImageWithURL:[NSURL URLWithString:ranksModel.wealthGradeImg]];
        [self.level2ImgV sd_setImageWithURL:[NSURL URLWithString:ranksModel.nobleGradeImg]];
    }else{
        [self.level1ImgV sd_setImageWithURL:[NSURL URLWithString:ranksModel.nobleGradeImg]];
        [self.level2ImgV sd_setImageWithURL:[NSURL URLWithString:@""]];
    }
    
}


@end
