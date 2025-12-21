//
//  PlayerVolumeView.h
//  LiveCommon
//
//  Created by klc on 2020/8/20.
//  Copyright © 2020 KLC. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN



@interface PlayerVolumeView : UIView


+ (void)showCurrentVolume:(int)volume changeVolume:(void(^)(int volume))block;


@end

NS_ASSUME_NONNULL_END
