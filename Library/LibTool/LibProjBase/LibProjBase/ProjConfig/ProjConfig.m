//
//  ProjConfig.m
//  LibProjBase
//
//  Created by admin on 2019/12/10.
//  Copyright © 2019 . All rights reserved.
//

#import "ProjConfig.h"
#import <LibTools/BaseMacroDefinition.h>
#import "RTRootNavigationController.h"
#import <LibTools/NSString+Extend.h>
#import "RouteManager.h"
#import "AppRouteName.h"
#import "ProjectCache.h"

@interface ProjConfig ()



@end

static ProjConfig *_instence = nil;
@implementation ProjConfig

+ (instancetype)shareInstence{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _instence = [[self alloc] init];
    });
    return _instence;
}

+ (id)allocWithZone:(struct _NSZone *)zone{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _instence = [super allocWithZone:zone];
    });
    return _instence;
}

- (nonnull id)copyWithZone:(nullable NSZone *)zone {
    return _instence;
}

- (nonnull id)mutableCopyWithZone:(nullable NSZone *)zone {
    return _instence;
}


+ (NSString *)baseUrl{
    return [[ProjConfig shareInstence].baseConfig baseUrl];
}
 
+ (int)getAppType{
    return [[ProjConfig shareInstence].baseConfig getAppType];
}

+ (UIColor*)projNavTitleColor{
    return [[ProjConfig shareInstence].baseConfig getNavTitleColor];
}

+ (UIColor *)normalColors{
    return [[ProjConfig shareInstence].baseConfig normalColors];
}

+ (UIColor *)projTintColor{
    return [[ProjConfig shareInstence].baseConfig projTintColor];
}

+ (UIColor *)projBgColor{
    return [[ProjConfig shareInstence].baseConfig projBgColor];
}

+ (UIImage *)getDefaultImage{
    return [UIImage imageNamed:[[ProjConfig shareInstence].baseConfig getUserDefaultIcon]];
}

+ (UIImage *)getLoginBgImage{
    return [UIImage imageNamed:[[ProjConfig shareInstence].baseConfig getLoginBgImageName]];
}

+ (UIImage *)getCoinImage{
    return [[ProjConfig shareInstence].baseConfig getDefaultCoinImage];
}

+ (UIImage *)getAppIcon{
    return [UIImage imageNamed:[[ProjConfig shareInstence].baseConfig getAppIconName]];
}

+ (UIImage *)getAPPGenderImage:(int)index hasAge:(BOOL)hasAge{
    return  [UIImage imageNamed:[[ProjConfig shareInstence].baseConfig getGenderImage:index hasAge:hasAge]];
}

+ (UIImage *)getAppThumb{
    return [UIImage imageNamed:[[ProjConfig shareInstence].baseConfig getAppThumbName]];
}
+ (UIImage *)getLanuchImg{
    return [UIImage imageNamed:[[ProjConfig shareInstence].baseConfig getLanuchImageName]];
}
 
+ (UIImage *)getLiveBgImage{
    return [UIImage imageNamed:[[ProjConfig shareInstence].baseConfig getLiveBgImageName]];
}

+ (NSString *)getAppVerticalVideoGravity{
    return [[ProjConfig shareInstence].baseConfig getVerticalVideoGravity];
}

+ (NSString *)getGenderName:(int)gender{
    return [[ProjConfig shareInstence].baseConfig getSexNameStr:gender];
}

+ (BOOL)hasGenderPicAge{
    return [[ProjConfig shareInstence].baseConfig hasGenderPicAge];
}

+ (NSString *)getAppSchemeUrl{
    return [[ProjConfig shareInstence].baseConfig getAppSchemeUrl];
}

+ (void)showLoginVC{
    [RouteManager routeForName:RN_login_welcome currentC:[ProjConfig currentVC]];
}

+ (int64_t)userId{
    return [[ProjConfig shareInstence].baseConfig userId];
}

+ (NSString *)userToken{
    return [[ProjConfig shareInstence].baseConfig userToken];
}
 
+ (void)tokenInvalid{
    [[NSNotificationCenter defaultCenter] postNotificationName:NotificationUserLogout object:nil userInfo:nil];
    [[ProjConfig shareInstence].baseConfig tokenInvalid];
}


+ (void)accountDisabled:(NSString *)showStr{
    [[ProjConfig shareInstence].baseConfig accountDisable:showStr];
}

+(void)showSuspenPublish{
    return [[ProjConfig shareInstence].baseConfig showSuspenPublish];
}

+ (BOOL)isUserLogin{
    return [[ProjConfig shareInstence].baseConfig isUserLogin];
}

+ (void)userlogined{
    [[ProjConfig shareInstence].baseConfig logined];
}

+ (void)logout{
    [[NSNotificationCenter defaultCenter] postNotificationName:NotificationUserLogout object:nil userInfo:nil];
    [[ProjConfig shareInstence].baseConfig logout];
}

///链接socket
+ (void)connectSocket{
    [[ProjConfig shareInstence].baseConfig connectSocket];
}

+ (UIViewController *)currentVC{
    
    UIViewController *result = nil;
    UIWindow * window = [[UIApplication sharedApplication] keyWindow];
    if (window.windowLevel != UIWindowLevelNormal)
    {
        NSArray *windows = [[UIApplication sharedApplication] windows];
        for(UIWindow * tmpWin in windows)
        {
            if (tmpWin.windowLevel == UIWindowLevelNormal)
            {
                window = tmpWin;
                break;
            }
        }
    }
    if ([window subviews].count == 0) {
        return nil;
    }
    
    UIView *frontView = [[window subviews] objectAtIndex:0];
    id nextResponder = [frontView nextResponder];
    if ([nextResponder isKindOfClass:[UIViewController class]])
    {
        result = nextResponder;
    }
    else
    {
        result = window.rootViewController;
    }
    
    if ([result isKindOfClass:[UITabBarController class]]) {
        
        UITabBarController *tabBarVC = (UITabBarController *)result;
        result = tabBarVC.selectedViewController;
    }
    
    if ([result isKindOfClass:[RTRootNavigationController class]]) {
        
        RTRootNavigationController *rtNVC = (RTRootNavigationController *)result;
        result = rtNVC.rt_viewControllers.lastObject;
        
    }
    return result;
}

+ (UITabBarController *)tabbarC{
    id vc = [UIApplication sharedApplication].keyWindow.rootViewController;
    if ([vc isKindOfClass:[UINavigationController class]]) {
        if ([vc isKindOfClass:[UITabBarController class]]) {
            return vc;
        }else{
            return nil;
        }
    }
    if ([vc isKindOfClass:[UITabBarController class]]) {
        return vc;
    }
    return nil;
}

+(NSString *)getZFBstring{
    NSString *zfbstring =  @"+X4wDCKQ6xjvGacCHlVRgw==";
    return [zfbstring aes256_decrypt];
}


///当前nvc中的vc的数组
+ (NSArray<UIViewController *> *)currentNVCList {
   return [self currentVC].rt_navigationController.rt_viewControllers;
}

+ (int)messageCenterItem{
    return [[ProjConfig shareInstence].baseConfig messageCenterItem];
}


///是否包含短视频
+ (BOOL)isContainShortVideo {
    NSString *appTypeStr = [NSString stringWithFormat:@"%d",[ProjConfig getAppType]];
    if ([appTypeStr containsString:@"4"]) {
        return YES;
    }
    return NO;
}

///是否包含1v1
+ (BOOL)isContain1v1 {
    NSString *appTypeStr = [NSString stringWithFormat:@"%d",[ProjConfig getAppType]];
    if ([appTypeStr containsString:@"2"]) {
        return YES;
    }
    return NO;
}

+ (BOOL)isContainShopping{
    NSString *appTypeStr = [NSString stringWithFormat:@"%d",[ProjConfig getAppType]];
    if ([appTypeStr containsString:@"5"]) {
        return YES;
    }
    return NO;
}

///是否包含多人视频
+ (BOOL)isContainMPVideo{
    NSString *appTypeStr = [NSString stringWithFormat:@"%d",[ProjConfig getAppType]];
    if ([appTypeStr containsString:@"1"] || [appTypeStr containsString:@"5"]) {
        return YES;
    }
    return NO;
}

///是否包含多人语音
+ (BOOL)isContainMPVoice{
    NSString *appTypeStr = [NSString stringWithFormat:@"%d",[ProjConfig getAppType]];
    if ([appTypeStr containsString:@"3"]) {
        return YES;
    }
    return NO;
}

@end
