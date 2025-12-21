//
//  LiveManager.h
//  LibProjView
//
//  Created by klc_sl on 2020/3/18.
//  Copyright © 2020 . All rights reserved.
//

#import <Foundation/Foundation.h>
///常用
#import <LiveCommon/LiveInfomation.h>
#import <LibProjBase/PopupTool.h>
#import "LiveBaseViewController.h"
#import "LiveComponentProtocol.h"

NS_ASSUME_NONNULL_BEGIN


///注:  只能直播间内使用
@interface LiveManager : NSObject

///直播间数据
+ (LiveInfomation *)liveInfo;

///设置显示的viewcontroller
+ (void)initBaseVC:(LiveBaseViewController *)baseVC;

///设置是否可以清屏
+ (void)setCanClear:(BOOL)canClear;


+ (UIViewController *)getCurrentVC;

#pragma mark - 业务 -

///清理直播间弹窗层popview视图
+ (void)livePopViewClear:(BOOL)clear;

///根据权限判断是否课继续播放
+ (void)promissionStop:(BOOL)stop;

///语音最小化
+ (void)showAudioMiniView;



@end

NS_ASSUME_NONNULL_END
