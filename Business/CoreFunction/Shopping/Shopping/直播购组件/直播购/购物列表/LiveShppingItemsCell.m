//
//  LiveShppingItemsCell.m
//  LiveCommon
//
//  Created by klc_sl on 2020/7/4.
//  Copyright © 2020 . All rights reserved.
//

#import "LiveShppingItemsCell.h"
#import <Masonry/Masonry.h>
#import <LibTools/LibTools.h>
#import <SDWebImage/SDWebImage.h>
#import <LibProjModel/ShopLiveGoodsModel.h>
#import <LibProjModel/HttpApiShopGoods.h>
#import <LibProjView/ForceAlertController.h>


@interface LiveShppingItemsCell ()

@property (nonatomic, weak)UIImageView *goodsIcon;

@property (nonatomic, weak)UILabel *goodsNameL;

@property (nonatomic, weak)UILabel *priceL;


@end

@implementation LiveShppingItemsCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    return self;
}

- (UIImageView *)goodsIcon{
    if (!_goodsIcon) {
        ///商品图片
        UIImageView *icon = [[UIImageView alloc] init];
        icon.layer.masksToBounds = YES;
        icon.contentMode = UIViewContentModeScaleAspectFill;
        [self.contentView addSubview:icon];
        _goodsIcon = icon;
        
        ///商品名称
        UILabel *titleLab = [[UILabel alloc] init];
        titleLab.font = [UIFont systemFontOfSize:14];
        titleLab.textColor = [UIColor blackColor];
        titleLab.numberOfLines = 2;
        [self.contentView addSubview:titleLab];
        _goodsNameL = titleLab;
        
        ///金币占位
        UILabel *YLab = [[UILabel alloc] init];
        YLab.font = [UIFont systemFontOfSize:10];
        YLab.textColor = [UIColor redColor];
        [self.contentView addSubview:YLab];
        YLab.text = @"¥";
        
        ///价位
        UILabel *priceLab = [[UILabel alloc] init];
        priceLab.font = [UIFont systemFontOfSize:14];
        priceLab.textColor = [UIColor redColor];
        [self.contentView addSubview:priceLab];
        _priceL = priceLab;
        
        UIButton *selectBtn = [UIButton buttonWithType:0];
        [selectBtn setBackgroundColor:kRGB_COLOR(@"#FF5500")];
        [selectBtn setTitle:kLocalizationMsg(@"去购买") forState:UIControlStateNormal];
        selectBtn.titleLabel.font = [UIFont systemFontOfSize:14];
        [selectBtn addTarget:self action:@selector(selectBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        [selectBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [self.contentView addSubview:selectBtn];
        _selectBtn = selectBtn;
        
        
        [icon mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(CGSizeMake(80, 80));
            make.centerY.equalTo(self);
            make.left.equalTo(self).mas_offset(15);
        }];
        [icon layoutIfNeeded];
        icon.layer.cornerRadius = 3.0;
        
        [titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(icon.mas_right).mas_offset(14);
            make.top.equalTo(icon);
            make.right.equalTo(self).mas_offset(-12);
        }];
        
        [YLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(titleLab);
            make.bottom.equalTo(priceLab);
            make.width.mas_equalTo(10);
        }];
        
        [priceLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(YLab.mas_right).mas_offset(2);
            make.bottom.equalTo(selectBtn);
            make.right.equalTo(selectBtn.mas_left).mas_offset(-10);
        }];
        
        [selectBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(CGSizeMake(90, 30));
            make.right.equalTo(self).mas_offset(-15);
            make.bottom.equalTo(icon);
        }];
        
        [selectBtn layoutIfNeeded];
        selectBtn.layer.cornerRadius = selectBtn.height/2.0;
        
    }
    return _goodsIcon;
}


- (void)setGoods:(ShopLiveGoodsModel *)goods{
    _goods = goods;
    
    NSString *picStr = @"";
    if (goods.goodsPicture.length > 0) {
        picStr = [goods.goodsPicture componentsSeparatedByString:@","].firstObject;
    }
    [self.goodsIcon sd_setImageWithURL:[NSURL URLWithString:picStr]];
    _goodsNameL.text = goods.name;
    _priceL.text = [NSString stringWithFormat:@"%0.2lf",goods.favorablePrice>0?goods.favorablePrice:goods.goodsPrice];
    

}
- (void)selectBtnClick:(UIButton *)btn{
    if (self.deleagte && [self.deleagte respondsToSelector:@selector(LiveShppingItemsCellGotoBuy:)]) {
        [self.deleagte LiveShppingItemsCellGotoBuy:self.goods];//去购买
    }
}


@end
