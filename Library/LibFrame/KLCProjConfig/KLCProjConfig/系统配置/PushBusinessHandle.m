//
//  PushBusinessHandle.m
//  KLCProjConfig
//
//  Created by klc_sl on 2020/11/28.
//  Copyright © 2020 KLC. All rights reserved.
//

#import "PushBusinessHandle.h"
#import <LibProjBase/LibProjBase.h>
#import <LibProjView/CheckRoomPermissions.h>

#import <LibProjModel/HttpApiAppShortVideo.h>
#import <LibProjModel/HttpApiDynamicController.h>
#import <LibProjModel/HttpApiOfficialNews.h>
#import <LibProjBase/PopupTool.h>
#import <LibProjModel/HttpApiOOOCall.h>
#import <LibTools/LibTools.h>

@implementation PushBusinessHandle

+ (void)showDetail:(NSDictionary *)info active:(BOOL)active{
    
    if (active) {
        return;
    }
    
    [PopupTool closeAllPopupView];
    
    ///推送类型 1:官方推送 2:特定属性群组消息推送 3:关注的主播上线 4:关注的主播开播 5:关注的用户发布动态 6:动态被评论 7:关注的用户发布短视频 8:短视频被评论 9:私信推送 10:视频/语音通话邀请推送
    int type = [info[@"pushType"] intValue];
   // NSLog(@"过滤文字推送收到的数据：%@"),info);
    
    switch (type) {
        case 1:
        {   ///官方推送
            [HttpApiOfficialNews messageViewed:[info[@"newId"] longLongValue] callback:^(int code, NSString *strMsg, AppOfficialNewsDTOModel *model) {
                if (code == 1) {
                    [RouteManager routeForName:RN_Message_OfficialDetailNotice currentC:[ProjConfig currentVC] parameters:@{@"model":model}];
                }
            }];
        }
            break;
        case 2:
        {
            ///预留
        }
            break;
        case 3:
        {   ///关注的主播上线
            [RouteManager routeForName:RN_Message_ConversationChatVC currentC:[ProjConfig currentVC] parameters:@{@"chatType":@"0",@"msgSendId":@([info[@"userId"] longLongValue])}];
        }
            break;
        case 4:
        {   ///关注的主播开播
            CheckLiveDataType type = [info[@"liveType"] intValue];
            [[CheckRoomPermissions share] joinRoom:[info[@"roomId"] longLongValue] liveDataType:type joinRoom:^(AppJoinRoomVOModel * _Nonnull joinModel) {
                LiveRoomListReqParam *req = [[LiveRoomListReqParam alloc] init];
                req.joinPosition = 9;
                [[CheckRoomPermissions share] joinRoomForModel:joinModel currentVC:[ProjConfig currentVC] otherInfo:req];
            } closeRoom:^(AppHomeHallDTOModel * _Nonnull dtoModel) {
                [[CheckRoomPermissions share] showDetail:dtoModel currentVC:[ProjConfig currentVC]];
            } fail:nil];
        }
            break;
        case 5:  ///关注的用户发布动态
        {
            [HttpApiDynamicController getDynamicInfo:-1 dynamicId:[info[@"videoId"] longLongValue] type:-1 callback:^(int code, NSString *strMsg, ApiUserVideoModel *model) {
                [RouteManager routeForName:RN_dynamic_playVideoVC currentC:[ProjConfig currentVC] parameters:@{@"models":@[model],@"hasLoading":@(NO)}];
            }];
        }
            break;
        case 6: ///动态被评论
        {
            [RouteManager routeForName:RN_Message_MyDynamicComment currentC:[ProjConfig currentVC]];
        }
            break;
        case 7:  ///关注的用户发布短视频
        {
            [HttpApiAppShortVideo getShortVideoInfoList:-1 shortVideoId:[info[@"videoId"] longLongValue] type:-1 callback:^(int code, NSString *strMsg, PageInfo *pageInfo, NSArray<ApiShortVideoDtoModel *> *arr) {
                if (code == 1 && arr.count>0) {
                    ApiShortVideoDtoModel *dtoModel = arr.firstObject;
                    ///请求接口
                    NSDictionary *prams = @{
                        @"dataType":@(5),
                        @"index":@(0),
                        @"shortVideoId":@(dtoModel.id_field),
                    };
                    [RouteManager routeForName:RN_shortVideo_play_List currentC:[ProjConfig currentVC] parameters:prams];
                }
            }];
        }
            break;
        case 8:  ///短视频被评论
        {
            [HttpApiAppShortVideo getShortVideoInfoList:[info[@"commentId"] intValue] shortVideoId:[info[@"videoId"] longLongValue] type:1 callback:^(int code, NSString *strMsg, PageInfo *pageInfo, NSArray<ApiShortVideoDtoModel *> *arr) {
                if (code == 1 && arr.count>0) {
                    ApiShortVideoDtoModel *dtoModel = arr.firstObject;
                    ///请求接口
                    NSDictionary *prams = @{
                        @"dataType":@(4),
                        @"checkType":@(dtoModel.type),
                        @"commentId":info[@"commentId"],
                        @"index":@(0),
                        @"shortVideoId":@(dtoModel.id_field),
                    };
                    [RouteManager routeForName:RN_shortVideo_play_List currentC:[ProjConfig currentVC] parameters:prams];
                }
            }];
        }
            break;
        case 9: ///私信推送
        {
            [RouteManager routeForName:RN_Message_ConversationChatVC currentC:[ProjConfig currentVC] parameters:@{@"chatType":@"0",@"msgSendId":@([info[@"userId"] longLongValue])}];
            
        }
            break;
        case 10:
        {
            [HttpApiOOOCall oooCallPushDataRestore:[info[@"oooFee"] doubleValue] sessionId:[info[@"sessionId"] longLongValue] callback:^(int code, NSString *strMsg, HttpNoneModel *model) {
                if (code == 1) {
                    ///等待接受socket
                }else{
                    [RouteManager routeForName:RN_Message_ConversationChatVC currentC:[ProjConfig currentVC] parameters:@{@"chatType":@"0",@"msgSendId":@([info[@"sendUid"] longLongValue])}];
                }
            }];
        }
            break;
        case 12: ///订单
        {
            int64_t orderId = [info[@"promiseOrderId"] longLongValue];
            if (orderId) {
                [RouteManager routeForName:RN_Seek_InviteInfoVC currentC:[ProjConfig currentVC] parameters:@{@"orderId":@(orderId)}];
            }
        }
            break;
        default:
            break;
    }
}

@end
