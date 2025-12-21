//
//  GameGlobalBannerView.m
//  LiveCommon
//
//  Created by klc_sl on 2020/3/24.
//  Copyright © 2020 . All rights reserved.
//

#import "GameGlobalBannerView.h"
#import <LibTools/LibTools.h>
#import <Masonry/Masonry.h>
#import <SDWebImage/SDWebImage.h>
#import <LibProjBase/LibProjBase.h>
#import <LibProjModel/GameUserWinAwardsDTOModel.h>

@interface GameGlobalBannerView ()

@property (nonatomic, weak)UIImageView *userIconV;  ///用户图标
@property (nonatomic, weak)UILabel *showTextL;  ///显示文字
@property (nonatomic, weak)UIImageView *subIconV; ///小图标
@property (nonatomic, weak)UIView *contentV;

@end

@implementation GameGlobalBannerView


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
    UIView *bgView = [[UIView alloc] initWithFrame:CGRectMake(kScreenWidth, 0, self.width, self.height)];
    [self addSubview:bgView];
    _contentV = bgView;
    
    UIImageView *bannerView = [[UIImageView alloc] init];
    bannerView.layer.masksToBounds = YES;
    bannerView.contentMode = UIViewContentModeScaleToFill;
    [bgView addSubview:bannerView];
    bannerView.layer.cornerRadius = 4.0;
    [bannerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self);
        make.left.equalTo(self).mas_offset(12);
        make.height.mas_equalTo(34);
    }];
    
    ///背景图
    UIImageView *imageV = [[UIImageView alloc] init];
    imageV.image = [UIImage imageNamed:@"live_btn_purple"];
    imageV.contentMode = UIViewContentModeScaleToFill;
    imageV.alpha = 0.7;
    [bannerView addSubview:imageV];
    
    ///用户头像
    UIImageView *userIcon = [[UIImageView alloc] init];
    userIcon.layer.masksToBounds = YES;
    userIcon.layer.borderWidth = 1.0;
    userIcon.contentMode = UIViewContentModeScaleToFill;
    userIcon.layer.borderColor = kRGB_COLOR(@"#FFCC5D").CGColor;
    [bannerView addSubview:userIcon];
    _userIconV = userIcon;
    
    ///副图标
    UIImageView *subIcon = [[UIImageView alloc] init];
    subIcon.layer.masksToBounds = YES;
    [bannerView addSubview:subIcon];
    _subIconV = subIcon;
    
    
    ///显示文字
    UILabel *showTextL = [[UILabel alloc] init];
    showTextL.font = [UIFont systemFontOfSize:14];
    showTextL.textColor = [UIColor whiteColor];
    [bannerView addSubview:showTextL];
    _showTextL = showTextL;
    
    [userIcon mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(bannerView).mas_offset(2);
        make.size.mas_equalTo(CGSizeMake(30, 30));
        make.centerY.equalTo(bannerView);
        make.right.equalTo(showTextL.mas_left).mas_offset(-10);
    }];
    
    [subIcon mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(15, 15));
        make.bottom.equalTo(userIcon.mas_bottom);
        make.right.equalTo(userIcon.mas_right).mas_offset(3);
    }];
    
    [showTextL mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(bannerView);
        make.right.equalTo(bannerView).mas_offset(-15);
    }];
    
    [imageV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.left.right.equalTo(bannerView);
    }];
    
    [userIcon layoutIfNeeded];
    userIcon.layer.cornerRadius = userIcon.height/2.0;
}

- (void)showPrizeModel:(GameUserWinAwardsDTOModel *)model{
    
    _userIconV.image = [UIImage imageNamed:@"game_banner_star"];
    
    NSString *gameStr = [NSString stringWithFormat:@"%@x%d",model.awardsName, model.awardsNum];
    NSString *showStr = [NSString stringWithFormat:kLocalizationMsg(@"恭喜 %@ %@抽中 %@"),model.userName, model.gameName, gameStr];
    NSMutableAttributedString *muStr = [[NSMutableAttributedString alloc] initWithString:showStr];
    
    [muStr setAttributes:@{NSForegroundColorAttributeName:kRGB_COLOR(@"#FFCC5D")} range:NSMakeRange(3, model.userName.length)];
    
    [muStr setAttributes:@{NSForegroundColorAttributeName:kRGB_COLOR(@"#FF9800")} range:NSMakeRange(showStr.length - gameStr.length - 1, gameStr.length + 1)];
    
    _showTextL.attributedText = muStr;
    
}


@end
