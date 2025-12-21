//
//  GiftGuardShowObj.m
//  LiveCommon
//
//  Created by klc_sl on 2020/3/24.
//  Copyright © 2020 . All rights reserved.
//

#import "GiftGuardShowObj.h"
#import "GiftBannerView.h"
#import <LibTools/LibTools.h>
#import <LibProjBase/LibProjBase.h>
#import <Masonry/Masonry.h>
#import <LibProjModel/ApiGiftSenderModel.h>
#import <LibProjModel/KLCAppConfig.h>
#import <LibTools/LiveMacros.h>

@interface GiftGuardShowObj ()

@property (nonatomic, assign)BOOL isShow;
@property (nonatomic, weak)UIView *superV;
@property (nonatomic, strong)NSMutableArray<ApiGiftSenderModel *> *itemArr;
@property (nonatomic, weak)GiftBannerView *bannerV;


@end

@implementation GiftGuardShowObj


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

- (void)playGuardGift:(ApiGiftSenderModel *)giftModel{
    
    ///判断礼物是否正在显示中
    if (![self judgeGiftView:giftModel]) {  ///　没有显示
        [self.itemArr addObject:giftModel];
        ///初始化数据
        [self playNextGift];
    }
}


- (NSMutableArray *)itemArr{
    if (_itemArr == nil) {
        _itemArr = [[NSMutableArray alloc] initWithCapacity:1];
    }
    return _itemArr;
}

- (GiftBannerView *)bannerV{
    if (!_bannerV) {
        GiftBannerView *bgV = [[GiftBannerView alloc] initWithFrame:CGRectMake(-_superV.size.width, liveGuardGiftBannerY, _superV.size.width, 50)];
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
    kWeakSelf(self);
    if (_isShow && weakself.bannerV.x >= 0) { ///礼物正在显示
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
        ApiGiftSenderModel *giftModel = _itemArr.firstObject;
        [self.bannerV showView:GiftBannerForGuard giftModel:giftModel];
        [self showBannerView];
        [_itemArr removeObjectAtIndex:0];
    }
}


///判断当前页面或者数据里是否有该条数据
- (BOOL)judgeGiftView:(ApiGiftSenderModel *)model{

    if ([self chectShowData:self.bannerV.giftModel newGiftData:model]) {
        
        {
            ++self.bannerV.giftModel.continuousNumber;
            [self reStartTime];
            [_bannerV changeLianSongNumber:self.bannerV.giftModel.continuousNumber luckCoin:model.winCoin];
            
        }
        
        return YES;
    }
    kWeakSelf(self);
    __block BOOL has = NO;
    [_itemArr enumerateObjectsUsingBlock:^(ApiGiftSenderModel * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if ([weakself chectShowData:obj newGiftData:model]) {
            ++obj.continuousNumber;
            [_itemArr replaceObjectAtIndex:idx withObject:obj];
            has = YES;
            *stop = YES;
        }
    }];
    return has;
}


- (BOOL)chectShowData:(ApiGiftSenderModel *)showData newGiftData:(ApiGiftSenderModel *)newGiftData{
    if (showData == nil) {
        return NO;
    }
    
    if ((showData.giftId == newGiftData.giftId) && (showData.giftNumber == newGiftData.giftNumber)  &&  (showData.userId == newGiftData.userId)  && (showData.anchorId == newGiftData.anchorId)) {
        return YES;
    }
    return NO;
}




@end
