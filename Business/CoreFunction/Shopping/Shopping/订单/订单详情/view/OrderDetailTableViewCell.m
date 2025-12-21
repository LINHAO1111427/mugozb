//
//  OrderDetailTableViewCell.m
//  Shopping
//
//  Created by yww on 2020/8/4.
//  Copyright © 2020 klc. All rights reserved.
//

#import "OrderDetailTableViewCell.h"
#import <LibProjModel/ShopSubOrderModel.h>
@interface OrderDetailTableViewCell()
@property (nonatomic, strong)UIView *contentV;
@property (nonatomic, strong)UIImageView *commodityHeaderImageV;
@property (nonatomic, strong)UILabel *nameL;
@property (nonatomic, strong)UILabel *attrL;
@property (nonatomic, strong)UILabel *priceL;

@end

@implementation OrderDetailTableViewCell
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self crateUI];
    }
    return self;
}
- (void)crateUI{
    self.backgroundColor = [UIColor clearColor];
    [self.contentView addSubview:self.contentV];
    [self.contentV addSubview:self.commodityHeaderImageV];
    [self.contentV addSubview:self.nameL];
    [self.contentV addSubview:self.attrL];
    [self.contentV addSubview:self.priceL];
    
}

- (void)setModel:(ShopSubOrderModel *)model{
    _model = model;
    NSArray *arr = [model.goodsPicture componentsSeparatedByString:@","];
    [self.commodityHeaderImageV sd_setImageWithURL:[NSURL URLWithString:arr.firstObject] placeholderImage:[ProjConfig getAppIcon]];
    self.nameL.text = model.goodsName;
    [self.nameL sizeToFit];
    self.attrL.text = model.skuName;
    NSString *price = [NSString stringWithFormat:@"¥%.2f",model.goodsPrice];
    NSString *num = [NSString stringWithFormat:@"x%d",model.goodsNum];
    NSString *strr = [NSString stringWithFormat:@"%@ %@",price,num];
    NSMutableAttributedString *atrri = [[NSMutableAttributedString alloc]initWithString:strr];
    NSRange rangeNum = [strr rangeOfString:num];
    NSRange Yrange = [strr rangeOfString:@"¥"];
    [atrri addAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:10]} range:Yrange];
    [atrri addAttributes:@{NSForegroundColorAttributeName:kRGB_COLOR(@"#999999"),NSFontAttributeName:[UIFont systemFontOfSize:10]} range:rangeNum];
    self.priceL.attributedText = atrri;
}


 

#pragma mark - lazy load
- (UIView *)contentV{
    if (!_contentV) {
        _contentV = [[UIView alloc]initWithFrame:CGRectMake(10, 0, kScreenWidth-20, 100)];
        _contentV.backgroundColor = [UIColor whiteColor];
    }
    return _contentV;
}
- (UIImageView *)commodityHeaderImageV{
    if (!_commodityHeaderImageV) {
        _commodityHeaderImageV = [[UIImageView alloc]initWithFrame:CGRectMake(12, 10, 80, 80)];
        _commodityHeaderImageV.contentMode = UIViewContentModeScaleAspectFill;
        _commodityHeaderImageV.clipsToBounds = YES;
        _commodityHeaderImageV.layer.masksToBounds = YES;
        _commodityHeaderImageV.layer.cornerRadius = 5;
        _commodityHeaderImageV.backgroundColor = [UIColor lightGrayColor];
    }
    return _commodityHeaderImageV;
}
- (UILabel *)nameL{
    if (!_nameL) {
        _nameL = [[UILabel alloc]initWithFrame:CGRectMake(_commodityHeaderImageV.maxX+10, 10, _contentV.width-24-90, 40)];
        _nameL.textAlignment = NSTextAlignmentLeft;
        _nameL.numberOfLines = 2;
        _nameL.textColor = kRGB_COLOR(@"#333333");
        _nameL.font = [UIFont systemFontOfSize:14];
    }
    return _nameL;
}
- (UILabel *)priceL{
    if (!_priceL) {
        _priceL = [[UILabel alloc] initWithFrame:CGRectMake(_commodityHeaderImageV.maxX+10, _attrL.maxY, _nameL.width, 20)];
        _priceL.textAlignment = NSTextAlignmentLeft;
        _priceL.textColor = kRGB_COLOR(@"#333333");
        _priceL.font = [UIFont systemFontOfSize:14];
    }
    return _priceL;
}
- (UILabel *)attrL{
    if (!_attrL) {
        _attrL  = [[UILabel alloc]initWithFrame:CGRectMake(_commodityHeaderImageV.maxX+10,_nameL.maxY, _nameL.width, 20)];
        _attrL.textColor = kRGB_COLOR(@"#999999");
        _attrL.font = [UIFont systemFontOfSize:12];
        _attrL.textAlignment = NSTextAlignmentLeft;
    }
    return _attrL;
}

@end
