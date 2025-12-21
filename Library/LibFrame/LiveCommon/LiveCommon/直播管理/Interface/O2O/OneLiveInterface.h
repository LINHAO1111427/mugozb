//
//  OneLiveInterface.h
//  OneVideoLive
//
//  Created by admin on 2020/1/7.
//  Copyright © 2020 Orely. All rights reserved.
//

#import <Foundation/Foundation.h>

#import <LiveCommon/OneLiveInfoHeaderInterface.h>
#import <LiveCommon/OneLiveInfoBottomInterface.h>

NS_ASSUME_NONNULL_BEGIN

@protocol OneLiveInterface <NSObject>


///直播间视频信息组件
+ (Class<OneLiveInfoHeaderInterface>)getOtoHeaderInfoView;
+ (Class<OneLiveInfoBottomInterface>)getOtoBottomInfoView;


@end

NS_ASSUME_NONNULL_END
