//
//  KLCPlusButton.h
//  TCDemo
//
//  Created by admin on 2019/8/30.
//  Copyright © 2019 CH. All rights reserved.
//

#import "CYLPlusButton.h"

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSUInteger, CYLTabBarPlusStatus) {
    CYLTabBarPlusCenterBar = 0,//默认在tabbar正中心
    CYLTabBarPlusTopLine,//按钮超出线上
    CYLTabBarPlusNone, ///没有中心按钮
};


@interface KLCPlusButton : CYLPlusButton<CYLPlusButtonSubclassing>

/**
 图片名称
 */
@property (nonatomic, copy, nonnull)NSString *item_Image_name;

//文字显示
@property (nonatomic, copy)NSString *item_normal_name;
@property (nonatomic, copy)NSString *item_select_name;
//文字颜色显示
@property (nonatomic, copy)UIColor *colorRGB_normal_text;
@property (nonatomic, copy)UIColor *colorRGB_select_text;


/**
 中间plus图标是顶出来还是居中 default no:居中  yes:横线上
 */
@property (nonatomic, assign)CYLTabBarPlusStatus plus_status;


//中间点击回调
@property (nonatomic, copy)void (^plusBtnClick)(void);


@end

NS_ASSUME_NONNULL_END
