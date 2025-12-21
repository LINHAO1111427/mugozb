//
//  OrderDetailSectionHeader.m
//  Shopping
//
//  Created by yww on 2020/8/4.
//  Copyright © 2020 klc. All rights reserved.
//

#import "OrderDetailSectionHeader.h"
#import <LibProjModel/AppUserModel.h>
#import <LibProjModel/ShopUserOrderDetailDTOModel.h>
#import <LibProjModel/ShopBusinessOrderModel.h>
 
@interface OrderDetailSectionHeader()
@property (nonatomic, strong)UIView *contentV;
@property (nonatomic, strong)UIImageView  *shopAvaterImV;
@property (nonatomic, strong)UILabel  *shopNameL;
@property (nonatomic, strong)UIButton *coversationBtn;//会话
@property (nonatomic, strong)UIButton *shoopBtn;//店铺按钮
@end

@implementation OrderDetailSectionHeader

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self createUI];
    }
    return self;
}
 
- (void)createUI{
    self.backgroundColor = [UIColor clearColor];
    [self addSubview:self.contentV];
    [self.contentV addSubview:self.shopAvaterImV];
    [self.contentV addSubview:self.shopNameL];
    [self.contentV addSubview:self.shoopBtn];
    [self.contentV addSubview:self.coversationBtn];
    self.shopNameL.width = self.contentV.width-self.shopAvaterImV.maxX-5-70-12;
 
}
- (void)setModel:(ShopUserOrderDetailDTOModel *)model{
    _model = model;
    NSString *avter = self.type == OrderTypeForCustomer?model.businessOrder.businessLogo:model.buyUserAvatar;
    [self.shopAvaterImV sd_setImageWithURL:[NSURL URLWithString:avter] placeholderImage:[ProjConfig getAppIcon]];
    NSString *name = @"";
    if (model.businessOrder.businessName.length > 0 && self.type == OrderTypeForCustomer) {
        name = [NSString stringWithFormat:@"%@ ",model.businessOrder.businessName];
    }else if(model.buyUserName.length > 0 && self.type == OrderTypeForMerchant){
        name = [NSString stringWithFormat:@"%@ ",model.buyUserName];
    }
    if (self.type == OrderTypeForCustomer) {
        [self.coversationBtn setTitle:kLocalizationMsg(@"联系卖家") forState:UIControlStateNormal];
    }else{
        [self.coversationBtn setTitle:kLocalizationMsg(@"发起会话") forState:UIControlStateNormal];
    }
    self.shopNameL.text = name;
}
- (void)shopBtnClick:(UIButton *)btn{
    if (self.delegate && [self.delegate respondsToSelector:@selector(OrderDetailSectionHeader:shopBtnClickWith:)]) {
        [self.delegate OrderDetailSectionHeader:self shopBtnClickWith:self.model];
    }
}
- (void)coversationBtnClick:(UIButton *)btn{
    if (self.delegate && [self.delegate respondsToSelector:@selector(OrderDetailSectionHeader:coversationBtnClickWith:)]) {
        [self.delegate OrderDetailSectionHeader:self coversationBtnClickWith:self.model];
    }
}


#pragma mark - lazy load
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
        [_coversationBtn setImage:[UIImage imageNamed:@"shopping_order_message"] forState:UIControlStateNormal];
        [_coversationBtn setTitle:kLocalizationMsg(@"发起会话") forState:UIControlStateNormal];
        [_coversationBtn setTitleColor:kRGB_COLOR(@"#FC8F3A") forState:UIControlStateNormal];
        _coversationBtn.titleLabel.font = [UIFont systemFontOfSize:12];
        [_coversationBtn addTarget:self action:@selector(coversationBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _coversationBtn;
}
- (UIView *)contentV{
    if (!_contentV) {
        _contentV = [[UIView alloc]initWithFrame:CGRectMake(10, 10, kScreenWidth-20, 44)];
        _contentV.backgroundColor = [UIColor whiteColor];
        CGFloat radius = 10; // 圆角大小
        UIRectCorner corner = UIRectCornerTopLeft | UIRectCornerTopRight; // 圆角位置
        UIBezierPath * path = [UIBezierPath bezierPathWithRoundedRect:_contentV.bounds byRoundingCorners:corner cornerRadii:CGSizeMake(radius, radius)];
        CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
        maskLayer.frame = _contentV.bounds;
        maskLayer.path = path.CGPath;
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
@end
