//
//  AudioPkFinishView.h
//  MPVoiceLive
//
//  Created by SL on 2019/12/20.
//  Copyright © 2019 Orely. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface AudioPkFinishView : UIView

+ (void)showFinishView:(void(^)(BOOL reStart))block;

@end

NS_ASSUME_NONNULL_END
