//
//  HostOrderTableViewCell.m
//  Shopping
//
//  Created by yww on 2020/8/3.
//  Copyright © 2020 klc. All rights reserved.
//

#import "HostOrderTableViewCell.h"
@interface HostOrderTableViewCell()
@property (nonatomic, strong)UIImageView *commodityHeaderImageV;
@property (nonatomic, strong)UILabel *nameL;
@property (nonatomic, strong)UILabel *attrL;
@property (nonatomic, strong)UILabel *priceL;
@property (nonatomic, strong)UILabel *numL;
@end
@implementation HostOrderTableViewCell
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self crateUI];
    }
    return self;
}
- (void)crateUI{
    self.backgroundColor = [UIColor whiteColor];
    
    UIView *contentV = [[UIView alloc]initWithFrame:CGRectMake(12, 0, kScreenWidth-24, 100)];
    contentV.backgroundColor = [UIColor whiteColor];
    [self.contentView addSubview:contentV];
    [contentV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.contentView).inset(12);
        make.top.bottom.equalTo(self.contentView);
    }];
    
    _commodityHeaderImageV = [[UIImageView alloc]init];
    _commodityHeaderImageV.contentMode = UIViewContentModeScaleAspectFill;
    _commodityHeaderImageV.clipsToBounds = YES;
    _commodityHeaderImageV.backgroundColor = [UIColor lightGrayColor];
    _commodityHeaderImageV.layer.masksToBounds = YES;
    _commodityHeaderImageV.layer.cornerRadius = 5;
    [contentV addSubview:_commodityHeaderImageV];
    [_commodityHeaderImageV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(80, 80));
        make.left.centerY.equalTo(contentV).inset(12);
        make.centerY.equalTo(contentV);
    }];
    
    _nameL = [[UILabel alloc]initWithFrame:CGRectMake(_commodityHeaderImageV.maxX+10, 10, contentV.width-24-90-80, 40)];
    _nameL.textAlignment = NSTextAlignmentLeft;
    _nameL.numberOfLines = 2;
    _nameL.textColor = kRGB_COLOR(@"#333333");
    _nameL.font = [UIFont systemFontOfSize:14];
    [_nameL setContentHuggingPriority:UILayoutPriorityRequired forAxis:UILayoutConstraintAxisVertical];
    [_nameL setContentHuggingPriority:UILayoutPriorityDefaultLow forAxis:UILayoutConstraintAxisHorizontal];
    [contentV addSubview:_nameL];
    [_nameL mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_commodityHeaderImageV.mas_right).inset(10);
        make.top.equalTo(_commodityHeaderImageV);
    }];
    
    _attrL = [[UILabel alloc]initWithFrame:CGRectMake(_commodityHeaderImageV.maxX+10, _nameL.maxY, _nameL.width, 20)];
    _attrL.textColor = kRGB_COLOR(@"#999999");
    _attrL.font = [UIFont systemFontOfSize:12];
    _attrL.textAlignment = NSTextAlignmentLeft;
    [contentV addSubview:_attrL];
    [_attrL mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_nameL);
        make.top.equalTo(_nameL.mas_bottom).inset(10);
    }];
    
    UIView *priceBgV = [[UIView alloc] init];
    [contentV addSubview:priceBgV];
    [priceBgV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(contentV).inset(12);
        make.top.equalTo(_commodityHeaderImageV);
        make.left.equalTo(_nameL.mas_right).inset(10);
    }];
    
    _priceL = [[UILabel alloc] initWithFrame:CGRectMake(_nameL.maxX, 10, 80, 20)];
    _priceL.textAlignment = NSTextAlignmentRight;
    _priceL.textColor = kRGB_COLOR(@"#333333");
    [_priceL setContentHuggingPriority:UILayoutPriorityRequired forAxis:UILayoutConstraintAxisVertical];
    [_priceL setContentCompressionResistancePriority:UILayoutPriorityRequired forAxis:UILayoutConstraintAxisHorizontal];
    [_priceL setContentHuggingPriority:UILayoutPriorityRequired forAxis:UILayoutConstraintAxisHorizontal];
    _priceL.font = [UIFont systemFontOfSize:14];
    [priceBgV addSubview:_priceL];
    [_priceL mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.equalTo(priceBgV);
    }];
    
    _numL = [[UILabel alloc]initWithFrame:CGRectMake(_attrL.maxX, _priceL.maxY, _priceL.width, 20)];
    _numL.textColor = kRGB_COLOR(@"#999999");
    _numL.font = [UIFont systemFontOfSize:12];
    _numL.textAlignment = NSTextAlignmentRight;
    [_numL setContentHuggingPriority:UILayoutPriorityRequired forAxis:UILayoutConstraintAxisHorizontal];
    [priceBgV addSubview:_numL];
    [_numL mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(priceBgV);
        make.top.mas_equalTo(_priceL.mas_bottom).inset(10);
    }];
    
    
    
}
- (void)setModel:(ShopSubOrderModel *)model{
    _model = model;
    NSArray *arr = [model.goodsPicture componentsSeparatedByString:@","];
    [self.commodityHeaderImageV sd_setImageWithURL:[NSURL URLWithString:arr.firstObject] placeholderImage:[ProjConfig getAppIcon]];
    self.nameL.text = model.goodsName;
    [self.nameL sizeToFit];
    self.attrL.text = model.skuName;
    self.priceL.text = [NSString stringWithFormat:@"¥%.2f",model.goodsPrice];
    self.numL.text = [NSString stringWithFormat:@"x%d",model.goodsNum];
}




@end
