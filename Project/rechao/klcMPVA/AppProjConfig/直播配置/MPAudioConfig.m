//
//  MPAudioConfig.m
//  klcVoice
//
//  Created by admin on 2020/1/9.
//  Copyright © 2020 . All rights reserved.
//

#import "MPAudioConfig.h"
#import <LiveCommon/MPLiveInterface.h>

#import <MPAudioLive/AudioLivePreView.h>
#import <MPAudioLive/MPAudioInfoHeaderView.h>
#import <MPAudioLive/MPAudioInfoBottomView.h>
#import <MPAudioLive/MPAudioCloseInfoShowView.h>
#import <MPAudioLive/MPAudioMiniView.h>

@interface MPAudioConfig ()<MPLiveInterface>


@end

@implementation MPAudioConfig

///
///直播间信息组件
+ (Class<MPLiveInfoHeaderInterface>)getHeaderInfoView{
    return MPAudioInfoHeaderView.class;
}

+ (Class<MPLiveInfoBottomInterface>)getBottomInfoView{
    return MPAudioInfoBottomView.class;
}

///开播视图
+ (Class<MPLivePreInterface>)getPreView{
    return AudioLivePreView.class;
}

///关播视图
+ (Class<MPLiveCloseInterface>)getCloseView{
    return MPAudioCloseInfoShowView.class;
}


+ (void)showAudioMiniView:(UIView *)subViews recover:(void (^)(void))recover{
    [MPAudioMiniView showAudioMiniView:subViews recover:recover];
}


@end
