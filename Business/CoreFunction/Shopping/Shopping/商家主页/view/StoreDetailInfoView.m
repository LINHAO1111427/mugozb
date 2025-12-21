//
//  StoreInfoView.m
//  Shopping
//
//  Created by klc on 2020/7/22.
//  Copyright © 2020 klc. All rights reserved.
//

#import "StoreDetailInfoView.h"
@interface StoreDetailInfoView()
@property (nonatomic, strong)UIButton *shopAvaterBtn;//头像
@property (nonatomic, strong)UILabel *shopNameLabel;//店铺名称
@property (nonatomic, strong)UILabel *shopSaleInfoLabel;//销售信息
@property (nonatomic, strong)UIView *tagView;//标签
@end
@implementation StoreDetailInfoView

- (UIButton *)shopAvaterBtn{
    if (!_shopAvaterBtn) {
        _shopAvaterBtn = [[UIButton alloc]initWithFrame:CGRectMake(14, 14, 50, 50)];
        _shopAvaterBtn.layer.cornerRadius = 25;
        _shopAvaterBtn.clipsToBounds = YES;
        _shopAvaterBtn.imageView.contentMode = UIViewContentModeScaleAspectFill;
        [_shopAvaterBtn addTarget:self action:@selector(shopAvaterBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _shopAvaterBtn;;
}
- (UILabel *)shopNameLabel{
    if (!_shopNameLabel) {
        _shopNameLabel = [[UILabel alloc]initWithFrame:CGRectMake(_shopAvaterBtn.maxX+10, _shopAvaterBtn.y+5, self.width-88, 20)];
        _shopNameLabel.font = [UIFont boldSystemFontOfSize:15];
        _shopNameLabel.textColor = kRGB_COLOR(@"#333333");
        _shopNameLabel.textAlignment = NSTextAlignmentLeft;
    }
    return _shopNameLabel;
}
- (UILabel *)shopSaleInfoLabel{
    if (!_shopSaleInfoLabel) {
        _shopSaleInfoLabel = [[UILabel alloc]initWithFrame:CGRectMake(_shopAvaterBtn.maxX+10,  _shopAvaterBtn.y+25, self.width-88, 20)];
        _shopSaleInfoLabel.font = [UIFont systemFontOfSize:12];
        _shopSaleInfoLabel.textColor = kRGB_COLOR(@"#666666");
        _shopSaleInfoLabel.textAlignment = NSTextAlignmentLeft;
    }
    return _shopSaleInfoLabel;
}
- (UIView *)tagView{
    if (!_tagView) {
        _tagView = [[UIView alloc]initWithFrame:CGRectMake(_shopAvaterBtn.maxX+10, _shopSaleInfoLabel.maxY+10, self.width-88, 20)];
        _tagView.backgroundColor = [UIColor whiteColor];
    }
    return _tagView;
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
    [self addSubview:self.shopAvaterBtn];
    [self addSubview:self.shopNameLabel];
    [self addSubview:self.shopSaleInfoLabel];
    [self addSubview:self.tagView];
    CGFloat margin = 10;
    CGFloat width = (self.tagView.width-30)/4.0;
    for (int i = 0; i < 4; i++) {
        UILabel *tagL = [[UILabel alloc]initWithFrame:CGRectMake(i*(margin+width), 0, width, 22)];
        tagL.layer.cornerRadius =  5;
        tagL.clipsToBounds = YES;
        tagL.layer.borderColor = kRGB_COLOR(@"#FF5500").CGColor;
        tagL.layer.borderWidth = 1.0;
        tagL.textAlignment = NSTextAlignmentCenter;
        tagL.font = [UIFont systemFontOfSize:13];
        tagL.textColor = kRGB_COLOR(@"#FF5500");
        if (i == 0) {
            tagL.text = kLocalizationMsg(@"认证商家");
        }else if (i == 1){
            tagL.text = kLocalizationMsg(@"正品保障");
        }else if (i == 2){
            tagL.text = kLocalizationMsg(@"闪电发货");
        }else if (i == 3){
            tagL.text = kLocalizationMsg(@"极速退款");
        }
        [self.tagView addSubview:tagL];
    }
}

- (void)setBusiness:(ShopBusinessModel *)business{
    _business = business;
    [self.shopAvaterBtn sd_setImageWithURL:[NSURL URLWithString:business.logo] forState:UIControlStateNormal placeholderImage:[ProjConfig getDefaultImage]];
    self.shopNameLabel.text = business.name;
    NSString *num1 = 0,*num2 = 0;
    if (business.effectiveGoodsNum > 10000) {
        num1 = [NSString stringWithFormat:kLocalizationMsg(@"%.1f万"),business.effectiveGoodsNum/10000.0];
    }else{
        num1 = [NSString stringWithFormat:@"%d",business.effectiveGoodsNum];
    }
    if (business.totalSoldNum > 10000) {
        num2 = [NSString stringWithFormat:kLocalizationMsg(@"%.1f万"),business.totalSoldNum/10000.0];
    }else{
        num2 = [NSString stringWithFormat:@"%d",business.totalSoldNum];
    }
    self.shopSaleInfoLabel.text = [NSString stringWithFormat:kLocalizationMsg(@"在售商品%@ | 累计销量%@"),num1,num2];
}

- (void)shopAvaterBtnClick:(UIButton *)btn{
   // NSLog(@"过滤文字点击吧"));
}
 
@end
