//
//  ScrollviewGuideBar.h
//  HomePage
//
//  Created by klc on 2020/6/6.
//  Copyright © 2020 klc. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface ScrollviewGuideBar : UIView

/// 初始化指示条
/// @param frame frame
/// @param barClolor 滑块颜色
/// @param backColor 背景色
- (instancetype)initWithFrame:(CGRect)frame barColor:(UIColor *)barClolor backColor:(UIColor *)backColor;

@property(nonatomic,assign)CGFloat value;//默认为0 取值0～1
@property(nonatomic,assign)CGFloat rate;//滑块占比 取值0～1 默认0.5

///相关联的scrollview
@property (nonatomic, weak)UIScrollView *relationScrollV;

@end

NS_ASSUME_NONNULL_END
