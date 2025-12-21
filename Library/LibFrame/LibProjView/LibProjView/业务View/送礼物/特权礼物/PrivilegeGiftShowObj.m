//
//  PrivilegeGiftShowObj.m
//  LiveCommon
//
//  Created by ssssssss on 2020/8/29.
//  Copyright © 2020 KLC. All rights reserved.
//

#import "PrivilegeGiftShowObj.h"

#import <LibTools/LibTools.h>
#import <LibTools/LiveMacros.h>
#import <LibProjModel/ApiGiftSenderModel.h>
#import <LibProjView/PrivilegeGiftAppearView.h>
 
@interface PrivilegeGiftShowObj()
@property (nonatomic, strong)NSMutableArray *userJoinArr;
@property (nonatomic, weak)UIView *animationSuperV;
@property (nonatomic, weak)PrivilegeGiftAppearView *giftShowView;
@property (nonatomic, assign)BOOL isAnimation;
@end

@implementation PrivilegeGiftShowObj

- (void)dealloc
{
    _isAnimation = YES;
    [_userJoinArr removeAllObjects];
    _userJoinArr = nil;
    [_giftShowView removeFromSuperview];
}


- (instancetype)initWithSuperView:(UIView *)superView{
    self = [super init];
    if (self) {
        _animationSuperV = superView;
    }
    return self;
}

- (void)ShowPrivilegeGiftAnimation:(ApiGiftSenderModel *)userModel{
    [self.userJoinArr addObject:userModel];
    [self playNextGift];
}


- (void)playNextGift{
    if (_isAnimation) {
        return;
    }
    if (_userJoinArr.count > 0) {
        _isAnimation = YES;
        ApiGiftSenderModel *model = _userJoinArr.firstObject;
        [self playAnimationView:model];
        [_userJoinArr removeObjectAtIndex:0];
    }
}

- (void)playAnimationView:(ApiGiftSenderModel *)model{
    double time = 1.5;
    if (model.giftswf.length >  0) {//动图礼物
        time = model.swftime;
    }
    [self.giftShowView showGiftModel:model];
    [self showBannerView:self.giftShowView afterTime:time];
}


- (void)showBannerView:(UIView *)banner afterTime:(double)time{
    kWeakSelf(self);
    [UIView animateWithDuration:0.3 animations:^{
         
    } completion:^(BOOL finished) {
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(time * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            weakself.isAnimation = NO;
            [weakself dismissBannerView:banner];
            [weakself playNextGift];
        });
    }];
}

- (void)dismissBannerView:(UIView *)banner{
    kWeakSelf(self);
    [UIView animateWithDuration:0.3 animations:^{
    } completion:^(BOOL finished) {
        [banner removeAllSubViews];
        [banner removeFromSuperview];
        weakself.giftShowView = nil;
    }];
}

- (NSMutableArray *)userJoinArr{
    if (!_userJoinArr) {
        _userJoinArr = [[NSMutableArray alloc] init];
    }
    return _userJoinArr;
}
 

- (PrivilegeGiftAppearView *)giftShowView{
    if (!_giftShowView) {
        CGFloat scale = 235/200.0;
        CGFloat width = kScreenWidth*200/360.0;
        CGFloat height  = width*scale;
        
        PrivilegeGiftAppearView *giftShowView = [[PrivilegeGiftAppearView alloc] initWithFrame:CGRectMake(12, (kScreenHeight-height)/2.0, kScreenWidth-24, height)];
        giftShowView.backgroundColor = [UIColor clearColor];
        [_animationSuperV addSubview:giftShowView];
        _giftShowView = giftShowView;
    }
    return _giftShowView;
}


@end
