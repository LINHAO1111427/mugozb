//
//  LiveGoodsBannerView.m
//  LiveCommon
//
//  Created by klc_sl on 2020/3/24.
//  Copyright © 2020 . All rights reserved.
//

#import "LiveGoodsBannerView.h"
#import <LibTools/LibTools.h>
#import <Masonry/Masonry.h>
#import <SDWebImage/SDWebImage.h>
#import <LibProjBase/LibProjBase.h>
#import <LiveCommon/LiveManager.h>
#import <LibProjModel/UserBuyDTOModel.h>

@interface LiveGoodsBannerView ()

@property (nonatomic, weak)UIImageView *bannerV;  ///底部图片

///送礼人信息
@property (nonatomic, weak)UIImageView *userIconV;  ///用户图标
@property (nonatomic, weak)UILabel *contentL;  ///用户名

@end

@implementation LiveGoodsBannerView


- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        [self createView];
    }
    return self;
}

- (void)createView{
    UIImageView *bannerView = [[UIImageView alloc] init];
    bannerView.layer.masksToBounds = YES;
    bannerView.contentMode = UIViewContentModeScaleToFill;
    [self addSubview:bannerView];
    _bannerV = bannerView;
    [bannerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self);
        make.left.equalTo(self).mas_offset(12);
        make.height.mas_equalTo(34);
    }];
    
    UIView *colorV = [[UIView alloc] init];
    colorV.backgroundColor = [[UIColor whiteColor] colorWithAlphaComponent:0.9];
    [bannerView addSubview:colorV];
    [colorV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(bannerView);
    }];
    
    ///用户头像
    UIImageView *userIcon = [[UIImageView alloc] init];
    userIcon.layer.masksToBounds = YES;
    userIcon.layer.borderWidth = 1.0;
    userIcon.contentMode = UIViewContentModeScaleToFill;
    [bannerView addSubview:userIcon];
    _userIconV = userIcon;
    
    ///送礼人姓名
    UILabel *contentLab = [[UILabel alloc] init];
    contentLab.font = [UIFont systemFontOfSize:12];
    contentLab.textColor = kRGB_COLOR(@"#FFCC5D");
    contentLab.lineBreakMode = NSLineBreakByCharWrapping;
    [bannerView addSubview:contentLab];
    _contentL = contentLab;

    
    [userIcon mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(bannerView).mas_offset(7);
        make.size.mas_equalTo(CGSizeMake(19, 19));
        make.centerY.equalTo(bannerView);
        make.right.equalTo(contentLab.mas_left).mas_offset(-5);
    }];
    
    [contentLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(bannerView);
        make.right.equalTo(bannerView).mas_offset(-7);
    }];
    
    [bannerView layoutIfNeeded];
    bannerView.layer.cornerRadius = 3.0;
    
}



- (void)showGoodsModel:(UserBuyDTOModel *)goods{
    
    [_userIconV sd_setImageWithURL:[NSURL URLWithString:goods.avatar] placeholderImage:[ProjConfig getDefaultImage]];
    NSString *showStr = [NSString stringWithFormat:kLocalizationMsg(@"%@ 购买了%@ 刚刚"),goods.username, goods.goodsName];
    NSMutableAttributedString *muStr = [[NSMutableAttributedString alloc] initWithString:showStr];
    NSRange nameRange = [showStr rangeOfString:goods.username];
    [muStr setAttributes:@{NSForegroundColorAttributeName:kRGB_COLOR(@"#FF5500")} range:nameRange];
    [muStr setAttributes:@{NSForegroundColorAttributeName:kRGB_COLOR(@"#AAAAAA")} range:NSMakeRange(showStr.length-2, 2)];
    _contentL.attributedText = muStr;
    
}


@end
