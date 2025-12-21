//
//  ProjBaseData.m
//  LibProjBase
//
//  Created by klc_sl on 2020/7/15.
//  Copyright © 2020 . All rights reserved.
//

#import "ProjBaseData.h"
#import <AFNetworking/AFNetworking.h>
#import <LibTools/LibTools.h>
#import <LibProjBase/ProjConfig.h>

@implementation ProjBaseData

+ (instancetype)share{
    static ProjBaseData *_baseData = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        if (_baseData == nil) {
            _baseData = [[ProjBaseData alloc] init];
        }
    });
    return _baseData;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
    }
    return self;
}

- (void)setUserState:(int)userState{
    _userState = userState;
    _roomId = userState==0?0:_roomId;
    _isMiniRoom = NO;
}


- (UIView *)allBannerBgView{
    if (!_allBannerBgView) {
        UIView *windowV = [UIApplication sharedApplication].keyWindow;
        UIView *globalBannerBgView = [[UIView alloc] initWithFrame:windowV.bounds];
        globalBannerBgView.userInteractionEnabled = NO;
        [windowV addSubview:globalBannerBgView];
        globalBannerBgView.layer.zPosition = MAXFLOAT;
        _allBannerBgView = globalBannerBgView;
    }
    return _allBannerBgView;
}

- (void)setSwitchOTOBanner:(BOOL)switchOTOBanner{
    if ([ProjConfig userId] > 0) {
        NSString *key = [NSString stringWithFormat:@"switchOTOBanner_%lld",[ProjConfig userId]];
        [NSUserDefaults setObject:@(switchOTOBanner) forKey:key];
    }
}

- (BOOL)switchOTOBanner{
    NSString *key = [NSString stringWithFormat:@"switchOTOBanner_%lld",[ProjConfig userId]];
    return [NSUserDefaults boolForKey:key];
}

- (void)setSwitchGlobalBanner:(BOOL)switchGlobalBanner{
    if ([ProjConfig userId] > 0) {
        NSString *key = [NSString stringWithFormat:@"switchGlobalBanner_%lld",[ProjConfig userId]];
        [NSUserDefaults setObject:@(switchGlobalBanner) forKey:key];
    }

}
- (BOOL)switchGlobalBanner{
    NSString *key = [NSString stringWithFormat:@"switchGlobalBanner_%lld",[ProjConfig userId]];
    return [NSUserDefaults boolForKey:key];
}

- (void)removeAllBanner{
    [_allBannerBgView removeAllSubViews];
    [_allBannerBgView removeFromSuperview];
    _allBannerBgView = nil;
}




#pragma mark - 消息声音 -
- (void)setEnableNotifyVoice:(BOOL)enableNotifyVoice{
    if ([ProjConfig userId] > 0) {
        NSString *key = [NSString stringWithFormat:@"enableNotifyVoice_%lld",[ProjConfig userId]];
        [[NSUserDefaults standardUserDefaults] setInteger:enableNotifyVoice?1:2 forKey:key];
        [[NSUserDefaults standardUserDefaults] synchronize];
    }
}

- (BOOL)enableNotifyVoice{
    NSString *key = [NSString stringWithFormat:@"enableNotifyVoice_%lld",[ProjConfig userId]];
    NSInteger setValue = [[NSUserDefaults standardUserDefaults] integerForKey:key];
    if (setValue) {
        return (setValue==1)?YES:NO;
    }else{
        return YES;
    }
}

- (void)setEnableNotifyShake:(BOOL)enableNotifyShake{
    if ([ProjConfig userId] > 0) {
        NSString *key = [NSString stringWithFormat:@"enableNotifyShake_%lld",[ProjConfig userId]];
        [[NSUserDefaults standardUserDefaults] setInteger:enableNotifyShake?1:2 forKey:key];
        [[NSUserDefaults standardUserDefaults] synchronize];
    }
}

- (BOOL)enableNotifyShake{
    NSString *key = [NSString stringWithFormat:@"enableNotifyShake_%lld",[ProjConfig userId]];
    NSInteger setValue = [[NSUserDefaults standardUserDefaults] integerForKey:key];
    if (setValue) {
        return (setValue==1)?YES:NO;
    }else{
        return YES;
    }
}

@end
