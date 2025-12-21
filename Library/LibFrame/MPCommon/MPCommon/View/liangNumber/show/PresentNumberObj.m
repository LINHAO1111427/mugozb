//
//  PresentNumberObj.m
//  LiveCommon
//
//  Created by klc_sl on 2020/4/2.
//  Copyright © 2020 . All rights reserved.
//

#import "PresentNumberObj.h"
#import "PresentNumShowView.h"
#import <LibProjModel/ApiBeautifulNumberModel.h>
#import <LibTools/LibTools.h>
#import <LibProjBase/LibProjBase.h>
#import <LibTools/LiveMacros.h>

@interface PresentNumberObj ()

@property (nonatomic, strong)NSMutableArray *itemArr;
@property (nonatomic, weak)UIView *superV;
@property (nonatomic, weak)PresentNumShowView *bannerView;
@property (nonatomic, assign)BOOL isAnimation;

@end

@implementation PresentNumberObj

- (void)dealloc
{
    [_bannerView removeFromSuperview];
    _bannerView = nil;
    _isAnimation = YES;
    [_itemArr removeAllObjects];
    _itemArr = nil;
}

- (instancetype)initWithSuperView:(UIView *)superView{
    self = [super init];
    if (self) {
        _superV = superView;
    }
    return self;
}

- (void)playPresentNumberView:(ApiBeautifulNumberModel *)model {
    [self.itemArr addObject:model];
    [self playNextGift];
}


- (void)playNextGift{
    if (_isAnimation) {
        return;
    }
    if (_itemArr.count > 0) {
        _isAnimation = YES;
        ApiBeautifulNumberModel *model = _itemArr.firstObject;
        [self.bannerView showPresentModel:model];
        [self showBannerView:self.bannerView];
        [_itemArr removeObjectAtIndex:0];
    }
}

- (void)showBannerView:(UIView *)banner{
    kWeakSelf(self);
    CGRect rc = banner.frame;
    rc.origin.x = 0;
    rc.origin.y = (kScreenHeight-rc.size.height)/2.0;
    banner.frame = rc;
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3.4 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [weakself dismissBannerView:banner];
    });
}

- (void)dismissBannerView:(UIView *)banner{

    kWeakSelf(self);
    [banner removeFromSuperview];
    [self.bannerView removeFromSuperview];
    self.bannerView = nil;
    self.isAnimation = NO;
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
         [weakself playNextGift];
    });
   
}


- (NSMutableArray *)itemArr{
    if (!_itemArr) {
        _itemArr = [[NSMutableArray alloc] init];
    }
    return _itemArr;
}


- (PresentNumShowView *)bannerView{
    if (!_bannerView) {
        PresentNumShowView *bannerV = [[PresentNumShowView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 50)];
        [_superV addSubview:bannerV];
        _bannerView = bannerV;
    }
    return _bannerView;
}



@end
