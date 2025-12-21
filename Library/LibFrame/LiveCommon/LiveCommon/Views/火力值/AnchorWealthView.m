//
//  AnchorWealthView.m
//  LiveCommon
//
//  Created by klc on 2020/5/22.
//  Copyright © 2020 . All rights reserved.
//

#import "AnchorWealthView.h"
#import <Masonry/Masonry.h>
#import <LiveCommon/LiveManager.h>
#import <LibTools/LibTools.h>
#import <LiveCommon/LiveAnchorListView.h>

@implementation AnchorWealthView

- (void)layoutSubviews{
    [super layoutSubviews];
    self.layer.cornerRadius = self.height/2.0;
}


- (instancetype)init
{
    self = [super init];
    if (self) {
        [self createUI];
    }
    return self;
}

- (void)createUI{
    
    self.backgroundColor = kRGBA_COLOR(@"#FF7174", 1.0);
    self.layer.masksToBounds = YES;
    
    UIButton *bgBtn = [[UIButton alloc] init];
    [bgBtn addTarget:self action:@selector(hotBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:bgBtn];
    
    UIImageView *imgV = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"live_hot_red"]];
    imgV.contentMode = UIViewContentModeScaleAspectFit;
    [self addSubview:imgV];
    
    UILabel *titleL = [[UILabel alloc] init];
    titleL.textColor = [UIColor whiteColor];
    titleL.textAlignment = NSTextAlignmentRight;
    titleL.font = [UIFont systemFontOfSize:12];
    titleL.text = 0;
    [self addSubview:titleL];
    _hotL = titleL;
    
    [bgBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self);
    }];
    
    [imgV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(52, 22));
        make.centerY.equalTo(self);
        make.left.equalTo(self).inset(3);
    }];
    
    [titleL mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(imgV.mas_right).inset(2);
        make.centerY.equalTo(self);
        make.right.equalTo(self).inset(7);
        make.width.mas_greaterThanOrEqualTo(5);
    }];
}

- (void)hotBtnClick{
    [LiveAnchorListView showAnchorListView];
}

@end
