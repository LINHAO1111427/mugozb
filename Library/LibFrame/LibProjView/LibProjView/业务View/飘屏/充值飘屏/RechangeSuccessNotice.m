//
//  RechangeSuccessNotice.m
//  LiveCommon
//
//  Created by klc_sl on 2020/4/2.
//  Copyright © 2020 . All rights reserved.
//

#import "RechangeSuccessNotice.h"
#import <LibProjModel/ApiUserInfoModel.h>
#import <LibTools/LibTools.h>
#import <LibProjBase/LibProjBase.h>
#import <LibTools/LiveMacros.h>
#import "RechangeSuccessView.h"

@interface RechangeSuccessNotice ()

@property (nonatomic, strong)NSMutableArray *userJoinArr;
@property (nonatomic, weak)UIView *superV;
@property (nonatomic, weak)RechangeSuccessView *bannerView;
@property (nonatomic, assign)BOOL isAnimation;

@end

@implementation RechangeSuccessNotice

- (void)dealloc
{
    [_bannerView removeAllSubViews];
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

- (void)playCongratulation:(ApiUserInfoModel *)model coin:(double)coin{
    NSArray *itemArr = @[model,@(coin)];
    [self.userJoinArr addObject:itemArr];
    [self playNextGift];
}


- (void)playNextGift{
    if (_isAnimation) {
        return;
    }
    if (_userJoinArr.count > 0) {
        _isAnimation = YES;
        NSArray *itemArr =  _userJoinArr.firstObject;
        [self.bannerView showCongratulationModel:itemArr.firstObject coin:[itemArr.lastObject doubleValue]];
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


- (RechangeSuccessView *)bannerView{
    if (!_bannerView) {
        RechangeSuccessView *bannerV = [[RechangeSuccessView alloc] initWithFrame:CGRectMake(kScreenWidth, liveRechangeBannerY, kScreenWidth, 50)];
        [_superV addSubview:bannerV];
        _bannerView = bannerV;
    }
    return _bannerView;
}



@end
