//
//  KLCPlusButton.m
//  TCDemo
//
//  Created by admin on 2019/8/30.
//  Copyright © 2019 CH. All rights reserved.
//

#import "KLCPlusButton.h"
#import <LibTools/BaseMacroDefinition.h>
#import <LibTools/UIhelpTools.h>

static KLCPlusButton *plusBtn;

@interface KLCPlusButton ()<UIActionSheetDelegate>


@end


@implementation KLCPlusButton

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self initView];
        plusBtn = self;
    }
    return self;
}

- (void)initView{
    _colorRGB_normal_text = [UIColor clearColor];
    _colorRGB_select_text = [UIColor clearColor];
    self.titleLabel.textAlignment = NSTextAlignmentCenter;
    self.adjustsImageWhenHighlighted = NO;

}

//上下结构的 button
- (void)layoutSubviews {
    [super layoutSubviews];

    //文字
    CGFloat  labelLineHeight = 0;
    if (self.plus_status == CYLTabBarPlusTopLine) {
        labelLineHeight  = 6;
    }
    if (self.item_normal_name.length > 0) {
         labelLineHeight = self.titleLabel.font.lineHeight+5;
    }
    
    
    //图片
    UIImage *image =[UIImage imageNamed:self.item_Image_name];
    CGFloat scale = 1.0*image.size.width/image.size.height;
    CGFloat  imageViewEdgeHeight = self.bounds.size.height;
    CGFloat  imageViewEdgeWidth = scale*imageViewEdgeHeight;
      
     //竖向
    CGFloat  verticalMarginT = self.bounds.size.height - labelLineHeight - imageViewEdgeHeight;
    CGFloat  verticalMargin = 0;
    if (verticalMarginT > 0) {
       verticalMargin = verticalMarginT/2;
    }else{
       verticalMargin = verticalMarginT;
    }
     
    //imageView和titleLabel中心的Y值
    CGFloat  centerOfImageView = verticalMargin + imageViewEdgeHeight * 0.5;
    CGFloat  centerOfTitleLabel = self.bounds.size.height-5-labelLineHeight*0.5;
    
    CGFloat  centerXOfView = self.bounds.size.width * 0.5;
    self.imageView.bounds = CGRectMake(0, 0, imageViewEdgeWidth, imageViewEdgeHeight);
    self.imageView.center = CGPointMake(centerXOfView, centerOfImageView);
    
    self.titleLabel.bounds = CGRectMake(0, 0, self.bounds.size.width, labelLineHeight);
    self.titleLabel.center = CGPointMake(centerXOfView, centerOfTitleLabel);
}

#pragma mark - CYLPlusButtonSubclassing Methods
 
+ (id)plusButton {
    
    KLCPlusButton *button = plusBtn;

    [button setImage:[UIImage imageNamed:button.item_Image_name] forState:UIControlStateNormal];
    button.imageView.contentMode = UIViewContentModeScaleAspectFit;
    
    if (button.item_normal_name.length) {
         [button setTitle:button.item_normal_name forState:UIControlStateNormal];
    }
    [button setTitleColor:button.colorRGB_normal_text forState:UIControlStateNormal];
    
    if (button.item_select_name.length) {
        [button setTitle:button.item_select_name forState:UIControlStateSelected];
    }
    [button setTitleColor:button.colorRGB_select_text forState:UIControlStateSelected];
    
    button.titleLabel.font = [UIFont boldSystemFontOfSize:11];
    
    [button addTarget:self action:@selector(plusButtonClick) forControlEvents:UIControlEventTouchUpInside];
    
    [button sizeToFit];
    
    return button;
}



/*!
 * 该方法是为了调整 PlusButton 中心点Y轴方向的位置，建议在按钮超出了 tabbar 的边界时实现该方法。
 * @attention 如果不实现该方法，内部会自动进行比对，预设一个较为合适的位置，如果实现了该方法，预设的逻辑将失效。
 * @return 返回值是自定义按钮中心点Y轴方向的坐标除以 tabbar 的高度，
           内部实现时，会使用该返回值来设置 PlusButton 的 centerY 坐标，公式如下：
              `PlusButtonCenterY = multiplierOfTabBarHeight * tabBarHeight + constantOfPlusButtonCenterYOffset;`
           也就是说：如果 constantOfPlusButtonCenterYOffset 为0，同时 multiplierOfTabBarHeight 的值是0.5，表示 PlusButton 居中，小于0.5表示 PlusButton 偏上，大于0.5则表示偏下。
 *
 */
+ (CGFloat)multiplierOfTabBarHeight:(CGFloat)tabBarHeight{
    KLCPlusButton *button = plusBtn;
    CGFloat multiplier = 0;
    switch (button.plus_status) {
        case CYLTabBarPlusCenterBar: {
            multiplier = 0.5;
        }
            break;
        case CYLTabBarPlusTopLine:{
            multiplier =  0.5;
        }
            break;
        default: {
             multiplier = 0.5;
        }
            break;
    }
    
    return multiplier;
}


/*!
* 见 `+multiplierOfTabBarHeight:` 注释：
* `PlusButtonCenterY = multiplierOfTabBarHeight * tabBarHeight + constantOfPlusButtonCenterYOffset;`
* 也就是说： constantOfPlusButtonCenterYOffset 大于0会向下偏移，小于0会向上偏移。
* @attention 实现了该方法，但没有实现 `+multiplierOfTabBarHeight:` 方法，在这种情况下，会在预设逻辑的基础上进行偏移。
*/
+ (CGFloat)constantOfPlusButtonCenterYOffsetForTabBarHeight:(CGFloat)tabBarHeight{
    KLCPlusButton *button = plusBtn;
    CGFloat YOffset = 0;
    switch (button.plus_status) {
        case CYLTabBarPlusCenterBar:{
            if (kSafeAreaBottom > 0) {
                YOffset = -kSafeAreaBottom/2.0;
            }else{
                YOffset = 0;
            }
        }
            break;
        case CYLTabBarPlusTopLine:{
            if (kSafeAreaBottom > 0) {
                YOffset = -kSafeAreaBottom/2.0;
            }else{
                YOffset = 0;
            }
        }
            break;
         
        default: {
            if (kSafeAreaBottom > 0) {
                YOffset = -kSafeAreaBottom/2.0;
            }else{
                YOffset = 0;
            }
        }
            break;
    }
    
    return YOffset;
}

+ (NSUInteger)indexOfPlusButtonInTabBar{
    return 2;
}

+ (void)plusButtonClick{
    KLCPlusButton *button = plusBtn;
    if (button.plusBtnClick) {
        button.plusBtnClick();
    }
}


@end
