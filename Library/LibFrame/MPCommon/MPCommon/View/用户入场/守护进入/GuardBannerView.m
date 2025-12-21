//
//  GuardBannerView.m
//  LiveCommon
//
//  Created by klc_sl on 2020/3/24.
//  Copyright © 2020 . All rights reserved.
//

#import "GuardBannerView.h"
#import <LibTools/LibTools.h>
#import <Masonry/Masonry.h>
#import <SDWebImage/SDWebImage.h>
#import <LibProjBase/LibProjBase.h>
#import <LiveCommon/LiveManager.h>
#import <LibProjModel/AppJoinRoomVOModel.h>

@interface GuardBannerView ()

@property (nonatomic, weak)UIImageView *userIcon;  ///用户头像
@property (nonatomic, weak)UIImageView *guardIcon;  ///用户图标
@property (nonatomic, weak)UILabel *showTextL;  ///显示文字
@property (nonatomic, weak)UIView *contentV;

@end

@implementation GuardBannerView


- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self createView];
    }
    return self;
}


- (void)createView{
    
    UIImageView *bannerView = [[UIImageView alloc] init];
    bannerView.image = [UIImage imageNamed:@"live_join_guard"];
    bannerView.contentMode = UIViewContentModeScaleAspectFit;
    [self addSubview:bannerView];
    
    [bannerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self);
        make.left.equalTo(self).mas_offset(22);
        make.height.mas_equalTo(50);
    }];

    ///用户头像
    UIImageView *userIcon = [[UIImageView alloc] init];
    userIcon.contentMode = UIViewContentModeScaleAspectFill;
    userIcon.layer.masksToBounds = YES;
    userIcon.layer.cornerRadius = 20.0;
    [bannerView addSubview:userIcon];
    _userIcon = userIcon;
    
    ///守护图标
    UIImageView *guardIcon = [[UIImageView alloc] init];
    guardIcon.image = [UIImage imageNamed:@"live_shouhu_medal"];
    guardIcon.contentMode = UIViewContentModeScaleAspectFit;
    [bannerView addSubview:guardIcon];
    _guardIcon = guardIcon;
    
    ///显示文字
    UILabel *showTextL = [[UILabel alloc] init];
    showTextL.font = [UIFont systemFontOfSize:14];
    showTextL.textColor = [UIColor whiteColor];
    [bannerView addSubview:showTextL];
    _showTextL = showTextL;

    [userIcon mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(bannerView).mas_offset(-10);
        make.size.mas_equalTo(CGSizeMake(40, 40));
        make.centerY.equalTo(bannerView);
    }];
    
    [guardIcon mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(70*25/60.0, 25));
        make.bottom.equalTo(userIcon);
        make.right.equalTo(userIcon).offset(10);
    }];
    
    [showTextL mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(guardIcon.mas_right).offset(5);
        make.centerY.equalTo(bannerView);
        make.right.equalTo(bannerView).mas_offset(-30);
    }];

    [bannerView layoutIfNeeded];
    bannerView.layer.cornerRadius = bannerView.height/2.0;

}


- (void)showGuardModel:(AppJoinRoomVOModel *)userRoom{
    NSString *showStr = [NSString stringWithFormat:kLocalizationMsg(@"挚爱守护 %@ 来啦～"),userRoom.userName];
    
    NSMutableAttributedString *muStr = [[NSMutableAttributedString alloc] initWithString:showStr];
    [muStr setAttributes:@{NSForegroundColorAttributeName:kRGBA_COLOR(@"#FFFF12", 1.0)} range:NSMakeRange(5, userRoom.userName.length)];
    _showTextL.attributedText = muStr;
    
    [_userIcon sd_setImageWithURL:[NSURL URLWithString:userRoom.userAvatar] placeholderImage:[ProjConfig getDefaultImage]];
}


@end
