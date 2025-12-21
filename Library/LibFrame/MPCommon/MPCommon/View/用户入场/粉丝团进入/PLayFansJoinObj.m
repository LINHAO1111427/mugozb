//
//  PLayFansJoinObj.m
//  LiveCommon
//
//  Created by klc_sl on 2020/4/2.
//  Copyright © 2020 . All rights reserved.
//

#import "PLayFansJoinObj.h"
#import "FansBannerView.h"
#import <LibProjModel/AppJoinRoomVOModel.h>
#import <LibTools/LibTools.h>
#import <LibProjBase/LibProjBase.h>
#import <LibTools/LiveMacros.h>

@interface PLayFansJoinObj ()

@property (nonatomic, strong)NSMutableArray *userJoinArr;
@property (nonatomic, weak)UIView *superV;
@property (nonatomic, weak)FansBannerView *bannerView;
@property (nonatomic, assign)BOOL isAnimation;

@end

@implementation PLayFansJoinObj
- (void)dealloc
{
    [_bannerView removeFromSuperview];
    _bannerView = nil;
    _isAnimation = YES;
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

- (void)playFansJoinView:(AppJoinRoomVOModel *)model{
    [self.userJoinArr addObject:model];
    [self playNextGift];
}


- (void)playNextGift{
    if (_isAnimation) {
        return;
    }
    if (_userJoinArr.count > 0) {
        _isAnimation = YES;
        AppJoinRoomVOModel *model = _userJoinArr.firstObject;
        [self.bannerView showFansModel:model];
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


- (FansBannerView *)bannerView{
    if (!_bannerView) {
        FansBannerView *bannerV = [[FansBannerView alloc] initWithFrame:CGRectMake(kScreenWidth, liveVIPJoinBannerY+30, kScreenWidth, 22)];
        [_superV addSubview:bannerV];
        _bannerView = bannerV;
    }
    return _bannerView;
}



@end
