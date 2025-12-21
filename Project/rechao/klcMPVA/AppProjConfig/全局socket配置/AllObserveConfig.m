//
//  AllObserveConfig.m
//  klcVoice
//
//  Created by klc_sl on 2020/5/21.
//  Copyright © 2020 . All rights reserved.
//

#import "AllObserveConfig.h"
#import <TXImKit/IMSocketIns.h>

#import <LibTools/LibTools.h>

#import <LibProjView/OverallObserver.h>

#import <MPAudioLive/MPAudioObserver.h>

#import <LiveCommon/GameAllSocket.h>

#import <MessageInfo/MessageNoReadSocketTool.h>

@implementation AllObserveConfig

+ (void)addAllObserver:(IMSocketIns *)socket{
    
    [socket removeAllReceiver];
    
    
    /// 消息中心
    [[MessageNoReadSocketTool share] MessageNoReadSocketToolParInit];
    
    ///全局飘
    [OverallObserver addAllBanner];
    
    ///游戏飘屏
    [[IMSocketIns getIns] addReceiver:socketGroupGlobal receiver:[[GameAllSocket alloc] init]];
    
    
    ///多人语音邀请
    [[IMSocketIns getIns] addReceiver:socketGroupGlobal receiver:[[MPAudioObserver alloc] init]];
    
}

@end
