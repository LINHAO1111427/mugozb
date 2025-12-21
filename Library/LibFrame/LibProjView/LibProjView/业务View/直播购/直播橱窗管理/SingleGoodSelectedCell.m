//
//  SingleGoodSelectedCell.m
//  LibProjView
//
//  Created by ssssssss on 2020/10/20.
//  Copyright © 2020 KLC. All rights reserved.
//

#import "SingleGoodSelectedCell.h"
#import <Masonry/Masonry.h>
#import <LibTools/LibTools.h>
#import <SDWebImage/SDWebImage.h>
#import <LibProjModel/ShopGoodsDTOModel.h>
#import <LibProjModel/HttpApiShopGoods.h>
#import <LibProjView/ForceAlertController.h>

@interface SingleGoodSelectedCell ()

@property (nonatomic, weak)UIImageView *goodsIcon;

@property (nonatomic, weak)UILabel *goodsNameL;

@property (nonatomic, weak)UILabel *priceL;

@property (nonatomic, weak)UIButton *numBtn;

@property (nonatomic, weak)UIButton *selectBtn;

@end


@implementation SingleGoodSelectedCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
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
        [selectBtn setImage:[UIImage imageNamed:@"live_goods_normal"] forState:UIControlStateNormal];
        [selectBtn setImage:[UIImage imageNamed:@"live_goods_select"] forState:UIControlStateSelected];
        [selectBtn setImageEdgeInsets:UIEdgeInsetsMake(5, 5, 5, 5)];
        [selectBtn addTarget:self action:@selector(selctedGoods:) forControlEvents:UIControlEventTouchUpInside];
        [self.contentView addSubview:selectBtn];
        _selectBtn = selectBtn;
        
        ///排序文字框
        UIButton *numBtn = [UIButton buttonWithType:0];
        numBtn.layer.masksToBounds = YES;
        [numBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        numBtn.titleLabel.font = [UIFont systemFontOfSize:13];
        numBtn.layer.borderColor = kRGB_COLOR(@"#AAAAAA").CGColor;
        numBtn.layer.borderWidth = 1.0f;
        [self.contentView addSubview:numBtn];
        _numBtn = numBtn;
        
        [icon mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(CGSizeMake(80, 80));
            make.centerY.equalTo(self);
            make.left.equalTo(self).mas_offset(12);
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
            make.bottom.equalTo(numBtn);
            make.right.equalTo(numBtn.mas_left).mas_offset(-10);
        }];
        
        [selectBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(CGSizeMake(30, 30));
            make.centerY.equalTo(numBtn);
            make.right.equalTo(self).mas_offset(-12);
        }];
        
        [numBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(CGSizeMake(44, 24));
            make.centerY.equalTo(selectBtn);
            make.bottom.equalTo(icon);
            make.right.equalTo(selectBtn.mas_left).mas_offset(-7);
        }];
        [numBtn layoutIfNeeded];
        numBtn.layer.cornerRadius = numBtn.height/2.0;
        numBtn.hidden = YES;
        
    }
    return _goodsIcon;
}

- (void)setGoods:(ShopGoodsDTOModel *)goods{
    _goods = goods;
    
    NSString *picStr = @"";
    if (goods.goodsPicture.length > 0) {
        picStr = [goods.goodsPicture componentsSeparatedByString:@","].firstObject;
    }
    [self.goodsIcon sd_setImageWithURL:[NSURL URLWithString:picStr]];
    _goodsNameL.text = goods.goodsName;
    _priceL.text = [NSString stringWithFormat:@"%0.2lf",goods.favorablePrice>0?goods.favorablePrice:goods.price];
    [_numBtn setTitle:[NSString stringWithFormat:@"%d",goods.liveSort] forState:UIControlStateNormal];
    _selectBtn.selected = goods.checked?YES:NO;
    
}
 
- (void)selctedGoods:(UIButton *)btn{
    if (self.delegate && [self.delegate respondsToSelector:@selector(SingleGoodSelectedCellDidSelected:)]) {
        [self.delegate SingleGoodSelectedCellDidSelected:self.goods];
    }
}
@end
