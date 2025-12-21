//
//  OpenMPLiveComponent.m
//  TCDemo
//
//  Created by CH on 2019/10/17.
//  Copyright © 2019 CH. All rights reserved.
//

#import "OpenMPLiveComponent.h"

#import <LiveCommon/LiveComponentInterface.h>
#import <LiveCommon/LiveComponentMsgListener.h>
#import <LiveCommon/LiveComponentMsgMgr.h>

#import <LibTools/LibTools.h>

#import <LiveCommon/LiveManager.h>

#import <LibProjView/TimeCountDownView.h>


@interface OpenMPLiveComponent()<LiveComponentInterface,LiveComponentMsgListener>

@property (nonatomic, weak) UIView *superView;

@property (nonatomic, weak) UIView *highView;

@property (nonatomic, weak) UIViewController *superVC;

@property (nonatomic, weak)UIView<MPLivePreInterface> *openInfoV;

@end

@implementation OpenMPLiveComponent

- (void)dealloc{
   // NSLog(@"过滤文字%s"),__func__);
}

// MARK: - 初始化UI
- (void)parInitViewController:(UIViewController *)superVC views:(NSArray<UIView *> *)views{
    _superVC = superVC;
    
    [LiveComponentMsgMgr addMsgListener:self];
    _superView = views[1]; // 第二层
    _highView = views.lastObject;
    
    if ([LiveManager liveInfo].roomId > 0) {
       // NSLog(@"过滤文字房间已存在  %lld"),[LiveManager liveInfo].roomId);
    }else{
        [self showPreView];
    }
}


- (void)onMsg:(NSInteger)msgType msgDic:(NSDictionary *)msgDic{
    switch (msgType) {
        case LM_LiveRoomInfo: ///有了开播信息
        {
            [_openInfoV removeFromSuperview];
            [self initAnchorInfo];
        }
            break;
            
        default:
            break;
    }
}

// MARK: - Other

///初始化主播基本信息
- (void)initAnchorInfo{
}

- (void)showPreView{

    kWeakSelf(self);
    Class cls = [[LiveManager liveInfo].mpViewConfig getPreView];
    UIView<MPLivePreInterface> *openInfoV = [[cls alloc] init];
    switch ([LiveManager liveInfo].liveType) {
        case LiveTypeForMPVideoLive:
        {
            [openInfoV showInView:_superView openResult:^(BOOL success){
                if (success) {
                    // 开播倒计时
                    [weakself timeCountDown];
                }
            }];
        }
            break;
        case LiveTypeForMPAudioLive:
        {
            [openInfoV showInView:_superView openResult:^(BOOL success){
                if (success) {
                     // 开播倒计时
                    [self timeCountDown];
                }
            }];
        }
            break;
        default:
            break;
    }
    _openInfoV = openInfoV;
    
}


- (void)timeCountDown{
    [LiveComponentMsgMgr sendMsg:LM_LiveRoomInfo msgDic:nil];
    [TimeCountDownView showInView:_highView times:3 complete:^{
       
    }];
}


@end
