//
//  FunctionSheetBaseView.h
//  LibProjView
//
//  Created by klc_sl on 2020/3/17.
//  Copyright © 2020 . All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef void(^_Nullable funcBtnClickBlock)(void);

@interface FunctionSheetBaseView : UIView


/// 不带标题的显示弹窗
/// @param detailV 内容详情  视图有高度用视图自己的高度，无高度就统一高度
/// @param cover 是否有遮盖层
+ (void)showView:(UIView *)detailV cover:(BOOL)cover;

/// 带标题的显示弹窗
/// /// @param title 标题
/// @param detailV 内容详情  视图有高度用视图自己的高度，无高度就统一高度
/// @param cover 是否有遮盖层
/// @param cancelBlock 返回
+ (void)showTitle:(NSString * _Nullable)title
       detailView:(UIView *)detailV
            cover:(BOOL)cover
       cancelBack:(funcBtnClickBlock)cancelBlock;


/// 显示带标题的弹窗 统一关闭按钮  （右侧固定关闭按钮）
/// @param title 标题
/// @param detailV 内容视图
/// @param cover 是否有遮盖层
+ (void)showTitle:(NSString * _Nullable)title
       detailView:(UIView *)detailV
            cover:(BOOL)cover;


/// 显示带标题的弹窗 自定义左右按钮
/// @param title 标题
/// @param detailV  内容详情  视图有高度用视图自己的高度，无高度就统一高度
/// @param cover 是否有遮盖层
/// @param image 右侧或者左侧按钮的图标名称
/// @param isLeft 是否为左侧按钮
/// @param clickBlock 点击按钮的回调

+ (void)showTitle:(NSString * _Nullable)title
       detailView:(UIView *)detailV
            cover:(BOOL)cover
         btnImage:(UIImage * _Nullable)image
           isLeft:(BOOL)isLeft
       clickBlock:(funcBtnClickBlock)clickBlock
       cancelBack:(funcBtnClickBlock)cancelBlock;


/// 仿ViewController显示View
/// @param title 标题
/// @param detailView 内容视图
/// @param btnStr 按钮显示名字字符串或者图片名称
/// @param isImage btnstr是否是图片名称
/// @param clickBlock 点击按钮回调

+ (void)controllerTitle:(NSString * _Nullable)title
             detailView:(UIView *)detailView
               rightBtn:(NSString *)btnStr
          btnStrIsImage:(BOOL)isImage
             clickBlock:(funcBtnClickBlock)clickBlock;



+ (void)deletePopView:(UIView *)popView;


@end

NS_ASSUME_NONNULL_END
