//
//  GamePriceItemCell.m
//  LibProjView
//
//  Created by klc_sl on 2020/7/17.
//  Copyright © 2020 . All rights reserved.
//

#import "GamePriceItemCell.h"
#import <Masonry/Masonry.h>

@implementation GamePriceItemCell

- (UIImageView *)imgV{
    if (!_imgV) {
        ///中心背景
        UIView *bgV = [[UIView alloc] init];
        [self.contentView addSubview:bgV];
        [bgV mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.equalTo(self);
            make.centerY.equalTo(self);
        }];
        
        UIImageView *imgV = [[UIImageView alloc] init];
        imgV.contentMode = UIViewContentModeScaleAspectFit;
        [bgV addSubview:imgV];
        _imgV = imgV;

        UILabel *contentL = [[UILabel alloc] init];
        contentL.font = [UIFont systemFontOfSize:13];
        contentL.textColor = [UIColor blackColor];
        [bgV addSubview:contentL];
        _textL = contentL;
        
        [imgV mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.left.right.equalTo(bgV);
            make.size.mas_equalTo(CGSizeMake(40, 40));
            make.bottom.equalTo(contentL.mas_top).mas_offset(-9);
        }];
        
        [contentL mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.equalTo(bgV);
            make.centerX.equalTo(bgV);
        }];
        
    }
    return _imgV;
}




@end
