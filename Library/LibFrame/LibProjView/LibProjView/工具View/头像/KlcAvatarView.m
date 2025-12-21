//
//  KlcAvatarView.m
//  LibProjView
//
//  Created by klc_sl on 2020/12/18.
//  Copyright © 2020 KLC. All rights reserved.
//

#import "KlcAvatarView.h"
#import <SDWebImage/SDWebImage.h>

@interface KlcAvatarView ()

@property (nonatomic, weak)UIImageView *userIcon;

@property (nonatomic, weak)UIImageView *vipBorder;

@end

@implementation KlcAvatarView

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self createUI];
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)coder
{
    self = [super initWithCoder:coder];
    if (self) {
        [self createUI];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self createUI];
    }
    return self;
}

- (void)layoutSubviews{
    [super layoutSubviews];
    _userIcon.layer.cornerRadius = _userIcon.height/2.0;
}

- (void)createUI{
    
    UIImageView *userIconV = [[UIImageView alloc] init];
    userIconV.contentMode = UIViewContentModeScaleAspectFill;
    userIconV.layer.masksToBounds = YES;
    [self addSubview:userIconV];
    [self sendSubviewToBack:userIconV];
    _userIcon = userIconV;
    [userIconV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self);
    }];
    
    ///贵族框
    UIImageView *vipBorderV = [[UIImageView alloc] init];
    [self addSubview:vipBorderV];
    [self bringSubviewToFront:vipBorderV];
    _vipBorder = vipBorderV;
    [vipBorderV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.height.equalTo(self.userIcon).multipliedBy(8/5.3);
        make.center.equalTo(self.userIcon);
    }];
}


- (void)showUserIconUrl:(NSString *)url vipBorderUrl:(NSString *)vipBorderUrl {
    [self.userIcon sd_setImageWithURL:[NSURL URLWithString:url] placeholderImage:[ProjConfig getDefaultImage]];
    [self.vipBorder sd_setImageWithURL:[NSURL URLWithString:vipBorderUrl]];
}


@end
