//
//  GameResultPrizeItemCell.m
//  klcProject
//
//  Created by klc_sl on 2020/7/18.
//  Copyright © 2020 KLC. All rights reserved.
//

#import "GameResultPrizeItemCell.h"
#import <Masonry/Masonry.h>
#import <LibTools/LibTools.h>
#import <LibProjBase/LibProjBase.h>
#import <LibProjModel/GamePrizeRecordModel.h>
#import <SDWebImage/SDWebImage.h>
#import <LibProjModel/KLCAppConfig.h>


@implementation GameResultPrizeItemCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

}

- (UIImageView *)prizeImgV{
    if (!_prizeImgV) {

        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
        UIImageView *bgImgV = [[UIImageView alloc] init];
        bgImgV.image = [UIImage imageNamed:@"game_result_prizeBg"];
        [self.contentView addSubview:bgImgV];
        [bgImgV mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(CGSizeMake(156, 56));
            make.center.equalTo(self);
        }];
        
        UIView *bgCenterV = [[UIView alloc] init];
        [bgImgV addSubview:bgCenterV];
        [bgCenterV mas_makeConstraints:^(MASConstraintMaker *make) {
            make.center.equalTo(bgImgV);
        }];
        
        UIImageView *leftImgV = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"game_result_left_white"]];
        [bgCenterV addSubview:leftImgV];
        UIImageView *rightImgV = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"game_result_right_white"]];
        [bgCenterV addSubview:rightImgV];
        
        [leftImgV mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(CGSizeMake(56, 37));
            make.top.left.bottom.equalTo(bgCenterV);
            make.right.equalTo(rightImgV.mas_left);
            make.centerY.equalTo(rightImgV);
        }];
        [rightImgV mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(CGSizeMake(80, 37));
            make.top.bottom.right.equalTo(bgCenterV);
        }];
        
        ///奖品图片
        UIView *prizeBgV = [[UIImageView alloc] init];
        [leftImgV addSubview:prizeBgV];
        [prizeBgV mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(CGSizeMake(34, 29));
            make.center.equalTo(leftImgV);
        }];
        
        UIImageView *prizeImgV = [[UIImageView alloc] init];
        prizeImgV.contentMode = UIViewContentModeScaleAspectFit;
        [prizeBgV addSubview:prizeImgV];
        _prizeImgV = prizeImgV;
        [prizeImgV mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(CGSizeMake(34, 29));
            make.center.equalTo(leftImgV);
        }];
        
        UILabel *prizeCoinL = [[UILabel alloc] init];
        prizeCoinL.font = [UIFont systemFontOfSize:10];
        prizeCoinL.textColor = kRGB_COLOR(@"#666666");
        prizeCoinL.textAlignment = NSTextAlignmentCenter;
        [prizeBgV addSubview:prizeCoinL];
        _prizeCoinL = prizeCoinL;
        [prizeCoinL mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.equalTo(@10);
            make.centerX.equalTo(prizeBgV);
            make.bottom.equalTo(prizeBgV);
        }];
        
        ///标题
        UILabel *titleL = [[UILabel alloc] init];
        titleL.font = [UIFont systemFontOfSize:12];
        titleL.textColor = kRGB_COLOR(@"#FE78AE");
        titleL.textAlignment = NSTextAlignmentCenter;
        [rightImgV addSubview:titleL];
        _contentL = titleL;
        [titleL mas_makeConstraints:^(MASConstraintMaker *make) {
            make.center.equalTo(rightImgV);
        }];
        
    }
    return _prizeImgV;
}


- (void)setModel:(GamePrizeRecordModel *)model{
    _model = model;

    if (model.awardsType == 0) {
        self.prizeCoinL.hidden = YES;
        [self.prizeImgV mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(CGSizeMake(34, 29));
            make.centerX.equalTo(self.prizeImgV.superview);
        }];
        self.prizeImgV.image = [ProjConfig getCoinImage];
        self.contentL.text = [NSString stringWithFormat:@"%@x%0.0lf",[KLCAppConfig unitStr],model.awardsCoin];
    }else{
        self.prizeCoinL.hidden = NO;
        [self.prizeImgV  mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(CGSizeMake(34, 19));
            make.centerX.equalTo(self.prizeImgV.superview);
        }];
        [self.prizeImgV sd_setImageWithURL:[NSURL URLWithString:model.picture]];
        self.contentL.text = [NSString stringWithFormat:@"%@x%d",model.giftName,model.awardsNum];
        self.prizeCoinL.attributedText = [[NSString stringWithFormat:@"%0.0lf",model.awardUnitPrice] attachmentForImage:[ProjConfig getCoinImage] bounds:CGRectMake(0, -1.5, 10, 10) before:YES];
    }
    
}

@end
