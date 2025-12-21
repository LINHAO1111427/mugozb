//
//  CustomSlider.m
//  LibProjView
//
//  Created by klc_sl on 2020/11/13.
//  Copyright © 2020 KLC. All rights reserved.
//

#import "CustomSlider.h"
#import <Masonry/Masonry.h>

@implementation CustomSlider

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self createUI];
    }
    return self;
}

- (void)createUI{

    UIView *defaultBgV = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 30, 30)];
    UIView *defaultV = [[UIView alloc] initWithFrame:CGRectMake(12, 12, 6, 6)];
    defaultV.layer.masksToBounds = YES;
    defaultV.layer.cornerRadius = 3;
    defaultV.backgroundColor = [UIColor whiteColor];
    [defaultBgV addSubview:defaultV];
    [self setThumbImage:[UIImage imageConvertFromView:defaultBgV] forState:UIControlStateNormal];
    
    UIView *selectBgV = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 30, 30)];
    UIView *selectV = [[UIView alloc] initWithFrame:CGRectMake(5, 5, 20, 20)];
    selectV.layer.masksToBounds = YES;
    selectV.layer.cornerRadius = 10;
    selectV.backgroundColor = [UIColor whiteColor];
    [selectBgV addSubview:selectV];
    [self setThumbImage:[UIImage imageConvertFromView:selectBgV] forState:UIControlStateSelected];
    [self setThumbImage:[UIImage imageConvertFromView:selectBgV] forState:UIControlStateHighlighted];
    
    self.minimumTrackTintColor = [UIColor whiteColor];
    
    
}

@end
