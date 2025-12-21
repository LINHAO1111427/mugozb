//
//  PLayMountsAnimationObj.m
//  LiveCommon
//
//  Created by klc_sl on 2020/3/31.
//  Copyright © 2020 . All rights reserved.
//

#import "PLayMountsAnimationObj.h"

#import <LibProjView/ShowAnimationPicView.h>
#import <LibProjModel/AppJoinRoomVOModel.h>
#import <LibTools/LibTools.h>
#import <LibProjBase/ProjectCache.h>
#import "MountsBannerView.h"
#import <LibTools/LiveMacros.h>

@interface PLayMountsAnimationObj ()

@property (nonatomic, strong)NSMutableArray *userJoinArr;
@property (nonatomic, weak)UIView *animationSuperV;
@property (nonatomic, weak)UIView *bannerSuperV;
@property (nonatomic, weak)ShowAnimationPicView *giftView;
@property (nonatomic, weak)MountsBannerView *bannerView;

@property (nonatomic, assign)BOOL isBannerPlaying; ///横向banner是否播放完成
@property (nonatomic, assign)BOOL isSwfPlaying; ///动态图是否播放完成

@end

@implementation PLayMountsAnimationObj

- (instancetype)initWithSuperView:(UIView *)superView bannerSuperView:(UIView *)bannerSuperV{
    self = [super init];
    if (self) {
        _animationSuperV = superView;
        _bannerSuperV = bannerSuperV;
    }
    return self;
}

- (void)playUserJoinAnimation:(AppJoinRoomVOModel *)userModel{
    [self.userJoinArr addObject:userModel];
    [self playNextGift];
}


- (void)playNextGift{
    if (_isBannerPlaying || _isSwfPlaying) {
        return;
    }
    if (_userJoinArr.count > 0) {
        _isBannerPlaying = YES;
        _isSwfPlaying = YES;
        AppJoinRoomVOModel *model = _userJoinArr.firstObject;
        [self playAnimationView:model];
        [_userJoinArr removeObjectAtIndex:0];
    }
}


- (void)playAnimationView:(AppJoinRoomVOModel *)model{
    NSString *filePath = model.carSwf;
    kWeakSelf(self);
    dispatch_async(dispatch_get_main_queue(), ^{
        [weakself.giftView playAnimationFilePath:filePath finishBlock:^{
            weakself.isSwfPlaying = NO;
            [weakself playNextGift];
        }];
        [weakself.bannerView showUserMountsModel:model];
        [weakself showBannerView:weakself.bannerView];
    });
}



- (void)showBannerView:(UIView *)banner{
    kWeakSelf(self);
    [UIView animateWithDuration:0.3 animations:^{
        CGRect rc = banner.frame;
        rc.origin.x = 0;
        banner.frame = rc;
    } completion:^(BOOL finished) {
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [weakself dismissBannerView:banner];
        });
    }];
}

- (void)dismissBannerView:(UIView *)banner{
    kWeakSelf(self);
    [UIView animateWithDuration:0.3 animations:^{
        CGRect rc = banner.frame;
        rc.origin.x = -weakself.bannerSuperV.width;
        banner.frame = rc;
    } completion:^(BOOL finished) {
        [banner removeFromSuperview];
        weakself.bannerView = nil;
        weakself.isBannerPlaying = NO;
        [weakself playNextGift];
    }];
}



- (NSMutableArray *)userJoinArr{
    if (!_userJoinArr) {
        _userJoinArr = [[NSMutableArray alloc] init];
    }
    return _userJoinArr;
}

- (ShowAnimationPicView *)giftView{
    if (!_giftView) {
        ShowAnimationPicView *giftView = [[ShowAnimationPicView alloc] initWithFrame:self.animationSuperV.bounds];
        [_animationSuperV addSubview:giftView];
        _giftView = giftView;
    }
    return _giftView;
}

- (MountsBannerView *)bannerView{
    if (!_bannerView) {
        MountsBannerView *bannerV = [[MountsBannerView alloc] initWithFrame:CGRectMake(kScreenWidth, liveMountJoinBannerY, kScreenWidth, 50)];
        [_bannerSuperV addSubview:bannerV];
        _bannerView = bannerV;
    }
    return _bannerView;
}




@end
