//
//  MPLiveInterface.h
//  LiveCommon
//
//  Created by admin on 2020/1/9.
//  Copyright © 2020 . All rights reserved.
//

#import <Foundation/Foundation.h>
#import <LiveCommon/MPLivePreInterface.h>
#import <LiveCommon/MPLiveCloseInterface.h>
#import <LiveCommon/MPLiveInfoBottomInterface.h>
#import <LiveCommon/MPLiveInfoHeaderInterface.h>

NS_ASSUME_NONNULL_BEGIN

@protocol MPLiveInterface <NSObject>

///
///直播间信息组件
+ (Class<MPLiveInfoHeaderInterface>)getHeaderInfoView;
+ (Class<MPLiveInfoBottomInterface>)getBottomInfoView;


///开播视图
+ (Class<MPLivePreInterface>)getPreView;

///关播视图
+ (Class<MPLiveCloseInterface>)getCloseView;



@optional

///语音
///显示音频最小化视图
+ (void)showAudioMiniView:(UIView *)subViews recover:(void(^)(void))recover;
///声音波纹
+ (NSString *)soundWaveColor:(int)gender;


@end

NS_ASSUME_NONNULL_END
