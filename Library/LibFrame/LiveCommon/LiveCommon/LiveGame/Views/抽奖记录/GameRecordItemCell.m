//
//  GameRecordItemCell.m
//  LibProjView
//
//  Created by klc_sl on 2020/7/16.
//  Copyright © 2020 . All rights reserved.
//

#import "GameRecordItemCell.h"
#import <Masonry/Masonry.h>

@implementation GameRecordItemCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}




- (UILabel *)titleL{
    if (!_titleL) {
        
        UIView *bgV = [[UIView alloc] init];
        [self.contentView addSubview:bgV];
        [bgV mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self);
            make.left.equalTo(self).mas_offset(12);
            make.right.equalTo(self).mas_offset(-12);
        }];
        
        ///名称
        UILabel *titleL = [[UILabel alloc] init];
        titleL.font = [UIFont systemFontOfSize:13];
        titleL.textColor = [UIColor blackColor];
        [bgV addSubview:titleL];
        _titleL = titleL;
        
        ///金币
        UILabel *coinL = [[UILabel alloc] init];
        coinL.font = [UIFont systemFontOfSize:13];
        coinL.textColor = [UIColor blackColor];
        coinL.textAlignment = NSTextAlignmentRight;
        [bgV addSubview:coinL];
        _coinL = coinL;
        
        ///时间
        UILabel *timeL = [[UILabel alloc] init];
        timeL.font = [UIFont systemFontOfSize:13];
        timeL.textColor = [UIColor blackColor];
        [bgV addSubview:timeL];
        _timeL = timeL;
        
        ///中奖信息
        UILabel *resultL = [[UILabel alloc] init];
        resultL.font = [UIFont systemFontOfSize:13];
        resultL.textColor = [UIColor blackColor];
        resultL.textAlignment = NSTextAlignmentRight;
        [bgV addSubview:resultL];
        _resultL = resultL;
        
        [titleL mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.left.equalTo(bgV);
            make.right.equalTo(coinL);
            make.height.mas_equalTo(15);
            make.bottom.equalTo(timeL.mas_top).mas_offset(-10);
        }];
        
        [coinL mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.right.equalTo(bgV);
            make.centerY.equalTo(titleL);
            make.height.equalTo(titleL.mas_height);
            make.width.mas_equalTo(100);
        }];
        
        [timeL mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.bottom.equalTo(bgV);
            make.right.equalTo(resultL.mas_left);
        }];
        
        [resultL mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.bottom.equalTo(bgV);
            make.centerY.equalTo(timeL);
            make.width.mas_equalTo(100);
        }];
    
    }
    return _titleL;
}








@end
