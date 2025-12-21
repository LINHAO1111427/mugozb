//
//  HostOrderListFootView.m
//  Shopping
//
//  Created by yww on 2020/8/3.
//  Copyright © 2020 klc. All rights reserved.
//

#import "HostOrderListFootView.h"
#import <LibProjModel/ShopSubOrderModel.h>
#import <LibProjModel/ShopBusinessOrderModel.h>
  
@interface HostOrderListFootView()
@property (nonatomic, assign)OrderType type;
@property (nonatomic, strong)UIView *line;
@property (nonatomic, strong)UIView *contentV;
@property (nonatomic, strong)UILabel *totalL;
@property (nonatomic, strong)UIButton *bottmRightBtn;
@property (nonatomic, strong)UIButton *bottmLeftBtn;
@end
@implementation HostOrderListFootView
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
    [self.contentV addSubview:self.totalL];
    UIView *line = [[UIView alloc]initWithFrame:CGRectMake(0, 40, kScreenWidth-24, 0.5)];
    line.backgroundColor = kRGB_COLOR(@"#DEDEDE");
    self.line = line;
    [self.contentV addSubview:line];
    
    _bottmRightBtn = [[UIButton alloc]init];
    _bottmRightBtn.layer.cornerRadius = 15;
    _bottmRightBtn.contentEdgeInsets = UIEdgeInsetsMake(0, 20, 0, 20);
    _bottmRightBtn.clipsToBounds = YES;
    [_bottmRightBtn setTitle:@"" forState:UIControlStateNormal];
    _bottmRightBtn.layer.borderColor = kRGB_COLOR(@"#FC8F3A").CGColor;
    _bottmRightBtn.layer.borderWidth = 1.0;
    _bottmRightBtn.hidden = YES;
    [_bottmRightBtn setTitleColor:kRGB_COLOR(@"#FC8F3A") forState:UIControlStateNormal];
    _bottmRightBtn.titleLabel.font = [UIFont systemFontOfSize:13];
    [_bottmRightBtn addTarget:self action:@selector(bottmRightBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.contentV addSubview:_bottmRightBtn];
    [_bottmRightBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(30);
        make.right.equalTo(self.contentV).inset(12);
        make.top.equalTo(self.contentV).inset(54);
    }];
    
    _bottmLeftBtn = [[UIButton alloc] init];
    _bottmLeftBtn.layer.cornerRadius = 15;
    _bottmLeftBtn.clipsToBounds = YES;
    _bottmLeftBtn.contentEdgeInsets = UIEdgeInsetsMake(0, 20, 0, 20);
    [_bottmLeftBtn setTitle:@"" forState:UIControlStateNormal];
    _bottmLeftBtn.layer.borderColor = kRGB_COLOR(@"#999999").CGColor;
    _bottmLeftBtn.layer.borderWidth = 1.0;
    _bottmLeftBtn.hidden = YES;
    [_bottmLeftBtn setTitleColor:kRGB_COLOR(@"#666666") forState:UIControlStateNormal];
    _bottmLeftBtn.titleLabel.font = [UIFont systemFontOfSize:13];
    [_bottmLeftBtn addTarget:self action:@selector(bottmLeftBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.contentV addSubview:_bottmLeftBtn];
    [_bottmRightBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(30);
        make.right.equalTo(_bottmRightBtn.mas_right).inset(12);
        make.centerY.equalTo(_bottmRightBtn);
    }];
    
}

- (void)setShopModel:(ShopUserOrderDTOModel *)shopModel{
    _shopModel = shopModel;
    CGFloat price = 0.0f;
    for (ShopSubOrderModel *mod in shopModel.subOrderList) {
        price += mod.goodsPrice*mod.goodsNum;
    }
    
    NSString *numS = [NSString stringWithFormat:@"%d",shopModel.goodsNum];
    NSString *priceS = [NSString stringWithFormat:@"¥%.2f",price];
    NSMutableAttributedString *attriStr = [[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:kLocalizationMsg(@"共 %@ 件商品 %@"),numS,priceS]];
    [attriStr addAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:14]} range:[attriStr.string rangeOfString:numS]];
    [attriStr addAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:14],NSForegroundColorAttributeName:kRGB_COLOR(@"#333333")} range:[attriStr.string rangeOfString:priceS]];
    self.totalL.attributedText = attriStr;
    self.bottmLeftBtn.tag = 0;
    self.bottmRightBtn.tag = 0;
    self.bottmLeftBtn.layer.borderColor = kRGB_COLOR(@"#999999").CGColor;
    [self.bottmLeftBtn setTitleColor:kRGB_COLOR(@"#999999") forState:UIControlStateNormal];
    self.bottmRightBtn.layer.borderColor = kRGB_COLOR(@"#FC8F3A").CGColor;
    [self.bottmRightBtn setTitleColor:kRGB_COLOR(@"#FC8F3A") forState:UIControlStateNormal];
    self.bottmLeftBtn.hidden = YES;
    self.bottmRightBtn.hidden = YES;
    self.line.hidden = YES;
    if (self.type == OrderTypeForCustomer) {///买家
        if ([self getOrderStatusIsRefundingNeed]) {//退款流程
            switch (shopModel.businessOrder.quitStatus) {
                case QuitOrderStatusWaittingCheck:{//待审核
                    self.bottmRightBtn.hidden = NO;
                    self.line.hidden = NO;
                    self.bottmRightBtn.tag = 200;
                    [self.bottmRightBtn setTitle:kLocalizationMsg(@"撤销退款申请") forState:UIControlStateNormal];
                }
                    break;
                case QuitOrderStatusWaittingForDeliver:{//待发货
                    self.bottmLeftBtn.hidden = NO;
                    self.bottmRightBtn.hidden = NO;
                    self.line.hidden = NO;
                    self.bottmLeftBtn.tag = 200;
                    self.bottmRightBtn.tag = 201;
                    self.bottmLeftBtn.layer.borderColor = kRGB_COLOR(@"#FC8F3A").CGColor;
                    [self.bottmLeftBtn setTitleColor:kRGB_COLOR(@"#FC8F3A") forState:UIControlStateNormal];
                    [self.bottmLeftBtn setTitle:kLocalizationMsg(@"撤销退款申请") forState:UIControlStateNormal];
                    [self.bottmRightBtn setTitle:kLocalizationMsg(@"填写物流单号") forState:UIControlStateNormal];
                }
                    break;
                case QuitOrderStatusWaittingForReceive:{//待收货
                    self.bottmRightBtn.hidden = NO;
                    self.line.hidden = NO;
                    self.bottmRightBtn.tag = 200;
                    [self.bottmRightBtn setTitle:kLocalizationMsg(@"撤销退款申请") forState:UIControlStateNormal];
                }
                    break;
                case QuitOrderStatusForComplete://退款完成
                    break;
                default:{
                    self.bottmRightBtn.hidden = NO;
                    self.line.hidden = NO;
                    self.bottmRightBtn.tag = 202;
                    [self.bottmRightBtn setTitle:kLocalizationMsg(@"联系客服") forState:UIControlStateNormal];
                }
                    break;
            }
        }else{
            switch (shopModel.businessOrder.status) {//正常
                case HostOrderStatusWaittingForPay:{//待付款
                    self.bottmLeftBtn.hidden = NO;
                    self.bottmRightBtn.hidden = NO;
                    self.line.hidden = NO;
                    self.bottmLeftBtn.tag = 101;
                    self.bottmRightBtn.tag = 102;
                    [self.bottmLeftBtn setTitle:kLocalizationMsg(@"取消订单") forState:UIControlStateNormal];
                    [self.bottmRightBtn setTitle:kLocalizationMsg(@"立即付款") forState:UIControlStateNormal];
                }
                    break;
                case HostOrderStatusWaittingForDeliver:{//待发货
                    self.bottmLeftBtn.hidden = NO;
                    self.bottmRightBtn.hidden = NO;
                    self.line.hidden = NO;
                    self.bottmRightBtn.tag = 103;
                    self.bottmLeftBtn.tag = 202;
                    [self.bottmLeftBtn setTitle:kLocalizationMsg(@"联系客服") forState:UIControlStateNormal];
                    [self.bottmRightBtn setTitle:kLocalizationMsg(@"提醒发货") forState:UIControlStateNormal];
                }
                    break;
                case HostOrderStatusWaittingForReceive:{//待收货
                    self.bottmLeftBtn.hidden = NO;
                    self.bottmRightBtn.hidden = NO;
                    self.line.hidden = NO;
                    self.bottmLeftBtn.tag = 104;
                    self.bottmRightBtn.tag = 105;
                    [self.bottmLeftBtn setTitle:kLocalizationMsg(@"查看物流") forState:UIControlStateNormal];
                    [self.bottmRightBtn setTitle:kLocalizationMsg(@"确认收货") forState:UIControlStateNormal];
                }
                    break;
                case HostOrderStatusForComplete:{//完成
                    self.bottmRightBtn.hidden = NO;
                    self.line.hidden = NO;
                    self.bottmRightBtn.tag = 106;
                    [self.bottmRightBtn setTitle:kLocalizationMsg(@"再次购买") forState:UIControlStateNormal];
                }
                    break;
                default:
                    break;
            }
            
        }
       }else{///卖家
           if ([self getOrderStatusIsRefundingNeed]) {//退款流程
               switch (shopModel.businessOrder.quitStatus) {
                   case QuitOrderStatusWaittingCheck:{//待审核
                       self.bottmLeftBtn.hidden = NO;
                       self.bottmRightBtn.hidden = NO;
                       self.line.hidden = NO;
                       self.bottmLeftBtn.tag = 107;
                       self.bottmRightBtn.tag = 203;
                       [self.bottmLeftBtn setTitle:kLocalizationMsg(@"联系买家") forState:UIControlStateNormal];
                       [self.bottmRightBtn setTitle:kLocalizationMsg(@"审核退款申请") forState:UIControlStateNormal];
                   }
                       break;
                   case QuitOrderStatusWaittingForReceive:{//待收货
                       self.bottmLeftBtn.hidden = NO;
                       self.bottmRightBtn.hidden = NO;
                       self.line.hidden = NO;
                       self.bottmLeftBtn.tag = 204;
                       self.bottmRightBtn.tag = 205;
                       [self.bottmLeftBtn setTitle:kLocalizationMsg(@"查看物流") forState:UIControlStateNormal];
                       [self.bottmRightBtn setTitle:kLocalizationMsg(@"货物审核") forState:UIControlStateNormal];
                   }
                   default:
                       break;
               }
           }else{
               switch (shopModel.businessOrder.status) {
                   case HostOrderStatusWaittingForDeliver:
                       self.bottmLeftBtn.hidden = NO;
                       self.bottmRightBtn.hidden = NO;
                       self.line.hidden = NO;
                       self.bottmLeftBtn.tag = 107;
                       self.bottmRightBtn.tag = 108;
                       [self.bottmLeftBtn setTitle:kLocalizationMsg(@"联系买家") forState:UIControlStateNormal];
                       [self.bottmRightBtn setTitle:kLocalizationMsg(@"立即发货") forState:UIControlStateNormal];
                       break;
                   case HostOrderStatusWaittingForReceive:
                       self.bottmLeftBtn.hidden = NO;
                       self.bottmRightBtn.hidden = NO;
                       self.line.hidden = NO;
                       self.bottmLeftBtn.tag = 109;
                       self.bottmRightBtn.tag = 107;
                       self.bottmRightBtn.layer.borderColor = kRGB_COLOR(@"#999999").CGColor;
                       [self.bottmRightBtn setTitleColor:kRGB_COLOR(@"#999999") forState:UIControlStateNormal];
                       [self.bottmLeftBtn setTitle:kLocalizationMsg(@"查看物流") forState:UIControlStateNormal];
                       [self.bottmRightBtn setTitle:kLocalizationMsg(@"联系买家") forState:UIControlStateNormal];
                       break;
                   default:
                       break;
               }
           }
            
       }
    if (self.line.hidden) {
        self.contentV.height = 57;
        UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:_contentV.bounds
                                                       byRoundingCorners:UIRectCornerBottomLeft | UIRectCornerBottomRight cornerRadii:CGSizeMake(10, 10)];
        CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
        maskLayer.frame = self.contentV.bounds;
        maskLayer.path = maskPath.CGPath;
        self.contentV.layer.mask = maskLayer;
    }else{
        self.contentV.height = 97;
    }
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
- (void)bottmRightBtnClick:(UIButton *)btn{
    [self btnClickWithIndex:btn.tag];
}
- (void)bottmLeftBtnClick:(UIButton *)btn{
    [self btnClickWithIndex:btn.tag];
}
- (void)btnClickWithIndex:(NSInteger)index{
    if (self.delegate && [self.delegate respondsToSelector:@selector(HostOrderListFootView:withModel:index:)]) {
        [self.delegate HostOrderListFootView:self withModel:self.shopModel index:index];
    }
}
#pragma mark - lazy load
- (UIView *)contentV{
    if (!_contentV) {
        _contentV = [[UIView alloc]initWithFrame:CGRectMake(12, 0, kScreenWidth-24, 97)];
        _contentV.backgroundColor = [UIColor whiteColor];
        UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:_contentV.bounds
                                                       byRoundingCorners:UIRectCornerBottomLeft | UIRectCornerBottomRight cornerRadii:CGSizeMake(10, 10)];
        CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
        maskLayer.frame = _contentV.bounds;
        maskLayer.path = maskPath.CGPath;
        _contentV.layer.mask = maskLayer;
    }
    return _contentV;
}
- (UILabel *)totalL{
    if (!_totalL) {
        _totalL = [[UILabel alloc]initWithFrame:CGRectMake(12, 10, kScreenWidth-48, 20)];
        _totalL.textColor = kRGB_COLOR(@"#999999");
        _totalL.font = [UIFont systemFontOfSize:12];
        _totalL.textAlignment = NSTextAlignmentRight;
    }
    return _totalL;
}
 
@end
