//
//  RechangeSuccessNotice.m
//  LiveCommon
//
//  Created by klc_sl on 2020/4/2.
//  Copyright © 2020 . All rights reserved.
//

#import "FullSiteNotice.h"
#import <LibProjModel/ApiSimpleMsgRoomModel.h>
#import <LibTools/LibTools.h>
#import <LibProjBase/LibProjBase.h>
#import <LibTools/LiveMacros.h>
#import "FullSiteView.h"

@interface FullSiteNotice ()

@property (nonatomic, strong)NSMutableArray *userJoinArr;
@property (nonatomic, weak)UIView *superV;
@property (nonatomic, weak)FullSiteView *bannerView;
@property (nonatomic, assign)BOOL isAnimation;
@property (nonatomic, weak)ApiSimpleMsgRoomModel *noticeModel;

@end

@implementation FullSiteNotice

- (void)dealloc
{
    [_bannerView removeAllSubViews];
    [_userJoinArr removeAllObjects];
    _userJoinArr = nil;
}

- (instancetype)initWithSuperView:(UIView *)superView{
    self = [super init];
    if (self) {
        _superV = superView;
    }
    return self;
}

- (void)fullStationCongratulation:(ApiSimpleMsgRoomModel *)model{
    NSArray *itemArr = @[model];
    [self.userJoinArr addObject:itemArr];
    [self playNextGift];
}


- (void)playNextGift{
    if (_isAnimation) {
        return;
    }
    if (_userJoinArr.count > 0) {
        _isAnimation = YES;
        NSArray *itemArr =  _userJoinArr.firstObject;
        ApiSimpleMsgRoomModel *model = itemArr.firstObject;
        self.noticeModel = model;
        [self.bannerView showCongratulationModel:model];
        
        [self showBannerView:self.bannerView];
        [_userJoinArr removeObjectAtIndex:0];
    }
}

- (void)showBannerView:(UIView *)banner{
    kWeakSelf(self);
    [UIView animateWithDuration:0.0 animations:^{
    
    } completion:^(BOOL finished) {
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [weakself dismissBannerView:banner];
        });
    }];
}

- (void)dismissBannerView:(UIView *)banner{
    kWeakSelf(self);
    [UIView animateWithDuration:0.3 animations:^{
         
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


- (FullSiteView *)bannerView{
    if (!_bannerView) {
        NSString *showStr = [NSString stringWithFormat:@"%@%@",self.noticeModel.userName,self.noticeModel.content];
        CGSize size = [showStr boundingRectWithSize:CGSizeMake(kScreenWidth-24-108, 20) options:1 attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:12]} context:nil].size;
        CGFloat width ;
        if (size.width+30 > kScreenWidth-24-108) {
            width = kScreenWidth-24-108;
        }else{
            width = size.width+30;
        }
        FullSiteView *bannerV = [[FullSiteView alloc] initWithFrame:CGRectMake(12, liveFullSiteBanner,width+108, 50)];
        [_superV addSubview:bannerV];
        _bannerView = bannerV;
    }
    return _bannerView;
}



@end
