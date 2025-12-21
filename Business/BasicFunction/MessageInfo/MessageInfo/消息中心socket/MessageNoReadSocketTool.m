//
//  KlcUnreadMessageManeger.m
//  LibProjView
//
//  Created by ssssssss on 2020/10/17.
//  Copyright © 2020 KLC. All rights reserved.
//

#import "MessageNoReadSocketTool.h"

#import <LibTools/LibTools.h>
#import <LibProjBase/LibProjBase.h>
#import <LibProjModel/HttpApiMessage.h>
#import <LibProjBase/KLCTabBarControl.h>
#import <TXImKit/TXImKit.h>

#import  "CommonUnreadMsg.h"
#import  "DynamicUnreadMsg.h"
#import  "ShortVideoUnreadMsg.h"

#import <LibProjView/IMMessageObserver.h>


@interface MessageNoReadSocketTool ()<IMObserverDelegate,ImConversationHander>

@property (nonatomic, strong)CommonUnreadMsg *commonUnread;
@property (nonatomic, strong)DynamicUnreadMsg *dynamicUnread;
@property (nonatomic, strong)ShortVideoUnreadMsg *shortVideoUnread;

@end

@implementation MessageNoReadSocketTool

+ (instancetype)share{
    static MessageNoReadSocketTool *shareTool = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        if (!shareTool) {
            shareTool = [[MessageNoReadSocketTool alloc] init];
        }
    });
    return shareTool;
}

//socket初始化
- (void)MessageNoReadSocketToolParInit{
    [[IMSocketIns getIns] addReceiver:socketGroupMessage receiver:self.commonUnread];
    [[IMSocketIns getIns] addReceiver:socketGroupMessage receiver:self.dynamicUnread];
    [[IMSocketIns getIns] addReceiver:socketGroupMessage receiver:self.shortVideoUnread];
    [[IMSocketIns getIns] addConversantionHander:self];
    [IMMessageObserver onImHandle];
    [IMMessageObserver addDelegate:self];
     
}

//移除socket
- (void)removeMessageSocket{
    [[IMSocketIns getIns] removeReceiverByGroupID:socketGroupMessage];
}

//IM消息代理方法
#pragma mark - IMObserverDelegate -
- (void)onConversationChanged:(NSArray<V2TIMConversation *> *)conversationList{
    [self getAppSystemNoReadData];
}

-(void)getAppSystemNoReadData{
    kWeakSelf(self);
    [HttpApiMessage getAppSystemNoRead:^(int code, NSString *strMsg, ApiNoReadModel *model) {
        if (code== 1) {
            [weakself getUnreadCount:model.totalNoRead time:10];
        }
    }];
    
}


- (void)clearAllUnreadMessage{
    kWeakSelf(self);
    [HttpApiMessage clearNoticeMsg:-1 type:0 callback:^(int code, NSString *strMsg, HttpNoneModel *model) {
        if (code == 1) {
            [[IMSocketIns getIns] readAllImMsg:^{
                
            } fail:^(int code, NSString * _Nonnull desc) {
               // NSLog(@"过滤文字####【IM反馈】#### 阅读所有消息失败"));
            }];
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [weakself getAppSystemNoReadData];
            });
            [[NSNotificationCenter defaultCenter] postNotificationName:NotificationUpdateStatus object:@{}];
            weakself.reloadMsgListBlock?weakself.reloadMsgListBlock():nil;
        }else{
            [SVProgressHUD showInfoWithStatus:kLocalizationMsg(@"忽略未读消息失败了~")];
        }
    }];
}


- (void)deleteAllConversationAndMsgs{
    
    
    
}


-(void)getUnreadCount:(int64_t)count time:(int)time{
    kWeakSelf(self);
    time --;
    [[IMSocketIns getIns] getAllUnreadMsgCount:^(int totalCount) {
        int64_t unread = totalCount + count;
        UITabBarController *tabbar = [ProjConfig tabbarC];
        if (tabbar) {
            [[KLCTabBarControl share] setBarItem:[ProjConfig messageCenterItem] badgeValue:[NSString stringWithFormat:@"%lld",(unread>0)?unread:0] animation:CYLBadgeAnimationTypeNone];
        }
        if (self.unReadTotalNumBlock) {
            self.unReadTotalNumBlock(unread);
        }
    } fail:^(int code, NSString * _Nonnull desc) {
       // NSLog(@"过滤文字####【IM反馈】##### 获得所有所有未读消息数目失败"));
        if (time > 0) {
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [weakself getUnreadCount:count time:time];
            });
        }
    }];
     
}
#pragma mark - ImConversationHander
/// 消息总未读数发生改变
/// @param totalUnreadCount 未读数
- (void)ImTotalUnreadMessageCountChanged:(UInt64) totalUnreadCount{
    if (self.unReadTotalNumBlock) {
        self.unReadTotalNumBlock(totalUnreadCount);
    }
}
#pragma mark - 懒加载
- (CommonUnreadMsg *)commonUnread{
    if (!_commonUnread) {
        _commonUnread = [[CommonUnreadMsg alloc] init];
        kWeakSelf(self);
        _commonUnread.noReadBlock = ^(int64_t noReadNum) {
            [weakself getAppSystemNoReadData];
        };
    }
    return _commonUnread;
}
- (DynamicUnreadMsg *)dynamicUnread{
    if (!_dynamicUnread) {
        kWeakSelf(self);
        _dynamicUnread = [[DynamicUnreadMsg alloc]init];
        _dynamicUnread.noReadBlock = ^(int noReadNum) {
            [weakself getAppSystemNoReadData];
        };
    }
    return _dynamicUnread;
}
- (ShortVideoUnreadMsg *)shortVideoUnread{
    if (!_shortVideoUnread) {
        kWeakSelf(self);
        _shortVideoUnread = [[ShortVideoUnreadMsg alloc]init];
        _shortVideoUnread.noReadBlock = ^(int noReadNum) {
            [weakself getAppSystemNoReadData];
        };
    }
    return _shortVideoUnread;
}



@end
