//
//  PopupTool.h
//  LibProjView
//
//  Created by klc_sl on 2020/3/18.
//  Copyright © 2020 . All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface PopupTool : NSObject

- (instancetype)init NS_UNAVAILABLE;
+ (instancetype)alloc NS_UNAVAILABLE;

/// 设置显示视图的父视图 （不传就默认）
@property (nonatomic, weak)UIView *popupSuperView;


#pragma mark - 类方法（防止视图不销或者莫名其妙显示） -

/// 默认keywindow上创建一个视图
+ (instancetype)share;

/**
 公共视图上的弹窗
 @param popupView   查找的弹窗
 */
+ (UIView *)getPopupViewForClass:(Class)popupView;

///将弹窗带到最外层
+ (void)bringViewToFront:(Class)popupView;


/** 关闭掉所有的弹窗 - 在控制器跳转的时候调用 */
+ (void)closeAllPopupView;





#pragma mark - 实例方法 -
/**
 显示弹窗  默认无背景色
 @param popupView   需要弹出的view
 @param tapOutside 点击弹窗外区域是否删除view (有消失动画)
 */
- (void)createPopupViewWithLinkView:(UIView *)popupView
                    allowTapOutside:(BOOL)tapOutside;


/**
 显示弹窗
 @param popupView   需要弹出的view
 @param tapOutside 点击弹窗外区域是否删除view (有消失动画)
 @param cover  是否有默认背景颜色。默认no-无色
 */
- (void)createPopupViewWithLinkView:(UIView *)popupView
                    allowTapOutside:(BOOL)tapOutside
                              cover:(BOOL)cover;


/**
 显示弹窗 可设置自动点击区域外方法
 @param popupView   需要弹出的view
 @param tapOutside 点击弹窗外区域是否隐藏view
 @param action          点击弹窗外区域对应的方法
 @param target          点击弹窗外区域对应的方法的对象
 @param cover  是否有默认背景颜色。默认no-无色
 */
- (void)createPopupViewWithLinkView:(UIView *)popupView
                    allowTapOutside:(BOOL)tapOutside
                  popupBgViewAction:(SEL _Nullable)action
                  popupBgViewTarget:(id _Nullable)target
                              cover:(BOOL)cover;


/**
 动画---从下往上进入
 */
- (void)animationShowPopupView:(UIView *)popupView;


/**
 关闭弹窗/删除弹窗  无动画
 @param popupView   关闭的弹窗
 */
- (void)closePopupView:(UIView *)popupView;

/**
 关闭弹窗/删除弹窗 带动画
 @param popupView   关闭的弹窗
 */
- (void)closePopupView:(UIView *)popupView animate:(BOOL)animate;




#pragma mark - 双层主视图统一视图弹窗组件管理 -


/// -----双层主视图使用-----显示弹窗 (子视图是主视图)
/// @param popupView  需要弹出的view
/// @param cover 主要显示的视图
- (void)createPopupViewWithLinkView:(UIView *)popupView
                            subView:(UIView *)subView
                  popupBgViewAction:(SEL _Nullable)action
                  popupBgViewTarget:(id _Nullable)target
                              cover:(BOOL)cover;


///-----双层主视图使用-----根据弹窗主视图获取弹窗视图
+ (UIView *)getSuperViewForMainPopupView:(Class)popupView;



@end

NS_ASSUME_NONNULL_END
