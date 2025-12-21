//
//  AudioSelectPkView.h
//  MPVoiceLive
//
//  Created by CH on 2019/12/19.
//  Copyright © 2019 Orely. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <LiveCommon/LiveManager.h>

NS_ASSUME_NONNULL_BEGIN


@interface AudioSelectPkView : UIView

+ (void)showAndSelectType:(void(^)(LiveInfo_PKType type))block;

@end

NS_ASSUME_NONNULL_END
