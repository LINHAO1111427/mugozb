//
//  GiftNormalShowObj.m
//  LiveCommon
//
//  Created by klc_sl on 2020/3/24.
//  Copyright © 2020 . All rights reserved.
//

#import "GiftNormalShowObj.h"
#import <LibTools/LibTools.h>
#import <LibProjBase/LibProjBase.h>
#import "GiftBannerView.h"
#import <LibProjModel/ApiGiftSenderModel.h>
#import <LibProjModel/KLCAppConfig.h>
#import <LibTools/LiveMacros.h>

@interface GiftManager : UIView

@property (nonatomic, assign)BOOL isShow;
@property (nonatomic, weak)GiftBannerView *bannerV;
@property (nonatomic, copy)void(^finishBlock)(void);

- (void)showGift:(ApiGiftSenderModel *)giftModel;
- (void)reloadGiftInfo:(ApiGiftSenderModel *)giftModel;

@end

@implementation GiftManager

- (void)dealloc
{
    [NSObject cancelPreviousPerformRequestsWithTarget:self selector:@selector(dismissBannerView) object:nil];
    _finishBlock = nil;
    [_bannerV removeFromSuperview];
}

- (GiftBannerView *)bannerV{
    if (!_bannerV) {
        GiftBannerView *bgV = [[GiftBannerView alloc] initWithFrame:CGRectMake(-self.frame.size.width, 0, self.frame.size.width, self.frame.size.height)];
        [self addSubview:bgV];
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
        rc.origin.x = -self.frame.size.width;
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
    kWeakSelf(self);
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        if (weakself.finishBlock) {
            weakself.finishBlock();
        }
    });
}

- (void)showGift:(ApiGiftSenderModel *)giftModel{
    if (_isShow) {
        return;
    }
    _isShow = YES;
    self.bannerV.frame = CGRectMake(-self.frame.size.width, 0, self.frame.size.width, self.frame.size.height);
    [self.bannerV showView:GiftBannerForNormal giftModel:giftModel];
    [self showBannerView];
}

- (void)reloadGiftInfo:(ApiGiftSenderModel *)giftModel{
    if (_isShow) {
        ++self.bannerV.giftModel.continuousNumber;
        [self reStartTime];
        [_bannerV changeLianSongNumber:self.bannerV.giftModel.continuousNumber luckCoin:giftModel.winCoin];
    }
}

@end



@interface GiftNormalShowObj ()

@property (nonatomic, strong)NSMutableArray<ApiGiftSenderModel *> *itemArr;

@property (nonatomic, weak)GiftManager *firstGiftView;
@property (nonatomic, weak)GiftManager *secondGiftView;

@end

@implementation GiftNormalShowObj

- (void)dealloc
{
    [_itemArr removeAllObjects];
    _itemArr = nil;
    _firstGiftView = nil;
    _secondGiftView = nil;
}

- (instancetype)initWithSuperView:(UIView *)superView{
    self = [super init];
    if (self) {
        
        GiftManager *secondGiftView = [[GiftManager alloc] initWithFrame:CGRectMake(0, liveNormal2GiftBannerY, superView.width, 50)];
        [superView addSubview:secondGiftView];
        _secondGiftView = secondGiftView;
        
        GiftManager *firstGiftView = [[GiftManager alloc] initWithFrame:CGRectMake(0, liveNormal1GiftBannerY, superView.width, 50)];
        [superView addSubview:firstGiftView];
        _firstGiftView = firstGiftView;
        
        
        ///初始化数据
        kWeakSelf(self);
        _firstGiftView.finishBlock = ^{
            [weakself showNextGift:weakself.firstGiftView];
        };
        _secondGiftView.finishBlock = ^{
            [weakself showNextGift:weakself.secondGiftView];
        };
    }
    return self;
}

- (NSMutableArray *)itemArr{
    if (_itemArr == nil) {
        _itemArr = [[NSMutableArray alloc] initWithCapacity:1];
    }
    return _itemArr;
}

- (void)playNormalGift:(ApiGiftSenderModel *)giftModel{
    ///判断礼物是否正在显示中
    if (![self judgeGiftView:giftModel]) {  ///　没有显示
        [self.itemArr addObject:giftModel];
        [self judgeNextPlay];
    }
}


- (void)showNextGift:(GiftManager *)giftView{
    if (_itemArr.count) {
        ApiGiftSenderModel *giftModel = _itemArr.firstObject;
        [giftView showGift:giftModel];
        [_itemArr removeObjectAtIndex:0];
        
        //        if (_itemArr.count) {
        //            /// 判断是否
        //            if (![self judgeGiftView:giftModel]) {  ///　没有显示
        //                [self judgeNextPlay];
        //            }else{
        //
        //            }
        //        }
    }
}

///判断从用哪一条UI播放
- (void)judgeNextPlay{
    if (!_firstGiftView.isShow) { ///如果当前礼物未播放
        [self showNextGift:_firstGiftView];
        return;
    }
    if (!_secondGiftView.isShow) { ///如果当前状态未播放
        [self showNextGift:_secondGiftView];
        return;
    }
}


///判断当前页面或者数据里是否有该条数据
- (BOOL)judgeGiftView:(ApiGiftSenderModel *)model{
    if ([self chectShowData:_firstGiftView.bannerV.giftModel newGiftData:model]) {
        [_firstGiftView reloadGiftInfo:model];
        return YES;
    }
    if ([self chectShowData:_secondGiftView.bannerV.giftModel newGiftData:model]) {
        [_secondGiftView reloadGiftInfo:model];
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
