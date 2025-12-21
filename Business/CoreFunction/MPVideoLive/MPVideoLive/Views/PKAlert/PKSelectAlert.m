//
//  PKSelectAlert.m
//  MPVideoLive
//
//  Created by admin on 2019/8/13.
//  Copyright © 2019 cat. All rights reserved.
//

#import "PKSelectAlert.h"
#import <objc/runtime.h>
#import <LibTools/LibTools.h>
#import <Masonry/Masonry.h>

@interface PKSelectAlert ()<UIGestureRecognizerDelegate>

@property (nonatomic, weak)UIView *alertView;

@end

@implementation PKSelectAlert

- (instancetype)initWithAlertTitle:(NSString *)title
{
    self = [super init];
    if (self) {
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(clickBgViewToRemove)];
        tap.delegate = self;
        [self addGestureRecognizer:tap];
        [self createUI:title];
    }
    return self;
}

- (void)createUI:(NSString *)title{
    UIView *alertV = [[UIView alloc] initWithFrame:CGRectMake(([UIScreen mainScreen].bounds.size.width-260)/2.0, 130+([[UIApplication sharedApplication] statusBarFrame].size.height-20)+[UIScreen mainScreen].bounds.size.width*2/6, 260, 112)];
    alertV.backgroundColor = [UIColor whiteColor];
    [self addSubview:alertV];
    alertV.layer.masksToBounds = YES;
    alertV.layer.cornerRadius = 6.7;
    _alertView = alertV;
    
    UIView *topView = [[UIView alloc] init];
    [alertV addSubview:topView];
    
    UILabel *titleLabel = [[UILabel alloc] init];
    titleLabel.textAlignment = NSTextAlignmentCenter;
    titleLabel.text = title;
    titleLabel.textColor = [UIColor blackColor];
    titleLabel.font = [UIFont systemFontOfSize:15];
    titleLabel.numberOfLines = 0;
    [topView addSubview:titleLabel];
    
    UIView *subV = [[UIView alloc] init];
    [alertV addSubview:subV];

    
    UIButton *defaultBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    defaultBtn.backgroundColor = kRGB_COLOR(@"#6FCEFC");
    [defaultBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    defaultBtn.titleLabel.font = [UIFont systemFontOfSize:14];
    [defaultBtn setTitle:kLocalizationMsg(@"普通PK") forState:UIControlStateNormal];
    [defaultBtn addTarget:self action:@selector(leftBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [subV addSubview:defaultBtn];
    
    UIButton *magicBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    magicBtn.backgroundColor = kRGB_COLOR(@"#FF6399");
    [magicBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    magicBtn.titleLabel.font = [UIFont systemFontOfSize:14];
    [magicBtn setTitle:kLocalizationMsg(@"魔法PK") forState:UIControlStateNormal];
    [magicBtn addTarget:self action:@selector(rightBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [subV addSubview:magicBtn];
    
    
    [topView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.equalTo(alertV);
        make.bottom.equalTo(subV.mas_top);
    }];
    [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(topView);
        make.left.equalTo(alertV).mas_offset(15);
        make.right.equalTo(alertV).mas_offset(-15);
    }];
    
    [subV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(alertV);
        make.height.mas_equalTo(40);
    }];
    [defaultBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.bottom.equalTo(subV);
        make.right.equalTo(magicBtn.mas_left);
        make.width.equalTo(magicBtn.mas_width);
    }];
    
    [magicBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.right.bottom.equalTo(subV);
    }];
}

//普通pk
- (void)leftBtnClick{
    void (^click)(void) = objc_getAssociatedObject(_alertView, @"selectAlertDefaultBlockKey");
    if (click) {
        click();
    }
    [self clickBgViewToRemove];
}
//魔法pk
- (void)rightBtnClick{
    void (^click)(void) = objc_getAssociatedObject(_alertView, @"selectAlertMagicBlockKey");
    if (click) {
        click();
    }
    [self clickBgViewToRemove];
}

- (void)clickBgViewToRemove{
    [self removeFromSuperview];
}

- (void)show{
    self.frame = [UIApplication sharedApplication].keyWindow.bounds;
    [[UIApplication sharedApplication].keyWindow addSubview:self];
}


- (void)clickDefaultPk:(void (^)(void))defaultBlock magicPk:(void (^)(void))magicBlock{
    objc_setAssociatedObject(_alertView, @"selectAlertMagicBlockKey", magicBlock, OBJC_ASSOCIATION_COPY_NONATOMIC);
    objc_setAssociatedObject(_alertView, @"selectAlertDefaultBlockKey", defaultBlock, OBJC_ASSOCIATION_COPY_NONATOMIC);
}


//屏蔽点击子视图响应事件
- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch{
    if ([touch.view isDescendantOfView:_alertView]) {
        return NO;
    }
    return YES;
}

@end
