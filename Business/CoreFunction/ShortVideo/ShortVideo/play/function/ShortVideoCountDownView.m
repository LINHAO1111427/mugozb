//
//  ShortVideoCountDownView.m
//  LiveCommon
//
//  Created by klc_sl on 2020/11/5.
//  Copyright © 2020 KLC. All rights reserved.
//

#import "ShortVideoCountDownView.h"
#import <LibTools/LibTools.h>
#import <Masonry/Masonry.h>

@implementation ShortVideoCountDownView


- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self createUI];
    }
    return self;
}


- (void)createUI{
    
    UIView *cover = [[UIView alloc] init];
    cover.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.2];
    [self addSubview:cover];
    
    [cover mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.equalTo(self).mas_offset(8);
        make.right.bottom.equalTo(self);
    }];
    cover.layer.masksToBounds = YES;
    cover.layer.cornerRadius = 10;
    
    UIImageView *clockV = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"live_trySee_clock"]];
    clockV.frame = CGRectMake(0, 0, 18, 18);
    [self addSubview:clockV];
    
    ///标题
    UILabel *titleL = [[UILabel alloc] init];
    [self addSubview:titleL];
    titleL.textAlignment = NSTextAlignmentCenter;
    titleL.text = kLocalizationMsg(@"试看倒计时");
    titleL.font = [UIFont systemFontOfSize:9];
    titleL.textColor = [UIColor whiteColor];
    [titleL mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self).mas_offset(12);
        make.left.right.equalTo(cover);
        make.height.mas_equalTo(13);
    }];
    
    UILabel *detailL = [[UILabel alloc] init];
    [self addSubview:detailL];
    detailL.textAlignment = NSTextAlignmentCenter;
    detailL.font = [UIFont systemFontOfSize:40];
    detailL.textColor = [UIColor whiteColor];
    _lastTimeL = detailL;
    [detailL mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(cover);
        make.top.equalTo(titleL.mas_bottom);
    }];
}

@end
