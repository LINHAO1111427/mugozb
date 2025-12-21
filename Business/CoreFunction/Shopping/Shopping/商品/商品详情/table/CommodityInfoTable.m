//
//  CommodityInfoTable.m
//  Shopping
//
//  Created by klc on 2020/7/4.
//  Copyright © 2020 klc. All rights reserved.
//

#import "CommodityInfoTable.h"
#import "CommodityImageScrollView.h"
#import "CommodityDetailInfoView.h"
#import "CommodityStandardView.h"
#import "RelatedShopInfoView.h"
#import <LibProjView/CommodityPaySelectedView.h>
#import <LibProjModel/ShopAttrValueModel.h>
#import <LibProjModel/HttpApiShopCar.h>
#import <LibProjModel/ShopCarModel.h>
 
//#import <LibProjView/PurchaseCarAnimationTool.h>

@interface CommodityInfoTable()<CommodityStandardViewDelegate,RelatedShopInfoViewDelegate>

//图片
@property (nonatomic, strong)CommodityImageScrollView *imageScrollV;
 
//商品信息
@property (nonatomic, strong)CommodityDetailInfoView *commodityInfoView;

//规格
@property (nonatomic, strong)CommodityStandardView *commodityStandardView;

//店铺相关
@property (nonatomic, strong)RelatedShopInfoView *shopInfoView;

@end


@implementation CommodityInfoTable


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

    self.imageScrollV = [[CommodityImageScrollView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenWidth)];
    self.imageScrollV.backgroundColor = [UIColor whiteColor];
    [self addSubview:self.imageScrollV];
    
    self.commodityInfoView = [[CommodityDetailInfoView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 80)];
    self.commodityInfoView.backgroundColor = [UIColor whiteColor];
    [self addSubview:self.commodityInfoView];
    [self.commodityInfoView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self);
        make.top.equalTo(self.imageScrollV.mas_bottom).inset(0);
        make.height.mas_greaterThanOrEqualTo(70);
    }];
    
    self.commodityStandardView = [[CommodityStandardView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 80)];
    self.commodityStandardView.delegate = self;
    [self addSubview:self.commodityStandardView];
    [self.commodityStandardView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self);
        make.height.mas_equalTo(80);
        make.top.equalTo(self.commodityInfoView.mas_bottom).offset(0);
    }];
    
    self.shopInfoView = [[RelatedShopInfoView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 0)];
    self.shopInfoView.delegate = self;
    [self addSubview:self.shopInfoView];
    [self.shopInfoView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.commodityStandardView.mas_bottom).offset(0);
        make.left.right.equalTo(self);
        make.bottom.equalTo(self);
    }];
}


- (void)setDetailModel:(ShopGoodsDetailDTOModel *)detailModel{
   _detailModel = detailModel;
    //图
    self.imageScrollV.detailModel = detailModel;
    //商品信息
    self.commodityInfoView.detailModel = detailModel;

    //规格
    ShopAttrComposeModel *model = [self getFirstSelectedAttributeModel:detailModel];
    self.commodityStandardView.model = model;
    self.selectedAttriModel = model;

    self.shopInfoView.detailModel = detailModel;

    ///外部不做尺寸设置
    self.height = [CommodityInfoTable getCellHeight:self.detailModel];
}



- (ShopAttrComposeModel *)getFirstSelectedAttributeModel:(ShopGoodsDetailDTOModel *)detailModel{
    ShopAttrComposeModel *model = detailModel.composeList.firstObject;
    CGFloat price;
    if (model.favorablePrice > 0) {
        price = model.favorablePrice;
    }else{
        price = model.price;
    }
    for (ShopAttrComposeModel *mod in self.detailModel.composeList) {
        if (mod.favorablePrice > 0) {
            if (mod.favorablePrice < price) {
                price = mod.favorablePrice;
                model = mod;
            }
        }else{
            if (mod.price < price) {
                price = mod.price;
                model = mod;
            }
        }
    }
    return model;
}
 
- (void)changeSelectedAttriBute:(ShopAttrComposeModel *)attriModel num:(int)num{
    self.num = num;
    self.commodityStandardView.num = num;
    if (self.detailModel.attrDTOList.count > 0) {
        self.selectedAttriModel = attriModel;
        self.commodityInfoView.selectedAttriModel = attriModel;
        self.commodityStandardView.selectedAttriModel = attriModel;
    }
    if (self.delegate && [self.delegate respondsToSelector:@selector(CommodityInfoTableSelectedAttriModelChange:)]) {
        [self.delegate CommodityInfoTableSelectedAttriModelChange:attriModel];
    }
}
#pragma mark - CommodityStandardViewDelegate
- (void)CommodityStandardViewClick:(CommodityStandardView *)standardView{
    if (self.detailModel.anchorId == [ProjConfig userId]) {
        return;
    }
    kWeakSelf(self);
    [CommodityPaySelectedView showInSuperV:self withDetailModel:self.detailModel selectedModel:self.selectedAttriModel selctedNum:self.num type:PaySelectedTypeAll callBack:^(BOOL isBtnClick, ShopAttrComposeModel * _Nonnull attModel, int buy_num, int btn_index, UIImageView * _Nonnull imageV, CGFloat height) {
        [weakself changeSelectedAttriBute:attModel num:buy_num];
        if (isBtnClick) {
            if (btn_index == 0) {//加入购物车
                [weakself appendToShopCart:attModel number:buy_num imageV:imageV height:height];
            }else if(btn_index == 1){//立即购买
                [weakself buyNow:attModel buy_num:buy_num];
            }
        }
    }];
}
- (void)buyNow:(ShopAttrComposeModel *)attModel buy_num:(int)buy_num{
    ShopCarModel *shopCarModel = [[ShopCarModel alloc]init];
    shopCarModel.goodsNum = buy_num;
    shopCarModel.goodsPicture = self.detailModel.shopGoods.goodsPicture;
    shopCarModel.goodsName = self.detailModel.shopGoods.goodsName;
    shopCarModel.goodsId = self.detailModel.shopGoods.id_field;
    shopCarModel.businessId = self.detailModel.shopGoods.businessId;
    shopCarModel.id_field = 0;
    if (attModel) {
        shopCarModel.composeId = attModel.id_field;
        if (attModel.name2.length > 0) {
            shopCarModel.skuName = [NSString stringWithFormat:@"%@;%@",attModel.name1,attModel.name2];
        }else{
            shopCarModel.skuName = [NSString stringWithFormat:@"%@",attModel.name1];
        }
        shopCarModel.goodsPrice = attModel.favorablePrice > 0?attModel.favorablePrice:attModel.price;
    }else{
        shopCarModel.composeId = 0;
        shopCarModel.goodsPrice = self.detailModel.shopGoods.favorablePrice > 0?self.detailModel.shopGoods.favorablePrice:self.detailModel.shopGoods.price;
        shopCarModel.skuName = @"";
    }
    NSMutableArray *orderList = [NSMutableArray array];
    NSDictionary *dict = @{
        @"businessId":self.detailModel.shopGoods.businessId > 0?@(self.detailModel.shopGoods.businessId):0,
        @"businessLogo":self.detailModel.businessLogo.length > 0?self.detailModel.businessLogo:@"",
        @"businessName":self.detailModel.businessName.length > 0?self.detailModel.businessName:@"",
        @"commodityList":@[shopCarModel]
    };
    [orderList addObject:dict];
    [RouteManager routeForName:RN_Shopping_ShopOrder_ConfirmVC currentC:self.superVc parameters:@{@"orderList":orderList}];
}


- (void)appendToShopCart:(ShopAttrComposeModel *)attributeModel number:(int)num imageV:(UIImageView *)imageV height:(CGFloat)height{
    if (num > 0) {
        kWeakSelf(self);
        [HttpApiShopCar saveShopCar:attributeModel?attributeModel.id_field:0 goodsId:self.detailModel.shopGoods.id_field goodsNum:num callback:^(int code, NSString *strMsg, HttpNoneModel *model) {
            if (code == 1) {
                if (weakself.delegate && [weakself.delegate respondsToSelector:@selector(commodityInfoRefresh)]) {
                    [weakself.delegate commodityInfoRefresh];
                }
                [SVProgressHUD showInfoWithStatus:strMsg];
                /*
               CGRect rect = CGRectMake(14, 14+kScreenHeight-height, 100, 100);
                CGRect imageViewRect   = imageV.frame;
                imageViewRect.origin.y = rect.origin.y + imageViewRect.origin.y;
                [[PurchaseCarAnimationTool shareTool] startAnimationandView:imageV rect:imageViewRect finisnPoint:CGPointMake(kScreenWidth-72, kStatusBarHeight+18) finishBlock:^(BOOL finish) {
                    if (weakself.delegate && [weakself.delegate respondsToSelector:@selector(commodityInfoRefresh)]) {
                        [weakself.delegate commodityInfoRefresh];
                    }
                }];
                 */
            }else{
                [SVProgressHUD showInfoWithStatus:strMsg];
            }
        }];
    }
}
#pragma mark - RelatedShopInfoViewDelegate
- (void)RelatedShopInfoViewShopClick:(RelatedShopInfoView *)shopInfoView shopId:(int64_t)shopId{
    NSDictionary *params = @{@"businessId":@(self.detailModel.shopGoods.businessId)};
    [RouteManager routeForName:RN_Store_Home_DetailVC currentC:self.superVc parameters:params];
}
- (void)RelatedShopInfoViewCommodityClick:(RelatedShopInfoView *)shopInfoView commodity:(ShopGoodsDTOModel *)model{
    if (model.channelId == 1) {
         NSDictionary *params = @{@"goodId":@(model.goodsId)};
        [RouteManager routeForName:RN_Shopping_Commodity_DetailVC currentC:self.superVc parameters:params];
    }else{
        if ([[UIApplication sharedApplication]canOpenURL:[NSURL URLWithString:model.productLinks]]) {
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:model.productLinks]];
        }
    }
}



+ (CGFloat)getCellHeight:(ShopGoodsDetailDTOModel *)dtoModel{
    CGFloat cellHeight = kScreenWidth;
    
    CGSize size = [dtoModel.shopGoods.goodsName boundingRectWithSize:CGSizeMake(kScreenWidth-24, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont boldSystemFontOfSize:15]} context:nil].size;
    
    cellHeight += 85 + size.height;
    
    cellHeight += 80;// 规格
    
    cellHeight += 115;//店家
    
    if (dtoModel.shopGoodsDTOS.count > 0) {
        ///商家商品推荐
        CGFloat scaleShopCommodity = 100/360.0;
        CGFloat nameH = 0;
        for (ShopGoodsDTOModel *model in dtoModel.shopGoodsDTOS) {
            CGSize size = [model.goodsName boundingRectWithSize:CGSizeMake(kScreenWidth*scaleShopCommodity, MAXFLOAT) options:1 attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:13]} context:nil].size;
            nameH = MAX(size.height+5, nameH);
        }
        cellHeight += kScreenWidth*scaleShopCommodity+40+nameH;//商品列表
    }
    
    return cellHeight;
}



@end
