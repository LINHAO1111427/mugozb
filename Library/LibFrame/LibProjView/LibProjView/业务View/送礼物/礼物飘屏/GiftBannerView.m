//
//  GiftBannerView.m
//  LiveCommon
//
//  Created by klc_sl on 2020/3/24.
//  Copyright © 2020 . All rights reserved.
//

#import "GiftBannerView.h"
#import <LibTools/LibTools.h>
#import <Masonry/Masonry.h>
#import <SDWebImage/SDWebImage.h>
#import <LibProjBase/LibProjBase.h>
#import <LibProjModel/ApiGiftSenderModel.h>
#import <LibProjView/KlcAvatarView.h>

@interface LuckGiftView : UIView

@property (nonatomic, weak)UILabel *titleL;

@end

@implementation LuckGiftView

- (instancetype)init{
    self = [super init];
    if (self) {
        [self createUI];
    }
    return self;
}

- (void)createUI{
    UIImageView *imgV = [[UIImageView alloc] init];
    imgV.image = [UIImage imageNamed:@"gift_luck_banner"];
    [self addSubview:imgV];
    [imgV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self);
    }];
    
    UIImageView *imgTextV = [[UIImageView alloc] init];
    imgTextV.image = [UIImage imageNamed:@"gift_banner_text"];
    imgTextV.contentMode = UIViewContentModeScaleAspectFit;
    [self addSubview:imgTextV];
    [imgTextV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(imgV);
        make.left.right.equalTo(imgV);
        make.height.mas_equalTo(15);
    }];
    
    UILabel *titleL = [[UILabel alloc] init];
    titleL.textAlignment = NSTextAlignmentCenter;
    titleL.font = [UIFont boldSystemFontOfSize:12];
    titleL.textColor = [UIColor whiteColor];
    [imgV addSubview:titleL];
    _titleL = titleL;
    [titleL mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self);
        make.bottom.equalTo(imgV);
        make.height.equalTo(imgV).multipliedBy(0.65);
    }];
}


@end


@interface GiftBannerView ()

@property (nonatomic, weak)UIImageView *bannerV;  ///底部图片

@property (nonatomic, weak)KlcAvatarView *userIconV;  ///用户头像
@property (nonatomic, weak)UILabel *userNameL;  ///送礼人名称
@property (nonatomic, weak)UILabel *recevieNameL;  ///收礼人名称

@property (nonatomic, weak)UIImageView *giftV;   ///礼物图标
@property (nonatomic, weak)UILabel *giftNumL; ///送礼个数

@property (nonatomic, weak)LuckGiftView *luckV; ///送礼个数

@end

@implementation GiftBannerView

- (void)dealloc
{
    _giftModel = nil;
}

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
    bannerView.contentMode = UIViewContentModeScaleToFill;
    [self addSubview:bannerView];
    _bannerV = bannerView;
    
    [bannerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self);
        make.left.equalTo(self).mas_offset(12);
        make.height.mas_equalTo(60);
        make.width.mas_equalTo(210);
    }];
    [bannerView layoutIfNeeded];
    
    ///用户头像
    KlcAvatarView *userIcon = [[KlcAvatarView alloc] init];
    [bannerView addSubview:userIcon];
    _userIconV = userIcon;
    
    UIView *centerV = [[UIView alloc] init];
    [bannerView addSubview:centerV];
    
    ///送礼人姓名
    UILabel *userNameL = [[UILabel alloc] init];
    userNameL.font = [UIFont systemFontOfSize:12];
    userNameL.textColor = kRGB_COLOR(@"#FFCC5D");
    userNameL.lineBreakMode = NSLineBreakByCharWrapping;
    [centerV addSubview:userNameL];
    _userNameL = userNameL;
    
    ///收礼人姓名
    UILabel *anchorName = [[UILabel alloc] init];
    anchorName.font = [UIFont systemFontOfSize:10];
    anchorName.textColor = [UIColor whiteColor];
    anchorName.lineBreakMode = NSLineBreakByCharWrapping;
    [centerV addSubview:anchorName];
    _recevieNameL = anchorName;
    
    ///礼物图标
    UIImageView *giftV  = [[UIImageView alloc] init];
    giftV.layer.masksToBounds = YES;
    giftV.contentMode = UIViewContentModeScaleAspectFit;
    [self addSubview:giftV];
    _giftV = giftV;
    
    ///送礼个数
    UILabel *giftNumL = [[UILabel alloc] init];
    giftNumL.font = [UIFont fontWithName:@"Arial-BoldItalicMT" size:22];
    giftNumL.textColor = [UIColor whiteColor];
    [self addSubview:giftNumL];
    _giftNumL = giftNumL;
    
    LuckGiftView *luckV = [[LuckGiftView alloc] init];
    luckV.hidden = YES;
    [self addSubview:luckV];
    _luckV = luckV;
    
    [userIcon mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(bannerView).mas_offset(10);
        make.size.mas_equalTo(CGSizeMake(35, 35));
        make.centerY.equalTo(bannerView);
        make.right.equalTo(centerV.mas_left).mas_offset(-10);
    }];
    [centerV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(giftV).mas_offset(-10);
        make.height.mas_equalTo(28);
        make.centerY.equalTo(bannerView);
    }];
    [userNameL mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.equalTo(centerV);
    }];
    [anchorName mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.left.right.equalTo(centerV);
    }];
    [giftV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(48, 48));
        make.bottom.equalTo(bannerView).mas_offset(-9);
        make.right.equalTo(bannerView).mas_offset(-30);
    }];
    [giftNumL mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(giftV.mas_right).mas_offset(22);
        make.bottom.equalTo(centerV).mas_offset(3);
    }];
    [luckV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(userIcon.mas_right).offset(-5);
        make.width.mas_equalTo(bannerView.width-(80));
        make.bottom.equalTo(bannerView.mas_top).offset(15);
        make.height.mas_equalTo((bannerView.width-(80))* 282/527.0);
    }];
}

- (void)showView:(GiftBannerType)type giftModel:(ApiGiftSenderModel *)giftModel{
    _giftModel = giftModel;
    self.giftNum = 1;
    [_userIconV showUserIconUrl:giftModel.userAvatar vipBorderUrl:giftModel.nobleAvatarFrame];
    _bannerV.image = [UIImage imageNamed:[self bgImgForType:type]];
    [_giftV sd_setImageWithURL:[NSURL URLWithString:giftModel.gifticon]];
    _userNameL.text = giftModel.userName;
    _userNameL.textColor = (type == GiftBannerForNormal)?kRGBA_COLOR(@"#ffffff", 1.0):kRGBA_COLOR(@"#FFEE7B", 1.0);
    _recevieNameL.text = [NSString stringWithFormat:kLocalizationMsg(@"送出 %@"),giftModel.anchorName];
    
    [self changeLianSongNumber:giftModel.continuousNumber luckCoin:giftModel.winCoin];
    
}


- (void)changeLianSongNumber:(NSInteger)liansongNumber luckCoin:(double)coin {
    
    __block NSInteger baseNum = self.giftNum;
    __block NSInteger giftNumber = (_giftModel?_giftModel.giftNumber:1);
    self.giftNum =  (liansongNumber+1)*giftNumber;
    kWeakSelf(self);
    
    if (giftNumber == 1) {
        
        NSString *giftNumStr = [NSString stringWithFormat:@"x%zi",self.giftNum];
        _giftNumL.attributedText = [giftNumStr textColor:[UIColor whiteColor] textBorderColor:kRGB_COLOR(@"#FFCC5D") strokeWidth:-5];

        [UIView animateWithDuration:0.5 animations:^{
            weakself.giftNumL.transform = CGAffineTransformMakeScale(1.5, 1.5);
        } completion:^(BOOL finished) {

            weakself.giftNumL.transform = CGAffineTransformMakeScale(1.0, 1.0);
        }];
        
    }else{
        [self circlePlayGiftNum:self.giftNum baseNum:baseNum];
    }

    if (coin > 0) {
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            weakself.luckV.hidden = NO;
            weakself.luckV.titleL.text = [NSString stringWithFormat:@"%.0lf",coin];
            //            weakself.luckV.titleL.attributedText = [[NSString stringWithFormat:@"%.0lf",coin] attachmentForImage:[ProjConfig getCoinImage] bounds:CGRectMake(0, -2, 13, 13) before:NO];
            weakself.luckV.transform = CGAffineTransformMakeScale(5, 5);
            weakself.luckV.alpha = 0;
            [UIView animateWithDuration:0.3 animations:^{
                weakself.luckV.transform = CGAffineTransformMakeScale(1.0, 1.0);
                weakself.luckV.alpha = 1;
            } completion:^(BOOL finished) {
                
            }];
        });
    }
}

- (void)circlePlayGiftNum:(NSInteger)giftNum baseNum:(NSInteger)baseNum{

    if (giftNum < baseNum) {
        return;
    }else{
        NSString *giftNumStr = [NSString stringWithFormat:@"x%zi",baseNum];
        _giftNumL.attributedText = [giftNumStr textColor:[UIColor whiteColor] textBorderColor:kRGB_COLOR(@"#FFCC5D") strokeWidth:-5];

        kWeakSelf(self);
        [UIView animateWithDuration:0.15 animations:^{
            weakself.giftNumL.transform = CGAffineTransformMakeScale(1.5, 1.5);
        } completion:^(BOOL finished) {
            weakself.giftNumL.transform = CGAffineTransformMakeScale(1.0, 1.0);
            [weakself circlePlayGiftNum:giftNum baseNum:(baseNum+1)];
        }];
    }
}


- (NSString *)bgImgForType:(GiftBannerType)type{
    NSString *bgImgStr = @"";
    switch (type) {
        case GiftBannerForNormal: ///普通礼物
        {
            bgImgStr = @"gift_banner_normal";
        }
            break;
        case GiftBannerForVIP:   ///贵族礼物
        {
            bgImgStr = @"gift_banner_guizu";
        }
            break;
        case GiftBannerForGuard:  ///　守护礼物
        {
            bgImgStr = @"gift_banner_guard";
        }
            break;
        case GiftBannerForFans:   ///粉丝团礼物
        {
            bgImgStr = @"gift_banner_fans";
        }
            break;
        default:
            break;
    }
    return bgImgStr;
    
}

@end
