//
//  GoodNumItemCell.m
//  LiveCommon
//
//  Created by klc on 2020/6/9.
//  Copyright © 2020 . All rights reserved.
//

#import "GoodNumItemCell.h"
#import <Masonry/Masonry.h>
#import <LibTools/LibTools.h>
#import <LibProjBase/LibProjBase.h>

@implementation GoodNumItemCell

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.centerView.hidden = NO;
    }
    return self;
}


- (UIView *)centerView{
    if (!_centerView) {
        
        self.layer.masksToBounds = YES;
        self.layer.cornerRadius = 8.0;
        self.backgroundColor = [ProjConfig normalColors];
    
        UIView *centerV = [[UIView alloc] init];
        centerV.userInteractionEnabled = NO;
        [self.contentView addSubview:centerV];
        [centerV mas_makeConstraints:^(MASConstraintMaker *make) {
            make.center.equalTo(self);
        }];
        _centerView = centerV;
        
        UILabel *titleL = [[UILabel alloc] init];
        titleL.textColor = [UIColor whiteColor];
        titleL.textAlignment = NSTextAlignmentCenter;
        titleL.font = [UIFont systemFontOfSize:16];
        [centerV addSubview:titleL];
        _titleL = titleL;
        
        UILabel *contentL = [[UILabel alloc] init];
        contentL.textColor = [UIColor whiteColor];
        contentL.textAlignment = NSTextAlignmentCenter;
        contentL.font = [UIFont systemFontOfSize:14];
        [centerV addSubview:contentL];
        _contentL = contentL;
        
        [titleL mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.left.right.equalTo(centerV);
            make.bottom.equalTo(contentL.mas_top).mas_offset(-10);
        }];
        [contentL mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.bottom.equalTo(centerV);
        }];
    }
    return _centerView;
}

@end
