//
//  PopupTool.m
//  LibProjView
//
//  Created by klc_sl on 2020/3/18.
//  Copyright © 2020 . All rights reserved.
//

#import "PopupTool.h"
#import <LibTools/LibTools.h>

///每一个弹窗的底视图
@interface PopDownView : UIView

@property(nonatomic,weak) UIView *linkView;
@property(nonatomic,weak) UIView *subMainView;

@property (nonatomic, assign) BOOL hasBgColor;   ///是否有背景色

@end

@implementation PopDownView

- (void)setHasBgColor:(BOOL)hasBgColor{
    _hasBgColor = hasBgColor;
    self.backgroundColor = hasBgColor?kRGBA_COLOR(@"#3A3A3A", 0.5):[UIColor clearColor];
}

@end


static PopupTool *_tools = nil;
@interface PopupTool ()<UIGestureRecognizerDelegate>

///弹出视图窗口bgView
@property (nonatomic, weak)UIView *popupBgView;

@end

@implementation PopupTool


- (void)dealloc
{
    [PopupTool closeAllPopupView];
    _popupBgView = nil;
}


+ (instancetype)share{
    if (!_tools) {
        _tools = [[PopupTool alloc] init];
    }
    return _tools;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
    }
    return self;
}

- (void)setPopupSuperView:(UIView *)popupSuperView{
    [PopupTool closeAllPopupView];
    _popupSuperView = popupSuperView;
}

///获取当前弹窗视图的基础视图
- (UIView *)getPopupSuperBaseView{
    return _popupBgView;
}


- (UIView *)popupBgView{
    if (!_popupBgView) {
        _popupBgView = _popupSuperView;
        
        ///MARK: 不要在这里设置基础颜色
        if (!_popupBgView) {
            UIView *winView = [UIApplication sharedApplication].keyWindow;
            UIView *popView = [[UIView alloc] initWithFrame:winView.bounds];
            [winView addSubview:popView];
            _popupBgView = popView;
        }
    }
    return _popupBgView;
}

- (void)createPopupViewWithLinkView:(UIView *)popupView allowTapOutside:(BOOL)tapOutside{
    [self createPopupViewWithLinkView:popupView allowTapOutside:tapOutside popupBgViewAction:nil popupBgViewTarget:nil cover:NO];
}

- (void)createPopupViewWithLinkView:(UIView *)popupView
                    allowTapOutside:(BOOL)tapOutside
                              cover:(BOOL)cover{
    [self createPopupViewWithLinkView:popupView allowTapOutside:tapOutside popupBgViewAction:nil popupBgViewTarget:nil cover:cover];
}


- (void)animationShowPopupView:(UIView *)popupView{
    [UIView animateWithDuration:0.3 animations:^{
        CGRect tempFrame = popupView.frame;
        tempFrame.origin.y = kScreenHeight - tempFrame.size.height;
        popupView.frame = tempFrame;
    }];
}

/**
 显示弹窗
 @param popupView   需要弹出的view
 @param tapOutside 点击弹窗外区域是否隐藏view
 @param action          点击弹窗外区域对应的方法
 @param target          点击弹窗外区域对应的方法的对象
 */
- (void)createPopupViewWithLinkView:(UIView *)popupView allowTapOutside:(BOOL)tapOutside popupBgViewAction:(SEL _Nullable)action popupBgViewTarget:(id _Nullable)target cover:(BOOL)cover
{
    
    PopDownView *bgView = [[PopDownView alloc] initWithFrame:self.popupBgView.bounds];
    bgView.userInteractionEnabled = YES;
    [self.popupBgView addSubview:bgView];
    [bgView addSubview:popupView];
    bgView.linkView = popupView;
    bgView.hasBgColor = cover;
    [self checkPopupWindowUserInteraction];
    
    if (tapOutside) {
        SEL bgVAction = action?action:@selector(clickHiddenTapdown:);
        id bgVTarget = target?target:self;
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:bgVTarget action:bgVAction];
        tap.delegate = self;
        [bgView addGestureRecognizer:tap];
    }
}

- (void)closePopupView:(UIView *)popupView{
    
    PopDownView *searchPopdownView = [self getPopDownView:popupView];
    [searchPopdownView.linkView removeFromSuperview];
    [searchPopdownView removeFromSuperview];
    [self checkPopupWindowUserInteraction];
}

- (void)closePopupView:(UIView *)popupView animate:(BOOL)animate{
    __weak typeof(self) weakSelf = self;
    [UIView animateWithDuration:animate?0.3:0.0 animations:^{
        CGRect tempFrame = popupView.frame;
        tempFrame.origin.y = kScreenHeight;
        popupView.frame = tempFrame;
    } completion:^(BOOL finished) {
        [weakSelf closePopupView:popupView];
    }];
    
}

- (PopDownView *)getPopDownView:(UIView *)popupView{
    PopDownView *searchPopdownView = nil;
    for (PopDownView *popdownView in self.popupBgView.subviews) {
        if ([popdownView isKindOfClass:[PopDownView class]] && popdownView.linkView == popupView) {
            searchPopdownView = popdownView;
            break;
        }
    }
    return searchPopdownView;
}


- (void)checkPopupWindowUserInteraction{
    if (self.popupBgView.subviews.count == 0) {
        self.popupBgView.userInteractionEnabled = NO;
        
        ///如果视图不是自定义的父视图，就说明是放在window上的视图，所以删除
        if (![self.popupBgView isKindOfClass:self.popupSuperView.class]) {
            [self.popupBgView removeFromSuperview];
        }
        self.popupBgView = nil;
    }
    else{
        self.popupBgView.userInteractionEnabled = YES;
    }
}


- (void)clickHiddenTapdown:(UITapGestureRecognizer *)tapGes{
    UIView *tapView = tapGes.view;
    if ([tapView isKindOfClass:[PopDownView class]]) {
        PopDownView *popdownView = (PopDownView *)tapView;
        [self closePopupView:popdownView.linkView animate:NO];
    }
    else{
        NSAssert(NO, kLocalizationMsg(@"tapView 类型不对"));
    }
}


+ (UIView *)getPopupViewForClass:(Class)popupView {
    UIView *superView = [[PopupTool share] getPopupSuperBaseView];
    if (superView) {
        for (PopDownView *popdownView in superView.subviews) {
            if ([popdownView isKindOfClass:[PopDownView class]] && [popdownView.linkView isMemberOfClass:popupView]) {
                return popdownView.linkView;
                break;
            }
        }
    }
    return nil;
}

+ (void)bringViewToFront:(Class)popupView {
    UIView *superView = [[PopupTool share] getPopupSuperBaseView];
    if (superView) {
        PopDownView *frontV;
        for (PopDownView *popdownView in superView.subviews) {
            if ([popdownView isKindOfClass:[PopDownView class]] && [popdownView.linkView class] == popupView) {
                frontV = popdownView;
                break;
            }
        }
        if (frontV) {
            [superView bringSubviewToFront:frontV];
        }
    }
}
+ (void)closeAllPopupView{
    UIView *superView = [[PopupTool share] getPopupSuperBaseView];
    if (superView) {
        for (UIView *itemView in superView.subviews) {
            if ([itemView isMemberOfClass:[PopDownView class]]) {
                [itemView removeFromSuperview];
            }
        }
        [[PopupTool share] checkPopupWindowUserInteraction];
    }
}


#pragma mark - 统一视图弹窗组件管理 -


/// 显示弹窗
/// @param popupView  需要弹出的view
/// @param subView 主要显示的视图
- (void)createPopupViewWithLinkView:(UIView *)popupView
                            subView:(UIView *)subView
                  popupBgViewAction:(SEL _Nullable)action
                  popupBgViewTarget:(id _Nullable)target
                              cover:(BOOL)cover {
    
    PopDownView *bgView = [[PopDownView alloc] initWithFrame:self.popupBgView.bounds];
    bgView.userInteractionEnabled = YES;
    [self.popupBgView addSubview:bgView];
    [bgView addSubview:popupView];
    bgView.linkView = popupView;
    bgView.subMainView = subView;
    bgView.hasBgColor = cover;
    if (action && target) {
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:target action:action];
        tap.delegate = self;
        [bgView addGestureRecognizer:tap];
    }
    
    [self checkPopupWindowUserInteraction];
}

///获得弹窗视图
+ (UIView *)getSuperViewForMainPopupView:(Class)popupView {
    UIView *superView = [[PopupTool share] getPopupSuperBaseView];
    if (superView) {
        for (PopDownView *popdownView in superView.subviews) {
            if ([popdownView isKindOfClass:[PopDownView class]] && [popdownView.subMainView isMemberOfClass:popupView]) {
                return popdownView.linkView;
                break;
            }
        }
        return nil;
    }
    return nil;
}



- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch{
    //    NSString * touchClass = NSStringFromClass([touch.view class]);
    //    if ([touchClass isEqualToString:@"UITableViewCellContentView"]) {
    //        return NO;
    //    }
    if ([touch.view isKindOfClass:[PopDownView class]]) {
        return YES;
    }
    return NO;
}


@end
