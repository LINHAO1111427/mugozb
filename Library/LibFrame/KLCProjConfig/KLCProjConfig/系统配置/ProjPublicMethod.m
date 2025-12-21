//
//  ProjPublicMethod.m
//  KLCProjConfig
//
//  Created by klc_sl on 2020/8/20.
//  Copyright © 2020 KLC. All rights reserved.
//

#import "ProjPublicMethod.h"
#import <TXImKit/TXImKit.h>
#import <LibTools/LibTools.h>
#import <LibProjBase/LibProjBase.h>
#import <LibProjModel/KLCUserInfo.h>
#import <LibProjModel/ApiUserInfoModel.h>
#import <LibProjModel/UserController_userUpdate.h>
#import <LibProjModel/KLCAppConfig.h>
#import "LiveLibConfig.h"
#import "SocketConfig.h"
#import "SocketHandle.h"
#import "CloudConfig.h"
#import <LibProjBase/TXMapManager.h>
#import <LibProjView/NetDataCache.h>
#import <LibProjBase/ProjBaseData.h>
#import <LibProjBase/KLCTabBarControl.h>
#import <libOpenInstallSDK/OpenInstallSDK.h>
#import <LibProjModel/HttpApiUserManagerController.h>
#import <LibProjModel/HttpApiUserController.h>
#import <LibProjModel/KLCAppConfig.h>
#import <LibProjModel/APPConfigModel.h>
#import <LibProjModel/AdminLoginSwitchModel.h>
#import <AgoraExtension/AgoraExtManager.h>
#import <LibProjBase/ApplePushManager.h>
#import "PushBusinessHandle.h"

@implementation ProjPublicMethod

+ (void)userLogout{
    [AgoraExtManager disconnect];
    [[IMSocketIns getIns] removeAllReceiver];
    [IMSocketIns closeIns];
    [[ProjBaseData share] setUserState:0];
    [[ProjBaseData share] removeAllBanner];
    [KLCUserInfo removeUserInfo];
    
    [[KLCTabBarControl share] setBarItem:[ProjConfig messageCenterItem] badgeValue:@"0" animation:CYLBadgeAnimationTypeNone];
    
}


+ (void)tokenInvalid{
    [SVProgressHUD showInfoWithStatus:kLocalizationMsg(@"您的帐号已经退出，请重新登录")];
    [ProjConfig logout];
}

+ (void)logined{
    
    [[ProjBaseData share] setUserState:0];

    ///用户登录了， 游客登录不能之注册socket
    if ([ProjConfig isUserLogin]) {
        
        [CloudConfig mediaConfig];
        
        [IMSocketIns setConfig:[SocketConfig new]];
        
        if ([KLCAppConfig appConfig].loginSwitch.invitationBindingMethod == 2 && [[ProjConfig shareInstence].baseConfig makeOpenInstall]) {
            [self inviteOpeninstallKey];
        }

        [LiveLibConfig rtcConfig];

        [ProjPublicMethod updateUserLocation];
        
        [ProjPublicMethod handlePushNotificationInfo];
    }
    
    [NetDataCache downloadGiftImage];

}


+ (void)logout{

    [ProjPublicMethod userLogout];
    
    [ProjConfig showLoginVC];
}


+ (void)connectSocket:(void (^)(void))addAllMonitorBlock {
    // 连接socket
    if ([ProjConfig isUserLogin]) {
        
        [KLCAppConfig updateAppConfig:^(BOOL success) {
        
            [IMSocketIns setConfig:[SocketConfig new]];
            
            [IMSocketIns initIns:[[SocketHandle alloc] init]];
            ///全局监听
            if (addAllMonitorBlock) {
                addAllMonitorBlock();
            }
            
        }];
    }
}


+ (void)firstLogin{
    [OpenInstallSDK reportRegister];
}


+ (void)updateUserLocation{
    [[TXMapManager shareInstance] startSingleLocation:^(BOOL success, LocationInfoModel * _Nullable infoModel) {
        if (success) {
            double lat = infoModel.coordinate.latitude;
            double lng = infoModel.coordinate.longitude;
            NSString *address = infoModel.name;
            NSString *city = infoModel.city;
            [HttpApiUserManagerController upLocationInformation:address city:city lat:lat lng:lng callback:^(int code, NSString *strMsg, HttpNoneModel *model) {
            }];
        }
    }];
}


+ (void)inviteOpeninstallKey{
    
    [[OpenInstallSDK defaultManager] getInstallParmsCompleted:^(OpeninstallData*_Nullable appData) {
        if (appData.data) {//(动态唤醒参数)
            //e.g.如免填邀请码建立邀请关系、自动加好友、自动进入某个群组或房间等
            id code = appData.data[@"code"];

            NSString *codeStr = @"";
            if ([code isKindOfClass:[NSString class]]) {
                codeStr = (NSString *)code;
            }
            if ([code isKindOfClass:[NSNumber class]]) {
                codeStr = [NSString stringWithFormat:@"%@",appData.data[@"code"]];
            }
            if (codeStr.length > 0) {
                [HttpApiUserController binding:codeStr fromSource:2 callback:^(int code, NSString *strMsg, HttpNoneModel *model) {
                    if (code == 1) {
                        [KLCUserInfo saveBind];
                    }
                }];
                
//                [HttpApiUserController binding:codeStr fromSource:2 callback:^(int code, NSString *strMsg, HttpNoneModel *model) {
//                    if (code == 1) {
//                        [KLCUserInfo saveBind];
//                    }
//                }];
            }
        }
        if (appData.channelCode) {//(通过渠道链接或二维码唤醒会返回渠道编号)
            //e.g.可自己统计渠道相关数据等
        }
       // NSLog(@"过滤文字OpenInstallSDK:\n动态参数：%@;\n渠道编号：%@"),appData.data,appData.channelCode);
    }];
}


+ (void)handlePushNotificationInfo{
    ///推送消息接收
    [ApplePushManager receiveDataHandle:^(BOOL active, NSDictionary * _Nonnull info) {
        [PushBusinessHandle showDetail:info active:active];
    }];
}

@end
