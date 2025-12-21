//
//  AudioPkLoadingView.h
//  MPVoiceLive
//
//  Created by CH on 2019/12/19.
//  Copyright © 2019 Orely. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <LiveCommon/LiveManager.h>

NS_ASSUME_NONNULL_BEGIN

@interface AudioPkLoadingView : UIView


+ (instancetype)showLoadingView;

- (void)showStartPKResult:(LiveInfo_PKType)pkType code:(int)code;

///超时提示
- (void)matchingTimeOut;

- (void)dismissView;


@end

NS_ASSUME_NONNULL_END
