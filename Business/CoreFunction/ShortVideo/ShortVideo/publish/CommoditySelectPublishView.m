//
//  CommoditySelectPublishView.m
//  ShortVideo
//
//  Created by klc_sl on 2021/6/19.
//  Copyright © 2021 KLC. All rights reserved.
//

#import "CommoditySelectPublishView.h"
#import <LibProjModel/ShopGoodsDTOModel.h>
#import <LibProjView/LiveGoodsManagerView.h>

@interface CommoditySelectPublishView()<UIGestureRecognizerDelegate>

@property (nonatomic, weak)UIView *shopView;
@property (nonatomic, weak)UIView *shopShadowView;
@property (nonatomic,weak)UIButton *selectBtn;

@property (nonatomic, weak)UIView *contentView;


@end



@implementation CommoditySelectPublishView

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self createBaseUI];
    }
    return self;
}

- (void)createBaseUI{
    
    UIView *shadowView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.width, 50)];
    shadowView.layer.cornerRadius = 5.0;
    shadowView.layer.borderWidth = 1.5f;
    shadowView.layer.borderColor = [UIColor whiteColor].CGColor;
    shadowView.layer.shadowColor = [UIColor blackColor].CGColor;
    shadowView.layer.shadowOffset = CGSizeMake(0.0, 0.0);
    shadowView.layer.shadowRadius = 4.0;
    shadowView.layer.shadowOpacity = 0.5f;
    self.shopShadowView = shadowView;
    [self addSubview:shadowView];

    ///内容
    UIView *contentV = [[UIView alloc] init];
    contentV.layer.cornerRadius = 5;
    contentV.clipsToBounds = YES;
    contentV.backgroundColor = [UIColor whiteColor];
    [self addSubview:contentV];
    _contentView = contentV;
    [contentV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.bottom.equalTo(shadowView);
    }];
    
    UIButton *headerV = [UIButton buttonWithType:0];
    headerV.frame = CGRectMake(0, 0, shadowView.width, 50);
    [headerV addTarget:self action:@selector(selectBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [contentV addSubview:headerV];
    
    UILabel *tLabel = [[UILabel alloc]initWithFrame:CGRectMake(10, 10, headerV.width-60, 30)];
    tLabel.userInteractionEnabled = NO;
    tLabel.textColor = kRGB_COLOR(@"#333333");
    tLabel.font = [UIFont systemFontOfSize:13];
    tLabel.textAlignment = NSTextAlignmentLeft;
    tLabel.text = kLocalizationMsg(@"关联同款商品");
    [headerV addSubview:tLabel];
    
    UIButton *selectGoodsBtn = [UIButton buttonWithType:0];
    selectGoodsBtn.frame = CGRectMake(tLabel.maxX, 5, 40, 40);
    [selectGoodsBtn setImage:[UIImage imageNamed:@"shopCart_mark_normal"] forState:UIControlStateNormal];
    [selectGoodsBtn setImage:[UIImage imageNamed:@"shopCart_mark_selected"] forState:UIControlStateSelected];
    [selectGoodsBtn setContentEdgeInsets:UIEdgeInsetsMake(10, 10, 10, 10)];
    [headerV addSubview:selectGoodsBtn];
    [selectGoodsBtn addTarget:self action:@selector(selectGoodBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    _selectBtn = selectGoodsBtn;
    
    _selectGoods = NO;
    _selectBtn.selected = NO;
}


- (void)changeShowCommodity{
    
    [self.shopView removeAllSubViews];
    [self.shopView removeFromSuperview];
    
    if (self.goodsModel) {
        
        UIView *shopV = [[UIView alloc]initWithFrame:CGRectMake(10, 51, 180, 70)];
        shopV.backgroundColor = kRGB_COLOR(@"#EEEEEE");
        shopV.layer.cornerRadius = 5;
        shopV.clipsToBounds = YES;
        self.shopView  = shopV;
        [self.contentView addSubview:shopV];
        
        UIImageView *goodImageV = [[UIImageView alloc]initWithFrame:CGRectMake(10, 10, 50, 50)];
        NSArray *arr = [self.goodsModel.goodsPicture componentsSeparatedByString:@","];
        goodImageV.contentMode = UIViewContentModeScaleAspectFill;
        goodImageV.clipsToBounds = YES;
        [goodImageV sd_setImageWithURL:[NSURL URLWithString:arr.firstObject] placeholderImage:[ProjConfig getDefaultImage]];
        [shopV addSubview:goodImageV];
        
        UILabel *goodNameL = [[UILabel alloc]initWithFrame:CGRectMake(65, 10, 85, 20)];
        goodNameL.textColor = kRGB_COLOR(@"#333333");
        goodNameL.font = [UIFont systemFontOfSize:14];
        goodNameL.textAlignment = NSTextAlignmentLeft;
        goodNameL.text = self.goodsModel.goodsName;
        [shopV addSubview:goodNameL];
        
        UILabel *pricel = [[UILabel alloc]initWithFrame:CGRectMake(65, 40, 85, 20)];
        pricel.textColor = kRGB_COLOR(@"#999999");
        pricel.font = [UIFont systemFontOfSize:11];
        pricel.textAlignment = NSTextAlignmentLeft;
        pricel.text = [NSString stringWithFormat:@" ¥%.2f",self.goodsModel.favorablePrice>0?self.goodsModel.favorablePrice:self.goodsModel.price];
        [shopV addSubview:pricel];
        
        UIButton *removeBtn = [[UIButton alloc]initWithFrame:CGRectMake(150, 0, 28, 28)];
        [removeBtn setImage:[UIImage imageNamed:@"present_close"] forState:UIControlStateNormal];
        [removeBtn addTarget:self action:@selector(removeBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        [shopV addSubview:removeBtn];
        
        self.shopShadowView.height = 135;
        
    }else{
        
        self.shopShadowView.height = 50;

    }
}

- (void)setGoodsModel:(ShopGoodsDTOModel *)goodsModel {
    _goodsModel = goodsModel;
    kWeakSelf(self);
    dispatch_async(dispatch_get_main_queue(), ^{
        [weakself changeShowCommodity];
    });
}

- (void)setSelectGoods:(BOOL)selectGoods{
    _selectGoods = selectGoods;
    _selectBtn.selected = _selectGoods;
}

- (void)selectGoodBtnClick:(UIButton *)btn{
    self.selectGoods = !self.selectGoods;
}




- (void)selectBtnClick:(UIButton *)btn{
    kWeakSelf(self);
    [LiveGoodsManagerView showGoodsListType:GoodsManagerTypeShortVideo selectedModel:self.goodsModel CallBack:^(BOOL close, ShopGoodsDTOModel * _Nonnull model) {
        weakself.goodsModel = model;
        weakself.selectGoods = YES;
    }];
}


- (void)removeBtnClick:(UIButton *)btn{
    self.goodsModel = nil;
}

@end
