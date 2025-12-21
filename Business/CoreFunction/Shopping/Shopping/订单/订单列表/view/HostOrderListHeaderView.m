//
//  HostOrderListHeaderView.m
//  Shopping
//
//  Created by yww on 2020/8/3.
//  Copyright © 2020 klc. All rights reserved.
//

#import "HostOrderListHeaderView.h"
#import <LibProjModel/AppUserModel.h>
#import <LibProjModel/ShopBusinessOrderModel.h>
#import <LibTools/LibTools.h>

@interface HostOrderListHeaderView()
@property (nonatomic, assign)OrderType type;
@property (nonatomic, strong)UIView *contentV;
@property (nonatomic, strong)UIImageView  *shopAvaterImV;
@property (nonatomic, strong)UILabel  *shopNameL;
@property (nonatomic, strong)UIButton *coversationBtn;//会话
@property (nonatomic, strong)UIButton *shoopBtn;//店铺按钮
@end
@implementation HostOrderListHeaderView
 
- (UILabel *)shopNameL{
    if (!_shopNameL) {
        _shopNameL = [[UILabel alloc]initWithFrame:CGRectMake(_shopAvaterImV.maxX+5, 12, _contentV.width-_shopAvaterImV.maxX-5-70-12, 20)];
        _shopNameL.textColor = kRGB_COLOR(@"#333333");
        _shopNameL.font = [UIFont boldSystemFontOfSize:14];
        _shopNameL.textAlignment = NSTextAlignmentLeft;
    }
    return _shopNameL;
}
- (UIImageView *)shopAvaterImV{
    if (!_shopAvaterImV) {
        _shopAvaterImV = [[UIImageView alloc]initWithFrame:CGRectMake(12, 10, 24, 24)];
        _shopAvaterImV.contentMode = UIViewContentModeScaleAspectFill;
        _shopAvaterImV.layer.cornerRadius = 12;
        _shopAvaterImV.clipsToBounds = YES;
    }
    return _shopAvaterImV;
}
- (UIButton *)coversationBtn{
    if (!_coversationBtn) {
        _coversationBtn = [[UIButton alloc]initWithFrame:CGRectMake(_shopNameL.maxX, 7, 70, 30)];
        _coversationBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
        [_coversationBtn setTitleColor:kRGB_COLOR(@"#666666") forState:UIControlStateNormal];
        _coversationBtn.titleLabel.font = [UIFont systemFontOfSize:13];
    }
    return _coversationBtn;
}
- (UIView *)contentV{
    if (!_contentV) {
        _contentV = [[UIView alloc]initWithFrame:CGRectMake(12, 10, kScreenWidth-24, 44)];
        _contentV.backgroundColor = [UIColor whiteColor];
        UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:_contentV.bounds
                                                       byRoundingCorners:UIRectCornerTopLeft | UIRectCornerTopRight cornerRadii:CGSizeMake(10, 10)];
        CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
        maskLayer.frame = _contentV.bounds;
        maskLayer.path = maskPath.CGPath;
        _contentV.layer.mask = maskLayer;
    }
    return _contentV;
}
- (UIButton *)shoopBtn{
    if (!_shoopBtn) {
        _shoopBtn = [[UIButton alloc]initWithFrame:CGRectMake(12, 0, _shopNameL.maxX-12, _contentV.height)];
        _shoopBtn.backgroundColor = [UIColor clearColor];
        [_shoopBtn addTarget:self action:@selector(shopBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _shoopBtn;
}
- (instancetype)initWithFrame:(CGRect)frame type:(OrderType)type{
    self = [super initWithFrame:frame];
    if (self) {
        self.type = type;
        [self createUI];
    }
    return self;
}
- (void)createUI{
    self.backgroundColor = kRGB_COLOR(@"#F6F6F6");
    [self addSubview:self.contentV];
    [self.contentV addSubview:self.shopAvaterImV];
    [self.contentV addSubview:self.shopNameL];
    [self.contentV addSubview:self.shoopBtn];
    self.shopNameL.width = self.contentV.width-self.shopAvaterImV.maxX-5-70-12;
    [self.contentV addSubview:self.coversationBtn];
    UIView *line = [[UIView alloc]initWithFrame:CGRectMake(0, self.contentV.height-1.0, self.contentV.width, 1.0)];
    line.backgroundColor = kRGB_COLOR(@"#F6F6F6");
    [self.contentV addSubview:line];
}
- (void)setShopModel:(ShopUserOrderDTOModel *)shopModel{
    _shopModel = shopModel;
    NSString *avter = self.type == OrderTypeForCustomer?shopModel.businessOrder.businessLogo:shopModel.buyUser.avatar;
    [self.shopAvaterImV sd_setImageWithURL:[NSURL URLWithString:avter] placeholderImage:[ProjConfig getAppIcon]];
    NSString *name = @"";
    if (shopModel.businessOrder.businessName.length > 0 && self.type == OrderTypeForCustomer) {
        name = [NSString stringWithFormat:@"%@ ",shopModel.businessOrder.businessName];
    }else if(shopModel.buyUser.username.length > 0 && self.type == OrderTypeForMerchant){
        name = [NSString stringWithFormat:@"%@ ",shopModel.buyUser.username];
    }
    if ([self getOrderStatusIsRefundingNeed]) {
        if(shopModel.businessOrder.quitStatus == 5){
            [self.coversationBtn setTitleColor:kRGB_COLOR(@"#999999") forState:UIControlStateNormal];
        }else{
            [self.coversationBtn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
        }
    }else if(self.shopModel.businessOrder.status < 4){
        [self.coversationBtn setTitleColor:kRGB_COLOR(@"#FC8F3A") forState:UIControlStateNormal];
    }else{
        [self.coversationBtn setTitleColor:kRGB_COLOR(@"#999999") forState:UIControlStateNormal];
    }
    NSString *status = @"";
    if ([self getOrderStatusIsRefundingNeed]) {
        if(shopModel.businessOrder.quitStatus == 5){
            status = kLocalizationMsg(@"已退款");
        }else{
            status = kLocalizationMsg(@"退款中");
        }
    }else{
        if (shopModel.businessOrder.status == 1) {
            status = kLocalizationMsg(@"待付款");
        }else if(shopModel.businessOrder.status == 2){
            status = kLocalizationMsg(@"待发货");
        }else if(shopModel.businessOrder.status == 3){
            status = kLocalizationMsg(@"待收货");
        }else if(shopModel.businessOrder.status == 4){
            status = kLocalizationMsg(@"已完成");
        }else if(shopModel.businessOrder.status == 5){
            status = kLocalizationMsg(@"已取消");
        }
    }
    [self.coversationBtn setTitle:status forState:UIControlStateNormal];
    self.shopNameL.text = name;
}
///判断是否退货订单的特殊处理
- (BOOL)getOrderStatusIsRefundingNeed{
    BOOL isRefunding = NO;
    if (self.shopModel.businessOrder.refundType > 0) {
        if (self.shopModel.businessOrder.quitStatus > 0 && self.shopModel.businessOrder.quitStatus != 7) {
            isRefunding = YES;
        }
    }
    return isRefunding;
}
- (void)shopBtnClick:(UIButton *)btn{
    if (self.delegate && [self.delegate respondsToSelector:@selector(HostOrderListHeaderView:shopBtnClickWith:)]) {
        [self.delegate HostOrderListHeaderView:self shopBtnClickWith:self.shopModel];
    }
}

@end
