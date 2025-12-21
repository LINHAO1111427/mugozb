//
//  EmptyView.m
//  TCDemo
//
//  Created by admin on 2019/10/22.
//  Copyright © 2019 CH. All rights reserved.
//

#import "EmptyView.h"
#import <LibProjBase/LibProjBase.h>
#import <LibTools/BaseMacroDefinition.h>
#import <LibTools/LocalizationHandle.h>
#import <Masonry/Masonry.h>

@interface EmptyView ()

@property (nonatomic, weak)UIView *centerView;
@property (nonatomic, copy)void (^clickHandle)(void);
@property (nonatomic, weak)UIControl *bgCon;

@end

@implementation EmptyView

@synthesize titleL;
@synthesize detailL;
@synthesize iconImgV;

+ (instancetype)registerView{
    return [[EmptyView alloc] init];
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self initData];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self initData];
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)coder
{
    self = [super initWithCoder:coder];
    if (self) {
        [self initData];
    }
    return self;
}


- (void)initData{
    self.centerView.hidden = NO;
}

- (UIView *)centerView{
    if (_centerView == nil) {
        UIView *centerV = [[UIView alloc] init];
        [self addSubview:centerV];
        _centerView = centerV;
        
        //图片
        UIImageView *icon = [[UIImageView alloc] init];
        icon.contentMode = UIViewContentModeScaleAspectFit;
        [centerV addSubview:icon];
        iconImgV = icon;
        
        //标题
        UILabel *lab = [[UILabel alloc] init];
        lab.font = [UIFont systemFontOfSize:14];
        lab.textColor = kRGB_COLOR(@"#333333");
        lab.textAlignment = NSTextAlignmentCenter;
        [centerV addSubview:lab];
        titleL = lab;
        
        //副标题
        UILabel *sublab = [[UILabel alloc] init];
        sublab.font = [UIFont systemFontOfSize:12];
        sublab.textColor = kRGB_COLOR(@"#969696");
        sublab.textAlignment = NSTextAlignmentCenter;
        sublab.numberOfLines = 0;
        [centerV addSubview:sublab];
        detailL = sublab;
        
        UIControl *bgCon = [[UIControl alloc] init];
        bgCon.userInteractionEnabled = NO;
        [self addSubview:bgCon];
        _bgCon = bgCon;
        [bgCon addTarget:self action:@selector(bgClickHandle) forControlEvents:UIControlEventTouchUpInside];
        
        [bgCon mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.left.right.bottom.equalTo(self);
        }];
        
        [centerV mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(self);
            make.centerY.equalTo(self).mas_offset(-30);
        }];
        
        [icon mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.top.equalTo(centerV);
            make.centerX.equalTo(centerV);
            make.bottom.equalTo(lab.mas_top).mas_offset(-20);
        }];

        [lab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(centerV);
            make.left.equalTo(self).mas_offset(20);
            make.bottom.equalTo(sublab.mas_top).mas_offset(-10);
        }];
        
        [sublab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.equalTo(centerV);
            make.centerX.equalTo(centerV);
            make.left.equalTo(self).mas_offset(20);
        }];
    }
    return nil;
}

- (void)showInView:(UIView *)superView{
    self.hidden = YES;
    [superView addSubview:self];
    [self mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(superView);
        make.top.left.equalTo(superView);
        ///这么写是防止本view放在scrollview上，可能会导致没有size的问题
        make.width.mas_equalTo(superView.mas_width);
        make.height.mas_equalTo(superView.mas_height);
    }];
}


- (void)showInView:(UIView *)superView andFrame:(CGRect)frame{
    self.hidden = YES;
    self.frame = frame;
    [superView addSubview:self];
}


- (void)bgClickHandle{
    if (_clickHandle) {
        _clickHandle();
    }
}

- (void)clickHandle:(void (^)(void))handle{
    _bgCon.userInteractionEnabled = YES;
    _clickHandle = handle;
}


- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event{
    UIView *hitV = [super hitTest:point withEvent:event];
    if (hitV == self) {
        return nil;
    }
    return hitV;
}


@end
