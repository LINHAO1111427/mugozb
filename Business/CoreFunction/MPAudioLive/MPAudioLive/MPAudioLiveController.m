//
//  MPAudioLiveController.m
//  OneVideoLive
//
//  Created by admin on 2020/1/2.
//  Copyright © 2020 Orely. All rights reserved.
//

#import "MPAudioLiveController.h"
#import <LibTools/LibTools.h>
#import <LiveCommon/LiveManager.h>
#import <LibProjModel/ApiUserInfoModel.h>
#import <LibProjModel/OpenAuthDataVOModel.h>

@interface MPAudioLiveController ()

@property (nonatomic, assign)BOOL isAnchor;

@end

@implementation MPAudioLiveController


- (instancetype)initWithIsAnchor:(BOOL)isAnchor{
    
    self = [super init];
    if (self) {
        _isAnchor = isAnchor;
        [LiveManager liveInfo].liveType = LiveTypeForMPAudioLive;
        [LiveManager liveInfo].roomRole = isAnchor?RoomRoleForAnchor:RoomRoleForAudience;
//        [LiveManager liveInfo].roomRole = RoomRoleForAudience;
    }
    return self;
}

- (void)viewDidLoad {
    ///先初始化数据
    [self createInvite];
    
    [super viewDidLoad];
    
    if ([LiveManager liveInfo].roomRole != RoomRoleForAnchor) {
        [LiveManager setCanClear:NO];
    }else{
        [LiveManager setCanClear:NO];
    }
}



- (void)createInvite{

    [LiveManager liveInfo].openData = self.openData;
    [LiveManager liveInfo].roomModel = self.roomModel;
    [LiveManager liveInfo].roomRole = _isAnchor?RoomRoleForAnchor:RoomRoleForAudience;
//    [LiveManager liveInfo].roomRole = RoomRoleForAudience;
    
}

@end
