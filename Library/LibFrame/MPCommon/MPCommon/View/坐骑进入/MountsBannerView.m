//
//  MountsBannerView.m
//  LiveCommon
//
//  Created by klc_sl on 2020/3/24.
//  Copyright © 2020 . All rights reserved.
//

#import "MountsBannerView.h"
#import <Masonry/Masonry.h>
#import <SDWebImage/SDWebImage.h>
#import <LibTools/LibTools.h>
#import <LibProjBase/LibProjBase.h>
#import <LiveCommon/LiveManager.h>
#import <LibProjModel/AppJoinRoomVOModel.h>

@interface MountsBannerView ()

@property (nonatomic, weak)UIImageView *userIconV;  ///用户图标
@property (nonatomic, weak)UILabel *showTextL;  ///显示文字
@property (nonatomic, weak)UIImageView *subIconV; ///小图标
@property (nonatomic, weak)UIImageView *levelImg; ///小图标
@property (nonatomic, weak)UIView *contentV;

@end

@implementation MountsBannerView


- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self createView];
    }
    return self;
}

- (void)createView{
    UIView *bgView = [[UIView alloc] initWithFrame:CGRectMake(kScreenWidth, 0, self.width, self.height)];
    [self addSubview:bgView];
    _contentV = bgView;
    
    UIImageView *bannerView = [[UIImageView alloc] init];
    bannerView.layer.masksToBounds = YES;
    bannerView.image = [UIImage imageNamed:@"live_join_zuoji"];
    bannerView.contentMode = UIViewContentModeScaleToFill;
    [bgView addSubview:bannerView];
    
    [bannerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self);
        make.left.equalTo(self).mas_offset(12);
        make.height.mas_equalTo(34);
    }];
    
    ///用户头像
    UIImageView *userIcon = [[UIImageView alloc] init];
    userIcon.layer.masksToBounds = YES;
    userIcon.contentMode = UIViewContentModeScaleToFill;
    [bannerView addSubview:userIcon];
    _userIconV = userIcon;
    
    ///副图标
    UIImageView *subIcon = [[UIImageView alloc] init];
    subIcon.layer.masksToBounds = YES;
    [bannerView addSubview:subIcon];
    _subIconV = subIcon;

    ///用户等级图标
    UIImageView *levelImg = [[UIImageView alloc] init];
    levelImg.contentMode = UIViewContentModeScaleAspectFit;
    [bannerView addSubview:levelImg];
    _levelImg = levelImg;
    
    ///显示文字
    UILabel *showTextL = [[UILabel alloc] init];
    showTextL.font = [UIFont systemFontOfSize:12];
    showTextL.textColor = [UIColor whiteColor];
    [bannerView addSubview:showTextL];
    _showTextL = showTextL;

    [userIcon mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(bannerView).mas_offset(2);
        make.size.mas_equalTo(CGSizeMake(30, 30));
        make.centerY.equalTo(bannerView);
        make.right.equalTo(levelImg.mas_left).mas_offset(-10);
    }];

    [subIcon mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(15, 15));
        make.bottom.equalTo(userIcon.mas_bottom);
        make.right.equalTo(userIcon.mas_right).mas_offset(3);
    }];

    [levelImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(40, 40));
        make.centerY.equalTo(bannerView);
        make.right.equalTo(showTextL.mas_left).mas_offset(-5);
    }];
    
    [showTextL mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(bannerView);
        make.right.equalTo(bannerView).mas_offset(-20);
    }];
       
    [bannerView layoutIfNeeded];
    bannerView.layer.cornerRadius = bannerView.height/2.0;

    [userIcon layoutIfNeeded];
    userIcon.layer.cornerRadius = userIcon.height/2.0;
}


- (void)showUserMountsModel:(AppJoinRoomVOModel *)userRoom{
    [_userIconV sd_setImageWithURL:[NSURL URLWithString:userRoom.userAvatar] placeholderImage:[ProjConfig getDefaultImage]];
    NSString *showStr = [NSString stringWithFormat:kLocalizationMsg(@"%@ 坐着【%@】进入直播间"),userRoom.userName, userRoom.carName];
    [_levelImg sd_setImageWithURL:[NSURL URLWithString:userRoom.userGradeImg]];
    _showTextL.text = showStr;
}


@end
