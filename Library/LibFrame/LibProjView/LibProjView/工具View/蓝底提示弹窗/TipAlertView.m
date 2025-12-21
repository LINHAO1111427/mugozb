//
//  TipAlertView.m
//  LibProjView
//
//  Created by klc on 2020/4/1.
//  Copyright © 2020 . All rights reserved.
//

#import "TipAlertView.h"
#import <Masonry/Masonry.h>
#import <LibTools/LibTools.h>
#import <LibProjBase/LibProjBase.h>
#import <SDWebImage/SDWebImage.h>
#import <LibProjBase/PopupTool.h>

@interface TipAlertView ()

@property (nonatomic, copy)void(^sureBtnClickBlock)(void);
@property (nonatomic, copy)void(^refuseBtnClickBlock)(void);
@property (nonatomic, copy)void(^cancelClickBlock)(void);

@end

@implementation TipAlertView


+ (void)showTitle:(NSString *)title subTitle:(void (^)(UILabel * _Nonnull))subTitleBlock sureBtnTitle:(NSString *)btnTitle btnClick:(void (^)(void))clickBlock cancel:(void (^)(void))cancel{
    UIView *selfV = [PopupTool getPopupViewForClass:self];
    if (!selfV) {
        TipAlertView *alert = [[TipAlertView alloc] init];
        alert.sureBtnClickBlock = clickBlock;
        alert.cancelClickBlock = cancel;
        [[PopupTool share] createPopupViewWithLinkView:alert allowTapOutside:YES popupBgViewAction:@selector(clickOutside) popupBgViewTarget:alert cover:YES];
        [alert createTitle:title subTitle:subTitleBlock sureBtnTitle:btnTitle];
    }
}

+ (void)removeSelf{
    UIView *selfV = [PopupTool getPopupViewForClass:self];
    if (selfV) {
        [[PopupTool share] closePopupView:selfV];
    }
}

- (void)clickOutside{
    [[PopupTool share] closePopupView:self];
    if (_cancelClickBlock) {
        _cancelClickBlock();
    }
}

+ (void)showTitle:(NSString *)title userIcon:(NSString *)iconUrl userName:(NSString *)userName gender:(int)gender levelStr:(NSString *)levelStr vipStr:(NSString *)vipStr subTitle:(void (^)(UILabel * _Nonnull))subTitleBlock sureBtnTitle:(NSString *)sureTitle sureBtnClick:(void (^)(void))sureBlock refuseBtnTitle:(NSString *)refuseTitle refuseBtnClick:(void (^)(void))refuseBlock cancel:(void (^)(void))cancel{
    
    UIView *selfV = [PopupTool getPopupViewForClass:self];
    if (!selfV) {
        TipAlertView *alert = [[TipAlertView alloc] init];
        alert.sureBtnClickBlock = sureBlock;
        alert.refuseBtnClickBlock = refuseBlock;
        alert.cancelClickBlock = cancel;
        [[PopupTool share] createPopupViewWithLinkView:alert allowTapOutside:YES popupBgViewAction:@selector(clickOutside) popupBgViewTarget:self cover:YES];
        [alert createTitle:title icon:iconUrl gender:gender levelStr:levelStr vipStr:vipStr sureBtnTitle:sureTitle refuseBtnTitle:refuseTitle subTitle:subTitleBlock];
    }
}


- (void)createTitle:(NSString *)title icon:(NSString *)icon gender:(int)gender levelStr:(NSString *)levelStr vipStr:(NSString *)vipStr sureBtnTitle:(NSString *)btnTitle refuseBtnTitle:(NSString *)refuseTitle subTitle:(void (^)(UILabel *))subTitleBlock{
    
    UIView *alertV = [self alertBgViewSureTitle:btnTitle cancelTitle:refuseTitle];
    
    if (title.length > 0) {
        UILabel *titleL = [[UILabel alloc] init];
        titleL.textAlignment = NSTextAlignmentCenter;
        titleL.textColor = [UIColor whiteColor];
        titleL.font = [UIFont systemFontOfSize:12];
        titleL.text = title;
        [alertV addSubview:titleL];
        [titleL mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(alertV);
            make.centerX.equalTo(alertV);
        }];
    }
    
    UIView *centerV = [[UIView alloc] init];
    [alertV addSubview:centerV];
    [centerV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(alertV);
        make.top.equalTo(alertV).mas_offset(40);
        make.height.mas_equalTo(60);
    }];
    
    ///头像
    UIImageView *iconImgV = [[UIImageView alloc] init];
    iconImgV.contentMode = UIViewContentModeScaleAspectFill;
    [iconImgV sd_setImageWithURL:[NSURL URLWithString:icon] placeholderImage:[ProjConfig getDefaultImage]];
    [centerV addSubview:iconImgV];
    
    UILabel *titleL = [[UILabel alloc] init];
    titleL.font = [UIFont systemFontOfSize:14];
    titleL.textColor = [UIColor whiteColor];
    [centerV addSubview:titleL];
    
    UILabel *subTitleL = [[UILabel alloc] init];
    subTitleL.font = [UIFont systemFontOfSize:14];
    subTitleL.textColor = [UIColor whiteColor];
    [centerV addSubview:subTitleL];
    
    UIImageView *genderImg = [[UIImageView alloc] init];
    genderImg.contentMode = UIViewContentModeScaleAspectFit;
    [centerV addSubview:genderImg];
    
    UIImageView *levelImg = [[UIImageView alloc] init];
    levelImg.contentMode = UIViewContentModeScaleAspectFit;
    [centerV addSubview:levelImg];
    
    UIImageView *vipImg = [[UIImageView alloc] init];
    vipImg.contentMode = UIViewContentModeScaleAspectFit;
    [centerV addSubview:vipImg];
    
    [iconImgV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.bottom.equalTo(centerV);
        make.right.equalTo(centerV.mas_left).mas_offset(-14);
        make.size.mas_equalTo(CGSizeMake(60, 60));
    }];
    
    [titleL mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(iconImgV.mas_right).mas_offset(14);
        make.top.equalTo(centerV).mas_offset(13);
        make.right.equalTo(genderImg.mas_left).mas_offset(-4);
    }];
    [genderImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(15, 15));
        make.centerY.equalTo(titleL);
        make.right.equalTo(levelImg.mas_left).mas_offset(-4);
    }];
    [levelImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(30, 15));
        make.centerY.equalTo(titleL);
        make.right.equalTo(centerV);
    }];
    [subTitleL mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(centerV);
        make.bottom.equalTo(centerV).mas_offset(-14);
    }];
    
    
    [iconImgV layoutIfNeeded];
    iconImgV.layer.cornerRadius = iconImgV.height/2.0;
    
    kWeakSelf(subTitleL);
    if (subTitleBlock) {
        subTitleBlock(weaksubTitleL);
    }
}



- (void)createTitle:(NSString *)title subTitle:(void (^)(UILabel *))subTitleBlock sureBtnTitle:(NSString *)btnTitle{
    
    UIView *alertV = [self alertBgViewSureTitle:btnTitle cancelTitle:nil];
    
    UIView *centerV = [[UIView alloc] init];
    [alertV addSubview:centerV];
    [centerV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(alertV);
        make.top.equalTo(alertV).mas_offset(40);
        make.left.equalTo(alertV).mas_offset(15);
    }];
    
    UILabel *titleL = [[UILabel alloc] init];
    titleL.textAlignment = NSTextAlignmentCenter;
    titleL.textColor = [UIColor whiteColor];
    titleL.font = [UIFont systemFontOfSize:15];
    titleL.text = title;
    [centerV addSubview:titleL];
    
    UILabel *subTitleL = [[UILabel alloc] init];
    subTitleL.textAlignment = NSTextAlignmentCenter;
    subTitleL.textColor = [UIColor whiteColor];
    subTitleL.font = [UIFont systemFontOfSize:15];
    [centerV addSubview:subTitleL];
    
    [titleL mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.equalTo(centerV);
        make.bottom.equalTo(subTitleL.mas_top).mas_offset(-16);
        make.height.mas_equalTo(17);
    }];
    
    [subTitleL mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(centerV);
        make.bottom.equalTo(centerV);
        make.height.mas_equalTo(17);
    }];
    
    kWeakSelf(subTitleL);
    if (subTitleBlock) {
        subTitleBlock(weaksubTitleL);
    }
}


-(void)clickSureBtn{
    [[PopupTool share] closePopupView:self];
    if (self.sureBtnClickBlock) {
        self.sureBtnClickBlock();
    }
}

- (void)clickCancelBtn{
    [self clickOutside];
}


- (UIView *)alertBgViewSureTitle:(NSString *)sureTitle cancelTitle:(NSString *)cancelTitle{
    
    self.frame = CGRectMake(0, 0, kScreenWidth, kScreenHeight);
    
    UIImageView *alertV = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"live_tips_tanchuang"]];
    alertV.userInteractionEnabled = YES;
    [self addSubview:alertV];
    [alertV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self);
        make.size.mas_equalTo(CGSizeMake(270, 166));
    }];
    [alertV layoutIfNeeded];
    
    UIButton *closeBtn = [[UIButton alloc] init];
    [closeBtn setImage:[UIImage imageNamed:@"live_guanbi_circle"] forState:UIControlStateNormal];
    [closeBtn setImageEdgeInsets:UIEdgeInsetsMake(3, 3, 3, 3)];
    [closeBtn addTarget:self action:@selector(clickCancelBtn) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:closeBtn];
    
    [closeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(30, 30));
        make.bottom.equalTo(alertV.mas_top).mas_offset(-10);
        make.right.equalTo(alertV);
    }];
    
    CGFloat viewH = 34;
    CGFloat viewY = alertV.height-20-viewH;
    CGFloat viewW = 110;
    UIButton *cancelBtn;
    if (cancelTitle.length > 0) {
        cancelBtn = [UIButton buttonWithType:0];
        cancelBtn.frame = CGRectMake(17, viewY, viewW, viewH);
        cancelBtn.layer.masksToBounds = YES;
        [cancelBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        cancelBtn.titleLabel.font = [UIFont systemFontOfSize:14];
        [cancelBtn setBackgroundColor:[[UIColor whiteColor] colorWithAlphaComponent:0.5]];
        [cancelBtn setTitle:cancelTitle forState:UIControlStateNormal];
        [cancelBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [cancelBtn addTarget:self action:@selector(clickSureBtn) forControlEvents:UIControlEventTouchUpInside];
        [alertV addSubview:cancelBtn];
    }
    
    UIButton *sureBtn = [UIButton buttonWithType:0];
    if (cancelBtn) {
        sureBtn.frame = CGRectMake((alertV.width-viewW-17), viewY, viewW, viewH);
    }else{
        viewW = 150;
        sureBtn.frame = CGRectMake((alertV.width-viewW)/2.0, viewY, viewW, viewH);
    }
    sureBtn.layer.masksToBounds = YES;
    [sureBtn setTitleColor:[ProjConfig normalColors] forState:UIControlStateNormal];
    sureBtn.titleLabel.font = [UIFont systemFontOfSize:14];
    [sureBtn setBackgroundColor:[UIColor whiteColor]];
    [sureBtn setTitle:sureTitle forState:UIControlStateNormal];
    [sureBtn setTitleColor:[ProjConfig normalColors] forState:UIControlStateNormal];
    [sureBtn addTarget:self action:@selector(clickSureBtn) forControlEvents:UIControlEventTouchUpInside];
    [alertV addSubview:sureBtn];
    
    [sureBtn layoutIfNeeded];
    sureBtn.layer.cornerRadius = sureBtn.height/2.0;
    
    return alertV;
}


- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event{
    UIView *hitV = [super hitTest:point withEvent:event];
    if (hitV == self) {
        return nil;
    }
    return hitV;
}


@end
