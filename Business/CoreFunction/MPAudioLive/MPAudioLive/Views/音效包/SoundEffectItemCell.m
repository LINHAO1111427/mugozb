//
//  SoundEffectItemCell.m
//  LiveCommon
//
//  Created by klc_sl on 2020/7/30.
//  Copyright © 2020 KLC. All rights reserved.
//

#import "SoundEffectItemCell.h"
#import <Masonry/Masonry.h>

@implementation SoundEffectItemCell


- (UIImageView *)imageV{
    if (!_imageV) {
        
        UIView *centerV = [[UIView alloc] init];
        [self.contentView addSubview:centerV];
        [centerV mas_makeConstraints:^(MASConstraintMaker *make) {
            make.center.equalTo(self);
        }];
        UIImageView *img = [[UIImageView alloc] init];
        img.contentMode = UIViewContentModeScaleAspectFit;
        [centerV addSubview:img];
        _imageV = img;
        
        UILabel *titleL = [[UILabel alloc] init];
        titleL.font = [UIFont systemFontOfSize:12];
        titleL.textColor = [UIColor blackColor];
        [centerV addSubview:titleL];
        _titleLab = titleL;
        
        [img mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(CGSizeMake(50, 50));
            make.top.left.right.equalTo(centerV);
            make.bottom.equalTo(titleL.mas_top).mas_equalTo(-6);
        }];
        
        [titleL mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.equalTo(centerV);
            make.centerX.equalTo(centerV);
        }];
        
        
    }
    return _imageV;
}



@end
