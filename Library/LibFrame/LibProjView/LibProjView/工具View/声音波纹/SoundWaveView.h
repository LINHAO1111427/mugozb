//
//  SoundWaveView.h
//  LibProjView
//
//  Created by klc on 2020/6/10.
//  Copyright © 2020 . All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface SoundWaveView : UIView


- (void)starAnimation;

- (void)stopAnimation;

/** 改变涟漪圈的颜色 */
@property(nonatomic,copy) UIColor *broadColorRGB;


@end

NS_ASSUME_NONNULL_END
