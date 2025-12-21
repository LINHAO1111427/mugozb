//
//  VIPBannerView.m
//  LiveCommon
//
//  Created by klc_sl on 2020/3/24.
//  Copyright © 2020 . All rights reserved.
//

#import "VIPBannerView.h"
#import <LibTools/LibTools.h>
#import <Masonry/Masonry.h>
#import <SDWebImage/SDWebImage.h>
#import <LibProjBase/LibProjBase.h>
#import <LibProjModel/AppJoinRoomVOModel.h>
#import <LibProjModel/AppJoinChatRoomMsgVOModel.h>

@interface VIPBannerView ()

@property (nonatomic, weak)UIImageView *vipIconV;  ///VIP图标
@property (nonatomic, weak)UILabel *showTextL;  ///显示文字
@property (nonatomic, weak)UIImageView *coinIconV; ///等级图标
@property (nonatomic, weak)UILabel *nameL; ///用户名称
@property (nonatomic, weak)UIView *contentV;

@end

@implementation VIPBannerView


- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.userInteractionEnabled = NO;
        [self createView];
    }
    return self;
}


- (void)createView{

    UIImageView *bannerView = [[UIImageView alloc] init];
    bannerView.layer.masksToBounds = YES;
    bannerView.image = [UIImage imageNamed:@"live_join_VIP"];
    bannerView.contentMode = UIViewContentModeScaleToFill;
    [self addSubview:bannerView];
    
    [bannerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self);
        make.left.equalTo(self).mas_offset(30);
        make.height.mas_equalTo(40);
    }];
    [bannerView layoutIfNeeded];
    bannerView.layer.cornerRadius = bannerView.height/2.0;

    ///贵族等级图标
    UIImageView *vipIconV = [[UIImageView alloc] init];
    vipIconV.contentMode = UIViewContentModeScaleAspectFill;
    [self addSubview:vipIconV];
    _vipIconV = vipIconV;
    
    ///username
    UILabel *nameL = [[UILabel alloc] init];
    nameL.font = [UIFont systemFontOfSize:14];
    nameL.textColor = [UIColor whiteColor];
    [bannerView addSubview:nameL];
    _nameL = nameL;
    
    ///显示文字
    UILabel *showTextL = [[UILabel alloc] init];
    showTextL.font = [UIFont systemFontOfSize:12];
    showTextL.textColor = [UIColor yellowColor];
    [bannerView addSubview:showTextL];
    _showTextL = showTextL;

    ///副图标
    UIImageView *coinIconV = [[UIImageView alloc] init];
    coinIconV.layer.masksToBounds = YES;
    [bannerView addSubview:coinIconV];
    _coinIconV= coinIconV;


    [vipIconV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(bannerView).mas_offset(-10);
        make.size.mas_equalTo(CGSizeMake(50, 50));
        make.bottom.equalTo(bannerView);
    }];

    [nameL mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(bannerView).offset(3);
        make.height.mas_equalTo(17);
        make.left.equalTo(vipIconV.mas_right).offset(10);
    }];
    
    [coinIconV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(30, 15));
        make.centerY.equalTo(nameL);
        make.left.equalTo(nameL.mas_right).offset(5);
    }];
    
    [showTextL mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(bannerView).offset(-3);
        make.left.equalTo(nameL);
        make.right.equalTo(bannerView).offset(-20);
    }];
}



- (void)showVIPModel:(AppJoinRoomVOModel *)userRoom{
    [self.vipIconV sd_setImageWithURL:[NSURL URLWithString:userRoom.nobleMedal] placeholderImage:[ProjConfig getAppIcon]];
    self.nameL.text = userRoom.userName;
    [self.coinIconV sd_setImageWithURL:[NSURL URLWithString:userRoom.wealthGradeImg]];
    _showTextL.text = [NSString stringWithFormat:kLocalizationMsg(@"欢迎 %@ 驾临直播间"),userRoom.nobleName];
}



- (void)showMsgVIPModel:(AppJoinChatRoomMsgVOModel *)userInfo{
   
    [self.vipIconV sd_setImageWithURL:[NSURL URLWithString:userInfo.nobleMedal] placeholderImage:[ProjConfig getAppIcon]];
    self.nameL.text = userInfo.userName;
    [self.coinIconV sd_setImageWithURL:[NSURL URLWithString:userInfo.wealthGradeImg]];
    _showTextL.text = [NSString stringWithFormat:kLocalizationMsg(@"欢迎 %@ 进入聊天室"),userInfo.nobleName];
    
}


@end
