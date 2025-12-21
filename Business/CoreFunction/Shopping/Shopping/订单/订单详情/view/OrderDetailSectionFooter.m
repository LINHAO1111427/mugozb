//
//  OrderDetailSectionFooter.m
//  Shopping
//
//  Created by yww on 2020/8/4.
//  Copyright © 2020 klc. All rights reserved.
//

#import "OrderDetailSectionFooter.h"
#import <LibProjModel/ShopUserOrderDetailDTOModel.h>
#import <LibProjModel/ShopBusinessOrderModel.h>
#import <LibProjModel/ShopSubOrderModel.h>
 
   
@interface OrderDetailSectionFooter()
@property (nonatomic, assign)OrderType type;
@property (nonatomic, strong)UIView *contentV;
@property (nonatomic, strong)UILabel *priceL;//价格
@property (nonatomic, strong)UILabel *allNumL;//数目

@property (nonatomic, strong)UIButton *leftBtn;
@property (nonatomic, strong)UIButton *middleBtn;
@property (nonatomic, strong)UIButton *rightBtn;
@property (nonatomic, strong)UIButton *bigBtn;//占满宽度
@end
@implementation OrderDetailSectionFooter
- (instancetype)initWithFrame:(CGRect)frame type:(OrderType)type{
    self = [super initWithFrame:frame];
    if (self) {
        self.type = type;
        [self createUI];
    }
    return self;
}
- (void)createUI{
    self.backgroundColor = kRGB_COLOR(@"#F5F5F5");
    [self addSubview:self.contentV];
    [self.contentV addSubview:self.allNumL];
    [self.contentV addSubview:self.priceL];
    
    _rightBtn = [[UIButton alloc]initWithFrame:CGRectMake(_middleBtn.maxX+10, 15+44, 80, 30)];
    _rightBtn.layer.cornerRadius = 15;
    _rightBtn.clipsToBounds = YES;
    [_rightBtn setTitleColor:kRGB_COLOR(@"#FC8F3A") forState:UIControlStateNormal];
    _rightBtn.layer.borderColor = kRGB_COLOR(@"#FC8F3A").CGColor;
    _rightBtn.layer.borderWidth = 1.0;
    _rightBtn.titleLabel.font = [UIFont systemFontOfSize:12];
    [_rightBtn addTarget:self action:@selector(rightBtnClik:) forControlEvents:UIControlEventTouchUpInside];
    _rightBtn.contentEdgeInsets = UIEdgeInsetsMake(0, 15, 0, 15);
    [self.contentV addSubview:_rightBtn];
    [_rightBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(30);
        make.top.equalTo(self.contentV).inset(15+44);
        make.right.equalTo(self.contentV).inset(12);
    }];
    
    _middleBtn = [[UIButton alloc]initWithFrame:CGRectMake(_leftBtn.maxX+10, 15+44, 80, 30)];
    _middleBtn.layer.cornerRadius = 15;
    _middleBtn.clipsToBounds = YES;
    [_middleBtn setTitleColor:kRGB_COLOR(@"#888888") forState:UIControlStateNormal];
    _middleBtn.layer.borderColor = kRGB_COLOR(@"#888888").CGColor;
    _middleBtn.layer.borderWidth = 1.0;
    _middleBtn.titleLabel.font = [UIFont systemFontOfSize:12];
    _middleBtn.contentEdgeInsets = UIEdgeInsetsMake(0, 15, 0, 15);
    [_middleBtn addTarget:self action:@selector(middleBtnClik:) forControlEvents:UIControlEventTouchUpInside];
    [self.contentV addSubview:_middleBtn];
    [_middleBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(30);
        make.centerY.equalTo(_rightBtn);
        make.right.equalTo(_rightBtn.mas_left).inset(10);
    }];
    
    _leftBtn = [[UIButton alloc]initWithFrame:CGRectMake(kScreenWidth-280-12-20, 15+44, 100, 30)];
    _leftBtn.layer.cornerRadius = 15;
    _leftBtn.clipsToBounds = YES;
    [_leftBtn setTitleColor:kRGB_COLOR(@"#888888") forState:UIControlStateNormal];
    _leftBtn.layer.borderColor = kRGB_COLOR(@"#888888").CGColor;
    _leftBtn.layer.borderWidth = 1.0;
    _leftBtn.titleLabel.font = [UIFont systemFontOfSize:12];
    _leftBtn.contentEdgeInsets = UIEdgeInsetsMake(0, 15, 0, 15);
    [_leftBtn addTarget:self action:@selector(leftBtnClik:) forControlEvents:UIControlEventTouchUpInside];
    [self.contentV addSubview:_leftBtn];
    [_leftBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(30);
        make.centerY.equalTo(_middleBtn);
        make.right.equalTo(_middleBtn.mas_left).inset(10);
    }];
    
    _bigBtn = [[UIButton alloc] init];
    _bigBtn.backgroundColor = kRGB_COLOR(@"#FC8F3A");
    _bigBtn.layer.cornerRadius = 20;
    _bigBtn.clipsToBounds = YES;
    _bigBtn.hidden = YES;
    _bigBtn.titleLabel.font = [UIFont systemFontOfSize:14];
    [_bigBtn addTarget:self action:@selector(bigBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [_bigBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.contentV addSubview:_bigBtn];
    [_bigBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.contentV).inset(12);
        make.height.mas_equalTo(40);
        make.top.equalTo(self.contentV).inset(10+44);
    }];
}

- (void)setModel:(ShopUserOrderDetailDTOModel *)model{
    _model = model;

    self.leftBtn.hidden = YES;
    self.leftBtn.tag = 0;
    [self.leftBtn setTitleColor:kRGB_COLOR(@"#888888") forState:UIControlStateNormal];
    self.leftBtn.layer.borderColor = kRGB_COLOR(@"#888888").CGColor;
    
    
    self.middleBtn.hidden = YES;
    self.middleBtn.tag = 0;
    [self.middleBtn setTitleColor:kRGB_COLOR(@"#888888") forState:UIControlStateNormal];
    self.middleBtn.layer.borderColor = kRGB_COLOR(@"#888888").CGColor;
    
    self.rightBtn.hidden = YES;
    self.rightBtn.tag = 0;
    [self.rightBtn setTitleColor:kRGB_COLOR(@"#FC8F3A") forState:UIControlStateNormal];
    self.rightBtn.layer.borderColor = kRGB_COLOR(@"#FC8F3A").CGColor;
    
    self.bigBtn.hidden = YES;
    self.bigBtn.tag = 0;
    if (self.type == OrderTypeForCustomer) {//用户
        if ([self getOrderStatusIsRefundingNeed]) {//退款流程
            if (model.businessOrder.status == HostOrderStatusWaittingForDeliver || model.businessOrder.status == HostOrderStatusWaittingForReceive ) {//退货退款
                if (model.businessOrder.quitStatus == QuitOrderStatusWaittingForDeliver) {//等待买家发货
                    self.middleBtn.hidden = NO;
                    self.middleBtn.tag = 108;
                    [self.middleBtn setTitle:kLocalizationMsg(@"撤销退款申请") forState:UIControlStateNormal];
                    self.rightBtn.hidden = NO;
                    self.rightBtn.tag = 109;
                    [self.rightBtn setTitle:kLocalizationMsg(@"填写物流单号") forState:UIControlStateNormal];
                }else{
                    self.rightBtn.hidden = NO;
                    self.rightBtn.tag = 108;
                    [self.rightBtn setTitleColor:kRGB_COLOR(@"#888888") forState:UIControlStateNormal];
                    self.rightBtn.layer.borderColor = kRGB_COLOR(@"#888888").CGColor;
                    [self.rightBtn setTitle:kLocalizationMsg(@"撤销退款申请") forState:UIControlStateNormal];
                }
            }else{//仅退款
                if (model.businessOrder.quitStatus < 4) {
                    self.rightBtn.hidden = NO;
                    self.rightBtn.tag = 108;
                    [self.rightBtn setTitleColor:kRGB_COLOR(@"#888888") forState:UIControlStateNormal];
                    self.rightBtn.layer.borderColor = kRGB_COLOR(@"#888888").CGColor;
                    [self.rightBtn setTitle:kLocalizationMsg(@"撤销退款申请") forState:UIControlStateNormal];
                }
            }
        }else{
            if (model.businessOrder.status == 1) {//待付款
                self.leftBtn.hidden = NO;
                self.leftBtn.tag = 101;
                [self.leftBtn setTitle:kLocalizationMsg(@"修改收货地址") forState:UIControlStateNormal];
                self.middleBtn.hidden = NO;
                self.middleBtn.tag = 102;
                [self.middleBtn setTitle:kLocalizationMsg(@"取消订单") forState:UIControlStateNormal];
                self.rightBtn.hidden = NO;
                self.rightBtn.tag = 103;
                [self.rightBtn setTitle:kLocalizationMsg(@"立即付款") forState:UIControlStateNormal];
            }else if (model.businessOrder.status == 2){//待发货
                self.middleBtn.hidden = NO;
                self.middleBtn.tag = 105;
                [self.middleBtn setTitle:kLocalizationMsg(@"申请退款") forState:UIControlStateNormal];
                self.rightBtn.hidden = NO;
                self.rightBtn.tag = 104;
                [self.rightBtn setTitleColor:kRGB_COLOR(@"#888888") forState:UIControlStateNormal];
                self.rightBtn.layer.borderColor = kRGB_COLOR(@"#888888").CGColor;
                [self.rightBtn setTitle:kLocalizationMsg(@"提醒发货") forState:UIControlStateNormal];
            }else if (model.businessOrder.status == 3){//待确认收货;
                self.middleBtn.hidden = NO;
                self.middleBtn.tag = 105;
                [self.middleBtn setTitle:kLocalizationMsg(@"申请退款") forState:UIControlStateNormal];
                self.rightBtn.hidden = NO;
                self.rightBtn.tag = 106;
                [self.rightBtn setTitle:kLocalizationMsg(@"确认收货") forState:UIControlStateNormal];
            }
        }
        
    }else{//商家
        if ([self getOrderStatusIsRefundingNeed]) {//退款
            if (model.businessOrder.quitStatus == QuitOrderStatusWaittingCheck) {//审核
                self.bigBtn.hidden = NO;
                self.bigBtn.tag = 110;
                [self.bigBtn setTitle:kLocalizationMsg(@"审核退款申请") forState:UIControlStateNormal];
            }else if(model.businessOrder.status == QuitOrderStatusWaittingForReceive){//待收货
                self.bigBtn.hidden = NO;
                self.bigBtn.tag = 111;
                [self.bigBtn setTitle:kLocalizationMsg(@"货物审核") forState:UIControlStateNormal];
            }
        }else{
            if (model.businessOrder.status == HostOrderStatusWaittingForDeliver) {//立即发货
                self.rightBtn.hidden = NO;
                self.rightBtn.tag = 107;
                [self.rightBtn setTitle:kLocalizationMsg(@"立即发货") forState:UIControlStateNormal];
            }
        }
    }
    
    CGFloat price = 0.0f;
    for (ShopSubOrderModel *mod in model.subOrderList) {
        price += mod.goodsPrice*mod.goodsNum;
    }
    CGFloat discount = price - model.businessOrder.transactionAmount;
    if (discount < 0) {
        discount = 0;
    }
//    NSString * discountS = [NSString stringWithFormat:@" %.2f",discount];//打折信息
    NSString *numS = [NSString stringWithFormat:@" %d",model.goodsNum];
    NSString *priceS = [NSString stringWithFormat:@" %.2f",model.businessOrder.transactionAmount];
    self.allNumL.text = [NSString stringWithFormat:kLocalizationMsg(@"共计%@ 件商品"),numS];
    self.priceL.text = [NSString stringWithFormat:@"¥%@",priceS];
}
///判断是否退货订单的特殊处理
- (BOOL)getOrderStatusIsRefundingNeed{
    BOOL isRefunding = NO;
    if (self.model.businessOrder.refundType > 0) {
        if (self.model.businessOrder.quitStatus > 0 && self.model.businessOrder.quitStatus != 7) {
            isRefunding = YES;
        }
    }
    return isRefunding;
}
- (void)leftBtnClik:(UIButton *)btn{
    [self btnClick:btn.tag];
}
- (void)middleBtnClik:(UIButton *)btn{
    [self btnClick:btn.tag];
}
- (void)rightBtnClik:(UIButton *)btn{
    [self btnClick:btn.tag];
}
- (void)bigBtnClick:(UIButton*)btn{
    [self btnClick:btn.tag];
}
- (void)btnClick:(NSInteger)tag{
    if (self.delegate && [self.delegate respondsToSelector:@selector(OrderDetailSectionFooter:btnClickWith:model:)]) {
        [self.delegate OrderDetailSectionFooter:self btnClickWith:tag model:self.model];
    }
}
#pragma mark - lazy load
- (UIView *)contentV{
    if (!_contentV) {
        _contentV = [[UIView alloc]initWithFrame:CGRectMake(10, 0, kScreenWidth-20, self.height-10)];
        _contentV.backgroundColor = [UIColor whiteColor];
        CGFloat radius = 10; // 圆角大小
        UIRectCorner corner = UIRectCornerBottomLeft | UIRectCornerBottomRight; // 圆角位置
        UIBezierPath * path = [UIBezierPath bezierPathWithRoundedRect:_contentV.bounds byRoundingCorners:corner cornerRadii:CGSizeMake(radius, radius)];
        CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
        maskLayer.frame = _contentV.bounds;
        maskLayer.path = path.CGPath;
        _contentV.layer.mask = maskLayer;
    }
    return _contentV;
}
- (UILabel *)priceL{
    if (!_priceL) {
        _priceL = [[UILabel alloc]initWithFrame:CGRectMake(_allNumL.maxX, 12, (kScreenWidth-24-20)/2.0, 20)];
        _priceL.textAlignment = NSTextAlignmentRight;
        _priceL.textColor = kRGB_COLOR(@"#333333");
        _priceL.font = [UIFont boldSystemFontOfSize:14];
    }
    return _priceL;
}
- (UILabel *)allNumL{
    if (!_allNumL) {
        _allNumL = [[UILabel alloc]initWithFrame:CGRectMake(12, 12,(kScreenWidth-24-20)/2.0, 20)];
        _allNumL.textAlignment = NSTextAlignmentLeft;
        _allNumL.textColor = kRGB_COLOR(@"#999999");
        _allNumL.font = [UIFont systemFontOfSize:14];
    }
    return _allNumL;
}
 
@end
