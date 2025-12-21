//
//  MPVideoLiveController.m
//  OneVideoLive
//
//  Created by admin on 2020/1/2.
//  Copyright © 2020 Orely. All rights reserved.
//

#import "MPVideoLiveController.h"
#import <LibTools/LibTools.h>
#import <LiveCommon/LiveManager.h>
#import <LiveCommon/LiveComponentMsgMgr.h>
#import <LiveCommon/LiveComponentMsgListener.h>
#import <LibProjModel/ApiUserInfoModel.h>
#import <LibProjModel/OpenAuthDataVOModel.h>
#import <LibProjModel/AppJoinRoomVOModel.h>
#import <TXImKit/TXImKit.h>

@interface MPVideoLiveController ()

@property (nonatomic, assign)BOOL isAnchor;

@end

@implementation MPVideoLiveController


- (instancetype)initWithIsAnchor:(BOOL)isAnchor{

    self = [super init];
    if (self) {
        _isAnchor = isAnchor;
        [LiveManager liveInfo].liveType = LiveTypeForMPVideoLive;
        [LiveManager liveInfo].roomRole = isAnchor? RoomRoleForAnchor:RoomRoleForAudience;
    }
    return self;
}

- (void)viewDidLoad {
    ///组件加载前先初始化数据
    [self createInvite];
    
    [super viewDidLoad];
    
    if ([LiveManager liveInfo].roomRole != RoomRoleForAnchor) {
        [LiveManager setCanClear:YES];
    }else{
        [LiveManager setCanClear:NO];
    }
}


- (void)createInvite{
    [LiveManager liveInfo].openData = self.openData;
    [LiveManager liveInfo].roomModel = self.roomModel;
    [LiveManager liveInfo].roomRole = _isAnchor?RoomRoleForAnchor:RoomRoleForAudience;
}

@end
