//
//  SocketConfig.m
//  klcVoice
//
//  Created by 高光明 on 2020/4/3.
//  Copyright © 2020 . All rights reserved.
//

#import "SocketConfig.h"
#import <LibProjBase/ProjConfig.h>
#import <LibProjModel/APPConfigModel.h>
#import <LibProjModel/CfgLiveKeyModel.h>
#import <LibProjModel/KLCAppConfig.h>
#import <LibProjModel/HttpApiTencentCloudImController.h>
 
@implementation SocketConfig

-(int64_t)getUserID
{
    int64_t uid= [ProjConfig  userId];
    return uid;
}
-(NSString*)getUserToken
{
    NSString * token= [ProjConfig  userToken];
    return token;
}
-(void)getImUserSig:(void(^)(NSString *userSig))callBack{
    NSString *uidStr = [NSString stringWithFormat:@"%lld",[ProjConfig  userId]];
    [HttpApiTencentCloudImController genUserSig:uidStr callback:^(int code, NSString *strMsg, HttpNoneModel *model) {
        if (code == 1) {
           // NSLog(@"过滤文字####【IM反馈】#### 获取腾讯iM签名成功"));
            callBack(model.no_use);
        }else{
            callBack(nil);
           // NSLog(@"过滤文字####【IM反馈】#### 获取腾讯iM签名失败"));
        }
    }];
}
-(void) onTokenInvalid
{
    [ProjConfig tokenInvalid];
}
-(int64_t)getImKey
{
    APPConfigModel *configModel = [KLCAppConfig appConfig];
    return configModel.liveKey.tencentAppId;
}

-(NSString*)getIp{
    
    APPConfigModel *configModel = [KLCAppConfig appConfig];
    return configModel.liveKey.imIp;
}

-(int)getPort{
    
    APPConfigModel *configModel = [KLCAppConfig appConfig];
    return configModel.liveKey.imProt;
}


@end
