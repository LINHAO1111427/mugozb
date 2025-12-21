//
//  NearbyenderSelectedPopView.m
//  LibProjView
//
//  Created by ssssssss on 2020/9/8.
//  Copyright © 2020 KLC. All rights reserved.
//

#import "NearbyGenderSiftPopView.h"

@interface NearbyGenderSiftPopView()<UIGestureRecognizerDelegate>
@property (nonatomic, copy)GenderSiftCallBack callBack;
@property (nonatomic, strong)UIView *selectedView;
@end

@implementation NearbyGenderSiftPopView

+ (void)showView:(UIView *)superView pointY:(CGFloat)pointY gender:(int)gender callBack:(GenderSiftCallBack)callBack{
    if (!superView) {
        return;
    }
    NearbyGenderSiftPopView *showView =[[NearbyGenderSiftPopView alloc]initWithFrame:CGRectMake(0,pointY>0?pointY:50, kScreenWidth, kScreenHeight-kNavBarHeight-50-kTabBarHeight)];
    showView.backgroundColor = [UIColor colorWithWhite:0 alpha:0];
    showView.callBack = callBack;
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:showView action:@selector(tap)];
    tap.delegate = showView;
    [showView addGestureRecognizer:tap];
    [superView  addSubview:showView];
    
    UIView *selectedView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 110)];
    selectedView.backgroundColor = [UIColor whiteColor];
    UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:selectedView.bounds byRoundingCorners:UIRectCornerBottomLeft | UIRectCornerBottomRight cornerRadii:CGSizeMake(10, 10)];
    CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
    maskLayer.frame = selectedView.bounds;
    maskLayer.path = maskPath.CGPath;
    selectedView.layer.mask = maskLayer;
    showView.selectedView = selectedView;
    selectedView.clipsToBounds = YES;
    selectedView.autoresizesSubviews = YES;
     [showView addSubview:selectedView];
    
    UILabel *titleL = [[UILabel alloc]initWithFrame:CGRectMake(15, 20, kScreenWidth-30, 20)];
    titleL.textAlignment = NSTextAlignmentLeft;
    titleL.font = [UIFont systemFontOfSize:13];
    titleL.text = kLocalizationMsg(@"性别选择");
    titleL.textColor = kRGB_COLOR(@"#333333");
    titleL.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin  | UIViewAutoresizingFlexibleWidth  | UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleTopMargin  | UIViewAutoresizingFlexibleHeight    | UIViewAutoresizingFlexibleBottomMargin ;
    [selectedView addSubview:titleL];
    
    CGFloat width = kScreenWidth*90/360.0;
    CGFloat margin = ((kScreenWidth-30)-width*3)/2.0;
    for (int i = 0; i < 3; i++) {
        UIButton *btn =[[UIButton alloc]initWithFrame:CGRectMake(15+i*(width+margin), titleL.maxY+10, width, 30)];
        btn.layer.cornerRadius = 15;
        btn.clipsToBounds = YES;
        [btn setBackgroundImage:[UIImage imageWithColor:kRGB_COLOR(@"#F4F4F4")] forState:UIControlStateNormal];
        [btn setBackgroundImage:[UIImage createImageSize:btn.size gradientColors:@[kRGB_COLOR(@"#FF54A0"),kRGB_COLOR(@"#FF6CF6")] percentage:@[@0.3,@1.0] gradientType:GradientFromTopToBottom] forState:UIControlStateSelected];
        btn.titleLabel.font = [UIFont systemFontOfSize:14];
        [btn setTitleColor:kRGB_COLOR(@"#666666") forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateSelected];
        btn.imageView.contentMode = UIViewContentModeScaleAspectFit;
        btn.tag = i;
        btn.imageEdgeInsets = UIEdgeInsetsMake(8, 25, 7, 50);
        if (i == gender) {
            btn.selected = YES;
        }
        if (i == 0) {
            [btn setTitle:kLocalizationMsg(@"不限性别") forState:UIControlStateNormal];
        }else if(i == 1){
            NSAttributedString *normalAttrStr = [kLocalizationMsg(@"男") attachmentForImage:[UIImage imageNamed:@"icon_gender_boy_black"] bounds:CGRectMake(0, -2, 14, 14) before:YES textFont:[UIFont systemFontOfSize:14] textColor:kRGB_COLOR(@"#666666")];
            NSAttributedString *selectAttrStr = [kLocalizationMsg(@"男") attachmentForImage:[UIImage imageNamed:@"icon_gender_boy_white"] bounds:CGRectMake(0, -2, 14, 14) before:YES textFont:[UIFont systemFontOfSize:14] textColor:[UIColor whiteColor]];
            [btn setAttributedTitle:normalAttrStr forState:UIControlStateNormal];
            [btn setAttributedTitle:selectAttrStr forState:UIControlStateSelected];
        }else if(i == 2){
            NSAttributedString *normalAttrStr = [kLocalizationMsg(@"女") attachmentForImage:[UIImage imageNamed:@"icon_gender_girl_black"] bounds:CGRectMake(0, -2, 14, 14) before:YES textFont:[UIFont systemFontOfSize:14] textColor:kRGB_COLOR(@"#666666")];
            NSAttributedString *selectAttrStr = [kLocalizationMsg(@"女") attachmentForImage:[UIImage imageNamed:@"icon_gender_girl_white"] bounds:CGRectMake(0, -2, 14, 14) before:YES textFont:[UIFont systemFontOfSize:14] textColor:[UIColor whiteColor]];
            [btn setAttributedTitle:normalAttrStr forState:UIControlStateNormal];
            [btn setAttributedTitle:selectAttrStr forState:UIControlStateSelected];
        }
        [btn addTarget:showView action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
        [selectedView addSubview:btn];
    }
    
    kWeakSelf(showView);
    [UIView animateWithDuration:0.3 animations:^{
        weakshowView.backgroundColor = [UIColor colorWithWhite:0 alpha:0.2];
    } completion:^(BOOL finished) {
        weakshowView.callBack(NO,YES, 0, weakshowView);
    }];
}
- (void)btnClick:(UIButton *)btn{
    [self dismiss:YES gender:(int)btn.tag];
}
- (void)tap{
    [self dismiss:NO gender:0 ];
}
 
- (void)dismiss:(BOOL)selected gender:(int)gender{
    [UIView animateWithDuration:0.1 animations:^{
        self.backgroundColor = [UIColor colorWithWhite:0 alpha:0];
    } completion:^(BOOL finished) {
        [self.selectedView removeAllSubViews];
        [self.selectedView removeFromSuperview];
        self.selectedView = nil;
        [self removeFromSuperview];
        self.callBack(selected,NO, gender, self);
    }];
}
#pragma mark - UIGestureRecognizerDelegate

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch{
    if ([touch.view isKindOfClass:[UIButton class]]){
        return NO;
    }
    if (touch.view == self.selectedView){
        return NO;
    }
    return YES;
}
@end
