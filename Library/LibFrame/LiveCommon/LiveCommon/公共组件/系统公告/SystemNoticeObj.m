//
//  SystemNoticeObj.m
//  LiveCommon
//
//  Created by klc_sl on 2020/4/14.
//  Copyright © 2020 . All rights reserved.
//

#import "SystemNoticeObj.h"
#import "LiveSystemNoticeView.h"
#import <LibProjModel/ApiSimpleMsgRoomModel.h>
#import <LibTools/LibTools.h>
#import <LibProjBase/LibProjBase.h>

@interface SystemNoticeObj ()

@property (nonatomic, strong)NSMutableArray *systemArr;
@property (nonatomic, weak)UIView *superV;
@property (nonatomic, weak)LiveSystemNoticeView *bannerView;
@property (nonatomic, assign)BOOL isAnimation;

@end

@implementation SystemNoticeObj

- (void)dealloc
{
    [_systemArr removeAllObjects];
    _systemArr = nil;
}

- (instancetype)initWithSuperView:(UIView *)superView{
    self = [super init];
    if (self) {
        _superV = superView;
    }
    return self;
}

- (void)addMsg:(ApiSimpleMsgRoomModel *)model{
    [self.systemArr addObject:model];
    [self playNextGift];
}


- (void)playNextGift{
    if (_isAnimation) {
        return;
    }
    if (_systemArr.count > 0) {
        _isAnimation = YES;
        ApiSimpleMsgRoomModel *model = _systemArr.firstObject;
        [self.bannerView showSystemNoticeModel:model];
        [self showBannerView:self.bannerView];
        [_systemArr removeObjectAtIndex:0];
    }
}

- (void)showBannerView:(UIView *)banner{
    kWeakSelf(self);
    [UIView animateWithDuration:0.3 animations:^{
        CGRect rc = banner.frame;
        rc.origin.x = 0;
        banner.frame = rc;
    } completion:^(BOOL finished) {
        [weakself.bannerView playNoticeAndFinishBlock:^{
            [weakself dismissBannerView:banner];
        }];
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


- (NSMutableArray *)systemArr{
    if (!_systemArr) {
        _systemArr = [[NSMutableArray alloc] init];
    }
    return _systemArr;
}


- (LiveSystemNoticeView *)bannerView{
    if (!_bannerView) {
        LiveSystemNoticeView *bannerV = [[LiveSystemNoticeView alloc] initWithFrame:CGRectMake(kScreenWidth, kNavBarHeight+10, kScreenWidth, 22)];
        [_superV addSubview:bannerV];
        _bannerView = bannerV;
    }
    return _bannerView;
}



@end
