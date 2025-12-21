//
//  OnlineUserVIPHintView.m
//  LibProjView
//
//  Created by klc_sl on 2021/9/26.
//  Copyright © 2021 KLC. All rights reserved.
//

#import "OnlineUserVIPHintView.h"

@implementation OnlineUserVIPHintView

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        [self createUI];
    }
    return self;
}


- (void)createUI{
    
    UIView *centerV = [[UIView alloc] init];
    [self addSubview:centerV];
    [centerV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self);
    }];
    
    UIImageView *imageV = [[UIImageView alloc] init];
    imageV.image = [UIImage imageNamed:@"gift_select_vip"];
    [centerV addSubview:imageV];
    
    UILabel *titleL = [[UILabel alloc] init];
    titleL.textColor = [ProjConfig normalColors];
    titleL.font = [UIFont systemFontOfSize:14];
    titleL.text = kLocalizationMsg(@"开通贵族才可查看附近的人");
    [imageV addSubview:titleL];
    
    UIButton *joinBtn = [UIButton buttonWithType:0];
    joinBtn.layer.masksToBounds = YES;
    joinBtn.titleLabel.font = [UIFont systemFontOfSize:13];
    [joinBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [joinBtn setBackgroundImage:[UIImage imageNamed:@"btn_bg_pink"] forState:UIControlStateNormal];
    [joinBtn addTarget:self action:@selector(openJoinBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [joinBtn setTitle:kLocalizationMsg(@"开通贵族") forState:UIControlStateNormal];
    [centerV addSubview:joinBtn];

    [imageV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(180, 140));
        make.top.left.right.equalTo(centerV);
    }];
    [titleL mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(imageV);
        make.bottom.equalTo(imageV).mas_offset(-7);
    }];
    [joinBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(centerV);
        make.size.mas_equalTo(CGSizeMake(130, 40));
        make.top.equalTo(imageV.mas_bottom).offset(20);
        make.bottom.equalTo(centerV);
    }];
    [joinBtn layoutIfNeeded];
    joinBtn.layer.cornerRadius = 20;
    
}

- (void)openJoinBtnClick{
    
    if (![ProjConfig isUserLogin]) {
        [RouteManager routeForName:RN_login_ShowLoginVC currentC:[ProjConfig currentVC]];
        return;
    }
    
    [RouteManager routeForName:RN_User_buyVIP currentC:[ProjConfig currentVC] parameters:nil];
}



@end
