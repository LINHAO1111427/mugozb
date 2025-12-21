//
//  ShopOrderListFooterView.m
//  Shopping
//
//  Created by klc on 2020/7/20.
//  Copyright © 2020 klc. All rights reserved.
//

#import "ShopOrderListFooterView.h"
#import <LibProjModel/ShopCarModel.h>

@interface ShopOrderListFooterView ()
@property (nonatomic, strong)UIView *contentV;
@property (nonatomic, strong)UILabel *amoutLabel;
@end
@implementation ShopOrderListFooterView

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self createUI];
    }
    return self;
}
 
- (void)createUI{
    self.backgroundColor = kRGB_COLOR(@"#F6F6F6");
    [self addSubview:self.contentV];
    [self.contentV addSubview:self.amoutLabel];
}

- (void)setDic:(NSDictionary *)dic{
    _dic = dic;
    NSArray *commodityList = dic[@"commodityList"];
    NSInteger num = 0;
    CGFloat money = 0.0f;
    for (ShopCarModel *model in commodityList) {
        num += 1;
        money += model.goodsNum*model.goodsPrice;
    }
    NSMutableAttributedString *attri;
    NSTextAttachment *attach = [[NSTextAttachment alloc]init];
    attach.image = [UIImage imageNamed:@"shop_icon_rmb"];
    attach.bounds = CGRectMake(0, 0, 10, 10);
    NSAttributedString *attImg = [NSAttributedString attributedStringWithAttachment:attach];
    NSString *preStr = [NSString stringWithFormat:kLocalizationMsg(@"共 %ld 件商品  合计"),(long)num];
    NSString *lastStr = [NSString stringWithFormat:@"%.2f",money];
    NSString *str = [NSString stringWithFormat:@"%@%@",preStr,lastStr];
    attri = [[NSMutableAttributedString alloc]initWithString:str];
    [attri insertAttributedString:attImg atIndex:preStr.length];
    [attri addAttributes:@{NSFontAttributeName:[UIFont boldSystemFontOfSize:14],NSForegroundColorAttributeName:kRGB_COLOR(@"#FB0035")} range:NSMakeRange(preStr.length+1, lastStr.length)];
    self.amoutLabel.attributedText = attri;
}

#pragma mark - 懒加载
- (UIView *)contentV{
    if (!_contentV) {
        _contentV = [[UIView alloc]initWithFrame:CGRectMake(12, 0, kScreenWidth-24, 54)];
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
- (UILabel *)amoutLabel{
    if (!_amoutLabel) {
        _amoutLabel = [[UILabel alloc]initWithFrame:CGRectMake(12, 10, _contentV.width-24, 34)];
        _amoutLabel.font = [UIFont systemFontOfSize:14];
        _amoutLabel.textColor = kRGB_COLOR(@"#333333");
        _amoutLabel.textAlignment = NSTextAlignmentRight;
    }
    return _amoutLabel;
}
@end
