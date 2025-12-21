//
//  ShopOderListCell.m
//  Shopping
//
//  Created by klc on 2020/7/20.
//  Copyright © 2020 klc. All rights reserved.
//

#import "ShopOrderListCell.h"
@interface ShopOrderListCell()

@property (nonatomic, strong)UIButton *commodityImageBtn;//商品图片
@property (nonatomic, strong)UILabel *commodityTitleLabel;//商品名称
@property (nonatomic, strong)UILabel *commodityPriceLabel;//商品价格
@property (nonatomic, strong)UILabel *commodityAttLabel;//商品属性
@property (nonatomic, strong)UILabel *commodityNumLabel;//商品数目
@end
@implementation ShopOrderListCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.backgroundColor = kRGB_COLOR(@"#F6F6F6");
        [self createUI];
    }
    return self;
}

- (void)createUI{
    
    UIView *contentV = [[UIView alloc] init];
    contentV.backgroundColor = [UIColor whiteColor];
    [self.contentView addSubview:contentV];
    [contentV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.contentView).inset(12);
        make.top.bottom.equalTo(self.contentView);
    }];
    
    
    ///商品图片
    _commodityImageBtn = [[UIButton alloc] init];
    _commodityImageBtn.userInteractionEnabled = NO;
    _commodityImageBtn.imageView.contentMode = UIViewContentModeScaleAspectFill;
    _commodityImageBtn.layer.cornerRadius = 5;
    _commodityImageBtn.clipsToBounds = YES;
    [contentV addSubview:_commodityImageBtn];
    [_commodityImageBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(80, 80));
        make.left.equalTo(contentV).inset(12);
        make.bottom.equalTo(contentV);
    }];
    
    ///商品名称
    _commodityTitleLabel = [[UILabel alloc] init];
    _commodityTitleLabel.textColor = kRGB_COLOR(@"#333333");
    _commodityTitleLabel.font = [UIFont systemFontOfSize:14];
    _commodityTitleLabel.textAlignment = NSTextAlignmentLeft;
    _commodityTitleLabel.numberOfLines = 2;
    [contentV addSubview:_commodityTitleLabel];
    [_commodityTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_commodityImageBtn);
        make.left.equalTo(self.commodityImageBtn.mas_right).inset(12);
    }];
    
    ///价钱
    UIView *priceBgV = [[UIView alloc] init];
    [contentV addSubview:priceBgV];
    [priceBgV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_commodityTitleLabel.mas_right).inset(12);
        make.right.equalTo(contentV).inset(12);
        make.top.equalTo(_commodityImageBtn);
    }];
    
    ///商品价格
    _commodityPriceLabel = [[UILabel alloc] init];
    _commodityPriceLabel.font = [UIFont systemFontOfSize:14];
    _commodityPriceLabel.textAlignment = NSTextAlignmentRight;
    [_commodityPriceLabel setContentHuggingPriority:UILayoutPriorityRequired forAxis:UILayoutConstraintAxisHorizontal];
    [_commodityPriceLabel setContentHuggingPriority:UILayoutPriorityRequired forAxis:UILayoutConstraintAxisVertical];
    [_commodityPriceLabel setContentCompressionResistancePriority:UILayoutPriorityRequired forAxis:UILayoutConstraintAxisHorizontal];
    _commodityPriceLabel.textColor = kRGB_COLOR(@"#333333");
    [priceBgV addSubview:_commodityPriceLabel];
    [_commodityPriceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.right.equalTo(priceBgV);
    }];
    
    
    _commodityNumLabel = [[UILabel alloc] init];
    _commodityNumLabel.textColor = kRGB_COLOR(@"#999999");
    _commodityNumLabel.userInteractionEnabled = YES;
    _commodityNumLabel.font = [UIFont systemFontOfSize:12];
    _commodityNumLabel.textAlignment = NSTextAlignmentRight;
    [_commodityNumLabel setContentHuggingPriority:UILayoutPriorityDefaultHigh forAxis:UILayoutConstraintAxisHorizontal];
    [_commodityNumLabel setContentHuggingPriority:UILayoutPriorityDefaultHigh forAxis:UILayoutConstraintAxisVertical];
    [_commodityNumLabel setContentCompressionResistancePriority:UILayoutPriorityDefaultHigh forAxis:UILayoutConstraintAxisHorizontal];
    [priceBgV addSubview:_commodityNumLabel];
    [_commodityNumLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(priceBgV);
        make.top.equalTo(_commodityPriceLabel.mas_bottom).offset(5);
    }];
    
    ///商品属性
    _commodityAttLabel = [[UILabel alloc]init];
    _commodityAttLabel.layer.cornerRadius = 5;
    _commodityAttLabel.clipsToBounds = YES;
    _commodityAttLabel.textColor = kRGB_COLOR(@"#999999");
    _commodityAttLabel.userInteractionEnabled = YES;
    _commodityAttLabel.font = [UIFont systemFontOfSize:12];
    [contentV addSubview:_commodityAttLabel];
    [_commodityAttLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.commodityTitleLabel);
        make.top.mas_equalTo(self.commodityTitleLabel.mas_bottom).inset(7);
    }];
    
}


- (void)setModel:(ShopCarModel *)model{
    _model = model;
    NSArray *arr = [model.goodsPicture componentsSeparatedByString:@","];
    [self.commodityImageBtn sd_setImageWithURL:[NSURL URLWithString:arr.firstObject] forState:UIControlStateNormal placeholderImage:[ProjConfig getDefaultImage]];
    self.commodityTitleLabel.text = model.goodsName;
    [self.commodityTitleLabel sizeToFit];
    self.commodityAttLabel.text = model.skuName;
    NSString *str = [NSString stringWithFormat:@"¥%.2f",model.goodsPrice];
    self.commodityPriceLabel.text = str;
    if (model.goodsNum > 0) {
        self.commodityNumLabel.text = [NSString stringWithFormat:@"x%d",model.goodsNum];
    }
}


@end

