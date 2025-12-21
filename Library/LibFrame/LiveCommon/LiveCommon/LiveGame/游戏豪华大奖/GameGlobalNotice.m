//
//  GameGlobalNotice.m
//  LiveCommon
//
//  Created by klc_sl on 2020/3/24.
//  Copyright © 2020 . All rights reserved.
//

#import "GameGlobalNotice.h"
#import "GameGlobalBannerView.h"
#import <LibTools/LibTools.h>
#import <LibProjBase/LibProjBase.h>
#import <Masonry/Masonry.h>
#import <LibProjModel/GameUserWinAwardsDTOModel.h>
#import <LibProjModel/KLCAppConfig.h>
#import <LibTools/LiveMacros.h>

@interface GameGlobalNotice ()

@property (nonatomic, strong)NSMutableArray *userJoinArr;
@property (nonatomic, weak)UIView *superV;
@property (nonatomic, weak)GameGlobalBannerView *bannerView;
@property (nonatomic, assign)BOOL isAnimation;

@end

@implementation GameGlobalNotice

- (void)dealloc
{
    [_userJoinArr removeAllObjects];
    _userJoinArr = nil;
}

- (instancetype)initWithSuperView:(UIView *)superView{
    self = [super init];
    if (self) {
        _superV = superView;
    }
    return self;
}

- (void)playGlobalPrize:(GameUserWinAwardsDTOModel *)prizeModel{
    [self.userJoinArr addObject:prizeModel];
    [self playNextGift];
}


- (void)playNextGift{
    if (_isAnimation) {
        return;
    }
    if (_userJoinArr.count > 0) {
        _isAnimation = YES;
        GameUserWinAwardsDTOModel *prizeModel =  _userJoinArr.firstObject;
        [self.bannerView showPrizeModel:prizeModel];
        [self showBannerView:self.bannerView];
        [_userJoinArr removeObjectAtIndex:0];
    }
}

- (void)showBannerView:(UIView *)banner{
    kWeakSelf(self);
    [UIView animateWithDuration:0.3 animations:^{
        CGRect rc = banner.frame;
        rc.origin.x = 0;
        banner.frame = rc;
    } completion:^(BOOL finished) {
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3.4 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [weakself dismissBannerView:banner];
        });
    }];
}

- (void)dismissBannerView:(UIView *)banner{
    kWeakSelf(self);
    [UIView animateWithDuration:0.3 animations:^{
        CGRect rc = banner.frame;
        rc.origin.x = - weakself.superV.width;
        banner.frame = rc;
    } completion:^(BOOL finished) {
        [banner removeFromSuperview];
        [weakself.bannerView removeFromSuperview];
        weakself.bannerView = nil;
        weakself.isAnimation = NO;
        [weakself playNextGift];
    }];
}


- (NSMutableArray *)userJoinArr{
    if (!_userJoinArr) {
        _userJoinArr = [[NSMutableArray alloc] init];
    }
    return _userJoinArr;
}


- (GameGlobalBannerView *)bannerView{
    if (!_bannerView) {
        GameGlobalBannerView *bannerV = [[GameGlobalBannerView alloc] initWithFrame:CGRectMake(kScreenWidth, liveRechangeBannerY-70, kScreenWidth, 50)];
        [_superV addSubview:bannerV];
        _bannerView = bannerV;
    }
    return _bannerView;
}


@end
