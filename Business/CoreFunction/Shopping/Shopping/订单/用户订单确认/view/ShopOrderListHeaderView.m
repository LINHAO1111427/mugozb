//
//  ShopOrderListHeaderView.m
//  Shopping
//
//  Created by klc on 2020/7/20.
//  Copyright © 2020 klc. All rights reserved.
//

#import "ShopOrderListHeaderView.h"

@interface ShopOrderListHeaderView()
@property (nonatomic, strong)UIView *contentV;
@property (nonatomic, strong)UIImageView  *shopAvaterImV;
@property (nonatomic, strong)UILabel  *shopNameL;
@end

@implementation ShopOrderListHeaderView
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
    [self.contentV addSubview:self.shopAvaterImV];
    [self.contentV addSubview:self.shopNameL];
    UIView *line = [[UIView alloc]initWithFrame:CGRectMake(0, self.contentV.height-1.0, self.contentV.width, 1.0)];
    line.backgroundColor = kRGB_COLOR(@"#F6F6F6");
    [self.contentV addSubview:line];
}
- (void)setDic:(NSDictionary *)dic{
    _dic = dic;
    NSString *businessLogo = dic[@"businessLogo"];
    NSString *name = dic[@"businessName"];
    [self.shopAvaterImV sd_setImageWithURL:[NSURL URLWithString:businessLogo] placeholderImage:[ProjConfig getAppIcon]];
    if (name.length > 0) {
        name = [NSString stringWithFormat:@"%@ ",name];
    }
    NSMutableAttributedString *attri = [[NSMutableAttributedString alloc] initWithString:name];
    NSTextAttachment *attach = [[NSTextAttachment alloc]init];
    attach.image = [UIImage imageNamed:@"mineCenter_gray_more"];
    attach.bounds = CGRectMake(0, -2, 8, 14);
    NSAttributedString *attatchStr = [NSAttributedString attributedStringWithAttachment:attach];
    [attri  insertAttributedString:attatchStr atIndex:name.length];
    self.shopNameL.attributedText = attri;
}
#pragma mark - 懒加载
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
- (UILabel *)shopNameL{
    if (!_shopNameL) {
        _shopNameL = [[UILabel alloc]initWithFrame:CGRectMake(_shopAvaterImV.maxX+5, 12, _contentV.width-_shopAvaterImV.maxX-5, 20)];
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
@end
