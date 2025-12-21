//
//  LiveShoppingAccrossCell.m
//  LiveCommon
//
//  Created by klc_sl on 2020/7/4.
//  Copyright © 2020 . All rights reserved.
//

#import "LiveShoppingAccrossCell.h"
#import <Masonry/Masonry.h>
#import <LibTools/LibTools.h>
#import <SDWebImage/SDWebImage.h>
#import <LibProjBase/LibProjBase.h>
#import <LibProjModel/ShopLiveGoodsModel.h>

@implementation LiveShoppingAccrossCell

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self createUI];
    }
    return self;
}

- (void)createUI{
    
    UIImageView *img = [[UIImageView alloc] init];
    img.contentMode = UIViewContentModeScaleAspectFill;
    img.clipsToBounds = YES;
    img.layer.masksToBounds = YES;
    img.userInteractionEnabled = YES;
    [self.contentView addSubview:img];
    _imageV = img;
    
    [img mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(self.width, self.width));
        make.top.left.equalTo(self);
    }];
    [img layoutIfNeeded];
    img.layer.cornerRadius = 4.0;
    
    
    UIButton *stateBtn = [UIButton buttonWithType:0];
    stateBtn.layer.masksToBounds = YES;
    stateBtn.hidden = YES;
    [stateBtn setTitle:kLocalizationMsg(@"讲TA") forState:UIControlStateNormal];
    [stateBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [stateBtn setBackgroundColor:kRGBA_COLOR(@"#E23A39", 0.8)];
    stateBtn.titleLabel.font = [UIFont systemFontOfSize:11];
    [img addSubview:stateBtn];
    _stateBtn = stateBtn;
    
    UILabel *titleL = [[UILabel alloc] init];
    titleL.textAlignment = NSTextAlignmentCenter;
    titleL.font = [UIFont systemFontOfSize:12];
    titleL.textColor = [UIColor blackColor];
    [self.contentView addSubview:titleL];
    _titleL = titleL;
    
    UILabel *priceL = [[UILabel alloc] init];
    priceL.font = [UIFont systemFontOfSize:12];
    priceL.textColor = kRGB_COLOR(@"#FB0035");
    [self.contentView addSubview:priceL];
    priceL.textAlignment = NSTextAlignmentCenter;
    _priceL = priceL;
    
    [stateBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(25);
        make.left.right.bottom.equalTo(img);
    }];
    
    [stateBtn layoutIfNeeded];
    stateBtn.layer.cornerRadius = stateBtn.height/2.0;
    
    [priceL mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.left.right.equalTo(self);
        make.height.mas_equalTo(15);
        make.top.equalTo(titleL.mas_bottom).mas_offset(4);
    }];
    
    [titleL mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self);
    }];
    
}


- (void)showGoods:(ShopLiveGoodsModel *)goods{
    NSString *picStr = @"";
    if (goods.goodsPicture.length > 0) {
        picStr = [goods.goodsPicture componentsSeparatedByString:@","].firstObject;
    }
    [self.imageV sd_setImageWithURL:[NSURL URLWithString:picStr]];
    self.titleL.text = goods.name;
    self.priceL.text = [NSString stringWithFormat:@"¥ %0.2lf",goods.favorablePrice>0?goods.favorablePrice:goods.goodsPrice];
    if (goods.idExplain) {
        [_stateBtn setTitle:kLocalizationMsg(@"讲解中") forState:UIControlStateNormal];
        [_stateBtn setBackgroundColor:kRGBA_COLOR(@"#FF8503", 0.8)];
    }else{
        [_stateBtn setTitle:kLocalizationMsg(@"讲TA") forState:UIControlStateNormal];
        [_stateBtn setBackgroundColor:kRGBA_COLOR(@"#E23A39", 0.8)];
    }
}





@end
