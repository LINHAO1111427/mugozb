//
//  KLCAppConfig.m
//  TCDemo
//
//  Created by admin on 2020/9/19.
//  Copyright © 2019 CH. All rights reserved.
//

#import "KLCAppConfig.h"

#import "APPConfigModel.h"
#import <LibTools/LibTools.h>
#import <ShareSDK/SSDKTypeDefine.h>
#import <LibProjBase/ProjConfig.h>
#import "AdminLoginSwitchModel.h"
#import <LibProjModel/HttpApiAppLogin.h>
#import <LibProjModel/AdminLiveConfigModel.h>
#import <LibProjModel/AdminVersionManageModel.h>
#import <LibProjModel/CoinDisplaySettingsVOModel.h>
#import <LibProjBase/ProjectCache.h>

#define AppConfigKey     @"AppConfigKey"

@interface KLCAppConfig ()

@property (nonatomic, strong)APPConfigModel *appConfig;

///金币的图标，已保存在本地的图标
@property (nonatomic,copy)UIImage *coinImg;
///影票的图标，已保存在本地的图标
@property (nonatomic,copy)UIImage *ticketImg;

@end

@implementation KLCAppConfig

+ (instancetype)share {
    static KLCAppConfig *appConfig = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        if (!appConfig) {
            appConfig = [[KLCAppConfig alloc] init];
        }
    });
    return appConfig;
}

+ (void)updateAppConfig:(void (^)(BOOL))complete{
    [HttpApiAppLogin getConfig:^(int code, NSString *strMsg, APPConfigModel *model) {
        if (code == 1) {
            KLCAppConfig.appConfig = model;
            [[NSUserDefaults standardUserDefaults]setBool:model.adminLiveConfig.jumpMode forKey:@"adJumpSafari"];//是否跳转外部浏览器
            [[NSNotificationCenter defaultCenter] postNotificationName:@"AppConfigGetSuccess" object:nil];
            [[NSUserDefaults standardUserDefaults] setBool:NO forKey:@"systemAlertHasShow"];
        }
        if (complete) {
            complete((code == 1)?YES:NO);
        }
    }];
}


+ (void)setAppConfig:(APPConfigModel *)appConfig{
    [KLCAppConfig share].appConfig = appConfig;
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        NSDictionary *appConfigDic = [appConfig modelToJSONObject];
        [[NSUserDefaults standardUserDefaults] setObject:appConfigDic forKey:AppConfigKey];
    });
    [ProjConfig getCoinImage];
}


+ (APPConfigModel *)appConfig{
    APPConfigModel *appDonfigModel = [KLCAppConfig share].appConfig;
    if (!appDonfigModel) {
        NSDictionary *appConfigDic = [[NSUserDefaults standardUserDefaults] objectForKey:AppConfigKey];
        appDonfigModel = [APPConfigModel getFromDict:appConfigDic];
        [KLCAppConfig share].appConfig = appDonfigModel;
    }
    return appDonfigModel;
}



+ (NSArray *)shareArray{
    NSMutableArray *dataArr  = [NSMutableArray arrayWithCapacity:1];
    
    APPConfigModel *config = KLCAppConfig.appConfig;
    NSArray *shareArr = [config.loginSwitch.shareType componentsSeparatedByString:@","];
    ///分享方式 1:QQ 2:qq空间 3:微信 4:微信朋友圈
    for (NSString *type in shareArr) {
        switch ([type intValue]) {
            case 1:
                [dataArr addObject:@{@"id":@"1",@"title":@"QQ",@"shareType":@(SSDKPlatformSubTypeQQFriend),@"image":@"icon_more_share_qq"}];
                break;
            case 2:
                [dataArr addObject:@{@"id":@"2",@"title":kLocalizationMsg(@"qq空间"),@"shareType":@(SSDKPlatformSubTypeQZone),@"image":@"icon_more_share_qqzone"}];
                break;
            case 3:
                [dataArr addObject:@{@"id":@"3",@"title":kLocalizationMsg(@"微信"),@"shareType":@(SSDKPlatformSubTypeWechatSession),@"image":@"icon_more_share_wechat"}];
                break;
            case 4:
                [dataArr addObject:@{@"id":@"4",@"title":kLocalizationMsg(@"朋友圈"),@"shareType":@(SSDKPlatformSubTypeWechatTimeline),@"image":@"icon_more_share_friend"}];
                break;
            case 5:
                [dataArr addObject:@{@"id":@"5",@"title":kLocalizationMsg(@"微博"),@"shareType":@(SSDKPlatformTypeSinaWeibo),@"image":@""}];
                break;
            default:
                break;
        }
    }
    return [NSArray arrayWithArray:dataArr];
}



+ (NSArray *)loginArray{
    
    NSMutableArray *dataArr  = [NSMutableArray arrayWithCapacity:1];
    APPConfigModel *config = KLCAppConfig.appConfig;
    NSArray *shareArr = [config.loginSwitch.loginType componentsSeparatedByString:@","];
    ///登录方式 1:QQ 2:微信
    for (NSString *type in shareArr) {
        switch ([type intValue]) {
            case 1:
                [dataArr addObject:@{@"id":@"1",@"title":@"QQ",@"shareType":@(SSDKPlatformTypeQQ)}];
                break;
            case 2:
                [dataArr addObject:@{@"id":@"2",@"title":kLocalizationMsg(@"微信"),@"shareType":@(SSDKPlatformTypeWechat)}];
                break;
            default:
                break;
        }
    }
    if (@available(iOS 13.0, *)) {
        if ([[ProjConfig shareInstence].baseConfig hasAppleLogin]) {
            //若使用需在开发者identifier中点开Sign In With Apple
            [dataArr addObject:@{@"id":@"3",@"title":@"Apple",@"shareType":@(SSDKPlatformTypeAppleAccount)}];
        }
    }
    return [NSArray arrayWithArray:dataArr];
}


///单位文字
+ (NSString *)unitStr{
    NSString *unitStr = KLCAppConfig.appConfig.vcUnit;
    unitStr = (unitStr.length>0 && ![unitStr isKindOfClass:[NSNull class]] && unitStr)?unitStr:kLocalizationMsg(@"金币");
    return unitStr;
}

+ (NSString *)incomeUnitStr{
    NSString *unitStr = KLCAppConfig.appConfig.ticketName;
    unitStr = (unitStr.length>0 && ![unitStr isKindOfClass:[NSNull class]] && unitStr)?unitStr:kLocalizationMsg(@"映票");
    return unitStr;
}


+ (NSTimeInterval)giftHoldTime{
    return 5.0;
}

+ (BOOL)showOtmCoin{
    return KLCAppConfig.appConfig.coinDisplaySettingsVO.iosCoinShow?YES:NO;;
}


+ (UIImage *)getCoinImage{
    if ([KLCAppConfig share].coinImg) {
        return [KLCAppConfig share].coinImg;
    }else{
        NSString *coinUrl = KLCAppConfig.appConfig.vcUnitIcon;
        if (coinUrl.length > 0) {
            [ProjectCache cacheFileWithFilePath:coinUrl finishHandle:^(NSData * _Nullable data, BOOL success) {
                UIImage *coinImage = [UIImage imageWithData:data];
                [KLCAppConfig share].coinImg = coinImage;
            }];
        }
        return [UIImage new];
    }
}

+ (UIImage *)getTicketImage{
    if ([KLCAppConfig share].ticketImg) {
        return [KLCAppConfig share].ticketImg;
    }else{
        NSString *ticketIcon = KLCAppConfig.appConfig.ticketIcon;
        if (ticketIcon.length > 0) {
            [ProjectCache cacheFileWithFilePath:ticketIcon finishHandle:^(NSData * _Nullable data, BOOL success) {
                UIImage *ticketImage = [UIImage imageWithData:data];
                [KLCAppConfig share].ticketImg = ticketImage;
            }];
        }
        return [UIImage new];
    }
}


+ (int64_t)tempUid{
    return KLCAppConfig.appConfig.visitorUserID;
}
+ (NSString *)tempUToken{
    return KLCAppConfig.appConfig.visitorUserToken;
}

@end
