//
//  HandleOtherComponent.m
//  TCDemo
//
//  Created by admin on 2019/11/19.
//  Copyright © 2019 CH. All rights reserved.
//

#import "HandleOtherComponent.h"
#import <LiveCommon/LiveComponentInterface.h>
#import <LiveCommon/LiveComponentMsgListener.h>
#import <LiveCommon/LiveComponentMsgMgr.h>
#import <LibProjView/LiveShareView.h>

#import <LiveCommon/LiveManager.h>
#import <LibProjBase/LibProjBase.h>
#import <LibTools/LibTools.h>
#import <AgoraExtension/AgoraExtManager.h>
#import "LiveSetFunctionView.h"
#import "LiveNoticeView.h"

#import "JoinFansTipView.h"
#import "VipSeatBuyView.h"
#import "VipSeatListView.h"

@interface HandleOtherComponent ()<LiveComponentInterface,LiveComponentMsgListener>

@property (nonatomic, weak)UIViewController *superVC;

@property (nonatomic, weak)UIView *secondV;

@end

@implementation HandleOtherComponent

- (void)dealloc
{
   // NSLog(@"过滤文字%s"),__func__);
}

// MARK: - init
- (void)parInitViewController:(UIViewController *)superVC views:(NSArray<UIView *> *)views{
    _superVC = superVC;
    _secondV = views[1];
    [LiveComponentMsgMgr addMsgListener:self];
    
}

// MARK: - 组件消息
- (void)onMsg:(NSInteger)msgType msgDic:(NSDictionary *)msgDic{
    
    switch (msgType) {
        case LM_LiveLeaveInfo:{
            // FIXME: 主播关播，用户如果在个人主页，跳回主播页面
            if ([LiveManager liveInfo].roomRole == 0) { // 观众
                UINavigationController *nvc = [_superVC isKindOfClass:[UINavigationController class]]? (UINavigationController *)_superVC:_superVC.navigationController;
                if (nvc != nil) {
                    [nvc popToViewController:_superVC animated:YES];
                }
            }
        }
            break;
        case LM_LiveRoomInfo:{

        }
            break;
        case LM_ShareView:
        {
            [self liveSharaClick];
        }
            break;
        case LM_SetRoomInfo:  ///房间设置
        {
            [self setRoom];
        }
            break;

        case LM_ShowTask:   ///任务
        {
            [self taskView];
        }
            break;
        case LM_ChangeNotice:   ///公告
        {
            [self roomNotice];
        }
            break;
        case LM_TimeJoinFans:{  ///粉丝团邀请加入
            [self showJoinFansTip];
        }
            break;
        case LM_buyVIPSeat:{ ///贵宾席
            [VipSeatBuyView showVIPSeat];
        }
            break;
        case LM_VIPSeatList:{ ///贵宾席
            [VipSeatListView showVIPSeatList];
        }
            break;
        default:
            break;
    }
}



// MARK: - Action
///显示分享
- (void)liveSharaClick{
    [LiveShareView showShareViewForType:2 shareId:[LiveManager liveInfo].roomId moreFunction:@[[ShareFunctionItem getCopyLinkFunction]]];
}

///房间设置
- (void)setRoom{
    [LiveSetFunctionView showSetView];
}


- (void)taskView{
    if ([LiveManager liveInfo].roomRole == RoomRoleForAnchor) {
        [RouteManager routeForName:RN_center_taskCenter currentC:_superVC parameters:@{@"isAnchor":@(1)}];
    }else{
        [RouteManager routeForName:RN_center_taskCenter currentC:_superVC parameters:@{@"isAnchor":@(0)}];
    }
}

- (void)roomNotice{
    [LiveNoticeView changeRoomNotice];
}
///邀请加入粉丝团
- (void)showJoinFansTip{
    [JoinFansTipView showJoinFansTip:_secondV];
}


@end
