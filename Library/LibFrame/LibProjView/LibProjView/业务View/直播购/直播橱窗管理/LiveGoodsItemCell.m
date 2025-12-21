//
//  LiveGoodsItemCell.m
//  LibProjView
//
//  Created by klc_sl on 2020/7/10.
//  Copyright © 2020 . All rights reserved.
//

#import "LiveGoodsItemCell.h"
#import <Masonry/Masonry.h>
#import <LibTools/LibTools.h>
#import <SDWebImage/SDWebImage.h>
#import <LibProjModel/ShopGoodsDTOModel.h>
#import <LibProjModel/HttpApiShopGoods.h>
#import <LibProjView/ZQAlterField.h>
#import <LibProjView/ForceAlertController.h>

@interface LiveGoodsItemCell ()

@property (nonatomic, weak)UIImageView *goodsIcon;

@property (nonatomic, weak)UILabel *goodsNameL;

@property (nonatomic, weak)UILabel *priceL;

@property (nonatomic, weak)UIButton *numBtn;

@property (nonatomic, weak)UIButton *selectBtn;

@end

@implementation LiveGoodsItemCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

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
        [selectBtn addTarget:self action:@selector(setLiveOnline:) forControlEvents:UIControlEventTouchUpInside];
        [self.contentView addSubview:selectBtn];
        _selectBtn = selectBtn;
        
        ///排序文字框
        UIButton *numBtn = [UIButton buttonWithType:0];
        numBtn.layer.masksToBounds = YES;
        [numBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        numBtn.titleLabel.font = [UIFont systemFontOfSize:13];
        numBtn.layer.borderColor = kRGB_COLOR(@"#AAAAAA").CGColor;
        numBtn.layer.borderWidth = 1.0f;
        [numBtn addTarget:self action:@selector(setGoodsSort:) forControlEvents:UIControlEventTouchUpInside];
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

///排序
- (void)setGoodsSort:(UIButton *)btn{
    ZQAlterField *alert = [ZQAlterField alertView];
    alert.title = kLocalizationMsg(@"请输入序号");
    alert.textField.keyboardType = UIKeyboardTypeNumberPad;
    alert.styleType = noRegCodeStyle;
    alert.Maxlength = 20;
    [alert show];
    kWeakSelf(self);
    kWeakSelf(alert);
    [alert ensureClickBlock:^(NSString *inputString) {
        [weakself changeSort:inputString];
        [weakalert dismiss];
    }];
    [alert cancelClickBlock:^{
        [weakalert dismiss];
    }];
    

}
- (void)changeSort:(NSString *)sortStr{
    __block int sort = [sortStr intValue];;
    kWeakSelf(self);
    [HttpApiShopGoods updateLiveGoodsSort:_goods.goodsId sort:sort callback:^(int code, NSString *strMsg, HttpNoneModel *model) {
        if (code == 1) {
            dispatch_async(dispatch_get_main_queue(), ^{
                weakself.goods.liveSort = sort;
                [weakself.numBtn setTitle:[NSString stringWithFormat:@"%d",sort] forState:UIControlStateNormal];
            });
        }else{
            [SVProgressHUD showInfoWithStatus:strMsg];
        }
    }];
}

///设置直播商品
- (void)setLiveOnline:(UIButton *)btn{
    if (_goods) {
        kWeakSelf(self);
        [HttpApiShopGoods saveLiveGoods:_goods.goodsId optType:self.goods.checked?2:1 sort:_goods.liveSort callback:^(int code, NSString *strMsg, HttpNoneModel *model) {
            if (code == 1) {
                dispatch_async(dispatch_get_main_queue(), ^{
                    weakself.goods.checked = weakself.goods.checked?0:1;
                    weakself.selectBtn.selected = weakself.goods.checked?YES:NO;
                });
            }else{
                [SVProgressHUD showInfoWithStatus:strMsg];
            }
        }];
    }
}

@end
