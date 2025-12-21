//
//  CustomNaviView.m
//  LibProjView
//
//  Created by klc_sl on 2021/8/2.
//  Copyright © 2021 KLC. All rights reserved.
//

#import "CustomNaviView.h"

@implementation CustomNaviView
{
    UIView *_bgColorView;
}

- (instancetype)init{
    self = [super initWithFrame:CGRectMake(0, 0, kScreenWidth, kNavBarHeight)];
    if (self)
    {
        [self createUI];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self createUI];
    }
    return self;
}

- (void)createUI{
    
    _bgColorView = [[UIView alloc] init];
    _bgColorView.backgroundColor = [[UIColor whiteColor] colorWithAlphaComponent:0];
    [self addSubview:_bgColorView];
    [_bgColorView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self);
    }];
    ///返回
    UIButton *backBtn = [UIButton buttonWithType:0];
    backBtn.contentEdgeInsets = UIEdgeInsetsMake(14, 14, 14, 14);
    [backBtn setImage:[UIImage imageNamed:@"main_navbar_back"] forState:UIControlStateNormal];
    backBtn.imageView.contentMode = UIViewContentModeScaleAspectFit;
    [self addSubview:backBtn];
    self.backBtn = backBtn;
    [backBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(40, 44));
        make.left.equalTo(self).offset(5);
        make.bottom.equalTo(self);
    }];
    
    UIButton *rightBtn = [UIButton buttonWithType:0];
    rightBtn.titleLabel.font = [UIFont systemFontOfSize:14];
    [rightBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self addSubview:rightBtn];
    self.rightBtn = rightBtn;
    [rightBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self).offset(-10);
        make.bottom.equalTo(self);
        make.height.mas_equalTo(44);
    }];
    
    UILabel *titleL = [[UILabel alloc] init];
    titleL.textAlignment = NSTextAlignmentCenter;
    titleL.numberOfLines = 0;
    titleL.font = [UIFont systemFontOfSize:17 weight:UIFontWeightMedium];
    [self addSubview:titleL];
    self.navTitleL = titleL;
    [titleL mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(44);
        make.bottom.equalTo(self);
        make.left.equalTo(backBtn.mas_right).offset(10);
        make.centerX.equalTo(self);
    }];
}



- (void)setBgAlpha:(CGFloat)bgAlpha {
    _bgAlpha = bgAlpha;
    [self.backBtn setImage:[UIImage imageNamed:bgAlpha>0.5?@"main_navbar_back_black":@"main_navbar_back"] forState:UIControlStateNormal];
    self.navTitleL.textColor = bgAlpha>0.5?[UIColor blackColor]:[UIColor whiteColor];
    _bgColorView.backgroundColor = [[UIColor whiteColor] colorWithAlphaComponent:bgAlpha];
    [self.rightBtn setTitleColor:bgAlpha>0.5?[UIColor blackColor]:[UIColor whiteColor] forState:UIControlStateNormal];
}


@end
