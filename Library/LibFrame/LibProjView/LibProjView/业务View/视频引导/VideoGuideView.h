//
//  VideoGuideView.h
//  ShortVideo
//
//  Created by KLC on 2020/6/20.
//  Copyright © 2020 KLC. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
typedef enum {
    videoGuideTypeShortVideo = 0,
    videoGuideTypeDynamic,
} VideoGuideType;

@interface VideoGuideView : UIView

/// 展示引导页
/// @param superV 父视图
/// @param guideType 类型
+ (void)showIn:(UIView*)superV type:(VideoGuideType)guideType;

@end

NS_ASSUME_NONNULL_END
