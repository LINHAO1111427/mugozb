//
//  GiftGlobalBannerView.m
//  LiveCommon
//
//  Created by klc_sl on 2020/3/24.
//  Copyright © 2020 . All rights reserved.
//

#import "GiftGlobalBannerView.h"
#import <LibTools/LibTools.h>
#import <Masonry/Masonry.h>
#import <SDWebImage/SDWebImage.h>
#import <LibProjBase/LibProjBase.h>
#import <LibProjModel/ApiGiftSenderModel.h>
#import "KlcAvatarView.h"

@interface GiftGlobalBannerView ()

@property (nonatomic, weak)UIImageView *bannerV;  ///底部图片

///送礼人信息
@property (nonatomic, weak)KlcAvatarView *sendUserIconV;  ///用户图标
@property (nonatomic, weak)UILabel *sendUserNameL;  ///送礼人用户图标
///收礼人信息
@property (nonatomic, weak)KlcAvatarView *receiveUserIconV;  ///收礼人 头像
@property (nonatomic, weak)UILabel *receiveUserNameL;  ///收礼人用户图标

@property (nonatomic, weak)UIImageView *giftV;   ///礼物图标
@property (nonatomic, weak)UILabel *giftNumL; ///送礼个数


@end

@implementation GiftGlobalBannerView

- (void)dealloc
{
    if (_giftModel) {
        _giftModel = nil;
    }
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.userInteractionEnabled = NO;
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
        make.height.mas_equalTo(32);
    }];

    ///用户头像
    KlcAvatarView *userIcon = [[KlcAvatarView alloc] init];
    [bannerView addSubview:userIcon];
    _sendUserIconV = userIcon;
    
    ///送礼人
    UILabel *sendUserNameL = [[UILabel alloc] init];
    sendUserNameL.font = [UIFont systemFontOfSize:14];
    sendUserNameL.textColor = kRGBA_COLOR(@"#FFF113", 1.0);
    [bannerView addSubview:sendUserNameL];
    _sendUserNameL = sendUserNameL;
    
    ///显示文字
    UILabel *showTextL = [[UILabel alloc] init];
    showTextL.font = [UIFont systemFontOfSize:14];
    showTextL.textColor = [UIColor whiteColor];
    showTextL.text = kLocalizationMsg(@"送给");
    showTextL.textAlignment = NSTextAlignmentCenter;
    [bannerView addSubview:showTextL];
    
    ///收礼人头像
    KlcAvatarView *anchorIcon = [[KlcAvatarView alloc] init];
    [bannerView addSubview:anchorIcon];
    _receiveUserIconV = anchorIcon;
    
    ///收礼人名称
    UILabel *receiveUserNameL = [[UILabel alloc] init];
    receiveUserNameL.font = [UIFont systemFontOfSize:14];
    receiveUserNameL.textColor = kRGBA_COLOR(@"#FFF113", 1.0);
    [bannerView addSubview:receiveUserNameL];
    _receiveUserNameL = receiveUserNameL;
    
    ///礼物图标
    UIImageView *giftV  = [[UIImageView alloc] init];
    giftV.layer.masksToBounds = YES;
    giftV.contentMode = UIViewContentModeScaleAspectFit;
    [bannerView addSubview:giftV];
    _giftV = giftV;
    
    ///送礼个数
    UILabel *giftNumL = [[UILabel alloc] init];
    giftNumL.font = [UIFont fontWithName:@"Arial-BoldItalicMT" size:22];
    giftNumL.textColor = [UIColor whiteColor];
    [self addSubview:giftNumL];
    _giftNumL = giftNumL;
    
    [userIcon mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(bannerView).mas_offset(8);
        make.size.mas_equalTo(CGSizeMake(22, 22));
        make.centerY.equalTo(bannerView);
        make.right.equalTo(sendUserNameL.mas_left).mas_offset(-5);
    }];

    [sendUserNameL mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(bannerView);
        make.width.mas_equalTo(20);
        make.right.equalTo(showTextL.mas_left).mas_offset(-1);
    }];
    
    [showTextL mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(bannerView);
        make.width.mas_equalTo(30);
        make.right.equalTo(anchorIcon.mas_left).mas_offset(-5);
    }];
    
    [anchorIcon mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(22, 22));
        make.centerY.equalTo(bannerView);
        make.right.equalTo(receiveUserNameL.mas_left).mas_offset(-5);
    }];
    
    [receiveUserNameL mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(bannerView);
        make.width.mas_equalTo(20);
        make.right.equalTo(giftV.mas_left).mas_offset(-3);
    }];
    
    [giftV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(30, 30));
        make.bottom.equalTo(bannerView).mas_offset(-3);
        make.right.equalTo(bannerView).mas_offset(-18);
    }];
    
    [giftNumL mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(bannerView).mas_offset(0);
        make.left.equalTo(bannerView.mas_right).mas_offset(9);
    }];
    
    [bannerView layoutIfNeeded];
    [bannerView layoutIfNeeded];
    bannerView.layer.cornerRadius = _bannerV.height/2.0;
    
}

- (void)showGiftModel:(ApiGiftSenderModel *)giftModel{
    _giftModel = giftModel;
    
    _bannerV.image = [UIImage imageNamed:@"gift_banner_all"];
    [_sendUserIconV showUserIconUrl:giftModel.userAvatar vipBorderUrl:giftModel.nobleAvatarFrame];
    [_receiveUserIconV showUserIconUrl:giftModel.anchorAvatar vipBorderUrl:nil];
    [_giftV sd_setImageWithURL:[NSURL URLWithString:giftModel.gifticon]];
    _sendUserNameL.text = giftModel.userName;
    _receiveUserNameL.text = giftModel.anchorName;
    
    CGSize sendNameSize = [giftModel.userName sizeWithAttributes:@{NSFontAttributeName:_sendUserNameL.font}];
    [_sendUserNameL mas_updateConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(sendNameSize.width+5);
    }];
    CGSize receiveNameSize = [giftModel.anchorName sizeWithAttributes:@{NSFontAttributeName:_receiveUserNameL.font}];
    [_receiveUserNameL mas_updateConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(receiveNameSize.width+5);
    }];
    
    [self changeLiansongNumber:giftModel.continuousNumber];

}


- (void)changeLiansongNumber:(NSInteger)liansongNumber{
    
    NSString *giftNumStr = [NSString stringWithFormat:@"x%zi",(liansongNumber+1)*(_giftModel?_giftModel.giftNumber:1)];
    _giftNumL.attributedText = [giftNumStr textColor:[UIColor whiteColor] textBorderColor:kRGB_COLOR(@"#FFCC5D") strokeWidth:-5];
    kWeakSelf(self);
    [UIView animateWithDuration:0.5 animations:^{
        weakself.giftNumL.transform = CGAffineTransformMakeScale(1.5, 1.5);
    } completion:^(BOOL finished) {
        weakself.giftNumL.transform = CGAffineTransformMakeScale(1.0, 1.0);
    }];
}


@end
