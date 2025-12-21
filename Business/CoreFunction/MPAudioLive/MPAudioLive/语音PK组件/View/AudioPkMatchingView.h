//
//  AudioPkMatchingView.h
//  MPVoiceLive
//
//  Created by CH on 2019/12/19.
//  Copyright © 2019 Orely. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN


@class VoicePkVOModel;

@interface AudioPkMatchingView : UIView

+ (instancetype)initWithMatchingResult:(VoicePkVOModel *)userInfo;

- (void)dismissView;

@end

NS_ASSUME_NONNULL_END
