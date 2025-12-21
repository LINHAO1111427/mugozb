//
//  ThirdPayTypeCell.m
//  LiveCommon
//
//  Created by klc_sl on 2020/3/28.
//  Copyright © 2020 . All rights reserved.
//

#import "ThirdPayTypeCell.h"
#import "LibProjModel/CfgPayWayDTOModel.h"
#import <SDWebImage.h>
#import <LibTools/LibTools.h>

@implementation ThirdPayTypeCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.lineV.hidden = NO;
    }
    return self;
}

- (UIView *)lineV{
    if (!_lineV) {
        UIView *topLine = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 0.8)];
        topLine.backgroundColor = [UIColor groupTableViewBackgroundColor];
        [self.contentView addSubview:topLine];
        _lineV = topLine;
        
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(15, (60-26)/2.0, kScreenWidth-30, 26)];
        label.font = [UIFont systemFontOfSize:14];
        label.textColor = [UIColor blackColor];
        label.textAlignment = NSTextAlignmentCenter;
        [self.contentView addSubview:label];
        _titleL = label;
    }
    return _lineV;
}

- (void)setPayModel:(CfgPayWayDTOModel *)payModel{
    _payModel = payModel;
    
    UIImage *image = [UIImage new];
   /// 支付渠道类型 1：支付宝  2：微信 3:ios内购
    switch (payModel.payChannel) {
        case 1: ///支付宝
        {
            image = [UIImage imageNamed:@"icon_payment_allepay"];
        }
        break;
        case 2: ///微信
        {
            image = [UIImage imageNamed:@"icon_payment_wechat"];
        }
            break;
        case 3:  ///苹果支付
        {
            image = [UIImage imageNamed:@"icon_payment_apple"];
        }
            break;
        case 4:  ///银联图标
        {
            image = [ProjConfig getCoinImage];
        }
            break;
        case 6:  ///银行卡
        {
            image = [UIImage imageNamed:@"icon_payment_card"];
        }
            break;
        case 12:  ///微信+支付宝
        {
            image = [UIImage imageNamed:@"icon_payment_allepay"];
        }
            break;
        default:
        {
            image = [UIImage imageNamed:@"icon_payment_allepay"];
        }
            break;
    }
    
    _titleL.attributedText = [payModel.name attachmentForImage:image bounds:CGRectMake(0, -8, 26, 26) before:YES];

    
  
}


@end
