//
//  AudioForAnchorVC.m
//  TCDemo
//
//  Created by CH on 2019/12/3.
//  Copyright © 2019 CH. All rights reserved.
//

#import "LiveBaseViewController.h"
#import <LiveCommon/LiveComponentInterface.h>
#import <LibProjBase/ProjConfig.h>
#import <LibProjBase/LibProjBase.h>
#import <LibProjBase/ProjBaseData.h>
#import <LiveCommon/LiveComponentMsgListener.h>
#import <LiveCommon/LiveComponentMsgMgr.h>

#import <LiveCommon/LiveInfomation.h>
#import <LiveCommon/LiveManager.h>
 
#import <LibProjModel/KLCUserInfo.h>
#import <LibProjModel/AppJoinRoomVOModel.h>

#import <LibTools/LiveMacros.h>
#import <LibTools/BaseMacroDefinition.h>
#import <LibTools/LibTools.h>
#import <TXImKit/TXImKit.h>

@interface LiveBaseViewController ()

@end

@implementation LiveBaseViewController

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIApplicationWillTerminateNotification object:nil];
}

- (instancetype)init{
    ///郑重声明：：：本viewcontroller不接通知 不接直播内消息
    self = [super init];
    if (self) {
        self.hidesBottomBarWhenPushed = YES;
        [[NSNotificationCenter defaultCenter] postNotificationName:liveChangeRoomNotify object:nil];
    }
    return self;
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden = YES;
    [[UIApplication sharedApplication] setIdleTimerDisabled:YES];
    [[NSNotificationCenter defaultCenter] postNotificationName:liveRoomWillAppearNotify object:nil];
}

- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    self.navigationController.navigationBarHidden = YES;
    [LiveManager livePopViewClear:NO];
    [[UIApplication sharedApplication] setIdleTimerDisabled:YES];
}


- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [LiveManager livePopViewClear:YES];
    [[UIApplication sharedApplication] setIdleTimerDisabled:NO];
}

- (void)viewDidLoad {

   // NSLog(@"过滤文字=======================初始化===%s"),__func__);
    
    self.navigationController.navigationBarHidden = YES;
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(applicationWillTerminate) name:UIApplicationWillTerminateNotification object:nil];
    
//    [IMSocketIns resetIdleTime];
    
    [super viewDidLoad];
    [LiveManager initBaseVC:self]; //准备直播页面

    self.view.backgroundColor = [UIColor blackColor];
    
    _roomModel = nil;
    
    [self initAudienceData];
    
}


- (void)initAudienceData{
    ///初始化观众数据。
   // NSLog(@"过滤文字=======================开播数据  注意这里一对一仍然发送了 请查看页面是否也重复 ===%lld"),[LiveManager liveInfo].roomModel.roomId);
    
    if ([LiveManager liveInfo].o2oModel) {
        [LiveComponentMsgMgr sendMsg:LM_LiveRoomInfo msgDic:nil];
    }
    
}



#pragma mark - 离开房间 -

- (void)leaveRoom:(BOOL)animated {
   // NSLog(@"过滤文字=======================离开房间===%lld"),[LiveManager liveInfo].roomModel.roomId);
    [[UIApplication sharedApplication] setIdleTimerDisabled:NO];
    kWeakSelf(self);
    NSArray *vcList = [ProjConfig currentNVCList];
    __block BOOL hasSelf = NO;
    [vcList enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if ([obj isKindOfClass:[LiveBaseViewController class]]) {
            hasSelf = YES;
            weakself.hidesBottomBarWhenPushed = NO;
            LiveBaseViewController *liveBaseVC = (LiveBaseViewController *)obj;
            [liveBaseVC dismissViewControllerAnimated:animated completion:nil];
            [liveBaseVC.navigationController popToRootViewControllerAnimated:animated];
            *stop = YES;
        }
    }];
    if (!hasSelf) {
        if ([self isKindOfClass:[LiveBaseViewController class]]) {
            self.hidesBottomBarWhenPushed = NO;
            [self dismissViewControllerAnimated:animated completion:nil];
            [self.navigationController popToRootViewControllerAnimated:animated];
        }
    }
}



- (void)applicationWillTerminate{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIApplicationWillTerminateNotification object:nil];
    [[UIApplication sharedApplication] setIdleTimerDisabled:NO];
}


@end
