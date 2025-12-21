//
//  LiveBuyGoodsShowObj.m
//  LiveCommon
//
//  Created by klc_sl on 2020/3/24.
//  Copyright © 2020 . All rights reserved.
//

#import "LiveBuyGoodsShowObj.h"
#import "LiveGoodsBannerView.h"
#import <LibTools/LibTools.h>
#import <LibProjBase/LibProjBase.h>
#import <Masonry/Masonry.h>
#import <LibProjModel/UserBuyDTOModel.h>
#import <LibProjModel/KLCAppConfig.h>
#import <LibTools/LiveMacros.h>

@interface LiveBuyGoodsShowObj ()

@property (nonatomic, assign)BOOL isShow;

@property (nonatomic, weak)UIView *superV;

@property (nonatomic, strong)NSMutableArray<UserBuyDTOModel *> *itemArr;

@property (nonatomic, weak)LiveGoodsBannerView *bannerV;

@end

@implementation LiveBuyGoodsShowObj


- (void)dealloc
{
    [_itemArr removeAllObjects];
    _itemArr = nil;
    [NSObject cancelPreviousPerformRequestsWithTarget:self selector:@selector(dismissBannerView) object:nil];
    [_bannerV removeFromSuperview];
}

- (instancetype)initWithSuperView:(UIView *)superView{
    self = [super init];
    if (self) {
        _superV = superView;
    }
    return self;
}

- (void)playGoods:(UserBuyDTOModel *)goods {
    ///判断礼物是否正在显示中
    [self.itemArr addObject:goods];
    ///初始化数据
    [self playNextGift];
}


- (NSMutableArray *)itemArr{
    if (_itemArr == nil) {
        _itemArr = [[NSMutableArray alloc] init];
    }
    return _itemArr;
}

- (LiveGoodsBannerView *)bannerV{
    if (!_bannerV) {
        LiveGoodsBannerView *bgV = [[LiveGoodsBannerView alloc] initWithFrame:CGRectMake(-_superV.size.width, liveVIPGiftBannerY, _superV.size.width, 50)];
        [_superV addSubview:bgV];
        _bannerV = bgV;
    }
    return _bannerV;
}

#pragma mark - 动画 -

- (void)showBannerView{
    kWeakSelf(self);
    [UIView animateWithDuration:0.3 animations:^{
        CGRect rc = weakself.bannerV.frame;
        rc.origin.x = 0;
        weakself.bannerV.frame = rc;
    } completion:^(BOOL finished) {
        [weakself reStartTime];
    }];
}

- (void)reStartTime{
    if (_isShow && self.bannerV.x >= 0) { ///礼物正在显示
        [NSObject cancelPreviousPerformRequestsWithTarget:self selector:@selector(dismissBannerView) object:nil];
        [self performSelector:@selector(dismissBannerView) withObject:nil afterDelay:[KLCAppConfig giftHoldTime]];
    }
}


- (void)dismissBannerView{
    kWeakSelf(self);
    [UIView animateWithDuration:0.1 animations:^{
        CGRect rc = weakself.bannerV.frame;
        rc.origin.x = -rc.size.width;
        weakself.bannerV.frame = rc;
    } completion:^(BOOL finished) {
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [weakself initalShowView];
        });
    }];
}

- (void)initalShowView{
    _isShow = NO;
    [_bannerV removeFromSuperview];
    _bannerV = nil;
    [self playNextGift];
}



- (void)playNextGift{
    if (_isShow) {
        return;
    }
    
    if (_itemArr.count) {
        _isShow = YES;
        UserBuyDTOModel *goods = _itemArr.firstObject;
        [self.bannerV showGoodsModel:goods];
        [self showBannerView];
        [_itemArr removeObjectAtIndex:0];
    }
}



@end
