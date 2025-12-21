//
//  MessageRoute.m
//  Message
//
//  Created by klc_sl on 2021/8/9.
//

#import "MessageRoute.h"
#import <LibProjBase/RouteManager.h>
#import <LibProjBase/AppRouteName.h>
#import <LibTools/LibTools.h>
#import "OfficialMessageDetailVC.h"
#import "MessageChatListVC.h"
#import "ConversationChatVC.h"
#import "ChatSetUpVC.h"
#import "SystemNotiContentVC.h"
#import "MessageDynamicListVC.h"
#import "SystemNotificationListVC.h"
#import "OfficialMessageListVC.h"
#import "MessageSquareListVC.h"
#import "SquareGroupMsgMemberVC.h"
#import "FansGroupMsgUserListVC.h"
#import "MessageCenterVC.h"
#import "RelationUserListVC.h"


@implementation MessageRoute

+ (void)registeRoute{
    
    ///我的动态评论列表
    [RouteManager addRouteForName:RN_Message_MyDynamicComment vcClass:MessageDynamicListVC.class];
    
    ///系统消息
    [RouteManager addRouteForName:RN_Message_SystemNotice vcClass:SystemNotificationListVC.class];

    ///官方消息
    [RouteManager addRouteForName:RN_Message_OfficialNotice vcClass:OfficialMessageListVC.class];
    
    ///聊天广场
    [RouteManager addRouteForName:RN_Message_MsgSquareList vcClass:MessageSquareListVC.class];
    
    ///广场成员列表
    [RouteManager addRouteForName:RN_Message_SquareUserList handle:^UIViewController * _Nonnull(NSDictionary<NSString *,id> * _Nullable parameters) {
        SquareGroupMsgMemberVC *userListVC = [[SquareGroupMsgMemberVC alloc] init];
        userListVC.groupId = [parameters[@"groupId"] longLongValue];
        userListVC.isSquareMute = [parameters[@"isSquareMute"] boolValue];
        return userListVC;
    }];
    
    ///粉丝团成员列表
    [RouteManager addRouteForName:RN_Message_FansGroupUserList handle:^UIViewController * _Nonnull(NSDictionary<NSString *,id> * _Nullable parameters) {
        FansGroupMsgUserListVC *userListVC = [[FansGroupMsgUserListVC alloc] init];
        userListVC.anchorId = [parameters[@"anchorId"] longLongValue];
        userListVC.groupId = [parameters[@"groupId"] longLongValue];
        return userListVC;
    }];
    
    
    ///官方消息详情
    [RouteManager addRouteForName:RN_Message_OfficialDetailNotice handle:^UIViewController * _Nonnull(NSDictionary<NSString *,id> * _Nullable parameters) {
        OfficialMessageDetailVC *recordVC = [[OfficialMessageDetailVC alloc] init];
        recordVC.dtoModel = parameters[@"model"];
        return recordVC;
    }];
    
    ///群聊消息列表
    [RouteManager addRouteForName:RN_Message_MessageList handle:^UIViewController * _Nonnull(NSDictionary<NSString *,id> * _Nullable parameters) {
        MessageChatListVC *list = [[MessageChatListVC alloc] init];
        list.isFullScreen = YES;
        list.navigationItem.title = kLocalizationMsg(@"私信");
        return list;
    }];
    
    //会话
    [RouteManager addRouteForName:RN_Message_ConversationChatVC handle:^UIViewController * _Nonnull(NSDictionary<NSString *,id> * _Nullable parameters) {
        ConversationChatVC *chatVC = [[ConversationChatVC alloc] init];
        chatVC.chatType = [parameters[@"chatType"] integerValue];
        chatVC.msgSendId = [parameters[@"msgSendId"] longLongValue];
        return chatVC;
    }];
    
    //聊天设置
    [RouteManager addRouteForName:RN_Message_ChatSettingsVC handle:^UIViewController * _Nonnull(NSDictionary<NSString *,id> * _Nullable parameters) {
        ChatSetUpVC *chatSetVC = [[ChatSetUpVC alloc] init];
        chatSetVC.chatType = [parameters[@"chatType"] intValue];
        chatSetVC.msgId = [parameters[@"msgId"] longLongValue];
        return chatSetVC;
    }];
    
    ///单个系统通知的列表
    [RouteManager addRouteForName:RN_Message_OneSystemNoticeList handle:^UIViewController * _Nonnull(NSDictionary<NSString *,id> * _Nullable parameters) {
        SystemNotiContentVC *noticeListVC = [[SystemNotiContentVC alloc] init];
        noticeListVC.noticeId = parameters[@"noticeId"];
        noticeListVC.navTitle = parameters[@"noticeName"];
        return noticeListVC;
    }];
    
    ///单个消息页面
    [RouteManager addRouteForName:RN_Message_MessageChatListVC vcClass:MessageCenterVC.class];
    
    
    ///通讯录中的用户信息
    [RouteManager addRouteForName:RN_User_UserRelationList handle:^UIViewController * _Nonnull(NSDictionary<NSString *,id> * _Nullable parameters) {
        RelationUserListVC *listVC = [[RelationUserListVC alloc] init];
        listVC.showType = [parameters[@"type"] intValue];
        listVC.navTitle = parameters[@"navTitle"];
        return listVC;
    }];
    
    
}

@end
