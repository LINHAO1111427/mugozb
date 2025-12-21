//
//  ScreenReocrdManager.m
//  LibProjView
//
//  Created by ssssssss on 2020/11/9.
//  Copyright © 2020 KLC. All rights reserved.
//

#import "ScreenReocrdManager.h"

#import <UIKit/UIKit.h>
#import <LibTools/LibTools.h>
#import <AgoraExtension/AgoraExtManager.h>
#import <LibProjView/ScreenRecForbidTipView.h>

@implementation ScreenReocrdManager
/// 开始监听
+(void)startMonitor
{
    // 监测设备的录制状态
    if (@available(iOS 11.0, *)) {
        [[NSNotificationCenter defaultCenter] addObserverForName:UIScreenCapturedDidChangeNotification object:nil queue:[NSOperationQueue mainQueue] usingBlock:^(NSNotification * _Nonnull note) {
            BOOL isRecord = NO;
            if ([UIScreen mainScreen].isCaptured) {
                isRecord = YES;
                [ScreenRecForbidTipView showForbidTipView];
               // NSLog(@"过滤文字开始屏幕录制 ..."));
            }else{
                [ScreenRecForbidTipView DismissForbidTipView];
               // NSLog(@"过滤文字结束屏幕录制 ..."));
            }
            [[AgoraExtManager pubMethod] localVideoClosed:isRecord];
            [[AgoraExtManager pubMethod] localVideoClosed:isRecord];
            [[AgoraExtManager pubMethod] remoteVideoClosed:isRecord];
            [[AgoraExtManager pubMethod] remoteVoiceClosed:isRecord];
        }];
    }
    
    
    [[NSNotificationCenter defaultCenter] addObserverForName:UIApplicationUserDidTakeScreenshotNotification
                                                      object:nil
                                                       queue:[NSOperationQueue mainQueue]
                                                  usingBlock:^(NSNotification * _Nonnull note) {
       // NSLog(@"过滤文字正在截屏"));
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:kLocalizationMsg(@"警告") message:kLocalizationMsg(@"禁止自私截屏，继续将有封号的风险！") preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *sureAction = [UIAlertAction actionWithTitle:kLocalizationMsg(@"我知道了") style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action){
        }];
        [alert addAction:sureAction];
        [[ProjConfig currentVC] presentViewController:alert animated:NO completion:nil];
    }];
}

/// 结束监听
+(void)stopMonitor
{
    if (@available(iOS 11.0, *)) {
        [[NSNotificationCenter defaultCenter] removeObserver:[UIApplication sharedApplication] name:UIScreenCapturedDidChangeNotification object:nil];
    }
    [[NSNotificationCenter defaultCenter] removeObserver:[UIApplication sharedApplication] name:UIApplicationUserDidTakeScreenshotNotification object:nil];
}
@end
