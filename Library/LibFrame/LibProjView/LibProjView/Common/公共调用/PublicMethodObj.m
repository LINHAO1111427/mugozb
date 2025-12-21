//
//  PublicMethodObj.m
//  LibProjView
//
//  Created by klc_sl on 2021/5/24.
//  Copyright © 2021 KLC. All rights reserved.
//

#import "PublicMethodObj.h"
#import <LibProjModel/KLCAppConfig.h>
#import <LibProjModel/AdminLiveConfigModel.h>
#import <LibProjBase/LibProjBase.h>

@implementation PublicMethodObj

+ (void)showUrl:(NSString *)url{
    
    if (url.length != 0 && url != nil && url != NULL ) {
        APPConfigModel *configModel = KLCAppConfig.appConfig;
        if ([url isEqualToString:@"app://goToInvitation"]) {
            [RouteManager routeForName:RN_center_inviteCode currentC:[ProjConfig currentVC]];
        }else if ([url isEqualToString:@"app://goToCoin"]) {
            [RouteManager routeForName:RN_center_myAccountAC currentC:[ProjConfig currentVC]];
        }else if (configModel.adminLiveConfig.jumpMode == 1) {
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:url]];
        }else {
            [RouteManager routeForName:RN_general_webView currentC:[ProjConfig currentVC] parameters:@{@"url":url}];
        }
    }
    
}


///判断启动视图的时间于当前时间间隔
+ (void)launchTimeJudge:(NSString *)keys withinOneDayBlock:(void (^)(BOOL))block {
    if ([ProjConfig userId] > 0) {
        NSString *newStr = [NSString stringWithFormat:@"%@_%lld",keys,[ProjConfig userId]];
        NSString *lastShowTimeStr = [NSUserDefaults stringForKey:newStr];
        if (lastShowTimeStr.length > 0) {
            NSDate *lastDate = [NSDate dateFormString:lastShowTimeStr dataFormat:@"yyyy-MM-dd HH:mm:ss"];
            // 日历对象
            NSCalendar *calendar = [NSCalendar currentCalendar];
            // NSCalendarUnit 枚举代表想获得哪些差值
            NSCalendarUnit unit = NSCalendarUnitYear | NSCalendarUnitWeekOfMonth | NSCalendarUnitDay;
            ///时间差
            NSDateComponents *lastComps = [calendar components:unit fromDate:lastDate];;
            NSDateComponents* currentComps = [calendar components:unit fromDate:[NSDate date]];
            if ((lastComps.year == currentComps.year)||(lastComps.month == currentComps.month)||(lastComps.day == currentComps.day)) {
                block?block(YES):nil;
            }else{
                block?block(NO):nil;
            }
        }else{
            if (block) {
                block(NO);
            }
        }
    }
}

///更新启动时间为当前时间
+ (void)LaunchTimechange:(NSString *)keys {
    if ([ProjConfig userId] > 0) {
        NSString *currentDate = [[NSDate date] timeStringWithDateFormat:@"yyyy-MM-dd HH:mm:ss"];
        NSString *newStr = [NSString stringWithFormat:@"%@_%lld",keys,[ProjConfig userId]];
        [NSUserDefaults setObject:currentDate forKey:newStr];
    }
}


@end
