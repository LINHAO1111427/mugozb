//
//  EmojiPlayView.h
//  MPAudioLive
//
//  Created by klc_sl on 2021/3/30.
//  Copyright © 2021 KLC. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface EmojiPlayView : UIView

- (void)stopAnimation;
- (void)playAnimation:(NSString *)path playTime:(double)time;


@end

NS_ASSUME_NONNULL_END
