//
//  GameLuckProgressView.m
//  klcProject
//
//  Created by klc_sl on 2020/7/17.
//  Copyright © 2020 KLC. All rights reserved.
//

#import "GameLuckProgressView.h"
#import <LibTools/LibTools.h>
#import <Masonry/Masonry.h>

@interface GameLuckProgressView ()

@property (nonatomic, weak)UIImageView *luckV;
@property (nonatomic, weak)UIImageView *imgBgV;

@end

@implementation GameLuckProgressView


- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self createUI];
    }
    return self;
}

- (void)layoutSubviews{
    [super layoutSubviews];
    
    _imgBgV.layer.cornerRadius = _imgBgV.height/2.0;
    
}

///创建视图
- (void)createUI{
    
    UIImageView *imgBgV = [[UIImageView alloc] init];
    imgBgV.image = nil;
    imgBgV.backgroundColor = kRGBA_COLOR(@"#730048", 0.3);
    [self addSubview:imgBgV];
    imgBgV.layer.masksToBounds = YES;
    [imgBgV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).mas_offset(20);
        make.right.equalTo(self).mas_offset(-20);
        make.top.bottom.equalTo(self);
    }];
    _imgBgV = imgBgV;
    
    UIImageView *luckV = [[UIImageView alloc] init];
    luckV.image = [UIImage imageNamed:@"game_progress_luck"];
    [imgBgV addSubview:luckV];
    _luckV = luckV;
    [luckV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.bottom.equalTo(imgBgV);
        make.width.mas_equalTo(0);
    }];
    
    UIImageView *startV = [[UIImageView alloc] init];
    startV.image = [UIImage imageNamed:@"game_progress_start"];
    [self addSubview:startV];
    
    [startV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(13);
        make.top.bottom.equalTo(imgBgV);
        make.centerX.equalTo(luckV.mas_right);
        make.centerY.equalTo(imgBgV);
    }];
    
}

- (void)setLuckNum:(int)luckNum{
    _luckNum = luckNum;
    
    
    CGFloat superW = _luckV.superview.width;
    _totalNum = _totalNum > 0?_totalNum:1;
    
    [_luckV mas_updateConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(superW * luckNum/(_totalNum*1.0));
    }];
    [_luckV layoutIfNeeded];
}


@end
