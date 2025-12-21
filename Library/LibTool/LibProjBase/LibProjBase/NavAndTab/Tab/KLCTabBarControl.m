//
//  KLCTabBarControl.m
//  TCDemo
//
//  Created by admin on 2019/8/30.
//  Copyright © 2019 CH. All rights reserved.
//

#import "KLCTabBarControl.h"
#import <LibTools/LibTools.h>

#define tabbar(_STR_,a)

static KLCTabBarControl *tabBarControl = nil;

@interface KLCTabBarControl ()<UITabBarControllerDelegate>

@property (nonatomic, copy)NSArray *itemArr;
@property (nonatomic, copy)NSArray *vcArr;

@property (nonatomic, assign)UIOffset titlePositionAdjustment;
@property (nonatomic, copy)CYLTabBarController *cyltabBar;


@end

@implementation KLCTabBarControl

+ (instancetype)share{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        if (tabBarControl == nil) {
            tabBarControl = [[KLCTabBarControl alloc] init];
        }
    });
    [tabBarControl initView];
    return tabBarControl;
}

- (void)initView{
    _colorRGB_badge_value = [UIColor redColor];
}

- (void)clearItem{
    _itemArr = nil;
    _vcArr = nil;
    [_cyltabBar cyl_clearBadge];
    _cyltabBar = nil;
    [KLCPlusButton removePlusButton];
    
}

/** 添加item */
- (void)addController:(UIViewController *)vc
                title:(NSString *)title
             imageStr:(NSString *)imageStr
       selectImageStr:(NSString *)selectImageStr{
    
    [self additem:vc isVC:YES];
    [self additem:[self itemForTitle:title imageStr:imageStr selectImageStr:selectImageStr] isVC:NO];
}


/** 中间特殊的item  */
- (void)addCenterPlusImage:(NSString *)imageName clickBlock:(void (^)(void))click{
    KLCPlusButton *plusBtn = [[KLCPlusButton alloc] init];
    plusBtn.item_Image_name = imageName;
    plusBtn.item_normal_name = _plus_text;
    plusBtn.item_select_name = _plus_text;
    plusBtn.colorRGB_normal_text = _plus_text_color;
    plusBtn.colorRGB_select_text = _plus_text_color;
    plusBtn.plus_status = _plus_status;
    plusBtn.plusBtnClick = ^{
        if (click) {
            click();
        }
    };
    [KLCPlusButton registerPlusButton];
}


/** 设置第几个item显示提示数据 */
- (void)setBarItem:(NSInteger)item badgeValue:(NSString *)value animation:(CYLBadgeAnimationType)animation{
    //设置导航栏
    //添加小红点
    
    if (item >= _cyltabBar.viewControllers.count) {
        return;
    }
    
    UIViewController *vc =  _cyltabBar.viewControllers[item];
    NSUInteger delaySeconds = 1.5;
    dispatch_time_t when = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delaySeconds * NSEC_PER_SEC));
    dispatch_after(when, dispatch_get_main_queue(), ^{
        @try {
            switch (value.length) {
                case 0:{
                    [vc cyl_setBadgeBackgroundColor:self.colorRGB_badge_value];
                    [vc cyl_showBadgeValue:@"" animationType:animation];
                    [vc cyl_clearBadge];
                }
                    break;
                default:{
                    if ([value isEqualToString:@"0"]) {
                        [vc cyl_clearBadge];
                    }else{
                        [vc cyl_showBadgeValue:value animationType:animation];
                    }
                }
                    break;
            }
        } @catch (NSException *exception) {}
    });
    
    
    /*
     __weak typeof(self) weakSelf = self;
     [_cyltabBar setViewDidLayoutSubViewsBlockInvokeOnce:YES block:^(CYLTabBarController *tabBarController) {
     NSUInteger delaySeconds = 1.5;
     dispatch_time_t when = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delaySeconds * NSEC_PER_SEC));
     dispatch_after(when, dispatch_get_main_queue(), ^{
     @try {
     UIViewController *vc = tabBarController.viewControllers[item];
     
     //[vc cyl_setBadgeBackgroundColor:kRandomColor];
     //[viewController0 cyl_setBadgeRadius:11/2];
     //以上对Badge的参数设置，需要在 cyl_showBadgeValue 调用之前执行。
     
     switch (value.length) {
     case 0:{
     [vc cyl_setBadgeBackgroundColor:weakSelf.colorRGB_badge_value];
     [vc cyl_showBadgeValue:@"" animationType:animation];
     [vc cyl_clearBadge];
     }
     break;
     default:{
     if ([value isEqualToString:@"0"]) {
     [vc cyl_clearBadge];
     }else{
     [vc cyl_showBadge];
     [vc cyl_showBadgeValue:value animationType:animation];
     }
     }
     break;
     }
     } @catch (NSException *exception) {}
     });
     }];
     */
    
}


/** 获取当前设定好的tabbar */
- (CYLTabBarController *)getTabBarC{
    UIEdgeInsets imageInsets = UIEdgeInsetsZero;
    if (_cyltabBar == nil) {
        _cyltabBar = [[CYLTabBarController alloc] initWithViewControllers:_vcArr tabBarItemsAttributes:_itemArr imageInsets:imageInsets titlePositionAdjustment:self.titlePositionAdjustment context:@""];
        _cyltabBar.delegate = [KLCTabBarControl share];
        [self customizeTabBarAppearance];
        
    }
    return _cyltabBar;
}


- (void)additem:(id)item isVC:(BOOL)isVC{
    NSMutableArray *muArr = [[NSMutableArray alloc] init];
    [muArr addObjectsFromArray:isVC?_vcArr:_itemArr];
    [muArr addObject:item];
    NSArray *arr = [NSArray arrayWithArray:muArr];
    isVC?(_vcArr = arr):(_itemArr = arr);
}


- (NSDictionary *)itemForTitle:(NSString *)title
                      imageStr:(NSString *)imageStr
                selectImageStr:(NSString *)selectImageStr{
    
    CGFloat xOffset = 0;
    if (title.length == 0) {
        switch (_itemArr.count) {
            case 0:
                xOffset = -12/2;
                break;
            case 1:
                xOffset = (-38+2)/2;
                break;
            case 2:
                xOffset = (38-2)/2;
                break;
            case 3:
                xOffset = 12/2;
                break;
            default:
                break;
        }
    }else{
        CGFloat diff = 38/4.0;
        switch (_itemArr.count) {
            case 0:
                xOffset = 0;
                break;
            case 1:
                xOffset = -diff+10;
                break;
            case 2:
                xOffset = diff-10;
                break;
            case 3:
                xOffset = 0;
                break;
            default:
                break;
        }
    }
    
    NSDictionary *itemsAttributes;
    NSMutableDictionary *mutilDic = [NSMutableDictionary dictionary];
    if (title.length == 0) {
        self.titlePositionAdjustment = UIOffsetMake(xOffset, MAXFLOAT);
        itemsAttributes = @{
            CYLTabBarItemTitle : title,
            CYLTabBarItemImage : [[UIImage imageNamed:imageStr] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal],  /*NSString and UIImage are supported*/
            CYLTabBarItemSelectedImage : selectImageStr,  /*NSString and UIImage are supported*/
            CYLTabBarItemTitlePositionAdjustment: [NSValue valueWithUIOffset:self.titlePositionAdjustment],
            CYLTabBarItemImageInsets:[NSValue valueWithUIEdgeInsets:UIEdgeInsetsMake(0, 0, 0, 0)]
        };
        [mutilDic setDictionary:itemsAttributes];
    }else{
        itemsAttributes = @{
            CYLTabBarItemTitle : title,
            CYLTabBarItemImage : imageStr.length > 0?imageStr:@"",  /* NSString and UIImage are supported*/
            CYLTabBarItemSelectedImage : selectImageStr,  /* NSString and UIImage are supported*/
            
            //第一位 右大，下大
            // CYLTabBarLottieURL : [NSURL fileURLWithPath:[[NSBundle mainBundle] pathForResource:@"tab_home_animate" ofType:@"json"]],
            // CYLTabBarLottieSize: [NSValue valueWithCGSize:CGSizeMake(22, 22)]
        };
        [mutilDic setDictionary:itemsAttributes];
        UIOffset offx;
        if (imageStr.length == 0) {
            offx = UIOffsetMake(xOffset, -16);
        }else{
            offx = UIOffsetMake(xOffset, -3.5);
            
        }
        
        if (_plus_status == CYLTabBarPlusNone) {
            offx = UIOffsetMake(0, 0);
        }
        
        [mutilDic setObject:[NSValue valueWithUIOffset:offx] forKey:CYLTabBarItemTitlePositionAdjustment];
    }
    
    return mutilDic;
}
- (void)setTranslucent_tabbar:(BOOL)translucent_tabbar{
    _translucent_tabbar = translucent_tabbar;
    _cyltabBar.tabBar.translucent = translucent_tabbar;
}

- (void)customizeTabBarAppearance {
    
    [self setColorRGB_normal_text:_colorRGB_normal_text];
    [self setColorRGB_select_text:_colorRGB_select_text];
    [self setHidden_shadow_line:_hidden_shadow_line];
    [self setTranslucent_tabbar:_translucent_tabbar];
    
    _cyltabBar.rootWindow.backgroundColor = _colorRGB_tabBar_bg.length?([UIColor colorWithRed:[[NSString stringWithFormat:@"%lu", strtoul([[_colorRGB_tabBar_bg substringWithRange:NSMakeRange(1, 2)] UTF8String], 0, 16)] intValue] / 255.0 green:[[NSString stringWithFormat:@"%lu", strtoul([[_colorRGB_tabBar_bg substringWithRange:NSMakeRange(3, 2)] UTF8String], 0, 16)] intValue] / 255.0 blue:[[NSString stringWithFormat:@"%lu", strtoul([[_colorRGB_tabBar_bg substringWithRange:NSMakeRange(5, 2)] UTF8String], 0, 16)] intValue] / 255.0 alpha:1.0]):[UIColor cyl_systemBackgroundColor];
    
    // 普通状态下的文字属性
    NSMutableDictionary *normalAttrs = [NSMutableDictionary dictionary];
    normalAttrs[NSForegroundColorAttributeName] = _colorRGB_normal_text?_colorRGB_normal_text:[UIColor cyl_systemGrayColor];
    normalAttrs[NSFontAttributeName] = [UIFont systemFontOfSize:11];
    // 选中状态下的文字属性
    NSMutableDictionary *selectedAttrs = [NSMutableDictionary dictionary];
    selectedAttrs[NSForegroundColorAttributeName] = _colorRGB_select_text?_colorRGB_select_text:[UIColor cyl_labelColor];
    normalAttrs[NSFontAttributeName] = [UIFont boldSystemFontOfSize:11];
    UITabBarItem *tabBar = [UITabBarItem appearance];
    [tabBar setTitleTextAttributes:selectedAttrs forState:UIControlStateSelected];
    [tabBar setTitleTextAttributes:normalAttrs forState:UIControlStateNormal];
    //是否隐藏tabbar上的横线

    if (!_hidden_shadow_line) {
        
        UIView *lineV = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 0.5)];
        lineV.backgroundColor = [UIColor colorWithRed:222/255.0 green:222/255.0 blue:222/255.0 alpha:0.5];
        _cyltabBar.tabBar.shadowImage = [UIImage imageConvertFromView:lineV];
        _cyltabBar.tabBar.backgroundImage = [UIImage new];
        
    }else{
        _cyltabBar.tabBar.shadowImage = [UIImage new];
        _cyltabBar.tabBar.backgroundImage = [UIImage new];
    }
    
    //tabbar的半透明
    _cyltabBar.tabBar.translucent = _translucent_tabbar;
    
}



#pragma mark - delegate

- (BOOL)tabBarController:(UITabBarController *)tabBarController shouldSelectViewController:(UIViewController *)viewController {
    
    BOOL should = YES;
    if (_tabBarShouldSelect) {
        NSInteger itemNum = [_vcArr indexOfObject:viewController];
        should = _tabBarShouldSelect(itemNum, viewController);
    }
    [_cyltabBar updateSelectionStatusIfNeededForTabBarController:tabBarController shouldSelectViewController:viewController shouldSelect:should];
    UIControl *selectedTabButton = [viewController.tabBarItem cyl_tabButton];
    if (selectedTabButton.selected) {
        //        @try {
        //            [[[_cyltabBar class] cyl_topmostViewController] performSelector:@selector(refresh)];
        //        } @catch (NSException *exception) {
        //           // NSLog(@"过滤文字🔴类名与方法名：%@（在第%@行），描述：%@"), @(__PRETTY_FUNCTION__), @(__LINE__), exception.reason);
        //        }
    }
    return should;
}

- (void)tabBarController:(UITabBarController *)tabBarController didSelectViewController:(UIViewController *)viewController{
    if (_tabBarDidSelect) {
        NSInteger itemNum = [_vcArr indexOfObject:viewController];
        _tabBarDidSelect(itemNum, viewController);
    }
}

- (void)tabBarController:(UITabBarController *)tabBarController didSelectControl:(UIControl *)control {
    UIView *animationView;
    if ([control cyl_isTabButton]) {
        //更改红标状态
        //        if ([_cyltabBar.selectedViewController cyl_isShowBadge]) {
        //            [_cyltabBar.selectedViewController cyl_clearBadge];
        //        }
        animationView = [control cyl_tabImageView];
    }
    
    UIButton *button = CYLExternPlusButton;
    BOOL isPlusButton = [control cyl_isPlusButton];
    // 即使 PlusButton 也添加了点击事件，点击 PlusButton 后也会触发该代理方法。
    if (isPlusButton) {
        animationView = button.imageView;
    }
    
    switch (_item_click_status) {
        case CYLTabBarClickForScale:
        {
            [self addScaleAnimationOnView:animationView repeatCount:1];
        }
            break;
        case CYLTabBarClickForRotate:
        {
            [self addRotateAnimationOnView:animationView];//暂时不推荐用旋转方式，badge也会旋转。
        }
            break;
        default:
            break;
    }
    
    
    
}

//缩放动画
- (void)addScaleAnimationOnView:(UIView *)animationView repeatCount:(float)repeatCount {
    //需要实现的帧动画，这里根据需求自定义
    CAKeyframeAnimation *animation = [CAKeyframeAnimation animation];
    animation.keyPath = @"transform.scale";
    animation.values = @[@1.0,@1.3,@0.9,@1.15,@0.95,@1.02,@1.0];
    animation.duration = 1;
    animation.repeatCount = repeatCount;
    animation.calculationMode = kCAAnimationCubic;
    [animationView.layer addAnimation:animation forKey:nil];
}


//旋转动画
- (void)addRotateAnimationOnView:(UIView *)animationView {
    // 针对旋转动画，需要将旋转轴向屏幕外侧平移，最大图片宽度的一半
    // 否则背景与按钮图片处于同一层次，当按钮图片旋转时，转轴就在背景图上，动画时会有一部分在背景图之下。
    // 动画结束后复位
    animationView.layer.zPosition = 65.f / 2;
    [UIView animateWithDuration:0.32 delay:0 options:UIViewAnimationOptionCurveEaseIn animations:^{
        animationView.layer.transform = CATransform3DMakeRotation(M_PI, 0, 1, 0);
    } completion:nil];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [UIView animateWithDuration:0.70 delay:0 usingSpringWithDamping:1 initialSpringVelocity:0.2 options:UIViewAnimationOptionCurveEaseOut animations:^{
            animationView.layer.transform = CATransform3DMakeRotation(2 * M_PI, 0, 1, 0);
        } completion:nil];
    });
}



@end
