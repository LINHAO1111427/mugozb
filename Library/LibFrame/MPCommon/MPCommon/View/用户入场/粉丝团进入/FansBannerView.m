//
//  FansBannerView.m
//  LiveCommon
//
//  Created by klc_sl on 2020/3/24.
//  Copyright © 2020 . All rights reserved.
//

#import "FansBannerView.h"
#import <LibTools/LibTools.h>
#import <Masonry/Masonry.h>
#import <SDWebImage/SDWebImage.h>
#import <LibProjBase/LibProjBase.h>
#import <LiveCommon/LiveManager.h>
#import <LibProjModel/AppJoinRoomVOModel.h>

@interface FansBannerView ()

@property (nonatomic, weak)UIImageView *fansIcon;  ///用户图标
@property (nonatomic, weak)UILabel *showTextL;  ///显示文字
@property (nonatomic, weak)UIView *contentV;

@end

@implementation FansBannerView


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
    bannerView.layer.masksToBounds = YES;
    bannerView.image = [UIImage imageNamed:@"live_join_fans"];
    bannerView.contentMode = UIViewContentModeScaleToFill;
    [self addSubview:bannerView];
    
    [bannerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self);
        make.left.equalTo(self).mas_offset(12);
        make.height.mas_equalTo(22);
    }];

    ///粉丝团图标
    UIImageView *fansIcon = [[UIImageView alloc] init];
    fansIcon.image = [UIImage imageNamed:@"live_fans_bannerIcon"];
    fansIcon.contentMode = UIViewContentModeScaleAspectFit;
    [bannerView addSubview:fansIcon];
    _fansIcon = fansIcon;
    
    ///显示文字
    UILabel *showTextL = [[UILabel alloc] init];
    showTextL.font = [UIFont systemFontOfSize:12];
    showTextL.textColor = [UIColor whiteColor];
    [bannerView addSubview:showTextL];
    _showTextL = showTextL;

    [fansIcon mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(bannerView).mas_offset(2);
        make.size.mas_equalTo(CGSizeMake(18, 18));
        make.centerY.equalTo(bannerView);
        make.right.equalTo(showTextL.mas_left).mas_offset(-10);
    }];
    
    [showTextL mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(bannerView);
        make.right.equalTo(bannerView).mas_offset(-20);
    }];

    [bannerView layoutIfNeeded];
    bannerView.layer.cornerRadius = bannerView.height/2.0;

}


- (void)showFansModel:(AppJoinRoomVOModel *)userRoom{
    NSString *showStr = [NSString stringWithFormat:kLocalizationMsg(@"粉丝团成员 %@ 进入直播间"),userRoom.userName];
    _showTextL.text = showStr;
}


@end
