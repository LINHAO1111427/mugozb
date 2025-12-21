//
//  SelectLiveItemCell.m
//  LiveCommon
//
//  Created by klc_sl on 2020/3/18.
//  Copyright © 2020 . All rights reserved.
//

#import "SelectLiveItemCell.h"
#import <Masonry.h>
#import <LibTools/LibTools.h>
#import <LibProjBase/LibProjBase.h>

@implementation SelectLiveItemCell

- (void)layoutSubviews{
    [super layoutSubviews];
}

- (void)selectItem:(BOOL)selected{
    _titleL.backgroundColor = selected?[ProjConfig normalColors]:[UIColor whiteColor];
    _titleL.textColor = selected?[UIColor whiteColor]:[UIColor blackColor];
}

- (UILabel *)titleL{
    if (!_titleL) {
        UILabel *lab = [[UILabel alloc] init];
        lab.font = [UIFont systemFontOfSize:14];
        lab.layer.masksToBounds = YES;
        lab.layer.borderColor = [UIColor lightGrayColor].CGColor;
        lab.layer.borderWidth = 0.5;
        lab.textAlignment = NSTextAlignmentCenter;
        [self.contentView addSubview:lab];
        _titleL = lab;
        [lab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(self.contentView);
        }];
        [lab layoutIfNeeded];
        lab.layer.cornerRadius = lab.height/2.0;
    }
    return _titleL;
}

@end
