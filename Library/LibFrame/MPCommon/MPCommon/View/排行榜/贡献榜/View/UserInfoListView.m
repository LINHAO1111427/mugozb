//
//  UserInfoListView.m
//  LiveCommon
//
//  Created by klc_sl on 2020/4/15.
//  Copyright © 2020 . All rights reserved.
//

#import "UserInfoListView.h"
#import <Masonry/Masonry.h>
#import <LibTools/LibTools.h>
#import <LibProjBase/LibProjBase.h>
#import <SDWebImage/SDWebImage.h>

#import <LibProjModel/HttpApiPublicLive.h>
#import <LiveCommon/LiveManager.h>
 

@implementation UserInfoListView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self createUI];
    }
    return self;
}

- (void)createUI{
    
    UIView *line = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, 0.8)];
    line.backgroundColor = [UIColor groupTableViewBackgroundColor];
    [self addSubview:line];
    
    ///用户头像
    KlcAvatarView *imgV = [[KlcAvatarView alloc] initWithFrame:CGRectMake(38.0, (self.height-40)/2.0, 40, 40)];
    [self addSubview:imgV];
    _userIcon = imgV;
    
    ///排行
    UILabel *numberLab = [[UILabel alloc] init];
    numberLab.font = [UIFont boldSystemFontOfSize:15];
    numberLab.textColor = [UIColor darkGrayColor];
    numberLab.textAlignment = NSTextAlignmentCenter;
    [self addSubview:numberLab];
    _numberL = numberLab;
    
    ///用户名
    UILabel *titleL = [[UILabel alloc] init];
    titleL.font = [UIFont boldSystemFontOfSize:13];
    titleL.textColor = [UIColor blackColor];
    [self addSubview:titleL];
    _titleL = titleL;
    
    ///固定文字
    UILabel *textL = [[UILabel alloc] init];
    textL.text = kLocalizationMsg(@"距离前1名");
    textL.font = [UIFont boldSystemFontOfSize:12];
    textL.textColor = [UIColor lightGrayColor];
    [self addSubview:textL];
    
    ///金币
    UILabel *coinLab = [[UILabel alloc] init];
    coinLab.font = [UIFont systemFontOfSize:14];
    coinLab.textColor = [UIColor blackColor];
    [self addSubview:coinLab];
    _coinL = coinLab;

    ///性别
    SWHTapImageView *genderImgV = [[SWHTapImageView alloc] init];
    genderImgV.layer.masksToBounds = YES;
    genderImgV.layer.cornerRadius = 7.5;
    [self addSubview:genderImgV];
    self.sexImgV = genderImgV;
    
    ///等级图标
    UIImageView *levelImg = [[UIImageView alloc] init];
    levelImg.contentMode = UIViewContentModeScaleAspectFit;
    [self addSubview:levelImg];
    _level1ImgV = levelImg;
    
    UIImageView *level2Img = [[UIImageView alloc] init];
    level2Img.contentMode = UIViewContentModeScaleAspectFit;
    [self addSubview:level2Img];
    _level2ImgV = level2Img;
    
    
    ///排名
    [numberLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self);
        make.left.equalTo(self);
        make.right.equalTo(imgV.mas_left);
    }];
    
    ///金币lab
    [coinLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self).mas_offset(-12);
        make.centerY.equalTo(self);
        make.left.equalTo(textL.mas_right);
    }];
    ///文字
    [textL mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self);
        make.width.mas_equalTo(62);
    }];
    
    ///用户名称
    [titleL mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(imgV).offset(2);
        make.left.equalTo(imgV.mas_right).mas_offset(10);
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
}


- (void)setUserRankModel:(RanksDtoModel *)model{
    ///金币
    self.coinL.attributedText = [[NSString stringWithFormat:@"%0.0lf",model.upperLevelDelta] attachmentForImage:[ProjConfig getCoinImage] bounds:CGRectMake(0, -4, 18, 18) before:YES];
    ///图标
    [self.userIcon showUserIconUrl:model.avatar vipBorderUrl:model.nobleAvatarFrame];
    
    _titleL.text = model.username.length?model.username:@"";

    _numberL.text = [NSString stringWithFormat:@"%d",model.sort];
    
    
    ///性别与角色
    UIImage *image = [[ProjConfig shareInstence].baseConfig imageGender:model.sex age:model.age role:model.role];
    if (image) {
        self.sexImgV.image = image;
    }else{
        [self.sexImgV mas_updateConstraints:^(MASConstraintMaker *make) {
            make.width.mas_equalTo(0);
        }];
    }
    self.sexImgV.btnClick = ^(int type) {
        [[ProjConfig shareInstence].businessConfig showAuthAlertView:[ProjConfig currentVC].view role:model.role];
    };
    
    if (model.wealthGradeImg.length > 0) {
        [self.level1ImgV sd_setImageWithURL:[NSURL URLWithString:model.wealthGradeImg]];
        [self.level2ImgV sd_setImageWithURL:[NSURL URLWithString:model.nobleGradeImg]];
    }else{
        [self.level1ImgV sd_setImageWithURL:[NSURL URLWithString:model.nobleGradeImg]];
        [self.level2ImgV sd_setImageWithURL:[NSURL URLWithString:@""]];
    }
}


- (void)loadUserInfoData{
    self.hidden = YES;
    kWeakSelf(self);
    [HttpApiPublicLive getLiveUserRank:[LiveManager liveInfo].roomId userId:[ProjConfig userId] callback:^(int code, NSString *strMsg, RanksDtoModel *model) {
        if (code == 1) {
            weakself.hidden = NO;
            [weakself setUserRankModel:model];
        }
    }];
}

@end
