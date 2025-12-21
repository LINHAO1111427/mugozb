//
//  RoomPkSelectView.m
//  MPVoiceLive
//
//  Created by CH on 2019/12/18.
//  Copyright © 2019 Orely. All rights reserved.
//

#import "RoomPkSelectView.h"
#import <Masonry/Masonry.h>

#import <LibTools/LibTools.h>
#import <LibProjBase/LibProjBase.h>

@interface RoomPkSelectView()

///退出PK
@property (nonatomic, copy)void(^selectBtnBlock)(BOOL);

@end

@implementation RoomPkSelectView


- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self createUI];
    }
    return self;
}

- (void)createUI{
    
    UIView *centerSelectV = [[UIView alloc] init];
    [self addSubview:centerSelectV];
    [centerSelectV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.equalTo(self);
        make.width.mas_equalTo(65);
        make.centerX.equalTo(self);
    }];
    
    UIView *centerBgV = [[UIView alloc] init];
    [centerSelectV addSubview:centerBgV];
    [centerBgV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(centerSelectV);
    }];
    
    UIImageView *pkImg = [[UIImageView alloc] init];
    pkImg.image = [UIImage imageNamed:@"voice_pk_icon"];
    pkImg.contentMode = UIViewContentModeScaleAspectFit;
    [centerBgV addSubview:pkImg];
    
    UIButton *startBtn = [[UIButton alloc] init];
    startBtn.layer.masksToBounds = YES;
    [startBtn setTitle:kLocalizationMsg(@"开始") forState:UIControlStateNormal];
    startBtn.titleLabel.font = [UIFont systemFontOfSize:10];
    startBtn.backgroundColor = [ProjConfig normalColors];
    [startBtn addTarget:self action:@selector(clickStartRoomPk:) forControlEvents:UIControlEventTouchUpInside];
    [centerBgV addSubview:startBtn];
    
    UIButton *stopBtn = [[UIButton alloc] init];
    stopBtn.layer.masksToBounds = YES;
    [stopBtn setTitle:kLocalizationMsg(@"退出") forState:UIControlStateNormal];
    stopBtn.titleLabel.font = [UIFont systemFontOfSize:10];
    stopBtn.backgroundColor = kRGB_COLOR(@"#999999");
    [stopBtn addTarget:self action:@selector(clickQuitRoomPk:) forControlEvents:UIControlEventTouchUpInside];
    [centerBgV addSubview:stopBtn];
    
    [pkImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(centerBgV);
        make.centerX.equalTo(centerBgV);
        make.left.right.equalTo(centerBgV);
        make.size.mas_equalTo(CGSizeMake(47, 22));
        make.bottom.equalTo(startBtn.mas_top).mas_offset(-15);
    }];
    
    [startBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(centerBgV);
        make.left.right.equalTo(centerBgV);
        make.size.mas_equalTo(CGSizeMake(52, 22));
        make.bottom.equalTo(stopBtn.mas_top).mas_offset(-15);
    }];
    
    [stopBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(centerBgV);
        make.left.right.equalTo(centerBgV);
        make.size.mas_equalTo(CGSizeMake(52, 22));
        make.bottom.equalTo(centerBgV);
    }];
    
    [startBtn layoutIfNeeded];
    startBtn.layer.cornerRadius = startBtn.height/2.0;
    [stopBtn layoutIfNeeded];
    stopBtn.layer.cornerRadius = stopBtn.height/2.0;
}

///点击开始按钮
- (void)clickStartRoomPk:(UIButton *)btn{
    if (self.selectBtnBlock) {
        self.selectBtnBlock(YES);
    }
}

///点击退出按钮
- (void)clickQuitRoomPk:(UIButton *)btn{
    if (self.selectBtnBlock) {
        self.selectBtnBlock(NO);
    }
}


- (void)roomPKSelect:(void (^)(BOOL))selectBlock{
    _selectBtnBlock = selectBlock;
}


@end
