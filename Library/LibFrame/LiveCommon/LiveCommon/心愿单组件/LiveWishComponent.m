//
//  LiveWishComponent.m
//  LiveCommon
//
//  Created by kalacheng on 2020/9/16.
//  Copyright © 2020 KLC. All rights reserved.
//

#import "LiveWishComponent.h"

#import <TXImKit/TXImKit.h>
#import <LibTools/LibTools.h>
#import <LiveCommon/LiveComponentInterface.h>

#import <LiveCommon/LiveComponentMsgListener.h>
#import <LiveCommon/LiveComponentMsgMgr.h>

@interface LiveWishComponent()<LiveComponentInterface,LiveComponentMsgListener>

@end

@implementation LiveWishComponent

- (void)dealloc
{
   // NSLog(@"过滤文字%s"),__func__);
}
// MARK: - Init
- (void)parInitViewController:(UIViewController *)superVC views:(NSArray<UIView *> *)views{

    [LiveComponentMsgMgr addMsgListener:self];
    [[IMSocketIns getIns] addReceiver:socketGroupLive receiver:self];
}

// MARK: - 组件通讯
- (void)onMsg:(NSInteger)msgType msgDic:(NSDictionary *)msgDic{
    switch (msgType) {
        
        case LM_LiveLeaveInfo:
        case LM_ExitRoom:{
           
        }
            break;
        case LM_LiveRoomInfo:
        {
            
        }
            break;
        default:
            break;
    }
}

// MARK: - IMRcvLiveWishSend
/**
 主播收到心愿单礼物后推送给直播间(用户)
 @param list null
 */
-(void) onUserAddWishMsgUser:(NSMutableArray<ApiUsersLiveWishModel*>* )list {
    
}

/**
 心愿单设置成功推给用户
 @param awList null
 */
-(void) onSendWishUser:(NSMutableArray<ApiUsersLiveWishModel*>* )awList {
     
}


/** 心愿单设置成功推给房间 */
-(void) onSendWish:(NSMutableArray<ApiUsersLiveWishModel *> *)awList{
    [LiveComponentMsgMgr sendMsg:LM_UpdateWishList msgDic:@{@"models":awList}];
}

/**
 主播收到心愿单礼物后推送给直播间
 @param list null
 */
-(void) onUserAddWishMsg:(NSMutableArray<ApiUsersLiveWishModel*>* )list{
    [LiveComponentMsgMgr sendMsg:LM_UpdateWishList msgDic:@{@"models":list}];
}


@end
