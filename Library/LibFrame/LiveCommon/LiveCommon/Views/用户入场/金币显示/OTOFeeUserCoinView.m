//
//  OTOFeeUserCoinView.m
//  LiveCommon
//
//  Created by klc on 2020/5/23.
//  Copyright © 2020 . All rights reserved.
//

#import "OTOFeeUserCoinView.h"
#import <LibProjBase/ProjConfig.h>
#import <Masonry/Masonry.h>
#import <LibProjModel/KLCAppConfig.h>

@implementation OTOFeeUserCoinView

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self createUI];
    }
    return self;
}

- (void)createUI{
    
    UIImageView *coinBgView = [[UIImageView alloc] init];
    coinBgView.image = [UIImage imageNamed:@"live_yue_bg"];
    coinBgView.clipsToBounds = YES;
    coinBgView.contentMode = UIViewContentModeScaleToFill;
    [self addSubview:coinBgView];
    
    UILabel *yueLab = [[UILabel alloc] init];
    yueLab.text = @"TA的余额";
    yueLab.textColor = [UIColor whiteColor];
    yueLab.textAlignment = NSTextAlignmentRight;
    yueLab.font = [UIFont systemFontOfSize:12];
    [coinBgView addSubview:yueLab];
    
    UILabel *coinLab = [[UILabel alloc] init];
    coinLab.textColor = [UIColor whiteColor];
    coinLab.font = [UIFont systemFontOfSize:14];
    coinLab.text = @"";
    coinLab.textAlignment = NSTextAlignmentRight;
    [coinBgView addSubview:coinLab];
    _coinL = coinLab;
    
    UIImageView *coinImage = [[UIImageView alloc] init];
    coinImage.image = [ProjConfig getAppDefaultCoinImage];
    [coinBgView addSubview:coinImage];
    
    ///金币数量
    [coinBgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self);
        make.right.equalTo(self).mas_offset(0);
        make.height.mas_equalTo(28);
    }];
    
    [coinImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(17.5, 17.5));
        make.centerY.equalTo(coinBgView);
        make.right.equalTo(coinBgView).mas_offset(-15);
        make.left.equalTo(coinLab.mas_right).mas_offset(6);
    }];
    
    [coinLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(coinBgView);
        make.left.equalTo(yueLab.mas_right).mas_offset(6);
    }];
    
    [yueLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(coinBgView);
        make.left.equalTo(coinBgView).mas_offset(15);
    }];
    
    [coinBgView layoutIfNeeded];
    coinBgView.layer.cornerRadius = coinBgView.frame.size.height / 2.0;;
    if ([KLCAppConfig appVersionHigh]) {
        [coinBgView removeFromSuperview];
    }
}



@end
