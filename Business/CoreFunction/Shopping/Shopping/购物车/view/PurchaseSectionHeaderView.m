//
//  PurchaseSectionHeaderView.m
//  Shopping
//
//  Created by klc on 2020/7/11.
//  Copyright © 2020 klc. All rights reserved.
//

#import "PurchaseSectionHeaderView.h"
#import <LibProjModel/ShopCarDTOModel.h>

@interface PurchaseSectionHeaderView()
@property (nonatomic, strong)UIView *contentV;
@property (nonatomic, strong)UIButton *selectedBtn;
@property (nonatomic, strong)UIImageView  *shopAvaterImV;
@property (nonatomic, strong)UILabel  *shopNameL;
@property (nonatomic, strong)UIButton *shoopBtn;//店铺按钮
@end

@implementation PurchaseSectionHeaderView
- (UIButton *)selectedBtn{
    if (!_selectedBtn) {
        _selectedBtn = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 44, 44)];
        [_selectedBtn setImage:[UIImage imageNamed:@"shopCart_mark_normal"] forState:UIControlStateNormal];
        [_selectedBtn setImage:[UIImage imageNamed:@"shopCart_mark_selected"] forState:UIControlStateSelected];
        [_selectedBtn addTarget:self action:@selector(selectedBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _selectedBtn;
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
        _shopAvaterImV = [[UIImageView alloc]initWithFrame:CGRectMake(_selectedBtn.maxX, 10, 24, 24)];
        _shopAvaterImV.contentMode = UIViewContentModeScaleAspectFill;
        _shopAvaterImV.layer.cornerRadius = 12;
        _shopAvaterImV.clipsToBounds = YES;
    }
    return _shopAvaterImV;
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
        _shoopBtn = [[UIButton alloc]initWithFrame:CGRectMake(_selectedBtn.maxX, 0, _shopNameL.maxX-_selectedBtn.maxX, _contentV.height)];
        _shoopBtn.backgroundColor = [UIColor clearColor];
        [_shoopBtn addTarget:self action:@selector(shopBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _shoopBtn;
}
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
    self.selectedBtn.selected = YES;
    [self.contentV addSubview:self.selectedBtn];
    [self.contentV addSubview:self.shopAvaterImV];
    [self.contentV addSubview:self.shopNameL];
    [self.contentV addSubview:self.shoopBtn];
    UIView *line = [[UIView alloc]initWithFrame:CGRectMake(0, self.contentV.height-1.0, self.contentV.width, 1.0)];
    line.backgroundColor = kRGB_COLOR(@"#F6F6F6");
    [self.contentV addSubview:line];
}
 
- (void)selectedBtnClick:(UIButton *)btn{
    if (self.delegate && [self.delegate respondsToSelector:@selector(PurchaseSectionHeaderView:selectedClick:)]) {
        [self.delegate PurchaseSectionHeaderView:self selectedClick:!self.sectionModel.checked];
    }
}

- (void)shopBtnClick:(UIButton *)btn{
    if (self.delegate && [self.delegate respondsToSelector:@selector(PurchaseSectionHeaderViewShopBtnClick:)]) {
        [self.delegate PurchaseSectionHeaderViewShopBtnClick:self];
    }
}

- (void)setSectionModel:(ShopCarDTOModel *)sectionModel{
    _sectionModel = sectionModel;
    [self.shopAvaterImV sd_setImageWithURL:[NSURL URLWithString:sectionModel.businessLogo] placeholderImage:[ProjConfig getAppIcon]];
    NSString *name = @"";
    if (sectionModel.businessName.length > 0) {
        name = [NSString stringWithFormat:@"%@ ",sectionModel.businessName];
    }
    NSMutableAttributedString *attri = [[NSMutableAttributedString alloc] initWithString:name];
    NSTextAttachment *attach = [[NSTextAttachment alloc]init];
    attach.image = [UIImage imageNamed:@"mineCenter_gray_more"];
    attach.bounds = CGRectMake(0, -2, 8, 14);
    NSAttributedString *attatchStr = [NSAttributedString attributedStringWithAttachment:attach];
    [attri  insertAttributedString:attatchStr atIndex:name.length];
    self.shopNameL.attributedText = attri;
    self.selectedBtn.selected = sectionModel.checked;
}
 
@end
