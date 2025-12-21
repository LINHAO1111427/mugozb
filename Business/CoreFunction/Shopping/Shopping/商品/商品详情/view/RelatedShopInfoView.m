//
//  RelatedShopInfoView.m
//  Shopping
//
//  Created by klc on 2020/7/8.
//  Copyright © 2020 klc. All rights reserved.
//

#import "RelatedShopInfoView.h"
#import <LibProjModel/ShopGoodsDTOModel.h>
#import <LibProjView/ScrollviewGuideBar.h>
 
@interface RelatedShopInfoView ()<UIScrollViewDelegate>
@property (nonatomic, strong)UIButton *shopAvaterBtn;//头像
@property (nonatomic, strong)UILabel *shopNameLabel;//店铺名称
@property (nonatomic, strong)UILabel *shopSaleInfoLabel;//销售信息
@property (nonatomic, strong)UIView *tagView;//标签
@property(nonatomic,strong)ScrollviewGuideBar *guideBar;
@property (nonatomic, strong)UIScrollView *commodityScrllV;//商品列表
@end

@implementation RelatedShopInfoView

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
- (void)layoutSubviews{
    [super layoutSubviews];
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
    
    self.guideBar = [[ScrollviewGuideBar alloc]initWithFrame:CGRectMake(0, self.height-15, 30, 3) barColor:kRGB_COLOR(@"#FF8503") backColor:kRGB_COLOR(@"#EEEEEE")];
    self.guideBar.centerX = self.width/2.0;
    [self addSubview:self.guideBar];
    [self.guideBar mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(30, 3));
        make.centerX.equalTo(self);
        make.bottom.equalTo(self).inset(10);
    }];
    
    self.commodityScrllV = [[UIScrollView alloc]initWithFrame:CGRectMake(0, _tagView.maxY+10, self.width, 0)];
    self.commodityScrllV.backgroundColor = [UIColor whiteColor];
    self.commodityScrllV.showsHorizontalScrollIndicator = NO;
    self.commodityScrllV.delegate = self;
    [self addSubview:self.commodityScrllV];
    [self.commodityScrllV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self);
        make.top.equalTo(self.tagView.mas_bottom).inset(10);
        make.bottom.equalTo(self.guideBar.mas_top).inset(5);
    }];
}

- (void)setDetailModel:(ShopGoodsDetailDTOModel *)detailModel{
    _detailModel = detailModel;
    [self.shopAvaterBtn sd_setImageWithURL:[NSURL URLWithString:detailModel.businessLogo] forState:UIControlStateNormal placeholderImage:[ProjConfig getDefaultImage]];
    self.shopNameLabel.text = detailModel.businessName;
    NSString *num1 = 0,*num2 = 0;
    if (detailModel.effectiveGoodsNum > 10000) {
        num1 = [NSString stringWithFormat:kLocalizationMsg(@"%.1f万"),detailModel.effectiveGoodsNum/10000.0];
    }else{
        num1 = [NSString stringWithFormat:@"%d",detailModel.effectiveGoodsNum];
    }
    if (detailModel.totalSoldNum > 10000) {
        num2 = [NSString stringWithFormat:kLocalizationMsg(@"%.1f万"),detailModel.totalSoldNum/10000.0];
    }else{
        num2 = [NSString stringWithFormat:@"%d",detailModel.totalSoldNum];
    }
    self.shopSaleInfoLabel.text = [NSString stringWithFormat:kLocalizationMsg(@"在售商品%@ | 累计销量%@"),num1,num2];
    
    [self.commodityScrllV removeAllSubViews];
    
    if (detailModel.shopGoodsDTOS.count > 0) {
        CGFloat scaleShopCommodity = 100/360.0;
        CGFloat widthG = scaleShopCommodity*self.width;
        CGFloat margin = (self.width-3*widthG)/4.0;
        for (int i = 0; i < detailModel.shopGoodsDTOS.count; i++) {
            
            ShopGoodsDTOModel *goods = detailModel.shopGoodsDTOS[i];
            
            UIButton *itemV = [UIButton buttonWithType:0];
            itemV.backgroundColor = [UIColor whiteColor];
            itemV.tag = i;
            [itemV addTarget:self action:@selector(commodityBtnClick:) forControlEvents:UIControlEventTouchUpInside];
            [self.commodityScrllV addSubview:itemV];
            [itemV mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.equalTo(self.commodityScrllV).inset(10);
                make.left.equalTo(self.commodityScrllV).offset(margin+(margin+widthG)*i);
                make.width.mas_equalTo(widthG);
            }];
            
            UIImageView *imagev = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, widthG, widthG)];
            imagev.contentMode = UIViewContentModeScaleAspectFill;
            imagev.clipsToBounds = YES;
            imagev.layer.masksToBounds = YES;
            imagev.layer.cornerRadius = 5;
            NSArray *arr = [goods.goodsPicture componentsSeparatedByString:@","];
            [imagev sd_setImageWithURL:[NSURL URLWithString:arr.firstObject] placeholderImage:[ProjConfig getDefaultImage]];
            [itemV addSubview:imagev];
            [imagev mas_makeConstraints:^(MASConstraintMaker *make) {
                make.size.mas_equalTo(CGSizeMake(widthG, widthG));
                make.top.left.equalTo(itemV);
            }];
            
            UILabel *nameLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, imagev.maxY, widthG, self.nameH)];
            nameLabel.textColor = kRGB_COLOR(@"#2B2C2C");
            nameLabel.font = [UIFont systemFontOfSize:13];
            nameLabel.textAlignment = NSTextAlignmentLeft;
            nameLabel.text = goods.goodsName;
            nameLabel.numberOfLines = 0;
            [nameLabel setContentHuggingPriority:UILayoutPriorityRequired forAxis:UILayoutConstraintAxisHorizontal];
            [nameLabel setContentCompressionResistancePriority:UILayoutPriorityRequired forAxis:UILayoutConstraintAxisHorizontal];
            [itemV addSubview:nameLabel];
            [nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.right.equalTo(imagev);
                make.top.equalTo(imagev.mas_bottom).offset(10);
            }];
            
            UILabel *priceLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, nameLabel.maxY, widthG, 20)];
            priceLabel.textAlignment = NSTextAlignmentLeft;
            priceLabel.font = [UIFont boldSystemFontOfSize:15];
            priceLabel.textColor = kRGB_COLOR(@"#FB0035");
            priceLabel.attributedText = [self getPriceAttriStrWithPrice:goods.price favorablePrice:goods.favorablePrice];
            [nameLabel setContentHuggingPriority:UILayoutPriorityDefaultHigh forAxis:UILayoutConstraintAxisHorizontal];
            [nameLabel setContentCompressionResistancePriority:UILayoutPriorityDefaultHigh  forAxis:UILayoutConstraintAxisHorizontal];
            [itemV addSubview:priceLabel];
            [priceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.right.equalTo(nameLabel);
                make.top.equalTo(nameLabel.mas_bottom).offset(10);
                make.bottom.equalTo(itemV);
            }];
        }
        self.guideBar.hidden = NO;
        self.commodityScrllV.contentSize = CGSizeMake((widthG+margin)*detailModel.shopGoodsDTOS.count+margin, 0);
        self.guideBar.rate = 1.0*self.width/self.commodityScrllV.contentSize.width;
    }else{
        self.guideBar.hidden = YES;
    }
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
    [attri addAttributes:@{NSFontAttributeName:[UIFont boldSystemFontOfSize:15],NSForegroundColorAttributeName:kRGB_COLOR(@"#FB0035")} range:NSMakeRange(1, str.length)];
    return attri;
}

- (void)commodityBtnClick:(UIButton *)btn{
    ShopGoodsDTOModel *goods = self.detailModel.shopGoodsDTOS[btn.tag];
    if (self.delegate && [self.delegate respondsToSelector:@selector(RelatedShopInfoViewCommodityClick:commodity:)]) {
       [self.delegate RelatedShopInfoViewCommodityClick:self commodity:goods];
    }
}
- (void)shopAvaterBtnClick:(UIButton *)btn{
    ShopGoodsModel *model =  self.detailModel.shopGoods;
    if (self.delegate && [self.delegate respondsToSelector:@selector(RelatedShopInfoViewShopClick:shopId:)]) {
       [self.delegate RelatedShopInfoViewShopClick:self shopId:model.businessId];
    }
}

#pragma mark - UIScrollViewDelegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    if (scrollView == self.commodityScrllV) {
        CGFloat scrollW = scrollView.width;
        CGFloat contentW = scrollView.contentSize.width;
        CGFloat x = scrollView.contentOffset.x;
        CGFloat value = x/(contentW -scrollW);
        self.guideBar.value = value;
    }
}
@end
