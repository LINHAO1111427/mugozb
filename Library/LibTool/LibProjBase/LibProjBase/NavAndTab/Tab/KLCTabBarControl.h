//
//  KLCTabBarControl.h
//  TCDemo
//
//  Created by admin on 2019/8/30.
//  Copyright © 2019 CH. All rights reserved.
//

#import <Foundation/Foundation.h>

#import <CYLTabBarController/CYLTabBarController.h>

#import "KLCPlusButton.h"

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSUInteger, CYLTabBarClickStatus) {
    CYLTabBarClickForDefault,
    CYLTabBarClickForScale,
    CYLTabBarClickForRotate,
};

@interface KLCTabBarControl : NSObject

/**
 设定tabbar
 */
@property (nonatomic, copy)NSString *colorRGB_tabBar_bg;
@property (nonatomic, copy)UIColor *colorRGB_normal_text;
@property (nonatomic, copy)UIColor *colorRGB_select_text;


@property (nonatomic, assign)BOOL hidden_shadow_line;

@property (nonatomic, assign)BOOL translucent_tabbar;

@property (nonatomic, assign)BOOL onlyText;//只显示text

/**
 tabbar item 点击样式
 */
@property (nonatomic, assign)CYLTabBarClickStatus item_click_status;

/**
 plus_button 的显示样式
 */
@property (nonatomic, assign)CYLTabBarPlusStatus plus_status;
@property (nonatomic, copy)NSString * plus_text;//文字
@property (nonatomic, copy)UIColor *plus_text_color;//颜色

/**
 tabbar_badge 颜色
 */
@property (nonatomic, copy)UIColor *colorRGB_badge_value;
 
/**
 tabbar点击某个item
 */
@property (nonatomic, copy)void (^tabBarDidSelect)(NSInteger item,UIViewController *vc);

/**
 tabbar点击某个item
 */
@property (nonatomic, copy)BOOL (^tabBarShouldSelect)(NSInteger item,UIViewController *vc);


/**
 使用单例可出效果 点击效果
 */
+ (instancetype)share;




- (void)clearItem;

/**
 添加item
 
 @param vc 显示的vc
 @param title 显示文字
 @param imageStr 默认图片
 @param selectImageStr 选中的图片
 */
- (void)addController:(UIViewController *)vc
                title:(NSString *)title
             imageStr:(NSString *)imageStr
       selectImageStr:(NSString *)selectImageStr;


/**
 中间特殊的item
 
 @param imageName 显示的图片
 @param click 点击返回
 */
- (void)addCenterPlusImage:(NSString *)imageName clickBlock:(void (^)(void))click;


/**
 获取当前设定好的tabbar
 
 @return tabBarController
 */
- (CYLTabBarController *)getTabBarC;


/**
 设置第几个item显示提示数据

 @param item 第几个item
 @param value @"" 为显示圆点   @"0" 不显示    @"55"显示数字
 */
- (void)setBarItem:(NSInteger)item badgeValue:(NSString *)value animation:(CYLBadgeAnimationType)animation;

@end

NS_ASSUME_NONNULL_END
