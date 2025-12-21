//
//  MsgTopMessageView.m
//  Message
//
//  Created by klc_sl on 2021/8/6.
//  Copyright © 2021 KLC. All rights reserved.
//

#import "MsgTopMessageView.h"
#import <Masonry/Masonry.h>
#import <LibProjBase/LibProjBase.h>
#import <LibTools/LibTools.h>
#import <LibProjModel/AppChatFamilyMsgTopVOModel.h>
#import <SDWebImage/SDWebImage.h>

@implementation MsgTopMessageView

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self createUI];
    }
    return self;
}

- (void)createUI{
    ///背景图
    UIImageView *bgImgV = [[UIImageView alloc] init];
    bgImgV.image = [UIImage imageNamed:@"message_top_bg"];
    bgImgV.contentMode = UIViewContentModeScaleAspectFill;
    bgImgV.clipsToBounds= YES;
    [self addSubview:bgImgV];
    self.bgImgV = bgImgV;
    [bgImgV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self);
    }];
    
    ///用户头像
    KlcAvatarView *userIconV = [[KlcAvatarView alloc] initWithFrame:CGRectMake(15, 15, 50, 50)];
    [userIconV addTarget:self action:@selector(topMsgUserIconClick) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:userIconV];
    userIconV.userIcon.layer.borderWidth = 1.0;
    userIconV.userIcon.layer.borderColor = [UIColor whiteColor].CGColor;
    self.userIconV = userIconV;
    
    ///用户名称
    UILabel *timeL = [[UILabel alloc] init];
    timeL.textColor = [[UIColor whiteColor] colorWithAlphaComponent:0.7];
    timeL.font = [UIFont systemFontOfSize:14];
    [self addSubview:timeL];
    self.timeL = timeL;
    [timeL mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(userIconV);
        make.right.equalTo(self).offset(-15);
        make.height.mas_equalTo(17);
    }];
    
    ///用户名称
    UILabel *userNameL = [[UILabel alloc] init];
    userNameL.textColor = [[UIColor whiteColor] colorWithAlphaComponent:0.7];
    userNameL.font = [UIFont systemFontOfSize:14];
    [self addSubview:userNameL];
    self.usernameL = userNameL;
    [userNameL mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self).offset(15);
        make.left.equalTo(userIconV.mas_right).offset(10);
        make.height.mas_equalTo(17);
    }];
    ///用户性别
    SWHTapImageView *userGenderV = [[SWHTapImageView alloc] init];
    userGenderV.layer.masksToBounds = YES;
    userGenderV.layer.cornerRadius = 7.5;
    [self addSubview:userGenderV];
    self.genderImgV = userGenderV;
    [userGenderV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(30, 15));
        make.left.equalTo(userNameL.mas_right).offset(5);
        make.centerY.equalTo(userNameL);
    }];
    
    ///用户性别
    UIImageView *userLevelV = [[UIImageView alloc] init];
    userLevelV.layer.masksToBounds = YES;
    userLevelV.layer.cornerRadius = 7.5;
    [self addSubview:userLevelV];
    self.levelImgV = userLevelV;
    [userLevelV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(30, 15));
        make.left.equalTo(userGenderV.mas_right).offset(5);
        make.centerY.equalTo(userGenderV);
    }];
    
    ///用户发送的内容
    UILabel *contentL = [[UILabel alloc] init];
    contentL.textColor = [UIColor whiteColor];
    contentL.numberOfLines = 0;
    contentL.font = [UIFont systemFontOfSize:15];
    [self addSubview:contentL];
    self.contentL = contentL;
    [contentL mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(userIconV.mas_bottom).offset(-20);
        make.left.equalTo(userNameL);
        make.right.equalTo(self).offset(-15);
        make.bottom.equalTo(self).offset(-20);
    }];
}


- (void)setMsgModel:(AppChatFamilyMsgTopVOModel *)msgModel{
    if (msgModel.isShow == 1 && msgModel.topMsgContent.length > 0) {
        self.hidden = NO;
    }else{
        self.hidden = YES;
    }
    [self.userIconV showUserIconUrl:msgModel.userAvatar vipBorderUrl:msgModel.nobleAvatarFrame];
    self.usernameL.text = msgModel.userName;
    [self.levelImgV sd_setImageWithURL:[NSURL URLWithString:msgModel.gradeImg]];
    UIImage *image = [[ProjConfig shareInstence].baseConfig imageGender:1 age:msgModel.age role:0];
    if (image) {
        self.genderImgV.image = image;
        self.genderImgV.btnClick = ^(int type) {
            [[ProjConfig shareInstence].businessConfig showAuthAlertView:[ProjConfig currentVC].view role:0];
        };
    }else{
        [self.genderImgV mas_updateConstraints:^(MASConstraintMaker *make) {
            make.width.mas_equalTo(0);
        }];
    }
    self.genderImgV.btnClick = ^(int type) {
        [[ProjConfig shareInstence].businessConfig showAuthAlertView:[ProjConfig currentVC].view role:0];
    };
    self.timeL.text = [[NSDate date] timeStringWithDateFormat:@"HH:mm"];
    self.contentL.text = msgModel.topMsgContent;
    
}


///显示用户基本信息
- (void)topMsgUserIconClick{
    if (self.delegate) {
        [self.delegate msgTopMessageForUserInfoClick:self];
    }
}

@end
