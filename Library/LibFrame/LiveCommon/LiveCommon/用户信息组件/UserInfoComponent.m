//
//  UserInfoComponent.m
//  TCDemo
//
//  Created by klc_tqd on 2019/11/2.
//  Copyright © 2019 CH. All rights reserved.
//

#import "UserInfoComponent.h"

#import <LiveCommon/LiveComponentInterface.h>
#import <LiveCommon/LiveComponentMsgListener.h>
#import <LiveCommon/LiveComponentMsgMgr.h>

#import <LibProjModel/HttpApiTencentCloudImController.h>

#import <LiveCommon/LiveManager.h>
#import <LibProjModel/HttpApiHttpLive.h>
#import <LiveCommon/LiveUserInfoView.h>
#import <LibTools/LibTools.h>
#import <TXImKit/TXImKit.h>

#import "AttentionTipView.h"
#import "LiveUserInfoView.h"

@interface UserInfoComponent ()<LiveComponentInterface, LiveComponentMsgListener>

@property (nonatomic, copy) NSDate *leaveTime;

@property (nonatomic, weak) UIViewController *superVC;

@property (nonatomic, weak) UIView *secondView;

@end

@implementation UserInfoComponent

- (void)dealloc{
   // NSLog(@"过滤文字%s"),__func__);
    
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

// MARK: - 初始化UI
- (void)parInitViewController:(UIViewController *)superVC views:(NSArray<UIView *> *)views{

    _superVC = superVC;

    _secondView = views[1];
    
    [LiveComponentMsgMgr addMsgListener:self];
    [[IMSocketIns getIns] addReceiver:socketGroupLive receiver:self];
    
}


// MARK: - Socket
// 主播暂时离开
- (void)onAnchorLeaveRoom:(ApiLeaveRoomAnchorModel *)ApiLeaveRoomAnchor{
    if (ApiLeaveRoomAnchor.roomId == [LiveManager liveInfo].roomId) {
        //主播离开一下，精彩不中断，不要走开哦
        [LiveComponentMsgMgr sendMsg:LM_AnchorStatus msgDic:@{@"status":@(0)}];
    }
}

// 主播回来了
-(void) onAnchorJoinRoom:(ApiJoinRoomAnchorModel* )apiJoinRoomAnchor{
    if (apiJoinRoomAnchor.roomId == [LiveManager liveInfo].roomId) {
        //主播回来了
        [LiveComponentMsgMgr sendMsg:LM_AnchorStatus msgDic:@{@"status":@(1)}];
    }
}

// MARK: - 组件通讯
- (void)onMsg:(NSInteger)msgType msgDic:(NSDictionary *)msgDic{
    
    switch (msgType) {
            // 查看用户信息
        case LM_ShowUserInfo:{
           // NSLog(@"过滤文字msgDic == %@"),msgDic);
            [self showUserInfoView:msgDic];
        }
            break;
            ///显示关注
        case LM_TimeAttention:{
            [self showUserAttentionTip];
        }
            break;
        case LM_LiveRoomInfo:{
//            [self initShowData];
        }
            break;
        default:
            break;
    }
}

//- (void)initShowData{
//    if ([LiveManager liveInfo].roomRole == RoomRoleForAnchor){
//        [[NSNotificationCenter defaultCenter] addObserver:self
//                                                 selector:@selector(appactive)
//                                                     name:UIApplicationDidBecomeActiveNotification
//                                                   object:nil];
//        [[NSNotificationCenter defaultCenter] addObserver:self
//                                                 selector:@selector(appnoactive)
//                                                     name:UIApplicationWillResignActiveNotification
//                                                   object:nil];
//       // NSLog(@"过滤文字主播端"));
//    }else{
//       // NSLog(@"过滤文字用户端"));
//    }
//}



-(void)showUserInfoView:(NSDictionary *)dict{
    [LiveUserInfoView showUserInfo:[dict[@"userID"] longLongValue] outLiveRoom:[dict[@"outLiveRoom"] boolValue]];
}


- (void)showUserAttentionTip{
    [AttentionTipView showAttentionTip:_secondView];
}


// MARK: - app回到前台
-(void)appactive{
   // NSLog(@"过滤文字app回到前台"));
    NSDate *nowDate = [NSDate date];
    NSTimeInterval timeSpace = [nowDate timeIntervalSinceDate:_leaveTime];
    if (timeSpace < 60) {
        NSDictionary *contentDic = @{
            @"roomId":@([LiveManager liveInfo].roomId)
        };
        [self handleScoket:contentDic type:@"Live" subType:@"joinRoomAnchor"];
    }
    else{
//        [SVProgressHUD showSuccessWithStatus:kLocalizationMsg(@"离开超过1分钟，直播已结束")];
//        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//            [LiveComponentMsgMgr sendMsg:LM_CloseLive msgDic:nil];
//        });
    }
}

// MARK: - app进入后台
-(void)appnoactive{
   // NSLog(@"过滤文字app进入后台"));
    if ([LiveManager liveInfo].roomRole == RoomRoleForAnchor) {
        _leaveTime = [NSDate date];
        NSDictionary *contentDic = @{
            @"roomId":@([LiveManager liveInfo].roomId)
        };
        [self handleScoket:contentDic type:@"Live" subType:@"leaveRoomAnchor"];
    }
}

- (void)handleScoket:(NSDictionary *)contentDic type:(NSString *)type subType:(NSString *)subType{
    NSString *content = [contentDic convertToJsonData];
    [HttpApiTencentCloudImController handleListenSocket:content subType:subType type:type callback:^(int code, NSString *strMsg, HttpNoneModel *model) {
        
    }];
}
@end
