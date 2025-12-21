
//
//  SystemBaseConfig.m
//  emo
//
//  Created by admin on 2019/12/11.
//  Copyright © 2019 . All rights reserved.
//

#import "SystemBaseConfig.h"
#import "AppDelegate.h"
#import "AllObserveConfig.h"
 
#import <LibProjView/FunctionSelectManager.h>
#import <LibProjBase/LibProjBase.h>
#import <TXImKit/IMSocketIns.h>
#import "TiBeautyObj.h"

@interface SystemBaseConfig()
 
@end
 
@implementation SystemBaseConfig

+ (NSString *)baseUrl{
    return BaseUrl;
}

///显示主页面
+ (void)showHomeMainVC{
    [[AppDelegate app] isLoginRoot:NO];
}

+ (void)connectSocket{
    [self connectSocketSuccessBlock:^{
        ///全局监听
        [AllObserveConfig addAllObserver:[IMSocketIns getIns]];
    }];

}

+ (NSString *)getAppSchemeUrl{
    return @"klcMPVA";
}

/**获取app类型
 1:视频直播
 2:一对一
 3:语音
 4:短视频
 5:直播购
 12:一对多+一对一
 13:一对多_语音
 23:一对一+语音
 123:以此类推
 */
+ (int)getAppType{
    // Voice-room only (hide other modules at UI level; keep code intact)
    return 3;
}


+ (void)showSuspenPublish{
    NSArray *items = @[
        [[MainFunctionModel alloc] initWithType:MainFunctionForMPAudio title:nil icon:nil],
    ];
    [FunctionSelectManager showFunction:items];
}


+ (Class)getBeautyViewClass{
    return TiBeautyObj.class;
}
 
@end
