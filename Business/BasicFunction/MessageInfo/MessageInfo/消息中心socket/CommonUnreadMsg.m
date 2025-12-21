//
//  CommonUnreadMsg.m
//  LibProjView
//
//  Created by ssssssss on 2020/10/17.
//  Copyright © 2020 KLC. All rights reserved.
//

#import "CommonUnreadMsg.h"
#import <TXImKit/TXImKit.h>
#import <LibTools/LibTools.h>
#import <LibProjBase/LibProjBase.h>
#import <LibProjModel/HttpApiChatRoomController.h>
#import <LibProjBase/KLCTabBarControl.h>
#import <LibProjModel/KLCUserInfo.h>
#import <LibProjModel/ApiUserInfoModel.h>
#import <LibProjView/LoginRewardView.h>
#import <LibProjView/ForceAlertController.h>


@implementation CommonUnreadMsg

- (void)onUserGetNoReadAll:(int64_t)count{
    if (self.noReadBlock) {
        self.noReadBlock(count);
    }
}

- (void)onUserSimpleInfo:(UserSimpleInfoModel *)userSimpleInfo{
    ApiUserInfoModel *userInfo = KLCUserInfo.getUserInfo;
    userInfo.nobleGrade = userSimpleInfo.nobleGrade;
    userInfo.isSvip = userSimpleInfo.isSvip;
    if (userSimpleInfo) {
        [[NSNotificationCenter defaultCenter] postNotificationName:@"updateUserSimpleInfo" object:nil userInfo:@{@"model":userSimpleInfo}];
    }
    [KLCUserInfo setUserInfo:userInfo];
    
}

- (void)onUserLoginRewards:(int)oneFlag{
    [LoginRewardView showLoginReward:^(BOOL isSucess) {
    }];
}


- (void)onAdminSendText:(AdminSendTextVOModel *)adminSendTextVO{
    ForceAlertController *alertVC = [ForceAlertController alertTitle:kLocalizationMsg(@"提醒") message:adminSendTextVO.msgContext];
    [alertVC addOptions:kLocalizationMsg(@"我知道了") textColor:ForceAlert_NormalColor clickHandle:nil];
    [[ProjConfig currentVC] presentViewController:alertVC animated:YES completion:nil];
}

@end
