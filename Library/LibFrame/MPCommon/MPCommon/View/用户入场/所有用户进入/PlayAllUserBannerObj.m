//
//  PlayAllUserBannerObj.m
//  LiveCommon
//
//  Created by kalacheng on 2020/9/2.
//  Copyright © 2020 KLC. All rights reserved.
//

#import "PlayAllUserBannerObj.h"

#import <LibTools/LibTools.h>
#import <LibProjBase/LibProjBase.h>
#import <LibTools/LiveMacros.h>
#import "AllUserBannerView.h"

#define kMargin 6

@interface PlayAllUserBannerObj()

@property (nonatomic, strong)NSMutableArray *allUserArr;
@property (nonatomic, weak)UIView *superV;
@property (nonatomic, weak)AllUserBannerView *bannerView;
@property (nonatomic, assign)BOOL isAnimation;

@end

@implementation PlayAllUserBannerObj

- (void)dealloc
{
    [_bannerView removeFromSuperview];
    _bannerView = nil;
    _isAnimation = YES;
    [_allUserArr removeAllObjects];
    _allUserArr = nil;
}

- (instancetype)initWithSuperView:(UIView *)superView {
    self = [super init];
    if (self) {
        _superV = superView;
    }
    return self;
}

- (void)playAllUserView:(ApiSimpleMsgRoomModel *)model {
    [self.allUserArr addObject:model];
    [self playNextGift];
}

- (void)playNextGift{
    if (_isAnimation) {
        return;
    }
    if (_allUserArr.count > 0) {
        _isAnimation = YES;
        ApiSimpleMsgRoomModel *model = _allUserArr.firstObject;
        [self.bannerView showAllUserModel:model];
        [self showBannerView:self.bannerView];
        [_allUserArr removeObjectAtIndex:0];
    }
}

- (void)showBannerView:(UIView *)banner{
    kWeakSelf(self);
    [UIView animateWithDuration:0.3 animations:^{
        banner.alpha = 1;
        CGRect rc = banner.frame;
        rc.origin.x = kMargin * 2;
        banner.frame = rc;
    } completion:^(BOOL finished) {
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [weakself dismissBannerView:banner];
        });
    }];
}

- (void)dismissBannerView:(UIView *)banner{
    kWeakSelf(self);
    [UIView animateWithDuration:0.1 animations:^{
        banner.alpha = 0;
    } completion:^(BOOL finished) {
        [banner removeFromSuperview];
        [weakself.bannerView removeFromSuperview];
        weakself.bannerView = nil;
        weakself.isAnimation = NO;
        [weakself playNextGift];
    }];
}

- (NSMutableArray *)allUserArr {
    if (!_allUserArr) {
        _allUserArr = [NSMutableArray array];
    }
    return _allUserArr;;
}

- (AllUserBannerView *)bannerView {
    if (!_bannerView) {
        CGFloat viewH = 210 * kScreenHeight / 640.0 - 40;
        CGFloat viewW = kMargin * 4 + [self defaultTextWidth] * 2 + 31;
        CGRect allUbFrame = CGRectMake(-viewW, _superV.height - viewH - liveBottomViewH - 5 - kSafeAreaBottom, viewW, 22);
        AllUserBannerView *bannerView = [[AllUserBannerView alloc] initWithFrame:allUbFrame];
        [_superV addSubview:bannerView];
        _bannerView = bannerView;
    }
    return _bannerView;;
}

- (CGFloat)defaultTextWidth {
    CGSize size =[kLocalizationMsg(@"进入了直播间") sizeWithAttributes:@{NSFontAttributeName : [UIFont systemFontOfSize:12]}];
    return size.width;
}

@end
