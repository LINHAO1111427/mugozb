//
//  UserTipObj.m
//  LiveCommon
//
//  Created by klc_sl on 2020/3/31.
//  Copyright © 2020 . All rights reserved.
//

#import "UserTipObj.h"
#import <LibTools/LibTools.h>
#import <LibProjModel/ApiElasticFrameModel.h>
#import "UserObtainTipView.h"
#import <LibProjModel/KLCAppConfig.h>

@interface UserTipObj ()

@property (nonatomic, weak)UIView *superV;
@property (nonatomic, strong)NSMutableArray *tipItems;
@property (nonatomic, assign)BOOL isShow;

@end

@implementation UserTipObj

- (instancetype)initWithSuperView:(UIView *)superView{
    self = [super init];
    if (self) {
        _superV = superView;
    }
    return self;
}

- (void)showTipView:(ApiElasticFrameModel *)tipModel {
    [self.tipItems addObject:tipModel];
    [self playNexView];
}

- (void)playNexView{
    if (_isShow) {
        return;
    }
    if (_tipItems.count > 0) {
        _isShow = YES;
        ApiElasticFrameModel *model = _tipItems.firstObject;
        UserObtainTipView *tipView = [[UserObtainTipView alloc] initContentInfo:model];
        [self.superV addSubview:tipView];
        [self showView:tipView];
        [_tipItems removeObjectAtIndex:0];
    }
}

- (void)showView:(UserObtainTipView *)tipView{
    tipView.frame = CGRectMake(0, kScreenHeight, kScreenWidth, 100);
    kWeakSelf(self);
    [UIView animateWithDuration:0.3 animations:^{
        CGRect rc = tipView.frame;
        rc.origin.y = kScreenHeight-rc.size.height-kSafeAreaBottom-60;
        tipView.frame = rc;
    } completion:^(BOOL finished) {
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [weakself dismissView:tipView];
        });
    }];
}

- (void)dismissView:(UserObtainTipView *)tipView{
    kWeakSelf(self);
    [UIView animateWithDuration:0.3 animations:^{
        CGRect rc = tipView.frame;
        rc.origin.y = kScreenHeight;
        tipView.frame = rc;
    } completion:^(BOOL finished) {
        [tipView removeFromSuperview];
        weakself.isShow = NO;
        [weakself playNexView];
    }];
}


- (NSMutableArray *)tipItems{
    if (!_tipItems) {
        _tipItems = [[NSMutableArray alloc] init];
    }
    return _tipItems;
}

@end
