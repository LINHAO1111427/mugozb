//
//  MobManager.m
//  TCDemo
//
//  Created by admin on 2019/11/13.
//  Copyright © 2019 CH. All rights reserved.
//

#import "MobManager.h"
#import <ShareSDK/ShareSDK.h>
#import <ShareSDK/ShareSDK+Base.h>
#import <ShareSDKConnector/ShareSDKConnector.h>
#import <LibTools/LocalizationHandle.h>
#import "ProjConfig.h"

@implementation MobManager

+ (void)registPlatforms{
    
    Class<KeyConfigInterface> mobCls = [ProjConfig shareInstence].keyConfig;
    
    [ShareSDK registPlatforms:^(SSDKRegister *platformsRegister) {
        //QQ
        if ([mobCls qqAPPID].length> 0 && [mobCls qqAPPkey].length> 0 ) {
            [platformsRegister setupQQWithAppId:[mobCls qqAPPID] appkey:[mobCls qqAPPkey] enableUniversalLink:NO universalLink:[NSString stringWithFormat:@"%@qq_conn/%@",[mobCls universalLink],[mobCls qqAPPID]]];
        }
        
        if ([mobCls wxAPPID].length> 0 && [mobCls wxAppSecret].length> 0 ) {
            //微信分享登陆注册
            [platformsRegister setupWeChatWithAppId:[mobCls wxAPPID] appSecret:[mobCls wxAppSecret] universalLink:[mobCls universalLink]];
        }
        
        if ([mobCls sinaAPPKey].length> 0 && [mobCls sinaAPPSecret].length> 0 ) {
            //新浪
            [platformsRegister setupSinaWeiboWithAppkey:[mobCls sinaAPPKey] appSecret:[mobCls sinaAPPSecret] redirectUrl:[mobCls sinaRedirectUrl].length?[mobCls sinaRedirectUrl]:@"http://www.sharesdk.cn" universalLink:@""];
        }
    }];
    
}


+ (void)shareType:(SSDKPlatformType)type title:(NSString *)title content:(NSString *)content image:(nonnull id)image url:(nonnull NSString *)url shareResult:(nonnull void (^)(BOOL))shareResult{
    //创建分享参数
    NSMutableDictionary *shareParams = [NSMutableDictionary dictionary];
    
    [shareParams SSDKSetupShareParamsByText:content
                                     images:image
                                        url:[NSURL URLWithString:url]
                                      title:title
                                       type:SSDKContentTypeAuto];
    
    [ShareSDK share:type parameters:shareParams onStateChanged:^(SSDKResponseState state, NSDictionary *userData, SSDKContentEntity *contentEntity, NSError *error) {
        if (state == SSDKResponseStateSuccess) {
           // NSLog(@"过滤文字=========%@========"),kLocalizationMsg(@"分享成功")));
            if (shareResult) {
                shareResult(YES);
            }
        }
        else if (state == SSDKResponseStateFail || state == SSDKResponseStateCancel || state == SSDKResponseStatePlatformCancel){
           // NSLog(@"过滤文字=========%@========"),kLocalizationMsg(@"分享失败")));
            if (shareResult) {
                shareResult(NO);
            }
        }
    }];
}

+ (void)loginType:(SSDKPlatformType)type resultHandle:(void (^)(BOOL, SSDKUser * _Nonnull))handle{
    
    [ShareSDK authorize:type settings:nil onStateChanged:^(SSDKResponseState state, SSDKUser *user, NSError *error) {
        
       // NSLog(@"过滤文字%@"),error);
        if (state == SSDKResponseStateSuccess)
        {
           // NSLog(@"过滤文字uid=%@"),user.uid);
           // NSLog(@"过滤文字%@"),user.credential);
           // NSLog(@"过滤文字token=%@"),user.credential.token);
           // NSLog(@"过滤文字nickname=%@"),user.nickname);
            if (handle) {
                handle(YES, user);
            }
        } else if (state == 2 || state == 3) {
            handle(NO, user);
        }
    }];
}


@end
