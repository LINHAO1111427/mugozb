//
//  SVCoverView.m
//  ShortVideo
//
//  Created by klc_sl on 2021/5/21.
//  Copyright © 2021 KLC. All rights reserved.
//

#import "SVCoverView.h"
#import <Masonry/Masonry.h>

@implementation SVCoverView



- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self createView];
    }
    return self;
}


- (void)createView{
    
    self.backgroundColor = [UIColor clearColor];
    ///遮盖层
    UIBlurEffect *blurEffect = [UIBlurEffect effectWithStyle:UIBlurEffectStyleLight];
    UIVisualEffectView *blurView = [[UIVisualEffectView alloc] initWithEffect:blurEffect];
    blurView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    [self addSubview:blurView];
    blurView.hidden = YES;

    _marskBlur = blurView;
    [blurView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self);
    }];
    
    ///锁
    UIButton *lockBtn = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 50, 50)];
    lockBtn.hidden = YES;
    [lockBtn setImage:[UIImage imageNamed:@"short_video_lock"] forState:UIControlStateNormal];
    [lockBtn addTarget:self action:@selector(lockBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:lockBtn];
    _lockBtn = lockBtn;
    [lockBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self);
        make.size.mas_equalTo(CGSizeMake(50, 50));
    }];
    
}

- (void)lockBtnClick:(UIButton *)btn{
    if (self.lockBtnClick) {
        self.lockBtnClick();
    }
}


@end
