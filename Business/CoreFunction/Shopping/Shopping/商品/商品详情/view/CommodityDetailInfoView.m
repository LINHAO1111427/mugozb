//
//  CommodityDetailInfoView.m
//  Shopping
//
//  Created by klc on 2020/7/7.
//  Copyright © 2020 klc. All rights reserved.
//

#import "CommodityDetailInfoView.h"
@interface CommodityDetailInfoView()
@property (nonatomic, strong)UILabel *priceLabel;//价格
@property (nonatomic, strong)UILabel *salesVolumeLabel;//销售额
@property (nonatomic, strong)UILabel *titleLabel;//标题
 
@end
@implementation CommodityDetailInfoView


- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self createUI];
    }
    return self;
}

- (void)createUI{
    _priceLabel = [[UILabel alloc]init];
    _priceLabel.textAlignment = NSTextAlignmentLeft;
    [_priceLabel setContentHuggingPriority:UILayoutPriorityRequired forAxis:UILayoutConstraintAxisHorizontal];
    [_priceLabel setContentCompressionResistancePriority:UILayoutPriorityRequired forAxis:UILayoutConstraintAxisHorizontal];
    [self addSubview:_priceLabel];
    [_priceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).inset(15);
        make.top.equalTo(self).inset(10);
    }];
    
    _salesVolumeLabel = [[UILabel alloc]init];
    _salesVolumeLabel.textAlignment = NSTextAlignmentRight;
    _salesVolumeLabel.textColor = kRGB_COLOR(@"#888888");
    _salesVolumeLabel.font = [UIFont systemFontOfSize:14];
    [self addSubview:_salesVolumeLabel];
    [_salesVolumeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self).inset(15);
        make.left.equalTo(_priceLabel.mas_right).offset(10);
        make.bottom.equalTo(_priceLabel).offset(-4);
    }];
    
    _titleLabel = [[UILabel alloc] init];
    _titleLabel.numberOfLines = 0;
    _titleLabel.textColor = kRGB_COLOR(@"#2B2C2C");
    _titleLabel.font = [UIFont boldSystemFontOfSize:15];
    _titleLabel.textAlignment = NSTextAlignmentLeft;
    [_titleLabel setContentHuggingPriority:UILayoutPriorityRequired forAxis:UILayoutConstraintAxisHorizontal];
    [_titleLabel setContentCompressionResistancePriority:UILayoutPriorityRequired forAxis:UILayoutConstraintAxisHorizontal];
    [self addSubview:_titleLabel];
    [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_priceLabel);
        make.right.equalTo(_salesVolumeLabel);
        make.top.equalTo(_priceLabel.mas_bottom).offset(15);
        make.bottom.equalTo(self).inset(15);
    }];
}
 


- (void)setDetailModel:(ShopGoodsDetailDTOModel *)detailModel{
    _detailModel = detailModel;
    NSMutableAttributedString *attri = [self getPriceAttriStrWithPrice:detailModel.shopGoods.price favorablePrice:detailModel.shopGoods.favorablePrice];;
    self.priceLabel.attributedText = attri;
    if (detailModel.totalSoldNum > 10000) {
        self.salesVolumeLabel.text = [NSString stringWithFormat:kLocalizationMsg(@"已售%.1f万+件"),detailModel.shopGoods.soldNum/10000.0];
    }else if(detailModel.totalSoldNum > 0){
        self.salesVolumeLabel.text = [NSString stringWithFormat:kLocalizationMsg(@"已售%d+件"),detailModel.shopGoods.soldNum];
    }else{
        self.salesVolumeLabel.text = [NSString stringWithFormat:kLocalizationMsg(@"已售0件")];
    }
    self.titleLabel.text = detailModel.shopGoods.goodsName;
    
    [self.titleLabel layoutIfNeeded];
}


- (NSMutableAttributedString *)getPriceAttriStrWithPrice:(CGFloat)price favorablePrice:(CGFloat)favorablePrice{
    NSMutableAttributedString *attri ;
    NSTextAttachment *attach = [[NSTextAttachment alloc]init];
    attach.image = [UIImage imageNamed:@"shop_icon_rmb"];
    attach.bounds = CGRectMake(0, 0, 15, 15);
    NSAttributedString *attImg = [NSAttributedString attributedStringWithAttachment:attach];
    if (favorablePrice > 0) {
        NSString *str1 = [NSString stringWithFormat:@"%.2f",favorablePrice];
        NSString *str2 = [NSString stringWithFormat:@"¥%.2f",price];
        attri = [[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@"%@ %@",str1,str2]];
        [attri insertAttributedString:attImg atIndex:0];
        [attri addAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:28],NSForegroundColorAttributeName:kRGB_COLOR(@"#FB0035")} range:NSMakeRange(0, str1.length+1)];
        [attri addAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:15],NSForegroundColorAttributeName:kRGB_COLOR(@"#888888"),NSStrikethroughStyleAttributeName:@(NSUnderlineStyleSingle)} range:NSMakeRange(str1.length+2, str2.length)];
    }else{
        NSString *str1 = [NSString stringWithFormat:@"%.2f",price];
        attri = [[NSMutableAttributedString alloc]initWithString:str1];
        [attri insertAttributedString:attImg atIndex:0];
        [attri addAttributes:@{NSFontAttributeName:[UIFont boldSystemFontOfSize:28],NSForegroundColorAttributeName:kRGB_COLOR(@"#FB0035")} range:NSMakeRange(0, str1.length+1)];
    }
    return attri;
}

- (void)setSelectedAttriModel:(ShopAttrComposeModel *)selectedAttriModel{
    _selectedAttriModel = selectedAttriModel;
    NSMutableAttributedString *attri = [self getPriceAttriStrWithPrice:selectedAttriModel.price favorablePrice:selectedAttriModel.favorablePrice];;
    self.priceLabel.attributedText = attri;
}

@end
