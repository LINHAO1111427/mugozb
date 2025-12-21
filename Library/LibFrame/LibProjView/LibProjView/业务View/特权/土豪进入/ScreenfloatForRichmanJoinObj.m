//
//  ScreenFloatForRichManObj.m
//  LiveCommon
//
//  Created by ssssssss on 2020/8/28.
//  Copyright © 2020 KLC. All rights reserved.
//

#import "ScreenfloatForRichmanJoinObj.h"
#import "RichManBannerView.h"
#import <LibProjModel/ApiSimpleMsgRoomModel.h>
#import <LibTools/LibTools.h>
#import <LibProjBase/LibProjBase.h>
#import <LibTools/LiveMacros.h>
 
@interface ScreenfloatForRichmanJoinObj()
@property (nonatomic, strong)NSMutableArray *userJoinArr;
@property (nonatomic, weak)UIView *superV;
@property (nonatomic, weak)RichManBannerView *bannerView;
@property (nonatomic, assign)BOOL isAnimation;
@end

@implementation ScreenfloatForRichmanJoinObj

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
        _isAnimation = NO;
        [self removeAllData];
        _superV = superView;
    }
    return self;
}

- (void)playRichManJoinView:(ApiSimpleMsgRoomModel *)model{
    [self.userJoinArr addObject:model];
    [self playNextGift];
}

- (void)playRichManJoinMsgView:(AppJoinChatRoomMsgVOModel *)model{
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
        if ([model isKindOfClass:[ApiSimpleMsgRoomModel class]]) {
            [self.bannerView showRichModel:model];
        }else{
            [self.bannerView showRichForMsgModel:model];
        }
        [self showBannerView:self.bannerView];
        [_userJoinArr removeObjectAtIndex:0];
    }
}

/// sadsad
/// @param banner das
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


- (RichManBannerView *)bannerView{
    if (!_bannerView) {
        RichManBannerView *bannerV = [[RichManBannerView alloc] initWithFrame:CGRectMake(kScreenWidth, liveRichManJoinBannerY, kScreenWidth, 65)];
        [_superV addSubview:bannerV];
        _bannerView = bannerV;
    }
    return _bannerView;
}
@end
