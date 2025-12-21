//
//  RechangeSuccessView.m
//  LiveCommon
//
//  Created by klc_sl on 2020/3/24.
//  Copyright © 2020 . All rights reserved.
//

#import "RechangeSuccessView.h"
#import <LibTools/LibTools.h>
#import <Masonry/Masonry.h>
#import <SDWebImage/SDWebImage.h>
#import <LibProjBase/LibProjBase.h>
#import <LibProjModel/ApiUserInfoModel.h>

@interface RechangeSuccessView ()

@property (nonatomic, weak)UIImageView *userIconV;  ///用户图标
@property (nonatomic, weak)UILabel *showTextL;  ///显示文字
@property (nonatomic, weak)UIImageView *subIconV; ///小图标
@property (nonatomic, weak)UIView *contentV;

@end

@implementation RechangeSuccessView


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
    bannerView.image = [UIImage imageNamed:@"banner_rechange_bg"];
    bannerView.contentMode = UIViewContentModeScaleToFill;
    [self addSubview:bannerView];
    
    [bannerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self);
        make.left.equalTo(self).mas_offset(12);
        make.height.mas_equalTo(34);
    }];
    [bannerView layoutIfNeeded];
    bannerView.layer.cornerRadius = bannerView.height/2.0;
    
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
    showTextL.font = [UIFont systemFontOfSize:12];
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
        make.right.equalTo(bannerView).mas_offset(-37);
    }];
    
    [userIcon layoutIfNeeded];
    userIcon.layer.cornerRadius = userIcon.height/2.0;
}

- (void)showCongratulationModel:(ApiUserInfoModel *)model coin:(double)coin{
    
    [_userIconV sd_setImageWithURL:[NSURL URLWithString:model.avatar] placeholderImage:[ProjConfig getDefaultImage]];
    NSString *showStr = [NSString stringWithFormat:kLocalizationMsg(@"恭喜【%@】充值成功 "),model.username];
    NSMutableAttributedString *muStr = [[NSMutableAttributedString alloc] initWithString:showStr];
    [muStr setAttributes:@{NSForegroundColorAttributeName:kRGB_COLOR(@"#FFCC5D")} range:NSMakeRange(3, model.username.length)];
    
    NSString *coinStr = [NSString stringWithFormat:kLocalizationMsg(@"%0.2f元"),coin];
    NSMutableAttributedString *muCoinStr = [[NSMutableAttributedString alloc] init];
    [muCoinStr appendAttributedString:[coinStr textColor:[UIColor whiteColor] textBorderColor:kRGB_COLOR(@"#FF9800") strokeWidth:-3.0]];
    [muCoinStr addAttributes:@{NSFontAttributeName:[UIFont boldSystemFontOfSize:18]} range:NSMakeRange(0, coinStr.length)];
    
    [muStr appendAttributedString:muCoinStr];

    _showTextL.attributedText = muStr;
}


@end
