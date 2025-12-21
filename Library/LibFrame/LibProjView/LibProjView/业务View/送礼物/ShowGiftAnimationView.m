//
//  ShowGiftAnimationView.m
//  LibProjView
//
//  Created by klc_sl on 2021/6/3.
//  Copyright © 2021 KLC. All rights reserved.
//

#import "ShowGiftAnimationView.h"
#import <LibProjView/GiftNormalShowObj.h>
#import <LibProjView/GiftFansShowObj.h>
#import <LibProjView/GiftNobilityShowObj.h>
#import <LibProjView/GiftGuardShowObj.h>
#import <LibProjView/PrivilegeGiftShowObj.h>
#import <LibProjView/PLayGiftAnimationObj.h>
#import <LibProjModel/ApiGiftSenderModel.h>

@interface ShowGiftAnimationView ()

@property (nonatomic,weak) UIView *bannerBgV;

@property (nonatomic, copy) GiftNormalShowObj *normalObj; ///普通礼物
@property (nonatomic, copy) GiftFansShowObj *fansObj;   ///粉丝团礼物
@property (nonatomic, copy) GiftNobilityShowObj *nobilityObj;   ///贵族礼物
@property (nonatomic, copy) GiftGuardShowObj *guardObj;   ///守护礼物
@property (nonatomic, copy) PrivilegeGiftShowObj *privilegeGiftObj;///特权礼物
@property (nonatomic, copy) PLayGiftAnimationObj *playAnimation;  // 动画礼物

@end

@implementation ShowGiftAnimationView

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self initView];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self initView];
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)coder
{
    self = [super initWithCoder:coder];
    if (self) {
        [self initView];
    }
    return self;
}

- (void)initView{
    self.userInteractionEnabled = NO;
}

- (void)dealloc
{
    _normalObj = nil;
    _fansObj = nil;
    _nobilityObj = nil;
    _guardObj = nil;
    _privilegeGiftObj = nil;
    _playAnimation = nil;
}

- (void)showGiftBanner:(ApiGiftSenderModel *)giftInfo {
    ///去掉豪华礼物
    switch (giftInfo.type) {
        case 0:  ///普通礼物
        {
            [self.normalObj playNormalGift:giftInfo];
        }
            break;
        case 1:   ///粉丝团(豪华礼物)
        {
            [self.fansObj playFansGift:giftInfo];
        }
            break;
        case 2:  ///守护(专属礼物)
        {
            [self.guardObj playGuardGift:giftInfo];
        }
            break;
        case 3:  ///贵族礼物(特殊礼物)
        {
            [self.nobilityObj playNobilityGift:giftInfo];
        }
            break;
        default:
        {
            [self.normalObj playNormalGift:giftInfo];
        }
            break;
    }
}

- (void)playAnimationEffect:(ApiGiftSenderModel *)giftInfo{
    if (giftInfo.giftswf.length > 0) {
        [self.playAnimation playGiftAnimation:giftInfo];
    }
    if (giftInfo.sendGiftPrivilege) {///礼物特权展示
        [self.privilegeGiftObj ShowPrivilegeGiftAnimation:giftInfo];
    }
}

#pragma mark - 懒加载 -

///普通礼物
- (GiftNormalShowObj *)normalObj{
    if (!_normalObj) {
        _normalObj = [[GiftNormalShowObj alloc] initWithSuperView:self.bannerBgV];
    }
    return _normalObj;
}

///粉丝团播放
- (GiftFansShowObj *)fansObj{
    if (!_fansObj) {
        _fansObj = [[GiftFansShowObj alloc] initWithSuperView:self.bannerBgV];
    }
    return _fansObj;
}

///播放动画
- (PLayGiftAnimationObj *)playAnimation{
    if (!_playAnimation) {
        _playAnimation = [[PLayGiftAnimationObj alloc] initWithSuperView:self];
    }
    return _playAnimation;
}

///守护
- (GiftGuardShowObj *)guardObj{
    if (!_guardObj) {
        _guardObj = [[GiftGuardShowObj alloc] initWithSuperView:self.bannerBgV];
    }
    return _guardObj;
}

///贵族
- (GiftNobilityShowObj *)nobilityObj{
    if (!_nobilityObj) {
        _nobilityObj = [[GiftNobilityShowObj alloc] initWithSuperView:self.bannerBgV];
    }
    return _nobilityObj;
}

- (PrivilegeGiftShowObj *)privilegeGiftObj{
    if (!_privilegeGiftObj) {
        _privilegeGiftObj = [[PrivilegeGiftShowObj alloc]initWithSuperView:self];
    }
    return _privilegeGiftObj;
}

- (UIView *)bannerBgV{
    if (!_bannerBgV) {
        UIView *bannerV = [[UIView alloc] init];
        if (self.bannerSuperV) {
            [self.bannerSuperV addSubview:bannerV];
        }else{
            [self addSubview:bannerV];
        }
        [bannerV.superview bringSubviewToFront:bannerV];
        _bannerBgV = bannerV;
        [bannerV mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(self);
        }];
        [bannerV layoutIfNeeded];
    }
    return _bannerBgV;
}

@end
