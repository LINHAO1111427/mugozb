//
//  myCommodityTableViewCell.m
//  Shopping
//
//  Created by klc on 2020/7/3.
//  Copyright © 2020 klc. All rights reserved.
//

#import "myCommodityTableViewCell.h"

@interface myCommodityTableViewCell()
@property (nonatomic, strong)UIView *line;
@property (nonatomic, strong)UILabel *desLabel;//描述
@property (nonatomic, strong)UIImageView *commodityImageV;//商品图
@property (nonatomic, strong)UILabel *orderLabel;//顺序
@property (nonatomic, strong)UIImageView *freezImageV;//冻结
@property (nonatomic, strong)UILabel *priceLabel;//价格
 

//首个处理
@property (nonatomic, strong)UIView *oneSetView;
@end
@implementation myCommodityTableViewCell
- (UIView *)oneSetView{
    if (!_oneSetView) {
        _oneSetView = [[UIView alloc]initWithFrame:CGRectMake(0, 120, kScreenWidth, 50)];
        _oneSetView.backgroundColor = kRGB_COLOR(@"#F4F4F4");
    }
    return _oneSetView;
}
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
   self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self createUI];
    }
    return self;
}

- (void)layoutSubviews{
    [super layoutSubviews];
    self.line.y = self.height-1.0;
}
- (void)createUI{
    self.backgroundColor = [UIColor whiteColor];
    UIView *line = [[UIView alloc]initWithFrame:CGRectMake(12, 0, kScreenWidth-24, 1)];
    line.backgroundColor = kRGB_COLOR(@"#DEDEDE");
    self.line = line;
    [self.contentView addSubview:self.line];
    
    UIImageView *commodityImageV = [[UIImageView alloc]initWithFrame:CGRectMake(12, 20, 80, 80)];
    commodityImageV.contentMode = UIViewContentModeScaleAspectFill;
    commodityImageV.clipsToBounds = YES;
    commodityImageV.layer.cornerRadius = 5;
    commodityImageV.layer.masksToBounds = YES;
    self.commodityImageV = commodityImageV;
    [self.contentView addSubview:self.commodityImageV];
    
    UILabel *orderLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 30, 16)];
    orderLabel.backgroundColor =kRGB_COLOR(@"#FF8503");
    orderLabel.textColor = [UIColor whiteColor];
    orderLabel.textAlignment = NSTextAlignmentCenter;
    orderLabel.font = [UIFont systemFontOfSize:12];
    UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:orderLabel.bounds byRoundingCorners: UIRectCornerBottomRight cornerRadii:CGSizeMake(8,8)];
    CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
    maskLayer.frame = orderLabel.bounds;
    maskLayer.path = maskPath.CGPath;
    [orderLabel.layer addSublayer:maskLayer];
    orderLabel.layer.mask = maskLayer;
    orderLabel.layer.masksToBounds = YES;
    self.orderLabel = orderLabel;
    [commodityImageV insertSubview:self.orderLabel atIndex:1];
    
    UIImageView *freezImageV = [[UIImageView alloc]initWithFrame:self.commodityImageV.bounds];
    freezImageV.backgroundColor = kRGBA_COLOR(@"#000000", 0.5);
    freezImageV.image = [UIImage imageNamed:@"shop_freze_cover"];
    freezImageV.hidden = YES;
    self.freezImageV = freezImageV;
    [self.commodityImageV insertSubview:self.freezImageV atIndex:0];
    
    UILabel *desLabel = [[UILabel alloc]initWithFrame:CGRectMake(commodityImageV.maxX+12, commodityImageV.y, kScreenWidth-24-92, 50)];
    desLabel.textAlignment = NSTextAlignmentLeft;
    desLabel.textColor = kRGB_COLOR(@"#2B2C2C");
    desLabel.font = [UIFont systemFontOfSize:14];
    desLabel.numberOfLines = 0;
    self.desLabel = desLabel;
    [self.contentView addSubview:self.desLabel];
    
    UILabel *priceLabel = [[UILabel alloc]initWithFrame:CGRectMake(commodityImageV.maxX+12, commodityImageV.maxY-20, kScreenWidth-24-100, 20)];
    priceLabel.textColor = kRGB_COLOR(@"#FB0035");
    priceLabel.font = [UIFont boldSystemFontOfSize:18];
    priceLabel.textAlignment = NSTextAlignmentLeft;
    priceLabel.text = @"0";
    self.priceLabel = priceLabel;
    [self.contentView addSubview:self.priceLabel];
    
}
- (void)setModel:(ShopGoodsDTOModel *)model{
    _model = model;
    NSString *url;
    if (model.channelId == 1) {
        NSArray *arr = [model.goodsPicture componentsSeparatedByString:@","];
        url = arr.firstObject;
    }else{
        url = model.goodsPicture;
    }
    [self.commodityImageV sd_setImageWithURL:[NSURL URLWithString:url] placeholderImage:[UIImage imageWithColor:[UIColor lightGrayColor]]];
    self.desLabel.text = model.goodsName;
     
    NSMutableAttributedString *attri;
    NSTextAttachment *attach = [[NSTextAttachment alloc]init];
    attach.image = [UIImage imageNamed:@"shop_icon_rmb"];
    attach.bounds = CGRectMake(0, 0, 10, 10);
    NSAttributedString *attImg = [NSAttributedString attributedStringWithAttachment:attach];
     
    if (model.favorablePrice > 0 && model.channelId == 1) {
        NSString *str1 = [NSString stringWithFormat:@"¥%.2f",model.price];
        NSString *str2 = [NSString stringWithFormat:@"%.2f",model.favorablePrice];
        attri = [[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@"%@ %@",str1,str2]];
        [attri insertAttributedString:attImg atIndex:str1.length+1];
        [attri addAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:14],NSForegroundColorAttributeName:kRGB_COLOR(@"#AAAAAA"),NSStrikethroughStyleAttributeName:@(NSUnderlineStyleSingle)} range:NSMakeRange(0, str1.length)];
        [attri addAttributes:@{NSFontAttributeName:[UIFont boldSystemFontOfSize:18],NSForegroundColorAttributeName:kRGB_COLOR(@"#FB0035")} range:NSMakeRange(str1.length, str2.length)];
    }else{
         NSString *str1 = [NSString stringWithFormat:@"%.2f",model.price];
         attri = [[NSMutableAttributedString alloc]initWithString:str1];
         [attri insertAttributedString:attImg atIndex:0];
         [attri addAttributes:@{NSFontAttributeName:[UIFont boldSystemFontOfSize:18],NSForegroundColorAttributeName:kRGB_COLOR(@"#FB0035")} range:NSMakeRange(1, str1.length)];
    }
    self.priceLabel.attributedText = attri;
    self.orderLabel.text = [NSString stringWithFormat:@"%d",model.sort];
    if (model.status != 3) {
        [self.oneSetView removeAllSubViews];
        [self.oneSetView removeFromSuperview];
        [self.contentView addSubview:self.oneSetView];
        [self UpdateOneSetView];
        self.freezImageV.hidden = YES;
    }else{
        self.freezImageV.hidden = NO;
    }
}


- (void)UpdateOneSetView{
    CGFloat margin = 15*kScreenWidth/360.0;
    CGFloat x = 12;
    CGFloat widthM = (kScreenWidth-margin*3-24)/5.8;
    CGFloat width = widthM;
    for (int i = 0; i < 4; i++) {
        if (i != 0) {
            width = 1.6*widthM;
        }
        UIButton *btn = [[UIButton alloc]initWithFrame:CGRectMake(x, 10, width, 30)];
        x += width+margin;
        btn.tag = i;
        btn.layer.cornerRadius = 15;
        btn.clipsToBounds = YES;
        btn.backgroundColor = [UIColor whiteColor];
        btn.layer.borderWidth = 1.0;
        btn.layer.borderColor = kRGB_COLOR(@"#AAAAAA").CGColor;
        btn.titleLabel.font = [UIFont systemFontOfSize:13];
        if (i == 0) {
            [btn setTitle:[NSString stringWithFormat:@"%d",self.model.sort] forState:UIControlStateNormal];
        }else if(i == 1){
            if (self.model.status == 1) {//未上架
               [btn setTitle:kLocalizationMsg(@"上架") forState:UIControlStateNormal];
            }else if (self.model.status == 2){//已上架
                [btn setTitle:kLocalizationMsg(@"下架") forState:UIControlStateNormal];
            }
        }else if(i == 2){
            [btn setTitle:kLocalizationMsg(@"编辑") forState:UIControlStateNormal];
        }else if(i == 3){
            [btn setTitle:kLocalizationMsg(@"删除") forState:UIControlStateNormal];
        }
        [btn setTitleColor:kRGB_COLOR(@"#333333") forState:UIControlStateNormal];
        [btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
        [self.oneSetView addSubview:btn];
    }
}

- (void)btnClick:(UIButton *)btn{
    if (self.delegate && [self.delegate respondsToSelector:@selector(myCommodityTableViewCellOneSetViewClick:itemClick:)]) {
        [self.delegate myCommodityTableViewCellOneSetViewClick:self itemClick:btn.tag];
    }
}

@end
