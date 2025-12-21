//
//  ShortVideoShopPlayView.m
//  LibProjView
//
//  Created by ssssssss on 2020/10/20.
//  Copyright © 2020 KLC. All rights reserved.
//

#import "ShortVideoShopPlayView.h"
#import <LibProjModel/ApiShortVideoDtoModel.h>
#import <LibProjModel/HttpApiShopGoods.h>
#import <LibProjModel/ShopGoodsModel.h>
 
@interface ShortVideoShopPlayView()
@property (nonatomic, copy)ShortVideoShopPlayViewCallback callBack;
@property (nonatomic, strong)ShopGoodsModel *model;

@property (nonatomic, weak)UIButton *infoBgV;

@end

@implementation ShortVideoShopPlayView

+ (void)showInSuperV:(UIView *)superV level:(int)level modelWith:(ApiShortVideoDtoModel *)commodityModel pointY:(CGFloat)pointY callBack:(nonnull ShortVideoShopPlayViewCallback)callBack{
    for (UIView *view in superV.subviews) {
        if ([view isKindOfClass:[ShortVideoShopPlayView class]]) {
            [view removeAllSubViews];
            [view removeFromSuperview];
            break;
        }
    }
    [HttpApiShopGoods getShopGoods:commodityModel.productId callback:^(int code, NSString *strMsg, ShopGoodsModel *model) {
        if (code == 1) {
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                ShortVideoShopPlayView *ShowV = [[ShortVideoShopPlayView alloc] initWithFrame:superV.bounds];
                ShowV.model = model;
                ShowV.callBack = callBack;
                [superV addSubview:ShowV];
                [superV insertSubview:ShowV atIndex:level+1];
                [ShowV createUI:pointY videoDtoModel:commodityModel];
            });
        }else{
            [SVProgressHUD showInfoWithStatus:strMsg];
        }
    }];
}

- (void)createUI:(CGFloat)pointY videoDtoModel:(ApiShortVideoDtoModel *)commodityModel{
    
    self.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.2];

    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapMineView)];
    [self addGestureRecognizer:tap];
    
    UIButton *showView = [UIButton buttonWithType:0];
    showView.frame=CGRectMake(12, pointY, kScreenWidth/2.0+30, 100);
    showView.backgroundColor = kRGB_COLOR(@"#F4F4F4");
    showView.layer.cornerRadius = 5;
    showView.clipsToBounds = YES;
    [showView addTarget:self action:@selector(shopInfoBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:showView];
    _infoBgV = showView;
    
    UILabel *titleL = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, showView.width, 40)];
    titleL.textColor = kRGB_COLOR(@"#666666");
    titleL.font = [UIFont systemFontOfSize:12];
    titleL.textAlignment = NSTextAlignmentCenter;
    if (commodityModel.type == 1) {
        titleL.text = kLocalizationMsg(@"视频中的同款商品");
    }else{
        titleL.text = kLocalizationMsg(@"图中的同款商品");
    }
    [showView addSubview:titleL];
    UIButton *closeBtn = [[UIButton alloc]initWithFrame:CGRectMake(showView.width-30, 0, 30, 30)];
    [closeBtn setImage:[UIImage imageNamed:@"main_close_jinshan"] forState:UIControlStateNormal];
    [closeBtn setContentEdgeInsets:UIEdgeInsetsMake(8, 8, 8, 8)];
    [closeBtn addTarget:self action:@selector(closeBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [showView addSubview:closeBtn];
    
    UIImageView *goodsImageV = [[UIImageView alloc]initWithFrame:CGRectMake(10, 40, 50, 50)];
    goodsImageV.contentMode = UIViewContentModeScaleAspectFill;
    goodsImageV.clipsToBounds = YES;
    goodsImageV.layer.masksToBounds = YES;
    goodsImageV.layer.cornerRadius = 4.0;
    NSArray *picArr = [self.model.goodsPicture componentsSeparatedByString:@","];
    [goodsImageV sd_setImageWithURL:[NSURL URLWithString:picArr.firstObject] placeholderImage:[ProjConfig getDefaultImage]];
    [showView addSubview:goodsImageV];
    
    UILabel *nameL = [[UILabel alloc]initWithFrame:CGRectMake(goodsImageV.maxX+5, 40, 135, 35)];
    nameL.textColor = kRGB_COLOR(@"#333333");
    nameL.font = [UIFont systemFontOfSize:14];
    nameL.textAlignment = NSTextAlignmentLeft;
    nameL.numberOfLines = 2;
    nameL.text = self.model.goodsName;
    [showView addSubview:nameL];
    
    UILabel *numL = [[UILabel alloc]initWithFrame:CGRectMake(goodsImageV.maxX+5, nameL.maxY, 65, 15)];
    numL.text = [NSString stringWithFormat:kLocalizationMsg(@"已售出%d"),self.model.soldNum];
    numL.textColor = kRGB_COLOR(@"#999999");
    numL.font = [UIFont systemFontOfSize:11];
    numL.textAlignment = NSTextAlignmentLeft;
    [showView addSubview:numL];
    
    UILabel *favoritePriceL = [[UILabel alloc] initWithFrame:CGRectMake(numL.maxX, numL.y, showView.width-numL.maxX-3, 15)];
    favoritePriceL.textColor = [UIColor redColor];
    favoritePriceL.font = [UIFont systemFontOfSize:11];
    favoritePriceL.textAlignment = NSTextAlignmentRight;
    favoritePriceL.text = [NSString stringWithFormat:@"￥%.2f",self.model.favorablePrice > 0?self.model.favorablePrice:self.model.price];
    [showView addSubview:favoritePriceL];
    
    if (self.model.favorablePrice > 0) {
        UILabel *priceL = [[UILabel alloc]initWithFrame:CGRectMake(numL.maxX, favoritePriceL.y-15, showView.width-numL.maxX-5, 15)];
        priceL.textColor = kRGB_COLOR(@"#CCCCCC");
        priceL.textAlignment = NSTextAlignmentRight;
        NSString *price = [NSString stringWithFormat:@"￥%.2f",self.model.price];
        NSMutableAttributedString *muttstr = [[NSMutableAttributedString alloc]initWithString:price];
        [muttstr addAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:8],NSForegroundColorAttributeName:kRGB_COLOR(@"#CCCCCC"),NSStrikethroughStyleAttributeName:@(NSUnderlineStyleSingle)} range:NSMakeRange(0, price.length)];
        priceL.attributedText = muttstr;
        [showView addSubview:priceL];
    }
}


- (void)closeBtnClick:(UIButton *)btn{
    [self removeAllSubViews];
    [self removeFromSuperview];
    self.callBack?self.callBack(NO,self):nil;

}

- (void)tapMineView{
    [self removeAllSubViews];
    [self removeFromSuperview];
    self.callBack?self.callBack(NO,self):nil;
}

- (void)shopInfoBtnClick{
    [self removeAllSubViews];
    [self removeFromSuperview];
    self.callBack?self.callBack(YES,self):nil;
}


@end
