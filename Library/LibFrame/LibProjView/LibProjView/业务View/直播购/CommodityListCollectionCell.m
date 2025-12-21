//
//  CommodityRecommendTable.m
//  Shopping
//
//  Created by KLC on 2020/7/4.
//  Copyright © 2020 klc. All rights reserved.
//

#import "CommodityListCollectionCell.h"
@interface CommodityListCollectionCell()
@property (nonatomic, strong)UIImageView *imageV;
@property (nonatomic, strong)UILabel *nameL;
@property (nonatomic, strong)UILabel *priceL;
@property (nonatomic, strong)UILabel *saleL;
@end

@implementation CommodityListCollectionCell
- (UIImageView *)imageV{
    if (!_imageV) {
        _imageV = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, self.width, self.width)];
        _imageV.clipsToBounds = YES;
        _imageV.contentMode = UIViewContentModeScaleAspectFill;
        _imageV.layer.masksToBounds = YES;
        _imageV.layer.cornerRadius = 4.0;
    }
    return _imageV;
}
- (UILabel *)nameL{
    if (!_nameL) {
        _nameL = [[UILabel alloc]initWithFrame:CGRectMake(0, _imageV.maxY+5, self.width, 40)];
        _nameL.font = [UIFont systemFontOfSize:14];
        _nameL.textColor = kRGB_COLOR(@"#2B2C2C");
        _nameL.textAlignment = NSTextAlignmentLeft;
        _nameL.numberOfLines = 0;
    }
    return _nameL;
}
- (UILabel *)priceL{
    if (!_priceL) {
        _priceL = [[UILabel alloc]initWithFrame:CGRectMake(0, _nameL.maxY+5, self.width/2.0, 20)];
        _priceL.font = [UIFont systemFontOfSize:14];
        _priceL.textAlignment = NSTextAlignmentLeft;
    }
    return _priceL;
}
- (UILabel *)saleL{
    if (!_saleL) {
        _saleL = [[UILabel alloc]initWithFrame:CGRectMake(self.width/2.0, _nameL.maxY+5, self.width/2.0, 20)];
        _saleL.font = [UIFont systemFontOfSize:12];
        _saleL.textAlignment = NSTextAlignmentRight;
        _saleL.textColor = kRGB_COLOR(@"#AAAAAA");
    }
    return _saleL;
}
- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self createUI];
    }
    return self;
}
- (void)createUI{
    self.backgroundColor = [UIColor whiteColor];
    [self.contentView addSubview:self.imageV];
    [self.contentView addSubview:self.nameL];
    [self.contentView addSubview:self.priceL];
    [self.contentView addSubview:self.saleL];
}

- (void)setModel:(ShopGoodsDTOModel *)model{
    _model = model;
    NSArray *imgArr =[model.goodsPicture componentsSeparatedByString:@","];
    [self.imageV sd_setImageWithURL:[NSURL URLWithString:imgArr.firstObject] placeholderImage:[ProjConfig getDefaultImage]];
    self.nameL.text = model.goodsName;
    self.priceL.attributedText = [self getPriceAttriStrWithPrice:model.price favorablePrice:model.favorablePrice];
    self.saleL.text = [NSString stringWithFormat:kLocalizationMsg(@"已售 %d 件"),model.soldNum];
}

- (NSMutableAttributedString *)getPriceAttriStrWithPrice:(CGFloat)price favorablePrice:(CGFloat)favorablePrice{
    NSMutableAttributedString *attri ;
    NSTextAttachment *attach = [[NSTextAttachment alloc]init];
    attach.image = [UIImage imageNamed:@"shop_icon_rmb"];
    attach.bounds = CGRectMake(0, 0, 10, 10);
    NSAttributedString *attImg = [NSAttributedString attributedStringWithAttachment:attach];
    NSString *str;
    if (favorablePrice > 0) {
        str = [NSString stringWithFormat:@"%.2f",favorablePrice];
    }else{
        str = [NSString stringWithFormat:@"%.2f",price];
    }
    attri = [[NSMutableAttributedString alloc]initWithString:str];
    [attri insertAttributedString:attImg atIndex:0];
    [attri addAttributes:@{NSFontAttributeName:[UIFont boldSystemFontOfSize:14],NSForegroundColorAttributeName:kRGB_COLOR(@"#FB0035")} range:NSMakeRange(1, str.length)];
    return attri;
}


@end
