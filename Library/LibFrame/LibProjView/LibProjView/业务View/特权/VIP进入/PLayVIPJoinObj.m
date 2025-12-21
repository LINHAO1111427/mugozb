//
//  PLayVIPJoinObj.m
//  LiveCommon
//
//  Created by klc_sl on 2020/4/2.
//  Copyright © 2020 . All rights reserved.
//

#import "PLayVIPJoinObj.h"
#import "VIPBannerView.h"
#import <LibProjModel/AppJoinRoomVOModel.h>
#import <LibTools/LibTools.h>
#import <LibProjBase/LibProjBase.h>
#import <LibTools/LiveMacros.h>

@interface PLayVIPJoinObj ()

@property (nonatomic, strong)NSMutableArray *userJoinArr;
@property (nonatomic, weak)UIView *superV;
@property (nonatomic, weak)VIPBannerView *bannerView;
@property (nonatomic, assign)BOOL isAnimation;

@end

@implementation PLayVIPJoinObj

- (void)dealloc
{
    _isAnimation = YES;
    [self removeAllData];
}

- (void)removeAllData{
    [_bannerView removeFromSuperview];
    _bannerView = nil;
    [_userJoinArr removeAllObjects];
    _userJoinArr = nil;
}

- (instancetype)initWithSuperView:(UIView *)superView{
    self = [super init];
    if (self) {
        [self removeAllData];
        _isAnimation = NO;
        _superV = superView;
    }
    return self;
}

- (void)playVIPJoinView:(AppJoinRoomVOModel *)model{
    [self.userJoinArr addObject:model];
    [self playNextGift];
}

- (void)playVIJoinMsgInfo:(AppJoinChatRoomMsgVOModel *)model{
    [self.userJoinArr addObject:model];
    [self playNextGift];
}

- (void)playNextGift{
    if (_isAnimation) {
        return;
    }
    if (_userJoinArr.count > 0) {
        _isAnimation = YES;
        
        id model = _userJoinArr.firstObject;
        if ([model isKindOfClass:[AppJoinRoomVOModel class]]) {
            [self.bannerView showVIPModel:model];
        }else{
            [self.bannerView showMsgVIPModel:model];
        }
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


- (VIPBannerView *)bannerView{
    if (!_bannerView) {
        VIPBannerView *bannerV = [[VIPBannerView alloc] initWithFrame:CGRectMake(kScreenWidth, liveVIPJoinBannerY, kScreenWidth, 50)];
        [_superV addSubview:bannerV];
        _bannerView = bannerV;
    }
    return _bannerView;
}



@end
