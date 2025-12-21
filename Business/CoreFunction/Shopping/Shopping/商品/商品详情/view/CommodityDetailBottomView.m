//
//  CommodityDetailBottomView.m
//  Shopping
//
//  Created by klc on 2020/7/8.
//  Copyright © 2020 klc. All rights reserved.
//

#import "CommodityDetailBottomView.h"
@interface CommodityDetailBottomView()
@property (nonatomic, strong)UIButton *shoppingTrolleyBtn;//购物车
@property (nonatomic, strong)UIButton *buyBtn;//支付
@property (nonatomic, strong)NSArray *btnArr;
@end
@implementation CommodityDetailBottomView

- (NSArray *)btnArr{
    if (!_btnArr) {
       _btnArr = @[
            @{@"title":kLocalizationMsg(@"店铺"),@"image":@"shopping_shop"},
            @{@"title":kLocalizationMsg(@"分享"),@"image":@"shopping_share"},
            @{@"title":kLocalizationMsg(@"客服"),@"image":@"shopping_customer_service"}
        ];
    }
    return _btnArr;
}
- (UIButton *)shoppingTrolleyBtn{
    if (!_shoppingTrolleyBtn) {
        CGFloat margin = 10;
        CGFloat width = 94;
        if (self.width-24-45*3 > 94*2+20) {
            width = 94;
            margin = (self.width-24-45*3-94*2)/2.0;
        }else{
            width = (self.width-24-45*3-10*2)/2.0;
        }
        _shoppingTrolleyBtn = [[UIButton alloc]initWithFrame:CGRectMake(margin+12+45*3, 12, width, 40)];
        _shoppingTrolleyBtn.layer.cornerRadius = 20;
        _shoppingTrolleyBtn.titleLabel.font = [UIFont systemFontOfSize:14];
        _shoppingTrolleyBtn.clipsToBounds = YES;
        [_shoppingTrolleyBtn setTitle:kLocalizationMsg(@"加入购物车") forState:UIControlStateNormal];
        [_shoppingTrolleyBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_shoppingTrolleyBtn setBackgroundImage:[UIImage createImageSize:_shoppingTrolleyBtn.bounds.size gradientColors:@[kRGB_COLOR(@"#FF8E00"),kRGB_COLOR(@"#FF5500")] percentage:@[@0.3,@1.0] gradientType:GradientFromTopToBottom] forState:UIControlStateNormal];
        [_shoppingTrolleyBtn setBackgroundImage:[UIImage imageWithColor:kRGB_COLOR(@"#888888")] forState:UIControlStateDisabled];
        [_shoppingTrolleyBtn addTarget:self action:@selector(shoppingTrolleyBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _shoppingTrolleyBtn;;
}
- (UIButton *)buyBtn{
    if (!_buyBtn) {
        CGFloat margin = 10;
        CGFloat width = 94;
        if (self.width-24-45*3 > 94*2+20) {
            width = 94;
            margin = (self.width-24-45*3-94*2)/2.0;
        }else{
            width = (self.width-24-45*3-10*2)/2.0;
        }
        _buyBtn = [[UIButton alloc]initWithFrame:CGRectMake(2*margin+12+45*3+width, 12, width, 40)];
        [_buyBtn setTitle:kLocalizationMsg(@"立即购买") forState:UIControlStateNormal];
        _buyBtn.titleLabel.font = [UIFont systemFontOfSize:14];
        _buyBtn.layer.cornerRadius = 20;
        _buyBtn.clipsToBounds = YES;
        [_buyBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_buyBtn setBackgroundImage:[UIImage createImageSize:_shoppingTrolleyBtn.bounds.size gradientColors:@[kRGB_COLOR(@"#FFBB06"),kRGB_COLOR(@"#FF8503")] percentage:@[@0.3,@1.0] gradientType:GradientFromTopToBottom] forState:UIControlStateNormal];
        [_buyBtn setBackgroundImage:[UIImage imageWithColor:kRGB_COLOR(@"#888888")] forState:UIControlStateDisabled];
        [_buyBtn addTarget:self action:@selector(buyBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _buyBtn;;
}
- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self creatUI];
    }
    return self;
}
- (void)creatUI{
    self.backgroundColor = [UIColor whiteColor];
    UIView *line = [[UIView alloc]initWithFrame:CGRectMake(0, 0, self.width, 0.5)];
    line.backgroundColor = kRGB_COLOR(@"#DEDEDE");
    [self addSubview:line];
    
    UIStackView *stackV = [[UIStackView alloc] initWithFrame:CGRectMake(10, 5, self.width-20, self.height-10-kSafeAreaBottom)];
    stackV.axis = UILayoutConstraintAxisHorizontal;
    stackV.alignment = UIStackViewAlignmentCenter;
    stackV.distribution = UIStackViewDistributionFillProportionally;
    stackV.spacing = 10;
    stackV.backgroundColor = [UIColor whiteColor];
    [self addSubview:stackV];
    
    for (int i = 0; i < self.btnArr.count; i++) {
        NSDictionary *dic = self.btnArr[i];
        UIButton *btn = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 40, 40)];
        btn.tag = i;
        [btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];

        UIImageView *imgV = [[UIImageView alloc] init];
        imgV.contentMode = UIViewContentModeScaleAspectFit;
        [btn addSubview:imgV];
        imgV.image = [UIImage imageNamed:dic[@"image"]];
        [imgV mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(CGSizeMake(25, 25));
            make.centerX.equalTo(btn);
            make.top.equalTo(btn).offset(-3);
        }];
        
        UILabel *titleL = [[UILabel alloc] init];
        titleL.text = dic[@"title"];
        titleL.font = [UIFont systemFontOfSize:10];
        titleL.textColor = kRGB_COLOR(@"#666666");
        [btn addSubview:titleL];
        [titleL mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(btn);
            make.bottom.equalTo(btn).offset(3);
        }];

        [stackV addArrangedSubview:btn];
    }

    [stackV addArrangedSubview:self.shoppingTrolleyBtn];
    [stackV addArrangedSubview:self.buyBtn];

    
    
    
}
- (void)btnClick:(UIButton *)btn{
    if (self.delegate && [self.delegate respondsToSelector:@selector(CommodityDetailBottomViewBtnClick:index:)]) {
        [self.delegate CommodityDetailBottomViewBtnClick:self index:btn.tag];
    }
}
- (void)shoppingTrolleyBtnClick:(UIButton *)btn{
    if (self.delegate && [self.delegate respondsToSelector:@selector(CommodityDetailBottomViewShopCartBtnClick:)]) {
        [self.delegate CommodityDetailBottomViewShopCartBtnClick:self];
    }
}
- (void)buyBtnClick:(UIButton *)btn{
   if (self.delegate && [self.delegate respondsToSelector:@selector(CommodityDetailBottomViewBuyBtnClick:)]) {
        [self.delegate CommodityDetailBottomViewBuyBtnClick:self];
    }
}
@end
