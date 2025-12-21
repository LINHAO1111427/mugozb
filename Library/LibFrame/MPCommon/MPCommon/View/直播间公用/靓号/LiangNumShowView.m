//
//  LiangNumShowView.m
//  LiveCommon
//
//  Created by klc_sl on 2020/6/22.
//  Copyright © 2020 . All rights reserved.
//

#import "LiangNumShowView.h"
#import <Masonry/Masonry.h>
#import <LibTools/LibTools.h>
#import <LiveCommon/LiveComponentMsgListener.h>
#import <LiveCommon/LiveComponentMsgMgr.h>

@implementation LiangNumShowView

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self createUI];
    }
    return self;
}

- (void)layoutSubviews{
    [super layoutSubviews];
    self.layer.cornerRadius = self.height/2.0;
}

- (void)createUI{
    
    self.layer.masksToBounds = YES;
    self.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.2];
    
    UIButton *liangNumBgView = [UIButton buttonWithType:0];
    [self addSubview:liangNumBgView];
    [liangNumBgView addTarget:self action:@selector(presentNumber) forControlEvents:UIControlEventTouchUpInside];
    
    UIImageView *imgV = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"live_lianghao_icon"]];
    [self addSubview:imgV];
    
    UILabel *textL = [[UILabel alloc] init];
    textL.text = @"668866";
    textL.font = [UIFont systemFontOfSize:12];
    textL.textAlignment = NSTextAlignmentCenter;
    textL.userInteractionEnabled = NO;
    textL.textColor = [UIColor whiteColor];
    [self addSubview:textL];
    _liangNumL = textL;
    
    [liangNumBgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self);
    }];

    [imgV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(36, 20));
        make.centerY.equalTo(self);
        make.left.equalTo(self);
    }];
    [textL mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(imgV.mas_right).inset(4);
        make.centerY.equalTo(self);
        make.right.equalTo(self).inset(8);
    }];
}


- (void)presentNumber{
    [LiveComponentMsgMgr sendMsg:LM_LiangNum msgDic:nil];
}




@end
