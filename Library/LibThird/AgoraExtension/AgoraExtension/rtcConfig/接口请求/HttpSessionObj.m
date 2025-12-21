//
//  HttpSessionObj.m
//  XTMedisKit
//
//  Created by shirley on 2019/9/9.
//  Copyright © 2019 XTY. All rights reserved.
//

#import "HttpSessionObj.h"
#import "AgoraRtcManager.h"
#import <AFNetworking/AFNetworking.h>
#import <LibProjModel/HttpApiConfigController.h>
#import <libTools/libTools.h>

@implementation HttpSessionObj

+ (void)getRtcToken:(NSString *)channelName userId:(int64_t)uid successBlock:(void (^)(BOOL, NSDictionary * _Nonnull))block {
    
    [HttpApiConfigController getRtcToken:channelName uid:uid callback:^(int code, NSString *strMsg, LiveRtcTokenModel *model) {
        NSString *rtcToken = [model.rtcToken isKindOfClass:[NSNull class]]?@"":model.rtcToken;
        NSDictionary *dic = @{@"rtcToken":rtcToken,
                              @"strMsg":strMsg};
        if (code != 1) {
            [SVProgressHUD showInfoWithStatus:strMsg];
        }
        block?block((code==1)?YES:NO, dic):nil;
    }];
}

+ (void)sendpushUrl:(NSString *)pushUrl userId:(int64_t)uid roomId:(NSString *)roomId successBlock:(void (^)(BOOL, NSDictionary * _Nonnull))block {
    
    [HttpApiConfigController sendpushUrl:pushUrl uid:uid roomId:roomId callback:^(int code, NSString *strMsg, NSDictionary *responDic) {
       
        if (code != 1) {
            [SVProgressHUD showInfoWithStatus:strMsg];
        }
        block?block((code==1)?YES:NO, responDic):nil;
    }];
}

@end
