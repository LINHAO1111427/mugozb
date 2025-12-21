//
//  FunctionSheetBaseView.m
//  LibProjView
//
//  Created by klc_sl on 2020/3/17.
//  Copyright © 2020 . All rights reserved.
//

#import "FunctionSheetBaseView.h"
#import <LibTools/LibTools.h>
#import <LibProjBase/PopupTool.h>
typedef void(^cancelBack)(void);
@interface FunctionSheetBaseView ()

@property (nonatomic, weak)UIView *detailV;
@property (nonatomic, assign)BOOL hasCover;
@property (nonatomic, copy)cancelBack cancelBlock;

@end

@implementation FunctionSheetBaseView

+ (void)showView:(UIView *)detailV cover:(BOOL)cover{
    UIView *selfV = [PopupTool getSuperViewForMainPopupView:detailV.class];
    if (!selfV) {
        FunctionSheetBaseView *baseView = [[FunctionSheetBaseView alloc] init];
        [baseView createViewTitle:@"" detailView:detailV image:nil isLeft:NO cover:cover clickBlock:nil];
    }
}

+ (void)showTitle:(NSString *)title detailView:(UIView *)detailV cover:(BOOL)cover{
    UIView *selfV = [PopupTool getSuperViewForMainPopupView:detailV.class];
    if (!selfV) {
        FunctionSheetBaseView *baseView = [[FunctionSheetBaseView alloc] init];
        [baseView createViewTitle:title detailView:detailV image:[UIImage imageNamed:@"live_guanbi_gray"] isLeft:NO cover:cover clickBlock:nil];
    }
}

+ (void)showTitle:(NSString *)title detailView:(UIView *)detailV cover:(BOOL)cover cancelBack:(funcBtnClickBlock)cancelBlock {
    UIView *selfV = [PopupTool getSuperViewForMainPopupView:detailV.class];
    if (!selfV) {
        FunctionSheetBaseView *baseView = [[FunctionSheetBaseView alloc] init];
        baseView.cancelBlock = cancelBlock;
        [baseView createViewTitle:title detailView:detailV image:[UIImage imageNamed:@"live_guanbi_gray"] isLeft:NO cover:cover clickBlock:cancelBlock];
    }
}

+ (void)showTitle:(NSString *)title detailView:(UIView *)detailV cover:(BOOL)cover btnImage:(UIImage *)image isLeft:(BOOL)isLeft clickBlock:(funcBtnClickBlock)clickBlock cancelBack:(funcBtnClickBlock)cancelBlock{
    UIView *selfV = [PopupTool getSuperViewForMainPopupView:detailV.class];
    if (!selfV) {
        FunctionSheetBaseView *baseView = [[FunctionSheetBaseView alloc] init];
        baseView.cancelBlock = cancelBlock;
        [baseView createViewTitle:title detailView:detailV image:image isLeft:isLeft cover:cover clickBlock:clickBlock];
    }
}


- (void)showDetail:(UIView *)detailV{
    [[PopupTool share] createPopupViewWithLinkView:self subView:detailV popupBgViewAction:@selector(dismissView) popupBgViewTarget:self cover:_hasCover];
    [[PopupTool share] animationShowPopupView:self];
}

- (void)dismissView{
    [_detailV endEditing:YES];
    if (self.cancelBlock) {
        self.cancelBlock();
    }else{
        [FunctionSheetBaseView deletePopView:_detailV];
    }
}

+ (void)deletePopView:(UIView *)popView{
    UIView *popV = [PopupTool getSuperViewForMainPopupView:popView.class];
    [[PopupTool share] closePopupView:popV animate:YES];
}

+ (void)controllerTitle:(NSString *)title detailView:(UIView *)detailView rightBtn:(NSString *)btnStr btnStrIsImage:(BOOL)isImage clickBlock:(funcBtnClickBlock)clickBlock{
    UIView *selfV = [PopupTool getSuperViewForMainPopupView:detailView.class];
    if (!selfV) {
        FunctionSheetBaseView *baseView = [[FunctionSheetBaseView alloc] init];
        [baseView createViewControllerTitle:title detailV:detailView rightBtn:btnStr btnStrIsImage:isImage clickBlock:clickBlock];
    }
}


#pragma mark - 创建视图 -
///待标题半屏视图
- (void)createViewTitle:(NSString *)title detailView:(UIView *)detailV image:(UIImage *)image isLeft:(BOOL)isLeft cover:(BOOL)cover clickBlock:(funcBtnClickBlock)clickBlock{
    _hasCover = cover;
    
    CGFloat detailH = 300;
    if (detailV.height > 0) {
        detailH = detailV.height;
    }
    
    CGFloat headerH = (title.length>0 || image)?50:0;
    
    self.frame = CGRectMake(0, kScreenHeight, kScreenWidth, headerH + detailH +(kISiPhoneXX ? 24.0 : 0));
    self.backgroundColor = (detailV.backgroundColor?detailV.backgroundColor:[UIColor whiteColor]);
    detailV.backgroundColor = [UIColor clearColor];
    
    UIView *headerV = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, headerH)];
    [self addSubview:headerV];
    
    if (title.length>0 || image) {
        //左侧关闭按钮
        UIButton *closeBtn = [UIButton buttonWithType:0];
        if (isLeft) {
            closeBtn.frame = CGRectMake(0, 0, headerV.height, headerV.height);
        }else{
            closeBtn.frame = CGRectMake(kScreenWidth-headerV.height, 0, headerV.height, headerV.height);
        }
        [closeBtn setImage:image forState:UIControlStateNormal];
        closeBtn.imageView.contentMode = UIViewContentModeScaleAspectFit;
//        [closeBtn setImageEdgeInsets:UIEdgeInsetsMake(15, 15, 15, 15)];
        closeBtn.hidden = image?NO:YES;
        [headerV addSubview:closeBtn];
        [closeBtn klc_whenTapped:^{
            if (clickBlock) {
                clickBlock();
            }else{
                [FunctionSheetBaseView deletePopView:detailV];
            }
        }];
        ///标题
        UILabel *titleL = [[UILabel alloc] initWithFrame:CGRectMake(closeBtn.width, 0, headerV.width-(closeBtn.width *2.0), headerV.height)];
        titleL.text = title;
        titleL.font = [UIFont systemFontOfSize:15];
        titleL.textColor = [UIColor blackColor];
        titleL.textAlignment = NSTextAlignmentCenter;
        [headerV addSubview:titleL];
    }
    ///内容
    detailV.frame = CGRectMake(0, headerV.maxY, self.frame.size.width, detailH);
    [self addSubview:detailV];
    _detailV = detailV;
    
    [self cornerRadii:CGSizeMake(25, 25) byRoundingCorners:(UIRectCornerTopLeft|UIRectCornerTopRight)];
    [self showDetail:detailV];
}


- (void)createViewControllerTitle:(NSString *)title detailV:(UIView *)detailV rightBtn:(NSString *)btnStr btnStrIsImage:(BOOL)isImage clickBlock:(funcBtnClickBlock)clickBlock{
    
    _hasCover = NO;
    self.frame = CGRectMake(0, kScreenHeight, kScreenWidth, kScreenHeight);
    self.backgroundColor = (detailV.backgroundColor?detailV.backgroundColor:[UIColor whiteColor]);
    detailV.backgroundColor = [UIColor clearColor];
    
    UIView *headerV = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, kNavBarHeight)];
    [self addSubview:headerV];
    
    //左侧关闭按钮
    UIButton *backBtn = [UIButton buttonWithType:0];
    backBtn.frame = CGRectMake(0, kStatusBarHeight+2, 40, 40);
    [backBtn setImage:[UIImage imageNamed:@"back_fanhui_gray"] forState:UIControlStateNormal];
    [backBtn setImageEdgeInsets:UIEdgeInsetsMake(12, 12, 12, 12)];
    [headerV addSubview:backBtn];
    [backBtn klc_whenTapped:^{
        [FunctionSheetBaseView deletePopView:detailV];
    }];
    
    ///右侧按钮
    UIButton *functionBtn = [UIButton buttonWithType:0];
    functionBtn.frame = CGRectMake(kScreenWidth-40, kStatusBarHeight+2, 40, 40);
    if (isImage) {
        [functionBtn setImage:[UIImage imageNamed:btnStr] forState:UIControlStateNormal];
        [functionBtn setImageEdgeInsets:UIEdgeInsetsMake(15, 15, 15, 15)];
    }else{
        [functionBtn setTitle:btnStr forState:UIControlStateNormal];
        [functionBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        functionBtn.titleLabel.font = [UIFont systemFontOfSize:12];
    }
    functionBtn.hidden = btnStr.length?NO:YES;
    [headerV addSubview:functionBtn];
    [functionBtn klc_whenTapped:^{
        if (clickBlock) {
            clickBlock();
        }
    }];
    
    ///标题
    UILabel *titleL = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 200, 25)];
    titleL.centerX = headerV.width/2.0;
    titleL.centerY = backBtn.centerY;
    titleL.text = title;
    titleL.font = [UIFont boldSystemFontOfSize:17];
    titleL.textColor = [UIColor blackColor];
    titleL.textAlignment = NSTextAlignmentCenter;
    [headerV addSubview:titleL];
    
    ///内容
    CGFloat detailH =detailV.height;
    if ((detailH == 0)||(detailH > (kScreenHeight-kNavBarHeight))) {
        detailH = kScreenHeight-kNavBarHeight;
    }
    detailV.frame = CGRectMake(0, headerV.maxY, self.frame.size.width, detailH);
    [self addSubview:detailV];
    _detailV = detailV;
    
    [self showDetail:detailV];
    
}


@end
