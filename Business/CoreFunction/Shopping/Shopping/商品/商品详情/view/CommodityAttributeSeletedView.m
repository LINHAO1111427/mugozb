//
//  CommodityAttributeSeletedView.m
//  Shopping
//
//  Created by tctd on 2020/7/7.
//  Copyright © 2020 klc. All rights reserved.
//

#import "CommodityAttributeSeletedView.h"
#import "CommBuyNumView.h"
#import <LibProjView/FunctionSheetBaseView.h>
#import <LibProjModel/ShopAttrValueModel.h>

@interface CommodityAttributeSeletedView()
@property (nonatomic, strong)ShopGoodsDetailDTOModel *detailModel;
@property (nonatomic, strong) ShopAttrComposeModel *selectedModel;
@property (nonatomic, assign) NSInteger row1;
@property (nonatomic, assign) NSInteger row2;
@property (nonatomic, copy)AttributeSeletedCallback callBack;

@property (nonatomic, strong)UIImageView *imageV;
@property (nonatomic, strong)UILabel *priceLabel;//价格
@property (nonatomic, strong)UILabel *capacityLabel;//库存
@property (nonatomic, strong)UILabel *selectedLabel;//已经选择
@property (nonatomic, strong)UIView *attri_1_View;
@property (nonatomic, strong)UIView *attri_2_View;
@property (nonatomic, strong)ShopAttrValueModel *selectedAttriModel1;//选中的属性1
@property (nonatomic, strong)ShopAttrValueModel *selectedAttriModel2;//选中的属性2

@property (nonatomic, assign)int type;//0 普通 1购物车 2 购买
@property (nonatomic, strong)CommBuyNumView *buyView;//购买
@property (nonatomic, assign)int num;//数量

@property (nonatomic, strong)UIButton *shoppingTrolleyBtn;//购物车
@property (nonatomic, strong)UIButton *buyBtn;//支付
@end

@implementation CommodityAttributeSeletedView
 
+ (void)showInSuperV:(UIView *)superV with:(ShopGoodsDetailDTOModel *)detailModel selectedModel:(ShopAttrComposeModel *)selectedModel type:(int)type callBack:(AttributeSeletedCallback)callBack{
     
    __block  CommodityAttributeSeletedView *showView = [[CommodityAttributeSeletedView alloc]init];
    __block CGFloat height = [showView getAttributeRow:detailModel view:showView];
    showView.frame = CGRectMake(0, 0, kScreenWidth, height);
    showView.backgroundColor = [UIColor whiteColor];
    showView.selectedModel = selectedModel;
    showView.type = type;
    showView.callBack = callBack;
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:showView action:@selector(tap)];
    [showView addGestureRecognizer:tap];
    
    [showView addSubview:showView.imageV];
    [showView addSubview:showView.priceLabel];
    [showView addSubview:showView.capacityLabel];
    [showView addSubview:showView.selectedLabel];
    UIView *line = [[UIView alloc]initWithFrame:CGRectMake(0, showView.imageV.maxY+13, kScreenWidth, 0.5)];
    line.backgroundColor = kRGB_COLOR(@"#DEDEDE", 1.0);
    [showView addSubview:line];
    [showView addSubview:showView.attri_1_View];
    [showView addSubview:showView.attri_2_View];
    [showView addSubview:showView.buyView];
    showView.num = 1;
 
    kWeakSelf(showView);
    showView.buyView.callBack = ^(int num) {
        if (detailModel.attrDTOList.count > 0) {
            if (num > weakshowView.selectedModel.stock) {
                weakshowView.buyBtn.enabled = NO;
                weakshowView.shoppingTrolleyBtn.enabled = NO;
            }else{
                weakshowView.buyBtn.enabled = YES;
                weakshowView.shoppingTrolleyBtn.enabled = YES;
                weakshowView.callBack(NO, weakshowView.selectedModel, num,0,weakshowView.imageV,height);
            }
        }
    };
    if (type == 0) {
        [showView addSubview:showView.shoppingTrolleyBtn];
        [showView addSubview:showView.buyBtn];
    }else if(type == 1){
        [showView addSubview:showView.shoppingTrolleyBtn];
    }else if(type == 2){
        [showView addSubview:showView.buyBtn];
    }
    
    [FunctionSheetBaseView showView:showView cover:YES];
    //数据初始化
    showView.detailModel = detailModel;
}
- (CGFloat)getAttributeRow:(ShopGoodsDetailDTOModel *)detailModel view:(CommodityAttributeSeletedView *)showView{
    CGFloat h = 250.0f;
    if (detailModel.attrDTOList.count > 0) {
        ShopGoodsAttrDTOModel*model1 = detailModel.attrDTOList.firstObject;
        CGFloat x1 = 0.0f;
        for (ShopAttrValueModel *attriModel in model1.attrValueList) {
            CGSize size = [attriModel.name boundingRectWithSize:CGSizeMake(kScreenWidth-28, 20) options:1 attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:14]} context:nil].size;
            if (size.width+20 < 40) {
                x1 += 40+10;
            }else{
                x1 += size.width+20+10;
            }
        }
        int row1 = x1/(kScreenWidth-28)+1;
        showView.row1 = row1;
        h += (row1-1)*10+row1*30+60;
        
        if (detailModel.attrDTOList.count > 1) {
            ShopGoodsAttrDTOModel*model2 = detailModel.attrDTOList.lastObject;
            CGFloat x2 = 0.0f;
            for (ShopAttrValueModel *attriModel in model2.attrValueList) {
                CGSize size = [attriModel.name boundingRectWithSize:CGSizeMake(kScreenWidth-28, 20) options:1 attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:14]} context:nil].size;
                if (size.width+20 < 40) {
                    x2 += 40+10;
                }else{
                    x2 += size.width+20+10;
                }
            }
            int row2 = x2/(kScreenWidth-28)+1;
            showView.row2 = row2;
            h += (row2-1)*10+row2*30+60;
        }
    }
     
    return  h+kSafeAreaBottom;
}
- (void)tap{
    [self endEditing:YES];
}
- (void)setDetailModel:(ShopGoodsDetailDTOModel *)detailModel{
    _detailModel = detailModel;
    NSArray *arr = [detailModel.shopGoods.goodsPicture componentsSeparatedByString:@","];
    [self.imageV sd_setImageWithURL:[NSURL URLWithString:arr.firstObject] placeholderImage:[UIImage imageWithColor:[UIColor lightGrayColor]]];
    
    //价格库存选购
    NSMutableAttributedString *attri = [self getPriceAttriStrWithPrice:detailModel.shopGoods.price favorablePrice:detailModel.shopGoods.favorablePrice];
    self.priceLabel.attributedText = attri;
    self.capacityLabel.text = [NSString stringWithFormat:@"库存 %d 件",self.selectedModel.stock];
    if (self.selectedModel.name2.length > 0) {
        self.selectedLabel.text = [NSString stringWithFormat:@"已选:\"%@\" \"%@\"",self.selectedModel.name1,self.selectedModel.name2];
    }else{
        self.selectedLabel.text = [NSString stringWithFormat:@"已选:\"%@\"",self.selectedModel.name1];
    }
    
    //属性
    [self.attri_1_View removeAllSubViews];
    [self.attri_2_View removeAllSubViews];
    if (detailModel.attrDTOList.count>0) {
        self.attri_1_View.frame = CGRectMake(0, self.imageV.maxY+14, kScreenWidth, (self.row1-1)*10+self.row1*30+60);
    }else{
        self.attri_1_View.frame = CGRectMake(0, self.imageV.maxY+14, kScreenWidth, 0);
    }
     
    ShopGoodsAttrDTOModel*model1 = detailModel.attrDTOList.firstObject;
    UILabel *attri_1_titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(14,10, self.width-28, 20)];
    attri_1_titleLabel.font = [UIFont systemFontOfSize:14];
    attri_1_titleLabel.textColor = kRGB_COLOR(@"#333333", 1.0);
    attri_1_titleLabel.textAlignment = NSTextAlignmentLeft;
    attri_1_titleLabel.text = model1.attrName;
    [self.attri_1_View addSubview:attri_1_titleLabel];
    CGFloat btn1x = 0.0f;
    for (int i = 0; i < model1.attrValueList.count; i++) {
        ShopAttrValueModel *attriModel = model1.attrValueList[i];
        CGSize size = [attriModel.name boundingRectWithSize:CGSizeMake(kScreenWidth-28, 20) options:1 attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:14]} context:nil].size;
        CGFloat width = 0.0f;
        if (size.width+20 < 40) {
            width = 40;
        }else{
            width = size.width+20;
        }
        int row = btn1x/(self.width-28);
        CGFloat x = btn1x-row*(self.width-28);
        UIButton *btn = [[UIButton alloc]initWithFrame:CGRectMake(14+x, attri_1_titleLabel.maxY+10+row*40, width, 30)];
        btn1x += width+10;
        btn.layer.cornerRadius = 5;
        btn.clipsToBounds = YES;
        btn.layer.borderWidth = 1.0;
        btn.layer.borderColor = kRGB_COLOR(@"#F5F5F5", 1.0).CGColor;
        btn.tag = i;
        if (attriModel.id_field == self.selectedModel.attribute1Id) {
            self.selectedAttriModel1 = attriModel;
            btn.selected = YES;
        }
        btn.titleLabel.font = [UIFont systemFontOfSize:14];
        [btn setTitle:attriModel.name forState:UIControlStateNormal];
        [btn setBackgroundImage:[UIImage imageWithColor:kRGB_COLOR(@"#F5F5F5", 1.0)] forState:UIControlStateNormal];
        [btn setBackgroundImage:[UIImage imageWithColor:kRGB_COLOR(@"#FFF3ED", 1.0)] forState:UIControlStateSelected];
        [btn setTitleColor:kRGB_COLOR(@"#666666", 1.0) forState:UIControlStateNormal];
        [btn setTitleColor:kRGB_COLOR(@"#FF5500", 1.0) forState:UIControlStateSelected];
        [btn addTarget:self action:@selector(attributeOneBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        [self.attri_1_View addSubview:btn];
    }
    UIView *line1 = [[UIView alloc]initWithFrame:CGRectMake(14, self.attri_1_View.height-1, self.width-28, 0.5)];
    line1.backgroundColor = kRGB_COLOR(@"#DEDEDE", 1.0);
    [self.attri_1_View addSubview:line1];
     
    if (detailModel.attrDTOList.count > 1) {
        self.attri_2_View.frame = CGRectMake(0, self.attri_1_View.maxY, kScreenWidth, (self.row2-1)*10+self.row2*30+60);
        ShopGoodsAttrDTOModel*model2 = detailModel.attrDTOList.lastObject;
        UILabel *attri_2_titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(14, 10, self.width-28, 20)];
        attri_2_titleLabel.font = [UIFont systemFontOfSize:14];
        attri_2_titleLabel.textColor = kRGB_COLOR(@"#333333", 1.0);
        attri_2_titleLabel.textAlignment = NSTextAlignmentLeft;
        attri_2_titleLabel.text = model2.attrName;
        [self.attri_2_View addSubview:attri_2_titleLabel];
        CGFloat btn2x = 0.0f;
        for (int i = 0; i < model2.attrValueList.count; i++) {
            ShopAttrValueModel *attriModel = model2.attrValueList[i];
            CGSize size = [attriModel.name boundingRectWithSize:CGSizeMake(kScreenWidth-28, 20) options:1 attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:14]} context:nil].size;
            CGFloat width = 0.0f;
            if (size.width+20 < 40) {
                width = 40;
            }else{
                width = size.width+20;
            }
             
            int row = btn2x/(self.width-28);
            CGFloat x = btn2x-row*(self.width-28);
            UIButton *btn = [[UIButton alloc]initWithFrame:CGRectMake(14+x, attri_2_titleLabel.maxY+10+row*40, width, 30)];
            btn2x += width+10;
            btn.layer.cornerRadius = 5;
            btn.clipsToBounds = YES;
            btn.layer.borderWidth = 1.0;
            btn.layer.borderColor = kRGB_COLOR(@"#F5F5F5", 1.0).CGColor;
            btn.tag = i;
            if (attriModel.id_field == self.selectedModel.attribute2Id) {
                btn.selected = YES;
                btn.layer.borderColor = kRGB_COLOR(@"#FF5500", 1.0).CGColor;
                self.selectedAttriModel2 = attriModel;
            }
            btn.titleLabel.font = [UIFont systemFontOfSize:14];
            [btn setTitle:attriModel.name forState:UIControlStateNormal];
            [btn setBackgroundImage:[UIImage imageWithColor:kRGB_COLOR(@"#F5F5F5", 1.0)] forState:UIControlStateNormal];
            [btn setBackgroundImage:[UIImage imageWithColor:kRGB_COLOR(@"#FFF3ED", 1.0)] forState:UIControlStateSelected];
            [btn setTitleColor:kRGB_COLOR(@"#666666", 1.0) forState:UIControlStateNormal];
            [btn setTitleColor:kRGB_COLOR(@"#FF5500", 1.0) forState:UIControlStateSelected];
            [btn addTarget:self action:@selector(attributeTwoBtnClick:) forControlEvents:UIControlEventTouchUpInside];
            [self.attri_2_View addSubview:btn];
        }
        UIView *line2 = [[UIView alloc]initWithFrame:CGRectMake(14, self.attri_2_View.height-1, self.width-28, 0.5)];
        line2.backgroundColor = kRGB_COLOR(@"#DEDEDE", 1.0);
        [self.attri_2_View addSubview:line2];
    }else{
        self.attri_2_View.height = 0;
    }
    //购买
    self.buyView.y = self.attri_1_View.maxY+self.attri_2_View.height;
    self.shoppingTrolleyBtn.y = self.buyView.maxY+12;
    self.buyBtn.y = self.buyView.maxY+12;
}
- (NSMutableAttributedString *)getPriceAttriStrWithPrice:(CGFloat)price favorablePrice:(CGFloat)favorablePrice{
    NSMutableAttributedString *attri ;
    NSTextAttachment *attach = [[NSTextAttachment alloc]init];
    attach.image = [UIImage imageNamed:@"shop_icon_rmb"];
    attach.bounds = CGRectMake(0, 0, 10, 10);
    NSAttributedString *attImg = [NSAttributedString attributedStringWithAttachment:attach];
    if (favorablePrice > 0) {
        NSString *str1 = [NSString stringWithFormat:@"¥%.1f",favorablePrice];
        NSString *str2 = [NSString stringWithFormat:@"%.1f",price];
        attri = [[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@"%@%@",str1,str2]];
        [attri insertAttributedString:attImg atIndex:str1.length];
        [attri addAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:14],NSForegroundColorAttributeName:kRGB_COLOR(@"#888888", 1.0),NSStrikethroughStyleAttributeName:@(NSUnderlineStyleSingle)} range:NSMakeRange(0, str1.length)];
        [attri addAttributes:@{NSFontAttributeName:[UIFont boldSystemFontOfSize:18],NSForegroundColorAttributeName:kRGB_COLOR(@"#FB0035", 1.0)} range:NSMakeRange(str1.length, str2.length+1)];
    }else{
        NSString *str1 = [NSString stringWithFormat:@"%.1f",price];
        attri = [[NSMutableAttributedString alloc]initWithString:str1];
        [attri insertAttributedString:attImg atIndex:0];
        [attri addAttributes:@{NSFontAttributeName:[UIFont boldSystemFontOfSize:18],NSForegroundColorAttributeName:kRGB_COLOR(@"#FB0035", 1.0)} range:NSMakeRange(1, str1.length)];
    }
    return attri;
}
- (void)attributeOneBtnClick:(UIButton *)btn{
    ShopAttrValueModel *attriModel = self.detailModel.attrDTOList.firstObject.attrValueList[btn.tag];
    self.selectedAttriModel1 = attriModel;
    for (UIView *subV in self.attri_1_View.subviews) {
        if ([subV isKindOfClass:[UIButton class]]) {
            UIButton *subBtn = (UIButton *)subV;
            if (subBtn.tag == btn.tag) {
                subBtn.selected = YES;
                subBtn.layer.borderColor = kRGB_COLOR(@"#FF5500", 1.0).CGColor;
            }else{
                subBtn.selected = NO;
                subBtn.layer.borderColor = kRGB_COLOR(@"#F5F5F5", 1.0).CGColor;
            }
        }
    }
    [self changeInfoShow];
}

- (void)attributeTwoBtnClick:(UIButton *)btn{
    ShopAttrValueModel *attriModel = self.detailModel.attrDTOList.lastObject.attrValueList[btn.tag];
    self.selectedAttriModel2 = attriModel;
    for (UIView *subV in self.attri_2_View.subviews) {
        if ([subV isKindOfClass:[UIButton class]]) {
            UIButton *subBtn = (UIButton *)subV;
            if (subBtn.tag == btn.tag) {
                subBtn.selected = YES;
                subBtn.layer.borderColor = kRGB_COLOR(@"#FF5500", 1.0).CGColor;
            }else{
                subBtn.selected = NO;
                subBtn.layer.borderColor = kRGB_COLOR(@"#F5F5F5", 1.0).CGColor;
            }
        }
    }
    [self changeInfoShow];
}
- (void)changeInfoShow{
    for (ShopAttrComposeModel *model in self.detailModel.composeList) {
        if (self.detailModel.attrDTOList.count > 1){
            if (model.attribute1Id == self.selectedAttriModel1.id_field && model.attribute2Id == self.selectedAttriModel2.id_field) {
                self.selectedModel = model;
                self.priceLabel.attributedText = [self getPriceAttriStrWithPrice:model.price favorablePrice:model.favorablePrice];
                self.capacityLabel.text = [NSString stringWithFormat:@"库存 %d 件",model.stock];
                self.selectedLabel.text = [NSString stringWithFormat:@"已选:\"%@\" \"%@\"",model.name1,model.name2];
                if (self.num > model.stock) {
                    self.buyBtn.enabled = NO;
                    self.shoppingTrolleyBtn.enabled = NO;
                }else{
                    self.buyBtn.enabled = YES;
                    self.shoppingTrolleyBtn.enabled = YES;
                    self.callBack(NO, model, self.num,0,self.imageV,self.height);
                }
                 
                return;
            }
        }else{
            if (model.attribute1Id == self.selectedAttriModel1.id_field) {
                self.selectedModel = model;
                self.priceLabel.attributedText = [self getPriceAttriStrWithPrice:model.price favorablePrice:model.favorablePrice];
                self.capacityLabel.text = [NSString stringWithFormat:@"库存 %d 件",model.stock];
                self.selectedLabel.text = [NSString stringWithFormat:@"已选:\"%@\"",model.name1];
                self.callBack(NO, model, self.num,0,self.imageV,self.height);
                return;
            }
        }
    }
     
}

- (void)shoppingTrolleyBtnClick:(UIButton *)btn{
    self.callBack(YES, self.selectedModel, self.num,0,self.imageV,self.height);
    [FunctionSheetBaseView deletePopView:self];
}
- (void)buyBtnClick:(UIButton *)btn{
    self.callBack(YES, self.selectedModel, self.num,1,self.imageV,self.height);
    [FunctionSheetBaseView deletePopView:self];
}

#pragma mark - 懒加载
 
- (UIButton *)shoppingTrolleyBtn{
    if (!_shoppingTrolleyBtn) {
        CGFloat scale = 156/360.0;
        CGFloat width = self.width*scale;
        CGFloat margin = (self.width-2*width)/3.0;
        if (self.type == 1) {
            width = 2*width+margin;
        }
        _shoppingTrolleyBtn = [[UIButton alloc]initWithFrame:CGRectMake(margin, 0, width, 36)];
        _shoppingTrolleyBtn.layer.cornerRadius = 18;
        _shoppingTrolleyBtn.titleLabel.font = [UIFont systemFontOfSize:14];
        _shoppingTrolleyBtn.clipsToBounds = YES;
        [_shoppingTrolleyBtn setTitle:@"加入购物车" forState:UIControlStateNormal];
        [_shoppingTrolleyBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_shoppingTrolleyBtn setBackgroundImage:[UIImage createImageSize:_shoppingTrolleyBtn.bounds.size gradientColors:@[kRGB_COLOR(@"#FF8E00", 1.0),kRGB_COLOR(@"#FF5500", 1.0)] percentage:@[@0.3,@1.0] gradientType:GradientFromTopToBottom] forState:UIControlStateNormal];
        [_shoppingTrolleyBtn setBackgroundImage:[UIImage imageWithColor:kRGB_COLOR(@"#888888", 1.0)] forState:UIControlStateDisabled];
        [_shoppingTrolleyBtn addTarget:self action:@selector(shoppingTrolleyBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _shoppingTrolleyBtn;;
}
- (UIButton *)buyBtn{
    if (!_buyBtn) {
        CGFloat scale = 156/360.0;
        CGFloat width = self.width*scale;
        CGFloat margin = (self.width-2*width)/3.0;
        CGFloat x = margin+(margin+width);
        if (self.type == 2) {
            width = 2*width+margin;
            x = margin;
        }
        _buyBtn = [[UIButton alloc]initWithFrame:CGRectMake(x, 0, width, 36)];
        [_buyBtn setTitle:@"立即购买" forState:UIControlStateNormal];
        _buyBtn.layer.cornerRadius = 18;
        _buyBtn.titleLabel.font = [UIFont systemFontOfSize:14];
        _buyBtn.clipsToBounds = YES;
        [_buyBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_buyBtn setBackgroundImage:[UIImage createImageSize:_buyBtn.bounds.size gradientColors:@[kRGB_COLOR(@"#FFBB06", 1.0),kRGB_COLOR(@"#FF8503", 1.0)] percentage:@[@0.3,@1.0] gradientType:GradientFromTopToBottom] forState:UIControlStateNormal];
        [_buyBtn setBackgroundImage:[UIImage imageWithColor:kRGB_COLOR(@"#888888", 1.0)] forState:UIControlStateDisabled];
        [_buyBtn addTarget:self action:@selector(buyBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _buyBtn;;
}
- (CommBuyNumView *)buyView{
    if (!_buyView) {
        _buyView = [[CommBuyNumView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 60)];
    }
    return _buyView;
}
- (UIView *)attri_1_View{
    if (!_attri_1_View) {
        _attri_1_View = [[UIView alloc]initWithFrame:CGRectMake(0, _imageV.maxY+14, kScreenWidth, 0)];
    }
    return _attri_1_View;
}
- (UIView *)attri_2_View{
    if (!_attri_2_View) {
        _attri_2_View = [[UIView alloc]initWithFrame:CGRectMake(0, _attri_1_View.maxY, kScreenWidth, 0)];
    }
    return _attri_2_View;
}
- (UILabel *)priceLabel{
    if (!_priceLabel) {
        _priceLabel = [[UILabel alloc]initWithFrame:CGRectMake(126, _imageV.y+15, (self.width-24-112), 20)];
        _priceLabel.textAlignment = NSTextAlignmentLeft;
    }
    return _priceLabel;
}
- (UILabel *)capacityLabel{
    if (!_capacityLabel) {
        _capacityLabel = [[UILabel alloc]initWithFrame:CGRectMake(126, _priceLabel.maxY+5, (self.width-24-112), 20)];
        _capacityLabel.textAlignment = NSTextAlignmentLeft;
        _capacityLabel.textColor = kRGB_COLOR(@"#999999", 1.0);
        _capacityLabel.font = [UIFont systemFontOfSize:14];
    }
    return _capacityLabel;
}
- (UILabel *)selectedLabel{
    if (!_selectedLabel) {
        _selectedLabel = [[UILabel alloc]initWithFrame:CGRectMake(126, _capacityLabel.maxY+5, (self.width-24-112), 20)];
        _selectedLabel.textAlignment = NSTextAlignmentLeft;
        _selectedLabel.textColor = kRGB_COLOR(@"#333333", 1.0);
        _selectedLabel.font = [UIFont systemFontOfSize:14];
    }
    return _selectedLabel;
}
- (UIImageView *)imageV{
    if (!_imageV) {
        _imageV = [[UIImageView alloc]initWithFrame:CGRectMake(14, 14, 100, 100)];
        _imageV.clipsToBounds = YES;
        _imageV.contentMode = UIViewContentModeScaleAspectFill;
    }
    return _imageV;
}
 
@end
