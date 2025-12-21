//
//  MPVideoConfig.m
//  klcVoice
//
//  Created by admin on 2020/1/9.
//  Copyright © 2020 . All rights reserved.
//

#import "MPVideoConfig.h"
#import <LiveCommon/MPLiveInterface.h>

#import <MPVideoLive/MPVideoInfoHeaderView.h>
#import <MPVideoLive/MPVideoInfoBottomView.h>
#import <MPVideoLive/MPVideoPreView.h>
#import <MPVideoLive/MPVideoCloseInfoShowView.h>


@interface MPVideoConfig ()<MPLiveInterface>


@end

@implementation MPVideoConfig


///直播间信息组件
+ (Class<MPLiveInfoHeaderInterface>)getHeaderInfoView{
    return MPVideoInfoHeaderView.class;
}

+ (Class<MPLiveInfoBottomInterface>)getBottomInfoView{
    return MPVideoInfoBottomView.class;
}

///开播视图
+ (Class<MPLivePreInterface>)getPreView{
    return MPVideoPreView.class;
}
///关播视图
+ (Class<MPLiveCloseInterface>)getCloseView{
    return MPVideoCloseInfoShowView.class;
}

+ (BOOL)videoHasShopping{
    return NO;
}

@end
